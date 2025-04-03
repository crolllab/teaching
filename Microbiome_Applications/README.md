# Microbiome Applications practical

## Aims of the practical
- Familiarity with the work in R, RStudio, and Quarto
- Sumarize and visualize microbiome composition data
- Assess differences among groups of samples

## Handing in your work

- Please hand in your answers to the questions (see below) by rendering the Quarto document to HTML or PDF and upload it to the Moodle platform. You only need to hand in your work at the end of the _second session_.

## Connection to the server  

- Open a web browser and go to the URL: [http://legcompute3.unine.ch:8787](http://legcompute3.unine.ch:8787)
- Log in with your credentials (see below).

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

Password (same for all): `MA_2025`

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
date: "2025-04-03"
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


## The microbiome dataset to analyze

We will look at a study entitled ["Fat, fibre and cancer risk in African Americans and rural Africans"](https://www.nature.com/articles/ncomms7342) published in 2015 in Nature Communications. The study investigates the association between diet and gut microbiome composition in African Americans and rural Africans. 

_Question 1: Summarize in your own words and 5-10 lines the main findings of the study. What is the main hypothesis? What are the main results? What are the conclusions? Focus on the microbiome part and sidestep the metabolic and tissue analyses._

Some helpful glossary terms:
- AFR: African
- AA(M): African American
- HE: home environment
- DI: dietary intervention (hospital)
- ED: endoscopy day

Take a look at Table 1 for a description of the sampling and study design.

## Starting with the analyses

[Tutorial adapted from the microbiome tutorial by Lahti, Shetty et al.]

We will base our tutorial on the R package `microbiome` provided by co-authors of the study. This packages includes a wealth of functions to analyze microbiome data. The package is already installed on the server, so you don't need to install it again. You can load it by running the following command in R:

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

As we have loaded the microbiome dataset, we can start by looking at the data. The dataset is a phyloseq object, which is a class used to store microbiome data in R. You can use the `print` function to see the contents of the object.

The dataset is part of the R package `microbiome` and is called `dietswap`. It contains the following elements:
  - `otu_table`: the OTU table, which contains the abundance of each OTU in each sample
  - `tax_table`: the taxonomic classification of each OTU
  - `sam_data`:  the metadata of each sample, which contains information about e.g., nationality, diet, timepoint, etc.
  - `phy_tree`: the phylogenetic tree of the OTUs. This is empty for this dataset.
  - `refseq`: the reference sequences of the OTUs. This is empty for this dataset.

## Explore the dataset

There are specific functions that help you "extract" the relevent `dietswap` dataset. Try these:

```r
# Extract the OTU table
otu_table(dietswap)
# Extract the taxonomic table
tax_table(dietswap)
# Extract the sample data
sample_data(dietswap)
```

We will explore first the available samples, categories and category sizes.

```r
# for simplicity, we create a new dataframe with the sample data
sample.df <- sample_data(dietswap)
# Sex ratio
ggplot(sample.df, aes(x = sex)) + geom_bar() + facet_grid(. ~ nationality ) + theme_ipsum()
# BMI types
ggplot(sample.df, aes(x = bmi_group)) + geom_bar() + facet_grid(. ~ nationality ) + theme_ipsum()
# Treatment group
ggplot(sample.df, aes(x = group)) + geom_bar() + facet_grid(. ~ nationality ) + theme_ipsum()
```

## Microbiome composition analyses
_Question 2: What is an OTU? What is the difference between an OTU and a species?_

Next, we want to summarize the microbiota composition of the samples. We want to focus on the most abundant and broadly shared taxa in the dataset. 

_Question 3: What is the difference between abundance and prevalence in the context of our samples?_

_Question 4: What is a HITChip phylogenetic microarray?_

As a first analysis step, we want to visualize the frequency of OTUs across all samples.

```r
# counting how widely spread each taxa is among samples
otu.df <- as.data.frame(otu_table(dietswap))
otu.df$taxa_count_non0 <- rowSums(otu.df != 0)

ggplot(otu.df, aes(x = taxa_count_non0)) +
  geom_histogram() + 
  theme_ipsum() +
  labs(y = "Number of OTUs", x = "Number of samples")  
```

_Question 5: What is more common - taxa shared among all samples or taxa unique to one sample?_

Next, we explore abundance of taxa based on the 

```r
ggplot(otu.df, aes(x = `Sample-1`)) +
  geom_histogram(binwidth = 10) + 
  theme_ipsum() +
  labs(y = "Number of OTUs", x = "Abundance of OTU")
```

We observe that the majority of OTUs are rare, with a few abundant ones. This is a common pattern in microbiome data. You can check that this pattern is true for other samples than "Sample-1" by changing the sample name in the code above.

## Merge rare taxa to speed up data processing

We will merge rare taxa to speed up data processing. We will use the `aggregate_rare` function from the `microbiome` package. This function will merge all taxa that are below a certain abundance threshold into a single "Other" category.

```r
# Merge rare taxa
mbiot <- transform(dietswap, "compositional")
# Setting thresholds for detection and prevalence (among samples)
mbiot <- aggregate_rare(mbiot, level = "Genus", detection = 1/100, prevalence = 50/100)
```

`mbiot` is now a phyloseq object that contains the merged taxa. You can check the contents of the object by using the `print` function.

## Plot the genus composition among samples

Sorted by the most abundant taxon (Prevotella melaninogenica et rel.)

```r
mbiot %>%
  plot_composition(sample.sort = "Prevotella melaninogenica et rel.", otu.sort = "abundance") +
  scale_y_continuous(label = scales::percent) + 
  scale_fill_brewer("Genera", palette = "Paired") +
  theme_ipsum(grid="Y") +
  labs(x = "Samples", y = "Relative abundance (%)",
       title = "Relative abundance data") + 
  # Removes sample names and ticks
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
```

Plot the samples sorted by geography (nationality)

```r
plot_composition(mbiot,
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


Subset the dataset to a specific group of samples

```r
# The subset function helps to filter the samples based on specific criteria
mbiot_sub <- subset_samples(mbiot, group == "DI" & nationality == "AFR")
````

Repeat the plot about but using the subset dataset

```r
plot_composition(mbiot_sub,
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
```


## Plot composition heatmaps

For this example, we will return to the full dataset (`mbiot`)

```r
microbiome::transform(mbiot, "compositional") %>% 
  plot_composition(plot.type = "heatmap",
                   sample.sort = "neatmap", 
                   otu.sort = "neatmap") +
  theme(axis.text.y=element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.text.x = element_text(size = 9, hjust=1),
        legend.text = element_text(size = 8)) +
  ylab("Samples")
```
