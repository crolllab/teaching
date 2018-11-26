### TP Génétique évolutive 4

(28 novembre 2018)


# Analyses de polymorphisme et structuration des populations humaines

### Introduction des concepts (voir slides)

-	SNP, MAF, techniques de séquençage
-	Principal component analyses (PCA)
-	Structure d’un fichier VCF


### Les données: "The 1000 Genomes Project"  
- La publication principale est apparue dans Nature vol 526, pages 68–74, 2015: [https://www.nature.com/articles/nature15393](https://www.nature.com/articles/nature15393)
- 2504 individus de 26 populations à travers le monde
- 84.7 mio SNP identifiés

Q1: Quels sont les résultats principaux de cette publication résumés en 3-4 phrases?

![](./images/map.png)

### Les données simplifiées pour ces TP

- Facultatif: Explorez les données SNP mises à disposition en utilisant un navigateur FTP. L'adresse suivant doit être utiliser: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502 (le login doit être "anonymous" ou en tant que guest)  


![](./images/vcf1.png)
  
![](./images/vcf2.png)  

- Pour ces TPs, nous avons généré un sous-échantillonnage des SNPs 1 sur 2000 pour ne pas alourdir les analyses. Le fichier complet serait de ~1 TB. Le fichier à disposition pour les TPs s'appelle donc `Human1000G.2000xSubsampled.MAF0.05.recode.vcf` (format VCF). Ce fichier est aussi filtré pour une fréquence allélique mineur (MAF) >0.05. Donc, les allèles rare n'y figurent plus!


### Introduction à l'analyse de fichiers VCF

- Ouvrez le fichier VCF à l'aide d'un éditeur de texte. Repéréz la partie supérieure reportant un grand nombre d'informations sur le contenu du fichier et les analyses faites ultérieurement. Puis, la partie inférieure identifiant chaque SNP (1 par ligne) avec sa position (`POS`) sur un chromosome spécifique (`CHROM`).

- Il existe de nombreux packages en R permettant la manipulation de fichiers VCF, mais la fonctionalité offerte par ces packages est rarement cohérente. Il est donc important d'évaluer le potentiel du package avant d'entamer une analyse spécifique.

![](./images/vcfR.png)  

Le point de départ: Définissez votre espace de travail, téléchargez le fichier VCF Human1000G.2000xSubsampled.noMAF.recode.vcf dans le même dossier  

```
# à ajuster
setwd("~/Dropbox/Daniel/Documents/UNINE/Teaching/**2018_A/TP_GenetiqueEvol_2018/")

# installer les packages nécessaires
install.packages(c("vcfR", "ggplot2", "adegenet"))
library(vcfR)
library(adegenet)
library(ggplot2)

# lisez le fichier VCF & conversion en genlight
vcf <- read.vcfR("Human1000G.2000xSubsampled.MAF0.05.recode.vcf")
allchr.snps <- vcfR2genlight(vcf)
```

Q1: Combien d'individus et de variants (SNPs) sont compris dans ce fichier réduit?

### Assigner les individus aux populations et régions d'origine

Télécharger le fichier "Human1000G.info.txt". Ce fichier résume l'information sur chaque individu inclut dans les données.

```
# lire le fichier
info.df <- read.table("Human1000G.info.txt", header=T, sep="\t")

# voir les catégories
head(info.df)


### ci-dessous vous avez trois options de catégoriser les individus
# assignez les individus aux populations (Population)
pop(allchr.snps) <- info.df$Population.name[match(indNames(allchr.snps), info.df$Sample.name)]

# alternativement: par continent/région (Superpopulation)
pop(allchr.snps) <- info.df$Superpopulation.name[match(indNames(allchr.snps), info.df$Sample.name)]

# alternativement: par sexe
pop(allchr.snps) <- info.df$Sex[match(indNames(allchr.snps), info.df$Sample.name)]
```

Q2: Faites un graphique simple résumant la taille de chaque population et super-population (régions).

### Sélection de positions, chromosomes ou individus

```
# sélectionner les premiers éléments de la matrice des génotypes (un example)
as.matrix(allchr.snps)[1:3,1:3]

# accès à l'intégralité des informations (positions, chromosomes, identifiants des loci)
allchr.snps@position
allchr.snps@chromosome
allchr.snps@loc.names

# en utilisant ces pièces d'information, crééer un dataframe
allchr.df <- data.frame(position = allchr.snps@position, chromosome = allchr.snps@chromosome, SNPid = allchr.snps@loc.names)
# générer l'ordre correct des chromosomes
allchr.df$chromosome <- factor(allchr.df$chromosome, levels = c(1:22, "X")) 

# Nombre de SNP inclut par chromosome
SNP.per.chr <- as.data.frame(table(allchr.df$chromosome))
qplot(x = allchr.df$chromosome, geom = "bar")
```

Q3: Calculez le nombre de SNP par megabases de chromosomes (i.e. densité). Est-ce que les chromosomes diffèrent en densité?  
[NB: l'information sur la taille des chromosomes humains est facilement accessible en ligne.]

```
# visualiser la densité des SNP
ggplot(allchr.df, aes(x = position/1000000)) + geom_histogram(binwidth = 10) + 
  labs(x = "Position sur le chromosome (en Mb)", y = "Densité SNP") +
  scale_x_continuous(breaks = seq(0,1000,50)) +
  theme(panel.background = element_blank()) +
  facet_grid(. ~ chromosome, space = "free", scales = "free")

ggsave("SNPdensity.pdf", width = 20, height = 4)
```

Q4: Cherchez une explications du pic principal de densité SNPs. 

A4: => Pic principal: région MHC

Q5: Quel est le génotype de l'individu "HG02334" à la première position du chromosome 2?

["0" correspond à homozygote de l'allèle REF (même allèle comme dans le génome de référence, "2" homozygote pour l'allèle alternatif, "1" hétérozygote)]

A5: ...
head(allchr.df[allchr.df$chromosome == 2,],1)
as.matrix(allchr.snps)["HG02334","rs300751"]


## Fréquences alléliques et allèles mineurs

Une propriété importante d'une population est la distribution des fréquences alléliques. On peut extraire l'information de la fréquence de l'allèle atlernative

```
# extraction des fréquences de l'allèle alternatif (l'allèle ne figurant pas dans le génome de référence)
alt.allele.freq <- glMean(allchr.snps)

# pour une population seulement
population <- "Yoruba"   #population <- "Finnish"
alt.allele.freq.pop <- glMean(allchr.snps[pop(allchr.snps) == population,])

qplot(alt.allele.freq.pop, binwidth = 0.05)
```

Q: Modifier le code pour visualiser les fréquences d'allèles mineurs (MAF)

A:
minor.allele.freq <- alt.allelle.freq
minor.allele.freq[minor.allele.freq > 0.5] <- 1-minor.allele.freq[minor.allele.freq > 0.5]
qplot(minor.allele.freq, binwidth = 0.05)

NB: Ce jeux de données est filtré pour éliminer les SNP avec allèles très rare (MAF < 0.05) pour des raisons pratiques (données trop volumineuses)



Q: Générer les plots pour deux populations que vous supposez de montrer un constraste au niveau des fréquences d'allèles mineurs (MAF). Comparer les distributions au niveau des populations avec la distribution au niveau global.

A: (pour une population)

```
population <- "Finnish"
alt.allele.freq <- glMean(allchr.snps[pop(allchr.snps) == population,])
minor.allele.freq <- alt.allelle.freq
minor.allele.freq[minor.allele.freq > 0.5] <- 1-minor.allele.freq[minor.allele.freq > 0.5]
qplot(minor.allele.freq, binwidth = 0.05)
```

## Fréquences génotypiques

Les fréquences génotypiques permettent d'estimer entre autres les taux d'homozygotie.

```
# accès aux données génotypiques se fait en transformant l'object allchr.snps
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

Q: En utilisant la procédure ci-dessus, calculez l'hétérozygotie pour la population "British" par chromosome.

A: (beaucoup de variantes de ce code sont possible, allchr.df a été généré plus tôt déjà!)  

```
heterozygosity.perSNP.perPOP.t <- as.data.frame(t(heterozygosity.perSNP.perPOP[,-1]))
names(heterozygosity.perSNP.perPOP.t) <- heterozygosity.perSNP.perPOP[,1]
heterozygosity.perSNP.perPOP.t$SNPid <- row.names(heterozygosity.perSNP.perPOP.t)
heterozygosity.perSNP.perPOP.fullinfo <-  merge(heterozygosity.perSNP.perPOP.t, allchr.df, by="SNPid")
heterozygosity.perSNP.perPOP.fullinfo$chromosome <- factor(heterozygosity.perSNP.perPOP.fullinfo$chromosome, levels = c(1:22, "X")) 

barplot(tapply(heterozygosity.perSNP.perPOP.fullinfo$British, INDEX = heterozygosity.perSNP.perPOP.fullinfo$chromosome, FUN = mean))
```


## Analyse en composantes principales

```
# étape longue (plus. minutes!)
allchr.pc <- glPca(allchr.snps, nf = 2)
barplot(allchr.pc$eig[1:10])

pca.data <- as.data.frame(allchr.pc$scores)

# essayer les deux alternatives pour définir les populations (continent ou population)
pca.data$pop <- info.df$Population.name[match(row.names(pca.data), info.df$Sample.name)]
pca.data$region <- info.df$Superpopulation.name[match(indNames(allchr.snps), info.df$Sample.name)]

## visualisation des régions
ggplot(pca.data, aes(x = PC1, y = PC2, fill=region, color=region)) + 
  geom_point(size = 3, alpha = 0.5)

ggsave("PCA_regions.pdf", width = 12, height = 10)

## visualisation des régions, ajout de texte identifiant les populations
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

