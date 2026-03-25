library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

# ── Simulator functions ────────────────────────────────────────────────────────

simulate_selection_drift <- function(q0, s, h, Ne, nrep, ngen) {
  q_mat      <- matrix(NA, nrow = ngen, ncol = nrep)
  q_mat[1, ] <- q0
  for (t in 2:ngen) {
    q     <- q_mat[t - 1, ]
    p     <- 1 - q
    w_bar <- p^2 * 1 + 2 * p * q * (1 - h * s) + q^2 * (1 - s)
    q_sel <- (q^2 * (1 - s) + p * q * (1 - h * s)) / w_bar
    q_sel <- pmax(0, pmin(1, q_sel))
    q_mat[t, ] <- rbinom(nrep, size = 2 * Ne, prob = q_sel) / (2 * Ne)
  }
  q_mat
}

simulate_multilocus <- function(loci, Ne, nrep, ngen) {
  n_loci  <- nrow(loci)
  q_array <- array(NA, dim = c(ngen, nrep, n_loci))
  for (l in seq_len(n_loci)) {
    q_array[, , l] <- simulate_selection_drift(
      q0 = loci$q0[l], s = loci$s[l], h = loci$h[l],
      Ne = Ne, nrep = nrep, ngen = ngen
    )
  }
  q_array
}

compute_fitness <- function(q_array, loci) {
  ngen   <- dim(q_array)[1]
  nrep   <- dim(q_array)[2]
  n_loci <- dim(q_array)[3]
  W_mat  <- matrix(1, nrow = ngen, ncol = nrep)
  for (l in seq_len(n_loci)) {
    q       <- q_array[, , l]
    p       <- 1 - q
    s       <- loci$s[l]
    h       <- loci$h[l]
    w_bar_l <- p^2 + 2 * p * q * (1 - h * s) + q^2 * (1 - s)
    W_mat   <- W_mat * w_bar_l
  }
  W_mat
}

# ── UI ─────────────────────────────────────────────────────────────────────────

ui <- fluidPage(
  titlePanel("Deleterious Mutation Load Simulator"),
  sidebarLayout(
    sidebarPanel(
      h4("Population parameters"),
      sliderInput("Ne",   "Effective population size (Ne):",
                  min = 10, max = 1000, value = 100, step = 10),
      sliderInput("nrep", "Number of replicate populations:",
                  min = 5,  max = 30,   value = 10,  step = 5),
      sliderInput("ngen", "Number of generations:",
                  min = 50, max = 600,  value = 300, step = 25),
      hr(),
      h4("Mutation landscape"),
      sliderInput("n_loci",  "Number of loci:",
                  min = 10,  max = 200, value = 100, step = 10),
      sliderInput("s_shape", "DFE shape parameter (Gamma):",
                  min = 0.1, max = 2.0, value = 0.3, step = 0.1),
      sliderInput("s_rate",  "DFE rate parameter (Gamma):",
                  min = 0.5, max = 10,  value = 3.0, step = 0.5),
      sliderInput("q0_max",  "Max starting frequency of deleterious allele:",
                  min = 0.1, max = 0.5, value = 0.3, step = 0.05),
      hr(),
      h4("Dominance model"),
      selectInput("h_model", "Dominance coefficient (h):",
                  choices  = c("Recessive (h = 0)"            = "0",
                               "Partially recessive (h = 0.1)" = "0.1",
                               "Co-dominant (h = 0.5)"         = "0.5",
                               "Dominant (h = 1)"              = "1"),
                  selected = "0.1"),
      hr(),
      actionButton("run", "Run simulation", class = "btn-primary", width = "100%")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Genetic load over time",
                 plotOutput("loadPlot",  height = "420px")),
        tabPanel("Locus fate",
                 plotOutput("fatePlot",  height = "420px")),
        tabPanel("Summary table",
                 tableOutput("summaryTable"))
      )
    )
  )
)

# ── Server ─────────────────────────────────────────────────────────────────────

server <- function(input, output) {

  # Generate mutation landscape whenever landscape parameters change
  loci_react <- reactive({
    input$run   # re-generate when button is pressed
    isolate({
      set.seed(42)
      n <- input$n_loci
      s <- rgamma(n, shape = input$s_shape, rate = input$s_rate)
      s <- pmin(s, 0.99)
      h  <- rep(as.numeric(input$h_model), n)
      q0 <- runif(n, 0.05, input$q0_max)
      data.frame(s = s, h = h, q0 = q0)
    })
  })

  # Run multi-locus simulation (triggered by button)
  sim_result <- eventReactive(input$run, {
    set.seed(123)
    loci    <- loci_react()
    withProgress(message = "Running simulation…", value = 0, {
      q_array <- simulate_multilocus(loci,
                                     Ne   = input$Ne,
                                     nrep = input$nrep,
                                     ngen = input$ngen)
      setProgress(0.9)
      W_mat <- compute_fitness(q_array, loci)
    })
    list(q_array = q_array, W_mat = W_mat, loci = loci)
  }, ignoreNULL = FALSE)   # run once on startup with defaults

  # ── Genetic load plot ────────────────────────────────────────────────────────
  output$loadPlot <- renderPlot({
    res   <- sim_result()
    L_mat <- 1 - res$W_mat
    ngen  <- nrow(L_mat)
    nrep  <- ncol(L_mat)
    gens  <- seq_len(ngen)

    L_df           <- as.data.frame(L_mat)
    colnames(L_df) <- paste0("Rep", seq_len(nrep))
    L_df$generation <- gens
    L_long  <- pivot_longer(L_df, starts_with("Rep"),
                            names_to = "rep", values_to = "load")
    L_means <- L_long %>%
      group_by(generation) %>%
      summarise(mean_load = mean(load), .groups = "drop")

    ggplot() +
      geom_line(
        data   = L_long,
        aes(x  = generation, y = load, group = rep),
        colour = "#2196F3", alpha = 0.4, linewidth = 0.5
      ) +
      geom_line(
        data   = L_means,
        aes(x  = generation, y = mean_load),
        colour = "#0D47A1", linewidth = 1.4
      ) +
      geom_hline(
        yintercept = mean(L_mat[1, ]),
        linetype   = "dashed", colour = "grey40"
      ) +
      annotate("text",
               x     = ngen * 0.65,
               y     = mean(L_mat[1, ]) * 1.04,
               label = "Initial load",
               colour = "grey40", size = 3.5) +
      labs(
        title = paste0("Genetic load  (Ne = ", input$Ne,
                       ",  ", input$n_loci, " loci,  h = ", input$h_model, ")"),
        x     = "Generation",
        y     = "Genetic load  (L = 1 \u2212 W\u0305)"
      ) +
      theme_classic(base_size = 13)
  })

  # ── Locus fate plot ──────────────────────────────────────────────────────────
  output$fatePlot <- renderPlot({
    res     <- sim_result()
    loci    <- res$loci
    q_array <- res$q_array
    q_final <- q_array[dim(q_array)[1], , ]   # matrix [nrep × n_loci]

    fate_df <- data.frame(
      s           = loci$s,
      prop_purged = colMeans(q_final < 0.05),
      prop_fixed  = colMeans(q_final > 0.95),
      prop_segreg = colMeans(q_final >= 0.05 & q_final <= 0.95)
    ) %>%
      pivot_longer(starts_with("prop_"),
                   names_to  = "outcome",
                   values_to = "proportion") %>%
      mutate(outcome = dplyr::recode(outcome,
        prop_purged = "Purged  (q < 0.05)",
        prop_fixed  = "Fixed  (q > 0.95)",
        prop_segreg = "Segregating"
      ))

    ggplot(fate_df, aes(x = s, y = proportion, colour = outcome)) +
      geom_point(alpha = 0.55, size = 2) +
      geom_smooth(method = "loess", se = FALSE, linewidth = 1) +
      scale_colour_manual(values = c(
        "Purged  (q < 0.05)" = "#4DAF4A",
        "Fixed  (q > 0.95)"  = "#E41A1C",
        "Segregating"        = "#377EB8"
      )) +
      labs(
        title  = paste0("Locus fate by selection coefficient  (Ne = ", input$Ne, ")"),
        x      = "Selection coefficient (s)",
        y      = "Proportion of replicates",
        colour = "Outcome"
      ) +
      theme_classic(base_size = 13) +
      theme(legend.position = "right")
  })

  # ── Summary table ────────────────────────────────────────────────────────────
  output$summaryTable <- renderTable({
    res     <- sim_result()
    loci    <- res$loci
    W_mat   <- res$W_mat
    q_array <- res$q_array
    ngen    <- nrow(W_mat)
    q_final <- q_array[ngen, , ]

    data.frame(
      Statistic = c(
        "Number of loci simulated",
        "Mean selection coefficient (s)",
        "Dominance coefficient (h)",
        "Initial mean genetic load",
        "Final mean genetic load",
        "Change in genetic load",
        "Mean proportion of loci purged (q < 0.05)",
        "Mean proportion of loci fixed  (q > 0.95)",
        "Mean proportion of loci segregating"
      ),
      Value = round(c(
        nrow(loci),
        mean(loci$s),
        mean(loci$h),
        mean(1 - W_mat[1, ]),
        mean(1 - W_mat[ngen, ]),
        mean(1 - W_mat[ngen, ]) - mean(1 - W_mat[1, ]),
        mean(q_final < 0.05),
        mean(q_final > 0.95),
        mean(q_final >= 0.05 & q_final <= 0.95)
      ), 4)
    )
  })
}

shinyApp(ui = ui, server = server)
