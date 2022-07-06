[![Deploy to Firebase Hosting on merge](https://github.com/Black-Thor/Biblio-App/actions/workflows/firebase-hosting-merge.yml/badge.svg?branch=main)](https://github.com/Black-Thor/Biblio-App/actions/workflows/firebase-hosting-merge.yml)

# Bibliotrack

## Contexte  

Il est parfois difficile de se retrouver dans une grande bibliothèque remplie de livre et encore plus en magasin lorsque l'on ne se souvient pas de ceux que l'on possède .

L’application BiblioTrack référence tous nos livres et vinyles par un simple scan du code-barres ou a la saisie d'un ISBN (le n° ISBN est l’identifiant unique d’un livre) grâce à l’appareil photo intégré à votre smartphone.

Une fois l’ISBN trouvé, l’application charge (presque) tout le reste, y compris la couverture et le nombre de pages. Le rôle de biblio track est de vous aider à vous y retrouvez .

## Objectif 

### Objectif Principaux 

L'objectif principal de bibliotrack est de fournir une application avec une interface simple et qui limite le besoin des données des utilisateurs, pour réussir cela il faut remplir le critère suivant  :

- Un design simple et intuitif , cela se traduit par un bouton unique qui nous permet d'ajouter du contenu facilement et sa fonctionnalité varie en fonction de la page sur laquelle nous sommes

- Un affichage en fonction des informations de base sur ce que l'on souhaite afficher ( nom du livre ou vinyles, auteur ou artiste, genre, date de création ) .

- Utilisez des données faciles d'accès via des services telles que Google ,discogs , marvel ...

- Une authentification qui garantit la conservation des données même si l'on change d'appareil ou de plateforme


### Objectif Secondaire 

- Avoir une liste de souhait qui permet à l'utilisateur de conserver une liste de livres et vinyle qu'il prévoit d'acheter et pouvoir les ajouter dans notre liste de possession facilement.

- Avoir la possibilité de choisir un livre ou vinyles et avoir des informations .

- Consulter le nombre de pages des livres et sauvegarder le nombre de pages que l'on a lus. Ainsi que les livres lu.

- Avoir un système de notation

## Des concurrents ? 
D’autres applications utilisant le scan du code-barre sur android . 

- Ma bibliothéque
- Gleeph 
- Handy Library

## Technologie 

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

[Flutter](https://flutter.dev/) est un kit de développement logiciel d'interface utilisateur open-source créé par Google. Il est utilisé pour développer des applications pour Android, iOS, Linux, Mac, Windows, Google Fuchsia et le web à partir d'une seule base de code. En plus d'être un langage étudié durant mon année scolaire de B3 .

![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

[Firebase](https://firebase.google.com/) est un ensemble de services d'hébergement pour n'importe quel type d'application. Il propose d'héberger en NoSQL et en temps réel des bases de données, du contenu, de l'authentification,  ou encore des services, tel que par exemple un outil de gestion des packages. Et son intégration sur flutter est assez simple .

## Architecture 

Voici la base de l'architecture de mon projet :

![Architecture](picture/Structure.png)

**Middleware** est la partie qui lie mon application et des sources de donnée disponible et gratuite , pour ce projet j'ai choisie de travailler avec **``Google play books ``** et son api qui permet un usage rapide et simple et **``Discogs``** qui est une plateforme de vente et d'achat de vinyles que j'utilise, elle autorise les utilisateurs à créer des api facilement et sans restriction.

**BackEnd** le backend correspond aux données crée et gérée via mon application. Pour ce faire j'ai décidé de travailler en **`serverless`** c'est à dire que toutes mes données sont conservée dans le cloud et non localement.

Pour applique cela, je me sers de **``Firebase``** pour gérer les utilisateurs et de **`Firebase Firestore`** pour Gérer leurs données .

Un avantage du serverless est que les données de mes utilisateurs 

### Base de donnée

Voici la représentation de ma base de données

![BDD](picture/BDD.png)

## Hébergement

L'hébergement de l'application se fait sur `Firebase Hosting` , l'utilisé me permet d'avoir un environnement de production avec la version web de l'application ;

## Pipeline CI/CD

![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

Pour déployer l'aspect web de mon application, j'utilise un pipeline de CI/CD qui me permet lors de la mise à jours de mon projet de tenir le site à jours 

```yml
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v1
        with:
          java-version: '12.x'
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable' 
      - name: 'Run flutter pub get'
        run: flutter pub get
      - name: 'Create  .env'
        run: |
          touch .env
          KEY_API_VINYL=CvhBCtXbyCyhrSHFCQhexqffsAiCsGDgsiGKLcyN >> .env
          KEY_API_BOOK=CvhBCtXbyCyhrSHFCQhexqffsAiCsGDgsiGKLcyN >> .env
          KEY_FIREBASE=AIzaSyCuRVzxLxw49YmbvjZZn1g__dXw1iMvEAY >> .env
          cat .env  
      - name: 'Build Web App'
        run: flutter build web
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
             repoToken: '${{ secrets.GITHUB_TOKEN }}'
             firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT_BIBLIO_55CA4 }}'
             channelId: live
             projectId: biblio-55ca4
```

Cette configuration me permet de créer un livrable `web` puis ce livrable est installé automatique sur la page d'hébergement `Firebase hosting`


![Hosting](picture/hosting.PNG)


## Design
Le choix du thème de couleur a été établie en utilisant [Coolors](https://coolors.co/) qui est un outil permettant de générer des thèmes de couleurs pour ces projets
![Color](picture/color.png)

## Liens Utils

### version web

Pour accéder à la version web il suffit de ce connecter à [l'url suivante](https://biblio-55ca4.firebaseapp.com/#/) .

### Demande d'accès à l'apk

Étant donné que les services play store sont payants j'ai opté pour la solution [App Distribution](https://appdistribution.firebase.dev/i/9174b245f6d0f3ac). Elle me permet de gérer les différents packages et facilitée leur distribution .

Pour l'utiliser , il faut s'inscrire sur firebase en suivant le lien et envoyer un mail à l'auteur à cette adresse stephane857@live.fr pour obtenir l'autorisation 

## ScreenShot
![Screen1](picture/Screen1.PNG)
![Screen2](picture/Screen2.PNG)
![Screen3](picture/Screen3.PNG)
![Screen4](picture/Screen4.PNG)


# Get started  

Assurez-vous d'avoir installé les applications suivantes  : 

- Flutter 
- dart 
- git 

Cloner le projet  : 

```
https://github.com/Black-Thor/Biblio-App.git
 ```


Installer toutes les dépendances nécessaires en utilisant la commande  : 

```
flutter pub get 
```

crée le fichier `.env` dans le dossier root avec les paramètres suivant : 

```
KEY_API_VINYL=
KEY_API_BOOK=
KEY_FIREBASE=
```

pour remplir c'est variable il faut aller sur  : 

pour [KEY_API_VINYL](https://www.discogs.com/developers)

pour [KEY_API_BOOK](https://developers.google.com/books/docs/v1/using)

pour `KEY_FIREBASE` créer une issue pour faire la demande .

Pour utiliser l'application sur mobile vous pouvez run le projet ou utilisez la commande suivante pour créer un package téléchargeable sur votre téléphone  : 

```
flutter build apk --release
```