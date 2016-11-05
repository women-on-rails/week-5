# Préambule

Slides du cours disponibles [ici](http://slides.com/women_on_rails/week-5)

Ce tutoriel a pour objectif de comprendre comment manipuler des objets dans le controleur et passer les données de ces objets à des vues, dans le cadre du cycle 1 des ateliers Women On Rails.

# Étape 1 : Rappels

## Commandes principales

Vous pouvez retrouver les commandes utiles pour le terminal, git et la console Ruby On Rails [ici](https://women-on-rails.github.io/guide/main_commands).

## MVC

Le rappel sur le patron de conception [Modèle - Vue - Controleur] peut etre trouvé [ici](https://openclassrooms.com/courses/apprendre-asp-net-mvc/le-pattern-mvc)

## Actions HTTP

Ruby On Rails permet d'utiliser au mieux le [protocole HTTP](https://openclassrooms.com/courses/les-requetes-http), sur lequel repose la navigation Web. Il y a 4 types de requêtes principales en HTTP :
- GET (afficher une page),
- POST (créer une nouvelle ressource),
- PUT (pour modifier entièrement la ressource, ou PATCH pour la modifier partiellement),
- DELETE (supprimer une ressource).

Suite à chaque requête, le serveur envoie une réponse.

De plus, chaque contrôleur Rails possède 7 actions de base, chaque action correspondant à un type de requête HTTP :
- SHOW : affiche une ressource en particulier (action GET)
- INDEX : affiche la liste de toutes les ressources d'un même type (action GET)
- NEW : affiche le formulaire pour créer une nouvelle ressource (action GET)
- CREATE : une fois le précédent formulaire complété, crée la ressource (action POST)
- EDIT : affiche le formulaire d’édition d'une ressource (action GET)
- UPDATE : met à jour une ressource spécifiée (action PUT)
- DESTROY : supprime une ressource spécifique (action DELETE)

# Étape 2 : Lire l'exercice et se lancer

## Application au projet Curiosités

Ouvrez votre projet avec Cloud9, ou l'éditeur que vous utilisez si vous avez une installation native.

Si vous utilisez SublimeText, vous pouvez faire ```subl .``` dans la console pour ouvrir directement votre projet. (subl c'est SublimeText, l'espace c'est parce que la commande est finie, et le point c'est pour dire "ouvre dans Sublime Text tout le dossier dans lequel je suis, en un coup").

## Faire une page principale pour chaque curiosité

### Créer le contrôleur

Pour commencer, créez le fichier ``` app/controllers/curiosities_controller.rb ```.
Ce fichier est pour le moment vide.

![Controleur vide](/images/readme/empty_controller.png)

Nous allons définir à l'intérieur de ce fichier la classe ``` CuriositiesController ``` qui va nous permettre d'orchestrer les accès aux vues (les pages html) des curiosités.

Pour cela, ajoutez le code suivant dans le fichier ``` app/controllers/curiosities_controller.rb ```:

![Controleur défini](/images/readme/defined_class.png)

Dans votre classe ``` CuriositiesController ```, vous allez ajouter les méthodes qui vont définir les actions possibles à faire sur des curiosités, dans l'application.

Ici, nous commençons donc par travailler sur l'action d'affichage d'une curiosité en définissant une méthode ``` show ```:

![Définition de la méthode ``` show ```](/images/readme/description_show.png)

Nous avons besoin de définir ce qu'il se passe quand un utilisateur demande à voir les détails d'une curiosité.

Dans la méthode ``` show ```, nous allons récupérer les données d'une curiosité, contenues dans la base de données, grâce aux paramètres de l'url ```/curiosities/3```. Puis nous allons les stocker dans une instance de ``` Curiosity ``` et passer cette instance à une vue pour les afficher.

Précisez ce que fait la méthode ``` show ``` dans le controleur ``` Curiosities ``` qui se trouve dans ``` app/controllers/curiosities_controller.rb ``` :

![Description action](/images/readme/instance.png)

> Astuce : Les valeurs contenues dans la variable ``` params ``` viennent du navigateur de l'utilisateur. Il les envoie au serveur lorsqu'une requete est effectuée. Par exemple, si un utilisateur demande:
> http://localhost:3000/curiosities?toto=poulpe
> Alors ``` params[:toto] ``` sera égal à poulpe.
> La variable ``` params ``` est simplement un tableau de valeurs accessibles grâce à des clés. Ici la valeur à laquelle accéder est poulpe et la clé d'accès est ``` :toto ```.

Si à cette étape vous lancez un serveur Rails et que vous essayez d'aller sur ``` https://curiosites-[votrenom].c9users.io/curiosities/1 ``` (remplacez [votrenom] par le nom de votre compte), voici le résultat que vous obtiendrez :

![Erreur route manquante](/images/readme/error_view_missing_route.png)

Nous n'avons pas encore défini de route relative à la méthode ``` show ``` que nous venons de créer. Du coup, l'application ne sait pas comment réagir avec cette URL. Voyons maintenant comment définir cette nouvelle route !

### Créer la route

Nous allons créer une nouvelle route dans le fichier ``` config/routes.rb ``` pour signifier à la fois l'action HTTP que nous voulons accomplir (ici ``` GET ```), le contrôleur de l'objet associé (ici ``` curiosities ```) et la méthode qui définira l'action à faire quand l'utilisateur cliquera sur le lien (ici ``` show ```).

Ce travail permet d'associer une URL (sur laquelle veut se rendre un utilisateur) à une action de contrôleur. Pour ce faire, on utilise la syntaxe suivante dans le fichier ``` config/routes.rb ``` : 
``` verbe_http 'URL', to: 'nom_du_controleur#nom_de_la_méthode' ```

Dans notre cas, nous allons ajouter la ligne suivante dans le fichier ``` config/routes.rb ``` :

![Définition route](/images/readme/routes.png)

Si vous lancez un serveur Rails et que vous essayez d'aller sur ``` https://curiosites-[votrenom].c9users.io/curiosities/1 ```, voici les résultats que vous pourriez obtenir :

![Erreur curiosité inconnue](/images/readme/error_view_record_not_found.png)

Ici, l'application n'arrive pas à trouver la curiosité demandée. La curiosité dont l'identifiant est passé en paramètre n'existe pas en base de données.

![Erreur vue manquante](/images/readme/error_view_missing_template.png)

Cette fois l'application sait comment réagir avec cette URL. Le souci maintenant, c'est que la vue liée à l'action ``` show ``` n'existe pas encore. Nous allons donc la créer, mais avant ça, voyons comment y accéder depuis l'index !

### Ajouter le lien pour accéder à une curiosité dans l'index

Il faut maintenant montrer à l'utilisateur qu'il peut afficher une curiosité spécifique. Pour cela, dans la vue d'index, nous allons créer un lien dans la boucle de toutes les curiosités contenant le chemin pour afficher une instance en particulier.

 Un lien dynamique se construit de cette façon en Ruby On Rails :

``` <%= link_to 'Nom du lien qui sera affiché dans la vue', chemin_vers_le_controleur %> ```

Il faut trouver le chemin (``` path ```) qui indiquera la route dans le fichier ``` config/routes.rb ``` vers la méthode du contrôleur. Pour trouver ce chemin, vous pouvez entrer ``` rake routes ``` dans votre terminal.

Ce qui vous donne :

![Rake routes](/images/readme/rake_routes.png)

La ligne qui nous intéresse est la suivante : ```  GET  /curiosities/:id(.:format) curiosities#show ```

Vous retrouvez bien le verbe HTTP ``` GET ``` (cf Verb), l'url ``` /curiosities/:id ```  (cf URI Pattern), la méthode du Contrôleur ``` curiosities#show ``` (cf Controller#Action). Et tout devant, un préfixe ``` curiosities ``` qui vous donne en fait le chemin à rajouter dans votre vue : ``` curiosities_path ```.

Attention, ici, le contrôleur a besoin de l'identifiant (ID) de la curiosité à afficher. Il faut donc la passer dans les paramètres. Nous l'indiquons comme ceci : ``` curiosities_path(curiosity) ```.

> Important : ``` curiosities_path(curiosity) est une méthode générée par Ruby On Rails directement, en fonction de ce que vous avez défini dans le fichier ``` route.rb ``` . Elle accepte en paramètre un objet ``` curiosity ``` ou son identifiant ``` curiosity.id ```.

Rajoutez le lien dans votre vue ``` app/views/home/index.html ``` :

![Lien vers la curiosité](/images/readme/view_index_code.png)

Testez maintenant votre nouveau lien en lançant un serveur Rails. Il s'affiche bien dans votre vue :

![Liste des curiosités](/images/readme/view_display_link.png)

Par contre, si vous cliquez dessus, vous obtenez toujours l'erreur sur la vue manquante : 

![Erreur vue manquante](/images/readme/error_view_missing_template.png)

C'est normal, la vue liée à l'action ```show``` n'existe pas encore. L'application sait où aller, quoi passer à une vue mais ne connaît pas encore cette vue. Construisons-là !

### Créer la vue affichant les détails d'une curiosité

Allez dans ```app/views``` et créez le dossier ```curiosities```. Ce dossier contiendra toutes les vues relatives au contrôleur ``` CuriositiesController ``` créé précédemment.

Puis, créez un fichier nommé ``` show.html.erb ``` dans le dossier ``` Curiosities ```, qui contiendra tout ce que vous voulez afficher concernant une curiosité.

Pour afficher les informations d'une curiosité, il faut manipuler la curiosité contenue dans la variable ``` @curiosity ``` (que nous avons définie précédemment) passée à la vue par le contrôleur.

![Code pour la vue / méthode SHOW](/images/readme/view_show_code.png)

ce code donnera un affichage comme suit:

![Vue / méthode SHOW](/images/readme/view_display_show.png)

# Étape 3 : Pour aller plus loin

## Détruire une instance en passant par le navigateur

### Créer la route

Pour commencer, nous allons créer une nouvelle route dans le fichier ````config/routes.rb```` pour signifier à la fois quelle action HTTP nous voulons accomplir (ici ````delete````), le contrôleur de l'objet associé (ici ````curiosities````) et la méthode qui définira l'action à faire quand l'utilisateur cliquera sur le lien (ici ````destroy````).

Rajoutez la ligne suivante dans le fichier ````config/routes.rb```` :

![Routes / DELETE](/images/readme/routes_delete.png)

### Ajouter la méthode correspondante dans le contrôleur

Maintenant, il s'agit de définir ce qu'il se passe quand l'utilisateur va cliquer sur le lien pour détruire une instance. Dans la méthode ````destroy````, nous allons récupérer l'instance que nous voulons supprimer, grâce aux paramètres de l'url ````/curiosities/25````. Ensuite, nous allons la supprimer dans la base de données grâce à la méthode ````.delete```` et ensuite rediriger l'utilisateur sur la vue de toutes les curiosités.

Rajoutez la méthode ````destroy```` et ce qu'elle fait dans le contrôleur ````Curiosities```` qui se trouve dans ````app/controllers/curiosities.rb```` :

![Controleur / méthode Destroy](/images/readme/controller_destroy_method.png)

> Rappel :
> Les valeurs contenues dans la variable ``` params ``` viennent du navigateur de l'utilisateur.
> Il les envoie au serveur lorsqu'une requête est effectuée. Par exemple, si un utilisateur demande:
> http://localhost:3000/curiosities?toto=poulpe

> Alors params[:toto] sera égal à poulpe.

> La variable ````params```` est simplement un tableau de valeurs accessibles grace à des clés.
> Ici la valeur à laquelle accéder est ````poulpe```` et la clé d'accès est ````:toto````.

### Ajouter le lien pour supprimer les curiosités dans la vue

Il faut maintenant afficher à l'utilisateur qu'il peut supprimer une curiosité. Pour cela, dans la vue, nous allons créer un lien dans la boucle de toutes les curiosités contenant le chemin pour détruire une instance en particulier.

> Rappel :
> Un lien dynamique se construit de cette façon en Ruby On Rails :

> ```Ruby <%= link_to 'Nom du lien qui sera affiché dans la vue', chemin_vers_le_controleur %>````

Trouvons le chemin (``` path ```) qui indiquera la route dans le fichier ``` config/routes.rb ``` vers la méthode du controleur.

> Rappel : vous pouvez entrer ``` rake routes ``` dans votre terminal pour trouver tous les chemins déjà définis.

![Rake routes](/images/readme/rake_routes_delete.png)

Vous retrouvez bien le verbe HTTP ``` DELETE ``` (cf Verb), l'url ``` /curiosity/:id ``` (cf URI Pattern), la méthode du Contrôleur ``` curiosities#destroy ``` (cf Controller#Action). Et tout devant, un préfixe ``` curiosities ``` qui vous donne en fait le chemin à rajouter dans votre vue : ``` curiosities_path ```. Attention, ici, le contrôleur a besoin de l'identifiant de la curiosité à supprimer. Il faut donc la passer dans les paramètres. Nous l'indiquons comme ceci : ``` curiosities_path(curiosity) ```.

> Rappel : ``` curiosities_path(curiosity) ``` est une méthode générée par Ruby On Rails directement, en fonction de ce que vous avez défini dans le fichier ``` route.rb ```.
> Elle accepte un objet ``` curiosity ``` ou son identifiant ``` curiosity.id ```.

Rajoutez le lien dans votre vue ``` app/views/home/index.html.erb ``` :

![Lien pour détruire une curiosité ](/images/readme/view_index_code_delete.png)

Dans le cadre d'une suppression, nous rajoutons un élément important au ``` link_to ``` : la précision du verbe HTTP avec ``` method: :delete ```.

Testez maintenant votre nouvelle action sur votre application en détruisant l'une de vos curiosités.

![Lien visible sur l'application, pour détruire une curiosité](/images/readme/view_index_button_delete.png)

### Ajout d'une pop-up de confirmation

Nous aimerions ajouter une pop-up de confirmation de destruction avec ````data: { confirm: 'Message de confirmation' }```` dans le ````link_to```` de la vue, car c'est une action sur laquelle l'utilisateur ne pourra pas revenir. Nous voulons donc être sûrs de son choix.

Aidez-vous de la documentation du [link_to](http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to) et ajoutez cette pop-up !

### Ajout d'une image

Pour rendre notre page plus sympa, nous aimerions avoir une image à la place du texte `Supprimer`. Amusez-vous à remplacer ce texte par une icône en utilisant les icônes bootstrap, dont vous pouvez trouver la documentation [ici](http://getbootstrap.com/components/) !


# Étape 4 : Enregistrer les modifications sur le répertoire distant

[Enregistrer vos modifications et les envoyer sur votre répertoire Github](https://women-on-rails.github.io/guide/push_project)

# Liens Utiles :
- La documentation de Ruby : http://ruby-doc.org/core-2.3.1/
- La documentation de Ruby On Rails : http://api.rubyonrails.org/
- Active Record : https://fr.wikipedia.org/wiki/Active_record (concept en français) ou http://guides.rubyonrails.org/active_record_basics.html (introduction de Rails, en anglais)
- Les routes dans Ruby On Rails : http://guides.rubyonrails.org/routing.html