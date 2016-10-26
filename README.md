# Préambule

Slides du cours disponibles [ici](http://slides.com/women_on_rails/week-5)

! EN CONSTRUCTION !

Ce tutoriel a pour objectif de comprendre , dans le cadre du cycle 1 des ateliers Women On Rails.

# Étape 1 : Rappels

## Commandes principales

Vous pouvez retrouver les commandes utiles pour le terminal, git et la console Ruby On Rails [ici](https://women-on-rails.github.io/guide/main_commands).

## MVC

Le rappel sur le patron de conception [Modèle - Vue - Controleur] peut etre trouvé [ici](openclassrooms.com/courses/apprendre-asp-net-mvc/le-pattern-mvc)

## Actions HTTP

! EN CONSTRUCTION !

# Étape 2 : Lire l'exercice et se lancer

## Application au projet Curiosités

Ouvrez votre projet avec Cloud9, ou l'éditeur que vous utilisez si vous avez une installation native.

Si vous utilisez SublimeText, vous pouvez faire subl . dans la console pour ouvrir directement votre projet. (subl c'est SublimeText, l'espace c'est parce que la commande est finie, et le point c'est pour dire "ouvre dans Sublime Text tout le dossier dans lequel je suis, en un coup").

## Faire une page principale pour chaque curiosité

### Créer le controleur

( ! EN CONSTRUCTION ! deux manieres : scaffold / a la main)

Pour commencer, créez le fichier ``` app/controllers/curiosities_controller.rb ```.
Ce fichier est pour le moment vide.

! IMAGE !

Nous allons définir à l'intérieur de ce fichier la classe ``` CuriositiesController ``` qui va nous permettre d'orchestrer les accès aux vues des curiosités.

Pour cela, ajoutez le code suivant dans le fichier ``` app/controllers/curiosities_controller.rb ```:

! IMAGE !

Dans votre classe ``` CuriositiesController ```, vous allez ajouter les méthodes qui vont définir les actions possibles à faire sur des curiosités, dans l'application.

Ici, nous commençons donc par travailler sur l'action d'affichage d'une curiosité.

! IMAGE !

Nous avons besoin de définir ce qu'il se passe quand un utilisateur demande à voir les détails d'une curiosité.

Dans la méthode ``` show ```, nous allons récupérer les données d'une curiosité, contenues dans la base de données, grâce aux paramètres de l'url ```/curiosities/3```. Puis nous allons les stocker dans une instance de ``` Curiosity ``` et passer cette instance à une vue pour les afficher.

Rajoutez la méthode ``` show ``` et ce qu'elle fait dans le controleur ``` Curiosities ``` qui se trouve dans ``` app/controllers/curiosities_controller.rb ``` :

! IMAGE !

> Astuce : Les valeurs contenues dans la variable ``` params ``` viennent du navigateur de l'utilisateur. Il les envoie au serveur lorsqu'une requete est effectuée. Par exemple, si un utilisateur demande:
> http://localhost:3000/curiosities?toto=poulpe
> Alors ``` params[:toto] ``` sera égal à poulpe.
> La variable ``` params ``` est simplement un tableau de valeurs accessibles grace à des clés. Ici la valeur à laquelle accéder est poulpe et la clé d'accès est ``` :toto ```.

Si à cette étape vous lancez un serveur Rails et que vous essayez d'aller sur ``` http://localhost:3000/curiosities/1 ```, voici le résultat que vous obtiendrez :

! IMAGE !

Nous n'avons pas encore défini de route relative à la méthode ``` show ``` que nous venons de créer. Du coup, l'application ne sait pas comment réagir avec cette URL. Voyons maintenant comment définir cette nouvelle route !

### Créer la route

Nous allons créer une nouvelle route dans le fichier ``` config/routes.rb ``` pour signifier à la fois quelle action HTTP nous voulons accomplir (ici ``` GET ```), le controleur de l'objet associé (ici ``` curiosities ```) et la méthode qui définira l'action à faire quand l'utilisateur cliquera sur le lien (ici ``` show ```).

Ce travail permet d'associer une URL (sur laquelle veut se rendre un utilisateur) à une action de controleur.

Rajoutez la ligne suivante dans le fichier ``` config/routes.rb ``` :

! IMAGE !

Si vous lancez un serveur Rails et que vous essayez d'aller sur ``` http://localhost:3000/curiosities/1 ```, voici le résultat que vous obtiendrez :

! IMAGE !

Cette fois l'application sait comment réagir avec cette URL. Le souci maintenant, c'est que la vue associée n'existe pas encore.

### Ajouter le lien pour accéder à une curiosité dans la vue

Il faut maintenant afficher à l'utilisateur qu'il peut afficher une curiosité spécifique. Pour cela, dans la vue, nous allons créer un lien dans la boucle de toutes les curiosités contenant le chemin pour afficher une instance en particulier.

 Un lien dynamique se construit de cette façon en Ruby On Rails :

``` <%= link_to 'Nom du lien qui sera affiché dans la vue', chemin_vers_le_controleur %> ```

Il faut trouver le chemin (``` path ```) qui indiquera la route dans le fichier ``` config/routes.rb ``` vers la méthode du controleur. Pour trouver ce chemin, vous pouvez entrer ``` rake routes ``` dans votre terminal.

Ce qui vous donne :

# Étape 3 : Pour aller plus loin

! EN CONSTRUCTION !

# Étape 4 : Enregistrer les modifications sur le répertoire distant

[Enregistrer vos modifications et les envoyer sur votre répertoire Github](https://women-on-rails.github.io/guide/push_project)

# Liens Utiles :

! EN CONSTRUCTION !
