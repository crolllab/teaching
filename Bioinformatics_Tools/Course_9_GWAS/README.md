### Bioinformatics Tools

# Course 9

### Major aims  
- A basic understanding of phenotype-genotype association mapping (i.e. GWAS)
- Know key filter steps

### Report to submit

Please compile brief answers to the questions for your report ("Q1", "Q2", etc.). Depending on the question, you can add a short text, some code or a graphic. The answers can be in a text file, Word doc, etc.

You can work alone or in groups. Every student should submit their own report through Moodle though. No copy-pasting, please. Formulate answers in your own words.

## The maize dataset

As a manageable dataset to work with, we will use a diversity study of maize accessions covering the genetic diversity of the crop. At its center of origin in Mexico, farmers retained a very high degree of diversity.

![](./images/maize.png)  

59 native Mexican maize landraces, CIMMYT

![](./images/gendiv.png)  

Maize originated from annual teosinte (_Zea mays_ subspecies _parviglumis_) around 9,000 years BP. Co-existing teosinte species in Mexico include also _Zea mays_ subspecies _mexicana_.

![](./images/field.png)  

We will analyze a set of 3093 SNPs (single nucleotide polymorphisms) of 282 inbred maize lines representing the global diversity in maize-breeding programs.

![](./images/pca.png)  

## Access the datasets

This genotyping method mainly exists to save money during sequencing. Instead of covering the entire genome, GBS allows to target a small subset of regions. This reduced number of variants (or SNPs) is often sufficient for analyses.

![](./images/gbs.png)  



Before we download the datasets, let's navigate to a specific folder:

`cd $HOME`

This ensure that we all start the analyses in the same place (our home folder). All data is in the *datasets* folder.

```
### Download links from the github site

# Genotype dataset
wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_9_GWAS/datasets/MaizeDivPanel_282_genotypes_GBS.hmp.txt

# Principal component analysis
wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_9_GWAS/datasets/MaizeDivPanel_282_genotypes_PCs.txt

# Information about the accessions (individuals)
wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_9_GWAS/datasets/MaizeDivPanel_282_genotypes_INFO.txt

# Phenotypic trait dataset
wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_9_GWAS/datasets/MaizeDivPanel_282_phenotypes_33traits.txt
```

_Q1: Use `head` to briefly check out each of the three files. Briefly describe the information you find in each._

### Visualize the Genotyping-by-sequencing (GBS) data of maize

From here on, we will work entirely in R ("Console"), not the "Terminal"!

We want to get a good representation of the genetic diversity of our maize individuals (accessions). Here is code to produce a principal component analysis (PCA) of the dataset.

```
# In R "Console"

library(ggplot2)

# read in the data (principal components and info)
PCA.df <- read.table("MaizeDivPanel_282_genotypes_PCs.txt", header=T)
info.df <- read.table("MaizeDivPanel_282_genotypes_INFO.txt", header=T, sep="\t")

# combine the two datasets
joint.df <- merge(PCA.df, info.df, all.x = T)

ggplot(joint.df, aes(x=PC1, y=PC2, color=Subpopulation)) +
  geom_point(size = 3, alpha = 0.5) +
  labs(x = "Principal component 1", y = "Principal component 2") +
  theme(axis.text = element_text(color = "black"))

ggsave("PCA.MaizeAccessions.pdf", width=6, height=4.5)
```

_Q2: What groups (subpopulations) of maize appear most distinct from the others?_

### Visualize the distribution of phenotypic traits

```
# In R "Console"

library(ggplot2)
library(reshape2)

# read in the data (principal components and info)
info.df <- read.table("MaizeDivPanel_282_genotypes_INFO.txt", header=T, sep="\t")
pheno.df <- read.table("MaizeDivPanel_282_phenotypes_33traits.txt", header=T, sep="\t")

# rename the first column name (from <Traits> to Accessions)
names(pheno.df)[1] <- "Accession"


# combine the two datasets
joint.df <- merge(pheno.df, info.df)

# melt the data
joint.m.df <- melt(joint.df, value.vars = names(joint.df)[2:34], value.name = "Trait_value", variable.name = "Trait")

# plot histograms for each trait
ggplot(joint.m.df, aes(x = Trait_value)) +

  geom_histogram(bins = 10) +
  facet_wrap(~Trait, scales = "free")

ggsave("Traits.MaizeAccessions.pdf", width=12, height=8)
```

_Q3: What kind of distribution describes best the majority of the traits?_

## Perform association mapping (GWAS)

We will now use the R package GAPIT3 to perform GWAS analysis for all traits.

```
# In R "Console"

library(GAPIT3)
traits.data  <- read.table("MaizeDivPanel_282_phenotypes_33traits.txt", head = TRUE)
genotypes.data <- read.table("MaizeDivPanel_282_genotypes_GBS.hmp.txt", head = FALSE)


# Please check if the code above gives some error message. Anything related to "File not found" or "can't open" usually means one of two things: 1) you have not yet downloaded the files (successfully) or 2) you are running the code in a different folder than the downloaded files.

# Perform a mixed linear model (MLM) GWAS
myGAPIT <- GAPIT(
  Y=traits.data,
  G=genotypes.data,
  PCA.total=3,
)
```

If all runs well, you will find a large number of
