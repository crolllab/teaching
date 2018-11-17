### TP Génétique évolutive 4

(28 novembre 2018)


# Analyses de polymorphisme et structuration des populations humaines

### Introduction des concepts (voir slides)

-	SNP, MAF, technique de séquençage
-	Répétitions FST, PCA, STRUCTURE
-	Structure d’un fichier VCF

### Les données: "The 1000 Genomes Project"  
- La publication principale est apparue dans Nature vol 526, pages 68–74, 2015: [https://www.nature.com/articles/nature15393](https://www.nature.com/articles/nature15393)
- 2504 individus de 26 populations à travers le monde
- 84.7 mio SNP identifiés

### Les données simplifiées pour ces TP

- Sous-échantillonnage des SNPs 1/2000: `Human1000G.2000xSubsampled.noMAF.recode.vcf` (format VCF)

- Filtrage pour une fréquence allélique mineur (MAF) >0.05: `Human1000G.2000xSubsampled.noMAF.recode.vcf` (format VCF)

### Introduction à l'analyse de fichiers VCF

- Ouvrez un des fichiers VCF à l'aide d'un éditeur de texte. Repéréz la partie supérieure reportant un grand nombre d'information sur le fichier. Puis, la partie inférieure identifiant chaque SNP (1 par ligne) avec sa position (`POS`) sur un chromosome spécifique (`CHROM`).

- Principes de bases de charger le VCF en utilsant R. Il existe de nombreux packages permettant la manipulation de fichiers VCF, mais la fonctionalité offerte par les packages est rarement cohérente.

Définissez votre espace de travail, téléchargez le fichier VCF Human1000G.2000xSubsampled.noMAF.recode.vcf dans le même dossier  

```
# à ajuster
setwd("~/Dropbox/Daniel/Documents/UNINE/Teaching/**2018_A/TP_GenetiqueEvol_2018/")

# installer les packages nécessaires
install.packages(c("vcfR", "ggplot2", "adegenet"))
library(vcfR)
library("adegenet")
library(ggplot2)

# lisez le fichier VCF & conversion en genlight
vcf <- read.vcfR("Human1000G.2000xSubsampled.noMAF.recode.vcf")
allchr.snps <- vcfR2genlight(vcf)
```

Assigner les individus aux populations et régions d'origine. Télécharger le fichier "Human1000G.info.txt"  

```
# lire le fichier
info.df <- read.table("Human1000G.info.txt", header=T, sep="\t")

# voir les catégories
head(info.df)
table(info.df$Population.name)
table(info.df$Superpopulation.name)

# assignez les individus aux populations
pop(allchr.snps) <- info.df$Population.name[match(indNames(allchr.snps), info.df$Sample.name)]
# alternativement: par continent
pop(allchr.snps) <- info.df$Superpopulation.name[match(indNames(allchr.snps), info.df$Sample.name)]

# alternativement: par sexe
pop(allchr.snps) <- info.df$Sex[match(indNames(allchr.snps), info.df$Sample.name)]
```

### Sélection de positions, chromosomes ou individus

```
# sélectionner les premiers éléments de la matrice des génotypes
as.matrix(allchr.snps)[1:3,1:3]

# accès à des informations supplémentaires
allchr.snps@position
allchr.snps@chromosome
allchr.snps@loc.names

# en utilisant ces pièces d'information, crééer un dataframe
allchr.df <- data.frame(position = allchr.snps@position, chromosome = allchr.snps@chromosome, SNPid = allchr.snps@loc.names)

# visualiser la densité des SNP
ggplot(allchr.df, aes(x = position/1000000)) + geom_density(n = 100) + 
  labs(x = "Position sur le chromosome (en Mb)", y = "Densité SNP") +
  facet_grid(. ~ chromosome, space = "free", scales = "free")

ggsave("SNPdensity.pdf", width = 12, height = 4)
```

Q: Explications du pic principal? Dépressions régulière sur chaque chromosome?

=> dépressions: centromères contenant moins de SNPs identifiables (régions inaccessibles par le séquençage), pic principal: région MHC

Q: Quel est le génotype de l'individu "HG02334" à la première position du chromosome 2?

["0" correspond à homozygote de l'allèle REF (même allèle comme dans le génome de référence, "2" homozygote pour l'allèle alternatif, "1" hétérozygote)]

```
head(allchr.df[allchr.df$chromosome == 2,],1)
as.matrix(allchr.snps)["HG02334","rs300751"]
```

### Fréquences alléliques

```
# extraction des fréquences de l'allèle alternatif (voir ci-dessus)
alt.allelle.freq <- glMean(allchr.snps)

# pour une population seulement
population <- "Yoruba"
population <- "Finnish"
alt.allelle.freq <- glMean(allchr.snps[pop(allchr.snps) == population,])

qplot(alt.allelle.freq, binwidth = 0.1)
```

Q: Générer les plots pour deux populations que vous supposez de montrer un constraste, comparer les patterns avec la population globale

Q: Modifier le code pour visualiser les fréquences d'allèles mineurs



### Genotype frequencies

```
# accès aux données génotypiques
allchr.df <- as.data.frame(allchr.snps)

# identification des hétérozygotes (identifiés toujours par "1")
allchr.het <- allchr.df == 1

heterozygosity.perSNP.perPOP <- aggregate(allchr.het, as.data.frame(allchr.snps$pop), function(x) {sum(x) / length(x)})
heterozygosity.df <- data.frame(population = heterozygosity.perSNP.perPOP[,1], MeanHeterozygosity = rowMeans(heterozygosity.perSNP.perPOP[,-1]))

ggplot(heterozygosity.df, aes(x = reorder(population, -MeanHeterozygosity), y = MeanHeterozygosity, fill = population)) +
  geom_bar(stat = "identity") +
  coord_cartesian(ylim = c(0.25, 0.33)) +
  labs(x = "Population", y = "Hétérozygotie moyenne") +
  theme(axis.text = element_text(colour = "black"), axis.text.x = element_text(angle = 45, hjust = 1), legend.position="none")

ggsave("Population_heterozygosity.pdf", width = 6, height = 4)
```

Q: Identifiez les populations qui ne suivaient pas vos prédictions. Expliquez votre raisonnement.





### Analyse en composantes principales

```
allchr.pc <- glPca(allchr.snps, nf = 2)
barplot(allchr.pc$eig[1:10])

pca.data <- as.data.frame(allchr.pc$scores)

# essayer les deux alternatives pour définir les populations (continent ou population)
pca.data$pop <- info.df$Population.name[match(row.names(pca.data), info.df$Sample.name)]
pca.data$region <- info.df$Superpopulation.name[match(indNames(allchr.snps), info.df$Sample.name)]

# visualisation des régions
ggplot(pca.data, aes(x = PC1, y = PC2, fill=region, color=region)) + 
  geom_point(size = 3, alpha = 0.5)

ggsave("PCA_regions.pdf", width = 12, height = 10)

# visualisation des régions, ajout de texte identifiant les populations
ggplot(pca.data, aes(x = PC1, y = PC2, fill=region, color=region)) + 
  geom_point(size = 3, alpha = 0.5) +
  geom_text(aes(x = PC1, y = PC2, label = pop), size = 2)

ggsave("PCA_regions_poptext.pdf", width = 12, height = 10)
```

Q: Qu'est-ce que signifie le barplot?

Q: En visualisant les "super-populations" (régions), expliquez la structuration observée dans la PCA. En s'appuyant sur les voies de colonisations majeures, quelles sont les raisons probables du regroupement?

Q: Un petit nombre d'individus non-africains se trouvent très proche du cluster africain. Explications probables?


### Exercise de synthèse

Q: Créer une PCA 


