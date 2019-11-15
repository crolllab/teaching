### TP Génétique évolutive 3

# Dérive génétique et homozygosité

### But de ces travaux pratiques

- Intégrer la dérive génétique dans un modèle de génétique de population
- Comprendre l'impact de la dérive génétique sur le niveau d'homozygosité
- Analyser l'interaction de la dérive génétique et la sélection

## La dérive génétique et l'échanntillonnage aléatoire

Nous voulons analyser tout d'abord l'effet de l'échantillonnage (répété) sur la distribution des valeurs observées.

![](./images/balls.jpg)
[source: https://moderndive.com]

Nous faisons un tirage au sort de boules rouges et blanches.

```
library(ggplot2)

# Définissons la fréquence des boules rouge 
p <- 0.5

# Nombre de boules à tirer
n <- 10

## Tirons des valeurs 0 (rouge) et 1 (blanc)
# 10 boules avec remplacement (les boules ne s'épuisent pas)
# les proprtions boules sont données par p
sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)

## la somme nous indique le nombre de boules blanches
sum(sample(c(0,1), prob = c(p, 1-p), size = 10, replace = T))
```

La prochaine étape est de répéter le tirage au sort pour observer la distribution des valeurs

```
## la fonction replicate() permet de répéter une fonction
# nombre de répétitions
rep <- 1000
replicate(n = rep, sum(sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)))

dist.val <- replicate(n = rep, sum(sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)))

# Visualisation du nombre de boules blanches tiré par répétition
hist(dist.val, col = "grey", main = paste(n, "balls"), xlim = c(0,n), xlab = "White balls")
```

Q1: Refaites le graphe en variant seulement le nombre de boules à tirer par répétition. Essayez e.g. 10, 100 et 1000. Faites un graphe pour chaque cas. Quelles sont vos observations? Quel est l'impact du nombre de boules tiré par rapport à la distribution des boules blanches obtenues à travers les répétitions?

Solution:
```
pdf("Drawing_balls.pdf", paper = "a4r")
par(mfrow = c(1,3))

# pour 10 boules par tirage
n <- 10
rep <- 1000
dist.val <- replicate(n = rep, sum(sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)))
hist(dist.val, col = "grey", main = paste(n, "balls"), xlim = c(0,n), xlab = "White balls")

# pour 100 boules par tirage
n <- 100
rep <- 1000
dist.val <- replicate(n = rep, sum(sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)))
hist(dist.val, col = "grey", main = paste(n, "balls"), xlim = c(0,n), xlab = "White balls")

# pour 1000 boules par tirage
n <- 1000
rep <- 1000
dist.val <- replicate(n = rep, sum(sample(c(0,1), prob = c(p, 1-p), size = n, replace = T)))
hist(dist.val, col = "grey", main = paste(n, "balls"), xlim = c(0,n), xlab = "White balls")

dev.off()
```

Nous voyons que si nous tirons peu de boules en total, nous observons une grande dispersion dans le nombre de boules blanches tirés au hasard. Avec un nombre plus de boules tirés, nous avons une dispersion beaucoup plus faible.

Nous pouvons utiliser cette réalisation pour mieux comprendre l'impact de la dérive génétique sur la composition en génotypes. Le plus d'individus qui se reproduisent à chaque génération ("tirer des génotypes pour la prochaine génération"), le plus la fréquence des génotypes à la prochaine génération devient prédictible (une dispersion plus faible). Autrement dit, l'impact du hasard est le plus fort si peu d'individus se reproduisent.


### Introduire la dérive génétique dans notre modèle 

Nous introduisons la dérive génétique au niveau de la production des zygotes. Au lieu de déterminer les fréquences génotypiques selon la loi de Hardy-Weinberg (voir TP 2), nous allons tirer au hasard des allèles A et a du pool des gamètes. Les probabilités de former des génotypes AA, Aa et aa vont être les mêmes, mais il y aura un effet stochastique en tirant au sort les combinaisons.

Définissons les fréquences alléliques
`p <- 0.2`    # allèle A
`q <- 1 - p`  # allèle a

Nous simplifions les calculs en représentant l'allèle A étant `1` et l'allèle a étant `0`. Nous tirons deux allèles du pool des gamètes (définit par p et q)
`sample(0:1, 2, c(q, p), replace = T)`

Q2: Générez 500 combinaisons d'allèles (= génotypes) sans utiliser une boucle. Résumez les génotypes en faisant la somme des codes utilisés pour les allèles. Allèle A étant `1` et l'allèle a étant `0`.

Solution:
```
p <- 0.2    # allèle A
q <- 1 - p  # allèle a
n <- 500

sampled.genotypes <- replicate(n, sample(0:1, 2, c(q, p), replace = T))

# conversion en génotypes codé par 0, 1 et 2 (pour aa, aA et AA)
colSums(sampled.genotypes)
```

Q3: Résumez les génotypes produits ci-dessus sous la forme `genotypes <- c(40, 20, 10) # pour AA, Aa, aa` adoptée pour le TP 2.

Solution: 
```
p <- 0.2    # allèle A
q <- 1 - p  # allèle a
n <- 500

sampled.genotypes <- replicate(n, sample(0:1, 2, c(q, p), replace = T))
sampled.genotypes.012 <- colSums(sampled.genotypes)
aa <- sum(sampled.genotypes.012 == 0)
Aa <- sum(sampled.genotypes.012 == 1)
AA <- sum(sampled.genotypes.012 == 2)
genotypes <- c(AA, Aa, aa)
```

Q4: Ecrivez une fonction analogue à `get.Progeny.GenoFreq(alleles)` (voir TP 2) qui prend comme valeurs des fréquences alléliques et un nombre de génotypes à échantillonner `n`. La fonction devrait produire des fréquences génotypiques soumises à la dérive génétique. Appelez la fonction `Progeny.GenoFreq.withDrift(alleles, n)`. Vous avez déjà produit la plupart du code nécessaire pour répondre à Q3.


Solution:
```
alleles <- c(0.1, 0.9) #  (fréquence p(A) de 0.1 et fréquence q(a) de 0.9)
n <- 100

Progeny.GenoFreq.withDrift <- function(alleles, n) {
  
  p <- alleles[1]
  q <- alleles[2]

  sampled.genotypes <- replicate(n, sample(0:1, 2, c(q, p), replace = T))
  sampled.genotypes.012 <- colSums(sampled.genotypes)

  newaa <- sum(sampled.genotypes.012 == 0)
  newAa <- sum(sampled.genotypes.012 == 1)
  newAA <- sum(sampled.genotypes.012 == 2)

  genotypes <- c(newAA, newAa, newaa)
  genotypes <- genotypes / sum(genotypes)

  return(genotypes)
  }

# test l'effet de la dérive
Progeny.GenoFreq.withDrift(alleles, n)
Progeny.GenoFreq.withDrift(alleles, n)
Progeny.GenoFreq.withDrift(alleles, n)
```

Q5: Reprenez le code proposé dans le corrigé TP 2 pour Q10 (ou votre code!). Enlever la partie du code qui intègre la sélection et rajoutez le code pour implémenter la dérive génétique. Enregistrez un `results.df` comme proposé.

Solution:
```
### Définir les fonctions importantes
get.Allele.Freq <- function(genotypes) {
  p <- genotypes[1] + 0.5*genotypes[2]
  q <- genotypes[3] + 0.5*genotypes[2]
  p <- p/(p+q)
  q <- 1 - p
  return(c(p,q))
  }

Progeny.GenoFreq.withDrift <- function(alleles, n) {
  
  p <- alleles[1]
  q <- alleles[2]

  sampled.genotypes <- replicate(n, sample(0:1, 2, c(q, p), replace = T))
  sampled.genotypes.012 <- colSums(sampled.genotypes)

  newaa <- sum(sampled.genotypes.012 == 0)
  newAa <- sum(sampled.genotypes.012 == 1)
  newAA <- sum(sampled.genotypes.012 == 2)

  genotypes <- c(newAA, newAa, newaa)
  genotypes <- genotypes / sum(genotypes)

  return(genotypes)
  }


### définir les génotypes de la génération t
genotypes.count <- c(20,40,20)
genotypes <- genotypes.count / sum(genotypes.count)

# définir le nombre de générations
n.generations <- 100

# définir la taille de la population (n pour l'échantillonnage)
n <- 100

results.df <- data.frame(generation=numeric(),
                          allele.A=numeric(),
                          allele.a=numeric(),
                          genotype.AA=numeric(),
                          genotype.Aa=numeric(),
                          genotype.aa=numeric()) 

for (i in 1:n.generations) {
  # enregistrer la génération en cours
  results.df[i,"generation"] <- i

  alleles <- get.Allele.Freq(genotypes)
  # enregistrer les fréquences alléliques
  results.df[i, c("allele.A", "allele.a")] <- alleles

  genotypes <- Progeny.GenoFreq.withDrift(alleles, n)
  

  # enregistrer les fréquences génotypiques
  results.df[i, c("genotype.AA", "genotype.Aa", "genotype.aa")] <- genotypes
  }
  
results.df
```

Q6: Réutilisez le code à la fin des TP 2 pour visualiser `results.df`. Etudiez l'impact d'une taille de population `n` variable. Visualisez uniquement les fréquences alléliques pour simplifier la présentation.

Solution
```
library(reshape2)
library(ggplot2)

# remanier les données
results.m.df <- melt(results.df, id.vars = "generation", value.name = "frequency", variable.name = "type")

# visualisation
ggplot(results.m.df, aes(x = generation, y = frequency, color = type)) + 
  geom_line() + 
  scale_y_continuous(limits = c(0,1)) +
  labs(title = paste("Population size", n))

ggsave("Simulating_drift.pdf", width = 8, height = 5)

# Alternative: visualisation uniquement de pA
ggplot(results.m.df[results.m.df$type == "allele.A",], aes(x = generation, y = frequency, color = type)) + 
  geom_line() + 
  scale_y_continuous(limits = c(0,1)) +
  labs(title = paste("Population size", n))
```

