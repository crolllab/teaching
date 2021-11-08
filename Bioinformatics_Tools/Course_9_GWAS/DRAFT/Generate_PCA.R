setwd("/Users/dcroll/Dropbox/Daniel/Documents/UNINE/Teaching/**2018_A/Bioinformatics_tools_2018/GWAS_class/Exercises/")

library(ggplot2)

# read PC table (from Tassel) and Info table (from publication)
PCA <- read.table("MaizeDivPanel_282_genotypes_PCs.txt", header=T)
Info <- read.table("MaizeDivPanel_282_genotypes_INFO.txt", header=T, sep="\t")

# 
joint.df <- merge(PCA, Info, all.x = T)

ggplot(joint.df, aes(x=PC1, y=PC2, color=Subpopulation)) + 
  geom_point(size = 3, alpha = 0.5) +
  labs(x = "Principal component 1", y = "Principal component 2") +
  theme(axis.text = element_text(color = "black"))

ggsave("PCA.MaizeAccessions.pdf", width=6, height=4.5)
