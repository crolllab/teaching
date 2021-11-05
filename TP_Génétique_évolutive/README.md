# TP Génétique évolutive

Prof. Daniel Croll et assistant.e.s

La génétique évolutive étudie les changements de gènes et fréquences de génotypes au sein des populations et espèces. Ces travaux pratiques fournissent une opportunité d’approfondir le cours « Génétique évolutive » (3me année). A travers des présentations, exercices et discussions, vous avez l’opportunité de développer des compétences dans le traitement de données génétiques y inclut :
- de mieux comprendre les bases théoriques de la génétique évolutive (e.g. Loi de Hardy-Weinberg, impact de la sélection ou goulot d’étranglement)
- de faire connaissance avec des applications de la génétique évolutive aux populations humaines (peuplement de la terre, assignements de génotypes individuels à des régions géographiques, détection de pression de sélection récente, etc.)
- gagner de l’expérience avec la génétique de la conservation appliquée aux bouquetins des Alpes (identification des risques d’appauvrissement génétique, évaluation de l’impact des plans de recolonisation, etc.).

Les travaux pratiques comprendront toujours une introduction au sujet, puis des exercises guidés avec l’appui de l’enseignant et des assistant.e.s.


## Utilisation de R et RStudio

### Utilisation de RStudio dans un navigateur web

Notre laboratoire peut vous fournir un accès à ses machines de calculs y inclut l'utilisation de RStudio dans un navigateur web. Nous préférons de vous fournir RStudio dans un navigateur web avec une connexion à distance au lieu de vous demander d'installer RStudio sur votre ordinateur. Ceci peut éviter certains problèmes d'installations de packages R.

**Marche à suivre pour suivre le cours en-ligne:**  
- Connectez-vous par [Webaccess UNINE](https://webaccess.unine.ch)  
- Naviguez par la suite dans le dossier "Logiciels VPN" pour télécharger un client VPN qui vous permettra de vous connecter au réseau UNINE. Il y a des versions pour Mac, Windows et Linux.  
- Installez le logiciel VPN.  
- Lancez le logiciel en fournissant votre login UNINE.  
- Si la connexion est bien établie, utilisez un navigateur web pour vous rendre sur le site suivant: [http://130.125.25.239:8787](http://130.125.25.239:8787)  

![](./images/image_1.png)

**Marche à suivre pour suivre à l'Unimail:**  
- Connectez-vous au réseau wifi "unine".
- Utilisez un navigateur web pour vous rendre sur le site suivant: [http://130.125.25.239:8787](http://130.125.25.239:8787)  

- Votre "Username" est: ge-prénom (alors e.g. ge-daniel). Sans accent, tout en minuscule.
- Votre "Password" est: tpgenevol   

```
# les noms d'utilisateurs exacts sont
ge-sara
ge-leen
ge-sarai
ge-jessica
ge-carla
ge-quentin
ge-armand
ge-ihssane
ge-roxane
ge-antonio
ge-samuel
ge-christophe
ge-vithuna
ge-lalya
ge-anais
ge-regine
ge-loic
ge-alois
ge-foaad
ge-celeste
ge-jeremy
ge-nuria
ge-amy
```

- L'utilisation de RStudio sur notre serveur est identique à RStudio installé sur votre ordinateur sauf:
  - le dossier de travail ne devrait pas être modifié
  - ignorer toute demande d'installer des packages lors du cours (`install.packages(...)`), procédez directement au chargement du package (`library(...)`)
  - par défaut, tout document enregistré va se trouver sur notre serveur
  - pour **transférer un document de votre ordinateur au serveur**: Identifiez le tab "Files" (en bas à droite de RStudio), cliquez sur "Upload" et puis "Choose File". Le fichier sera placé alors sur le serveur. Vous le trouverez sous "Files".

![](./images/image_2.png)  
![](./images/image_3.png)  

  - pour **récupérer un fichier du serveur vers votre ordinateur**: Identifiez le tab "Files" (en bas à droite de RStudio), sélectionnez le(s) fichier à télécharger, "More" et puis "Export...". Ceci permettra de procéder au téléchargement.

![](./images/image_4.png)  

  - Cette méthode vous permettra aussi de récupérer votre script R enregistré sur le serveur.


## Mode d'évaluation

Référez-vous à IS-Academia pour plus de détails.

### TP 1 Introduction à R

Aucune évaluation

### TP 2-6

Document à rendre le jour par Moodle (ou selon l'accord avec l'enseignant) donnant les réponses aux questions (Q1...Qn). Merci de nommer votre document Nom_Prenom.

Répondez à chaque question de manière succincte (1-3 phrases sont souvent suffisantes). Si vous êtes obligés d'écrire du code ou générer des graphiques, les deux devraient en principe figurer dans le document.

Je m'attends à un effort correspondant aux heures des travaux pratiques et pas plus. Donc, si vous rencontrez des difficultés particulières sans résolution simple (installation des packages, etc.), il suffit de brièvement documenter les problèmes dans votre rapport.
