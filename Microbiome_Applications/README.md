# Microbiome Applications practical

## Aims of the practical
- Familiarity with the work in R, RStudio, and Quarto
- Sumarize and visualize microbiome composition data
- Assess differences among groups of samples
  
## Connection to the server  

- Open a web browser and go to the URL: `http://legcompute3.unine.ch:8787`
- Log in with your credentials

```
MA-Antoine
MA-Arthur
MA-Benoit
MA-Elena
MA-Liam
MA-Matthias
MA-Nina
MA-Ryutaro
MA-Stefany
MA-Subidsha
MA-Tinian
MA-Tristan
```

Password (same for all): `MA2025`

- To recover a file from RStudio, select it in the file tab on the left and click on the download icon (arrow pointing down).
- To upload a file, click on the upload icon (arrow pointing up) and select the file from your computer.

## Documenting your code and results with Quarto
- Quarto is a document format that allows you to combine code, text, and results in a single file.
- It is similar to RMarkdown and can be most easily used in RStudio.
- Quarto files have the extension `.qmd` and can be rendered to various formats (HTML, PDF, Word, etc.).
- You can create a new Quarto document by clicking on the `New File` button in RStudio and selecting `Quarto Document`. Give it a name (e.g., `Microbiome_Applications_practical_MyName.qmd`).
- You can render a Quarto document by clicking on the `Render` button in RStudio or by typing `quarto render` in the terminal.

- Look at the provided code, you see that a Quarto document starts by a header. You can adjust this to your liking.

```yaml
---
title: "Microbiome Applications practical"
author: "Your Name"
date: "2025-04-03"
format: html
editor: visual
---
```

- You can start a new sections by adding a new header. The number of `#` indicates the level of the header. For example, `##` is a second-level header, `###` is a third-level header, etc.

- You can add text, code chunks, and figures in the document. Code chunks are enclosed by three backticks (```) and start with `{r}`. `#` here means a comment, so not code. For example:

```r
# This is a code chunk
x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
```

## Handing in your work

- Please hand in your work by rendering the Quarto document to HTML or PDF and upload it to the Moodle platform. You only need to hand in your work at the end of the _second_ session.


## The dataset to analyze

We will look at a study entitled ["Fat, fibre and cancer risk in African Americans and rural Africans"](https://www.nature.com/articles/ncomms7342) published in 2015 in Nature Communications. The study investigates the association between diet and gut microbiome composition in African Americans and rural Africans. 

- The dataset is a CSV file named `diet_microbiome.csv`. It contains the following columns:
  - `SampleID`: the ID of the sample
  - `Group`: the group of the sample (African American or rural African)
  - `Diet`: the diet of the sample (high fat, low fat, high fiber, low fiber)
  - `Microbiome`: the microbiome composition of the sample (OTU table)

_Question 1: Summarize in your own words and 5-10 lines the main findings of the study. What is the main hypothesis? What are the main results? What are the conclusions?_

## Starting with the analyses

[Tutorial adapted from the microbiome tutorial by Lahti, Shetty et al.]

We will base our tutorial on the R package `microbiome` provided by co-authors of the study. This packages includes a wealth of functions to analyze microbiome data. The package is already installed on the server, so you don't need to install it again. You can load it by running the following command in R:

```r
library(microbiome)
library(tidyverse)

data(dietswap)
# There is a conflict between identically named functions called "transform"
transform <- microbiome::transform
```

As we have loaded the microbiome dataset, we can start by looking at the data. The dataset is a phyloseq object, which is a class used to store microbiome data in R. You can use the `print` function to see the contents of the object.

You find three main components in the dataset:
- `otu_table`: the OTU table, which contains the abundance of each OTU in each sample
- `sample_data`: the metadata of each sample, which contains information about e.g., group, diet, etc.
- `tax_table`: the taxonomic classification of each OTU

_Question 2: What is an OTU? What is the difference between an OTU and a species?_

Next, we want to summarize the microbiota composition of the samples. We want to focus on the most abundant and broadly shared taxa in the dataset. 

_Question 3: What is the difference between abundance and prevalence? What values did we choose?_

```r
# Merge rare taxa to speed up data processing
pseq <- transform(dietswap, "compositional")
pseq <- aggregate_rare(pseq, level = "Genus", detection = 1/100, prevalence = 50/100)

# Pick sample subset, here DI is the dietary intervention group and AFR is the African group
library(phyloseq)
pseq2 <- subset_samples(pseq, group == "DI" & nationality == "AFR" & timepoint.within.group == 1)

# Let's explore this subset. We can use helper functions to inspect the content.
```r
otu_table(pseq2)
sample_data(pseq2)
tax_table(pseq2)
``` 

# Contrast to normal western adults
```r
data(atlas1006)
pseq3 <- atlas1006 %>%
  subset_samples(DNA_extraction_method == "r") %>%
  aggregate_taxa(level = "Phylum") %>%  
  microbiome::transform(transform = "compositional")
```

_Question 4: What body types are represented in the atlas1006 dataset?_

# Plot the taxa composition

```r
library(hrbrthemes)
library(gcookbook)
library(tidyverse)
#theme_set(theme_bw(21))
p <- pseq3 %>%
  plot_composition(sample.sort = "Firmicutes", otu.sort = "abundance") +
  # Set custom colors
  scale_fill_manual("Phylum",values = default_colors("Phylum")[taxa(pseq3)]) +
  scale_y_continuous(label = scales::percent) + 
  theme_ipsum(grid="Y") +
  # Removes sample names and ticks
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
print(p)
```

# Limit the analyses to core taxa and specific individuals
```r 
# Limit the analysis on core taxa and specific sample group
p <- plot_composition(pseq2,
                      taxonomic.level = "Genus",
                      sample.sort = "nationality",
                      x.label = "nationality") +
  scale_fill_brewer("Genera", palette = "Paired") +
  guides(fill = guide_legend(ncol = 1)) +
  scale_y_percent() +
  labs(x = "Samples", y = "Relative abundance (%)",
       title = "Relative abundance data") + 
  theme_ipsum(grid="Y") +
  theme(axis.text.x = element_text(angle=90, hjust=1),
        legend.text = element_text(face = "italic"))
print(p)  
```
