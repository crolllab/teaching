# Microbiome Applications practical

## Aims of the practical

- Gain familiarity with R, RStudio, and Quarto
- Summarise and visualise microbiome composition data
- Assess differences in microbiome diversity and composition among sample groups

## Handing in your work

- Answer the numbered questions throughout this document by editing your Quarto file.
- Render the document to HTML or PDF and upload it to the Moodle platform. You only need to hand in your work at the end of the **second session**.

## Connection to the server  

- Open a web browser and go to the URL: [http://legcompute3.unine.ch:8787](http://legcompute3.unine.ch:8787)
- Log in with your credentials (see Moodle how to claim an account).

- What you see is a web interface RStudio. All code will run on the server, so you don't need to install anything on your computer.
- To recover a file from RStudio, select it in the file tab on the right and click on the wheels icon (select Export).
- To upload a file, click on the upload icon (arrow pointing up) and select the file from your computer.

## Documenting your code and results with Quarto
- Quarto is a document format that allows you to combine code, text, and results in a single file.
- It is similar to RMarkdown and can be most easily used within RStudio.
- Quarto files have the extension `.qmd` and can be rendered to various formats (HTML, PDF, Word, etc.).
- You can create a new Quarto document by clicking on the `New File` menu in RStudio (File -> ...) and selecting `Quarto Document`. Give it a name (e.g., `Microbiome_Applications_practical_MyName.qmd`).
- You can render a Quarto document by clicking on the `Render` button in RStudio.

- Look at the provided code, you see that a Quarto document starts by a header. You can adjust this to your liking.

```yaml
---
title: "Microbiome Applications practical"
author: "Your Name"
date: "2026-04-03"
format: html
editor: visual
---
``` 

- You can start new sections by adding a new header. The number of `#` indicates the level of the header. For example, `##` is a second-level header, `###` is a third-level header, etc.

- You can add text, code chunks, and figures in the document. Code chunks are enclosed by three backticks and then `{r}` (if your code is R code). `#` here means a comment, so not code. For example:

```r
# This is a code chunk
x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
```

- To produce a pdf instead of a html output ("rendering"), replace the `html` with `pdf` in the header. You need to include also this code here at the beginning of your document. Use the correct three backticks to enclose the code and the `{r}` (see above). 

```r
library(knitr)
knitr::opts_chunk$set(dev = "ragg_png")
```


## The microbiome dataset to analyse

We will look at a study entitled ["Fat, fibre and cancer risk in African Americans and rural Africans"](https://www.nature.com/articles/ncomms7342) published in 2015 in *Nature Communications*. The study investigates the association between diet and gut microbiome composition in African Americans and rural Africans.

> **Question 1:** Summarise in your own words (5–10 lines) the main findings of the study. What is the main hypothesis? What are the main results and conclusions? Focus on the microbiome part and sidestep the metabolic and tissue analyses.

### Glossary of key terms

| Abbreviation | Meaning |
|---|---|
| AFR | African (rural South African) |
| AA(M) | African American |
| HE | Home environment (baseline, no dietary intervention) |
| DI | Dietary intervention (participants housed in hospital and fed a controlled diet) |
| ED | Endoscopy day (sample collected on the day of the colonoscopy) |

Take a look at Table 1 of the paper for a full description of sampling and study design.

## Starting with the analyses

*Tutorial adapted from the microbiome tutorial by Lahti, Shetty et al.*

We will base our tutorial on the R package `microbiome`, which was developed by co-authors of the study. It provides a rich set of functions for analysing and visualising microbiome data. The package is already installed on the server. Load it together with the other required packages:

```r
library(microbiome)
library(tidyverse)
library(phyloseq)
library(hrbrthemes)
library(gcookbook)

data(dietswap)
# There is a conflict between identically named functions called "transform"
transform <- microbiome::transform
```

Once loaded, `dietswap` is a **phyloseq** object — a dedicated R class for storing microbiome data. Use `print()` to get an overview:

```r
print(dietswap)
```

The object contains the following components:

| Component | Description |
|---|---|
| `otu_table` | Abundance of each OTU (row) in each sample (column) |
| `tax_table` | Taxonomic classification of each OTU (Kingdom → Genus) |
| `sam_data` | Sample metadata: nationality, diet group, timepoint, BMI, sex, etc. |
| `phy_tree` | Phylogenetic tree — *not available for this dataset* |
| `refseq` | Reference sequences — *not available for this dataset* |

## Explore the dataset

Phyloseq provides accessor functions to extract each component individually:

```r
# Extract the OTU table (taxa × samples)
otu_table(dietswap)
# Extract the taxonomic classification table
tax_table(dietswap)
# Extract the sample metadata
sample_data(dietswap)
```

Let's start by visualising how the samples are distributed across the key metadata variables (sex, BMI group, and dietary group), broken down by nationality:

```r
# For convenience, pull the sample metadata into a plain data frame
sample.df <- sample_data(dietswap)

# Sex ratio by nationality
ggplot(sample.df, aes(x = sex)) +
  geom_bar() + facet_grid(. ~ nationality) + theme_ipsum()

# BMI category by nationality
ggplot(sample.df, aes(x = bmi_group)) +
  geom_bar() + facet_grid(. ~ nationality) + theme_ipsum()

# Dietary intervention group by nationality
ggplot(sample.df, aes(x = group)) +
  geom_bar() + facet_grid(. ~ nationality) + theme_ipsum()
```

## Microbiome composition analyses

> **Question 2:** What is an OTU? What is the difference between an OTU and a species?

Next, we want to summarise the microbiota composition of the samples, focusing on the most abundant and broadly shared taxa.

> **Question 3:** What is the difference between *abundance* and *prevalence* in the context of these samples?

> **Question 4:** What is a HITChip phylogenetic microarray? How does it differ from 16S rRNA amplicon sequencing?

As a first step, we visualise the **prevalence** of each OTU — i.e., how many samples it appears in:

```r
# For each OTU (row), count the number of samples where it is detected (abundance > 0)
otu.df <- as.data.frame(otu_table(dietswap))
otu.df$taxa_count_non0 <- rowSums(otu.df != 0)

ggplot(otu.df, aes(x = taxa_count_non0)) +
  geom_histogram() +
  theme_ipsum() +
  labs(y = "Number of OTUs", x = "Number of samples in which OTU is detected")
```

> **Question 5:** What is more common — taxa shared among all samples, or taxa unique to just one sample?

Next, we look at the **abundance distribution** of OTUs within a single sample. The example below uses `Sample-1`:

```r
ggplot(otu.df, aes(x = `Sample-1`)) +
  geom_histogram(binwidth = 10) +
  theme_ipsum() +
  labs(y = "Number of OTUs", x = "Abundance of OTU in Sample-1")
```

You will observe that the majority of OTUs have very low abundance, with only a few highly abundant ones. This **hollow curve** or **long-tail** distribution is a universal feature of microbiome datasets. Try swapping `Sample-1` for another sample name to confirm the pattern holds.

## Filter and aggregate rare taxa

Working with hundreds of low-abundance OTUs adds noise and slows down computation. We therefore:

1. **Convert to relative (compositional) abundance** — each sample's counts are divided by its total, so values represent proportions summing to 1.
2. **Aggregate rare taxa at the genus level** — any genus detected at less than 1 % abundance (`detection = 1/100`) in fewer than 50 % of samples (`prevalence = 50/100`) is collapsed into a single *"Other"* category.

```r
# Step 1: convert raw counts to relative abundance (proportions sum to 1 per sample)
mbiot <- transform(dietswap, "compositional")

# Step 2: merge genera that are rare or infrequent into an "Other" category
mbiot <- aggregate_rare(mbiot, level = "Genus", detection = 1/100, prevalence = 50/100)

# Inspect the reduced dataset
print(mbiot)
```

This leaves you with a much smaller set of well-characterised genera plus the *Other* bin.

## Plot genus composition across samples

### All samples, sorted by the dominant taxon

Samples are ordered by the relative abundance of *Prevotella melaninogenica* et rel. — the most abundant genus in this dataset — so that compositional gradients become visible from left to right:

```r
mbiot %>%
  plot_composition(sample.sort = "Prevotella melaninogenica et rel.",
                   otu.sort = "abundance") +
  scale_y_continuous(label = scales::percent) +
  scale_fill_brewer("Genera", palette = "Paired") +
  theme_ipsum(grid = "Y") +
  labs(x = "Samples", y = "Relative abundance (%)",
       title = "Genus-level composition — sorted by dominant taxon") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
```

### All samples, grouped by nationality

Sorting by `nationality` places AFR and AAM samples side-by-side, making geographic differences in composition immediately apparent:

```r
plot_composition(mbiot,
                 taxonomic.level = "Genus",
                 sample.sort = "nationality",
                 x.label = "nationality") +
  scale_fill_brewer("Genera", palette = "Paired") +
  guides(fill = guide_legend(ncol = 1)) +
  scale_y_percent() +
  labs(x = "Samples", y = "Relative abundance (%)",
       title = "Genus-level composition — grouped by nationality") +
  theme_ipsum(grid = "Y") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.text = element_text(face = "italic"))
```

### Subset to a specific group

You can focus on any sub-group of interest using `subset_samples()`. The example below selects only rural African participants during the dietary intervention (DI), i.e., when they were fed an African American-style diet in a controlled hospital setting:

```r
# Recall: DI = dietary intervention group; AFR = rural African participants
mbiot_sub <- subset_samples(mbiot, group == "DI" & nationality == "AFR")
```

Repeat the composition plot for this subset:

```r
plot_composition(mbiot_sub,
                 taxonomic.level = "Genus",
                 sample.sort = "nationality",
                 x.label = "nationality") +
  scale_fill_brewer("Genera", palette = "Paired") +
  guides(fill = guide_legend(ncol = 1)) +
  scale_y_percent() +
  labs(x = "Samples", y = "Relative abundance (%)",
       title = "Genus-level composition — AFR dietary intervention only") +
  theme_ipsum(grid = "Y") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.text = element_text(face = "italic"))
```


## Plot composition heatmaps

A heatmap gives a simultaneous overview of all genera across all samples. The `"neatmap"` ordering re-arranges both rows (genera) and columns (samples) using a seriation algorithm that places the most similar entries adjacent to each other, making compositional gradients and clusters visually clear:

```r
# Return to the full dataset (mbiot) for the heatmap
microbiome::transform(mbiot, "compositional") %>%
  plot_composition(plot.type = "heatmap",
                   sample.sort = "neatmap",
                   otu.sort    = "neatmap") +
  theme(axis.text.y  = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x  = element_text(size = 9, hjust = 1),
        legend.text  = element_text(size = 8)) +
  ylab("Samples")
```

> **Question 6:** Formulate three distinct, simple questions about microbiota composition differences between sample groups. Adapt the plots above (e.g. by subsetting samples or changing the sorting variable) to address each question visually. For each question, provide: (1) the question, (2) the code you used, (3) the resulting plot, and (4) a brief interpretation. Quantitative tests are not required.

**Hint:** The following plot gives an overview of the sample distribution across the available metadata factors, which may help you identify interesting comparisons:

```r
ggplot(sample.df, aes(x = bmi_group, fill = after_stat(count))) +
  geom_bar() +
  theme_ipsum() +
  scale_fill_distiller(direction = 1) +
  facet_grid(sex ~ nationality)
```

## Microbiome diversity analyses

In this section we shift from describing *which* taxa are present towards quantifying *how diverse* each sample is. **Alpha diversity** summarises the diversity within a single sample — capturing both species richness (how many taxa) and evenness (how equally abundant they are). For a review of alpha-diversity metrics, see the [Wikipedia page on alpha diversity](https://en.wikipedia.org/wiki/Alpha_diversity).

We will continue working with the `mbiot` dataset (the filtered, relative-abundance phyloseq object created above). If you are starting a fresh R session, re-run the package-loading and `mbiot`-creation steps first.

Here's the code to calculate and visualize different metrics per sample.

### Alpha diversity

The `alpha()` function computes several richness and diversity indices simultaneously for each sample:

```r
library(microbiome)
library(knitr)

mbiot_tab <- microbiome::alpha(mbiot, index = "all")
kable(head(mbiot_tab))
```

### Rarity

Rarity indices quantify how concentrated the community is among rare, low-abundance taxa — higher values indicate that rare taxa contribute more to the overall community:

```r
tab <- rarity(mbiot, index = "all")
kable(head(tab))
```

### Dominance

Dominance indices capture the contribution of the single most abundant taxon. A highly dominant community is one where one or a few taxa account for most of the reads:

```r
tab <- dominance(mbiot, index = "all")
kable(head(tab))
```

### Evenness

Evenness measures how uniformly individuals are distributed across taxa. A perfectly even community has all taxa at equal abundance; an uneven community has a few very dominant taxa and many rare ones:

```r
tab <- evenness(mbiot, index = "all")
kable(head(tab))
```

### Visualising diversity indices

Boxplots are a concise way to compare Shannon diversity (which balances both richness and evenness) across dietary intervention groups:

```r
p.shannon <- boxplot_alpha(mbiot,
                           index      = "shannon",
                           x_var      = "group",
                           fill.colors = c(HE = "cyan4", DI = "deeppink4", ED = "darkorange2"))

p.shannon <- p.shannon + theme_minimal() +
  labs(x = "Dietary group", y = "Shannon diversity") +
  theme(axis.text    = element_text(size = 12),
        axis.title   = element_text(size = 16),
        legend.text  = element_text(size = 12),
        legend.title = element_text(size = 16))
p.shannon
```

> **Note:** To compare a different grouping variable (e.g. `nationality` or `bmi_group`), update `x_var` and adjust the colour names in `fill.colors` to match the new group levels.

### Statistical testing of diversity differences

To determine whether the observed differences in Shannon diversity across groups are statistically significant, we use a one-way ANOVA followed by Tukey's Honest Significant Difference (HSD) test for pairwise comparisons:

```r
d <- meta(mbiot)
d$diversity <- microbiome::diversity(mbiot, "shannon")$shannon

# One-way ANOVA: does Shannon diversity differ among dietary groups?
model <- aov(diversity ~ group, data = d)
anova(model)

# Tukey's HSD: which specific pairs of groups differ?
TukeyHSD(model)
```

> **Note:** To test a different grouping factor, replace `group` in the `aov()` formula with the variable of interest (e.g. `nationality`, `sex`, or `bmi_group`).


## Visualising sample similarities

Ordination methods reduce the high-dimensional OTU table to a 2-D plot where similar samples cluster together.

### PCA (Principal Component Analysis)

PCA is a linear method that finds the axes of greatest variance in the data. Points far apart in the PCA plot have very different overall compositions. We apply a **centred log-ratio (CLR) transformation** before PCA because it is the compositionally appropriate way to handle relative abundance data — it removes the unit-sum constraint that distorts Euclidean distances on raw proportions:

```r
plot_landscape(mbiot, method = "PCA", transformation = "clr", col = "group") +
  labs(title = "PCA of genus composition (CLR-transformed)") +
  scale_color_brewer("Group", palette = "Paired")
```

### t-SNE (t-distributed Stochastic Neighbor Embedding)

t-SNE is a **non-linear** dimensionality reduction method that prioritises preserving local neighbourhood structure — samples that are most similar end up closest together. It is especially good at revealing tight clusters, but distances *between* well-separated clusters are not directly interpretable. We use a **Hellinger transformation** here (square-root of proportions), which down-weights very abundant taxa and makes Euclidean distance behave more like the Bray-Curtis dissimilarity commonly used in ecology.

For a detailed visual explainer of t-SNE, see: [t-SNE clearly explained](https://medium.com/data-science/t-sne-clearly-explained-d84c537f53a)

```r
plot_landscape(mbiot, "t-SNE",
               distance       = "euclidean",
               transformation = "hellinger",
               col            = "group") +
  labs(title = "t-SNE of genus composition (Hellinger-transformed)") +
  scale_color_brewer("Group", palette = "Paired")
```

> **Question 7:** Adjust both ordination plots to colour points by (a) nationality and (b) BMI group. What patterns emerge that were not visible when colouring by dietary group?

> **Synthesis — Question 8:** Based on all the analyses above (composition plots, heatmaps, alpha diversity, and ordinations), summarise the main differences you observe between the sample groups. Do the different methods tell a consistent story? How would you describe the biological significance of these differences?
