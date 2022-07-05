# Bibliotrack


## Contexte  

Il est parfois difficile de se retrouver dans une grande bibliothéque remplie de livre et encore plus en magasin lorsque l'on ne se souvent pas de ceux que l'on possède .

L’application BiblioTrack référence tous vos livres et vinyles par un simple scan du code-barre ou a la saisie d'un ISBN (le n° ISBN,  est l’identifiant unique d’un livre) grâce à l’appareil photo intégré à votre smartphone. 

Une fois l’ISBN trouvé, l’application charge (presque) tout le reste, y compris la couverture et le nombre de pages. Le rôle de bibliotrack est de vous aider à vous y retrouvez .

## Objectif 

### Objectif Principaux 

Le principal objectif de bibliotrack est de fournir une application avec une interface simple et qui limite le besoin des donnée utilisateur, pour réussir cela il faut remplir les critére suivant  : 

- Un design simple et intuitif , cela se traduit par un bouton unique qui nous permet de d'ajouter des élèments facilement.

- Un affichage en fonction des informations de base sur ce que l'on souhaite afficher ( nom du livre ou vinyls , auteur ou artiste , genre , date de création ) .

- Utilisez des données fournie par des service tel que Google , discogs ...

- Une authentification qui garentie la conservation des données même si on change d'appareil 


### Objectif Secondaire 

- Avoir une liste de souhait qui permete à l'utilisateur de conserver une liste de livres et vinyle qu'il prévoit d'acheter et pouvoir les ajouter dans nos possetion facilement 

- Consulter le nombre de page d'un livres et sauvegarder le nombre de pages que l'on à lu . Ainsi que les livres lu . 

- Avoir un système de notation 

## Des concurrents ? 
D’autres applications utilisant le scan du code-barre sur android . 

- Ma bibliothéque 
- Gleeph 
- Handy Library

## Technologie 

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

[Flutter](https://flutter.dev/) est un kit de développement logiciel d'interface utilisateur open-source créé par Google. Il est utilisé pour développer des applications pour Android, iOS, Linux, Mac, Windows, Google Fuchsia et le web à partir d'une seule base de code.

![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

[Firebase](https://firebase.google.com/) est un ensemble de services d'hébergement pour n'importe quel type d'application. Il propose d'héberger en NoSQL et en temps réel des bases de données, du contenu, de l'authentification sociale, et des notifications, ou encore des services, tel que par exemple un serveur de communication temps réel.

## Architecture 

Voici la base de l'architecture de mon projet : 

![Architecture](picture/Structure.png)

**Middleware** est la partie qui lie mon application et des sources de donnée disponible et gratuite , pour ce projet j'ai choisie de travailler avec **``Google play books ``** et son api qui permet un usage rapide et simple et **``Discogs``** qui est une plateforme de vente et d'achat de vinyls que j'utilise , elle autorise les utilisateur à crée des api facilement et sans restriction .

**BackEnd** le backend correspond au donnée crée et gérée via mon application. Pour ce faire j'ai décidé de travailler en **`serverless`** c'est à dire que toutes mes données sont conservée dans le cloud et non localement . 
Pour applique cela je me sert de **``Firebase``** pour gérer les utilisateurs et de **`Firebase Firestore`** pour Gérer leurs donnée .
Un avantage du serverless est que les données de mes utilisateurs 


### Navigation 

### Base de donnée 

Voici la représentation de ma base de donnée 

![BDD](picture/BDD.png)

## Pipeline CI/CD


![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

## Design 
Le choix du théme de couleur à été élatblie en utilisant [Coolors](https://coolors.co/) qui est un outils permettant de generer des théme de couleurs pours ces projets 
![Color](picture/color.png)

## Liens Utils

### version web 

Pour accèder à la version web il suffit de ce connecter à [l'url suivante](https://biblio-55ca4.firebaseapp.com/#/) .

### Demande d'accès à l'apk

Etant donnée que les services play store sont payant j'ai opté pour la solution [App Distribution](https://appdistribution.firebase.dev/i/9174b245f6d0f3ac). Elle me permet de gérer les différents package et facilitée leur distribution .

Pour l'utiliser , il faut s'inscrire sur firebase en suivant le lien et envoyer un mail à l'auteur à cette adresse stephane857@live.fr pour obtenir l'autorisation 

### Liens vers la vidéo de Démo

## ScreenShot

