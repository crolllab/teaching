library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

simulate_drift <- function(p_start, Ne, nrep, ngen) {
  freq      <- matrix(NA, nrow = ngen, ncol = nrep)
  freq[1, ] <- p_start
  for (t in 2:ngen) {
    freq[t, ] <- rbinom(nrep, size = 2 * Ne, prob = freq[t - 1, ]) / (2 * Ne)
  }
  freq
}
ui <- fluidPage(
  titlePanel("Translocation Planner: Heterozygosity Simulator"),
  sidebarLayout(
    sidebarPanel(
      h4("Population parameters"),
      sliderInput("Ne",     "Effective population size (Ne):",
                  min = 10, max = 500, value = 100, step = 10),
      sliderInput("n_pops", "Number of populations:",
                  min = 2,  max = 10,  value = 5,   step = 1),
      sliderInput("ngen",   "Total generations:",
                  min = 50, max = 500, value = 200, step = 10),
      numericInput("p0",    "Initial allele frequency (p0):",
                   min = 0.05, max = 0.95, value = 0.5, step = 0.05),
      hr(),
      h4("Translocation event"),
      checkboxInput("do_trans", "Enable translocation", value = TRUE),
      sliderInput("t_trans",    "Generation of translocation:",
                  min = 10, max = 490, value = 80, step = 5),
      sliderInput("n_migrants", "Number of migrants:",
                  min = 1,  max = 100, value = 10, step = 1),
      numericInput("p_source",  "Source allele frequency:",
                   min = 0.05, max = 0.95, value = 0.5, step = 0.05)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Heterozygosity over time", plotOutput("hetPlot", height = "460px")),
        tabPanel("Summary table",            tableOutput("summaryTable"))
      )
    )
  )
)

server <- function(input, output) {
  
  sim_data <- reactive({
    set.seed(42)
    Ne      <- input$Ne
    nrep    <- input$n_pops
    ngen    <- input$ngen
    p0      <- input$p0
    t_trans <- min(input$t_trans, ngen - 1)   # guard: must be < ngen
    n_m     <- input$n_migrants
    p_src   <- input$p_source
    
    # Baseline: pure drift (no translocation)
    freq_no <- simulate_drift(p0, Ne, nrep, ngen)
    
    # With translocation (two-phase)
    freq_pre  <- simulate_drift(p0, Ne, nrep, t_trans)
    p_after   <- (Ne * freq_pre[t_trans, ] + n_m * p_src) / (Ne + n_m)
    freq_post <- simulate_drift(p_after, Ne, nrep, ngen - t_trans + 1)
    freq_with <- rbind(freq_pre, freq_post[-1, ])
    
    list(freq_no = freq_no, freq_with = freq_with, t_trans = t_trans)
  })
  
  output$hetPlot <- renderPlot({
    dat         <- sim_data()
    generations <- 1:input$ngen
    H0          <- 2 * input$p0 * (1 - input$p0)
    H_th        <- H0 * (1 - 1 / (2 * input$Ne))^generations
    
    make_long <- function(freq_mat, label) {
      H_mat <- 2 * freq_mat * (1 - freq_mat)
      df    <- as.data.frame(H_mat)
      colnames(df) <- paste0("Pop", seq_len(input$n_pops))
      df$generation <- generations
      long <- pivot_longer(df, starts_with("Pop"),
                           names_to = "population", values_to = "H_observed")
      long$scenario <- label
      long
    }
    
    H_long_both <- bind_rows(
      make_long(dat$freq_no,   "No translocation"),
      make_long(dat$freq_with, "With translocation")
    )
    
    H_mean_no   <- rowMeans(2 * dat$freq_no   * (1 - dat$freq_no))
    H_mean_with <- rowMeans(2 * dat$freq_with * (1 - dat$freq_with))
    
    means_df <- data.frame(
      generation = rep(generations, 3),
      H    = c(H_mean_no, H_mean_with, H_th),
      line = rep(c("Observed mean — no translocation",
                   "Observed mean — with translocation",
                   "Expected (no translocation)"), each = input$ngen)
    )
    
    p <- ggplot() +
      geom_line(
        data  = H_long_both,
        aes(x = generation, y = H_observed,
            colour = scenario, group = interaction(population, scenario)),
        alpha = 0.35, linewidth = 0.55
      ) +
      geom_line(
        data = means_df,
        aes(x = generation, y = H, linetype = line, colour = line),
        linewidth = 1
      ) +
      scale_colour_manual(
        values = c(
          "With translocation"                   = "#2196F3",
          "No translocation"                     = "#FF7043",
          "Observed mean — with translocation"   = "#0D47A1",
          "Observed mean — no translocation"     = "#BF360C",
          "Expected (no translocation)"          = "darkred"
        ),
        guide = guide_legend(
          override.aes = list(
            linetype  = c("dashed", "solid", "solid", "solid", "solid"),
            linewidth = c(1, 0.55, 1, 1, 0.55),
            alpha     = c(1, 0.35, 1, 1, 0.35)
          )
        )
      ) +
      scale_linetype_manual(values = c(
        "With translocation"                   = "solid",
        "No translocation"                     = "solid",
        "Observed mean — with translocation"   = "solid",
        "Observed mean — no translocation"     = "solid",
        "Expected (no translocation)"          = "dashed"
      )) +
      guides(linetype = "none") +
      labs(
        title  = paste0("Heterozygosity over time (Ne = ", input$Ne,
                        ", ", input$n_migrants, " migrants at gen ", dat$t_trans, ")"),
        x      = "Generation",
        y      = "Heterozygosity (H)",
        colour = NULL
      ) +
      theme_classic(base_size = 13) +
      theme(legend.position = "right",
            legend.key.width = unit(1.5, "cm"))
    
    if (input$do_trans) {
      p <- p +
        geom_vline(xintercept = dat$t_trans, linetype = "dotted", colour = "grey30") +
        annotate("text", x = dat$t_trans + 2, y = H0 * 0.97,
                 label = paste0("Translocation\n(gen ", dat$t_trans,
                                ", ", input$n_migrants, " migrants)"),
                 hjust = 0, size = 3.2, colour = "grey30")
    }
    p
  })
  
  output$summaryTable <- renderTable({
    dat  <- sim_data()
    ngen <- input$ngen
    H0   <- 2 * input$p0 * (1 - input$p0)
    
    H_final_no   <- mean(2 * dat$freq_no[ngen, ]   * (1 - dat$freq_no[ngen, ]))
    H_final_with <- mean(2 * dat$freq_with[ngen, ] * (1 - dat$freq_with[ngen, ]))
    H_th_final   <- H0 * (1 - 1 / (2 * input$Ne))^ngen
    
    data.frame(
      Statistic = c(
        "Initial heterozygosity (H0)",
        "Expected H at final generation (theory)",
        "Observed mean H — no translocation",
        "Observed mean H — with translocation",
        "Absolute H rescued by translocation",
        "% of H0 retained — no translocation",
        "% of H0 retained — with translocation"
      ),
      Value = round(c(
        H0,
        H_th_final,
        H_final_no,
        H_final_with,
        H_final_with - H_final_no,
        100 * H_final_no   / H0,
        100 * H_final_with / H0
      ), 4)
    )
  })
}

shinyApp(ui = ui, server = server)
