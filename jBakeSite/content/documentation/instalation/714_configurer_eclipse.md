title=Configurer Eclipse IDE
date=2025-04-09
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"preparation", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, preparation, V0.0.1
tags=installer WebLeger
status=published
exerpt=Configurer Eclipse IDE pour votre projet
contentImage=images/documentation/configurer_eclipse/Eclipse IDE.svg
displayDate=true
order=714
~~~~~~
## Lancer le build du site Web

Eclipse gère les actions sous forme de **configuration**. Pour construire votre SiteWeb Maven est utilisé. Une version est intégré à Eclipse IDE il n'est pas nécéssaire d'installer Maven sur votre ordinateur.

### Ajouter une configuration Build

1. Une fois Elcipse IDE démaré il faut cliquer sur la petite flèche vers le bas à coté de l'icone de lancement d'une configuration ![Ajouter une configuration étape 1](${webleger.build.host}/images/documentation/configurer_eclipse/Eclipse_IDE_Ajouter_Configuration_1.png) 
1. puis cliquer sur *Run Configuration...* ![Ajouter une configuration étape 2](${webleger.build.host}/images/documentation/configurer_eclipse/Eclipse_IDE_Ajouter_Configuration_2.png)
1. faire un clique droit sur le groupe *Maven Build* ![Ajouter une configuration étape 3](${webleger.build.host}/images/documentation/configurer_eclipse/Eclipse_IDE_Ajouter_Configuration_3.png)
    1. Choisir un nom pour la configuration, par exemple "WebLeger install"
    2. Choisir la dossier de base de lancement de l'action
        1. En cliquant sur Workspace puis en selectionnant votre projet
    3. Dans Goals saisir ``clean initialize resources:resources jbake:generate`` 
    4. Dans l'onglet **JRE** choisir la JRE 1.8 téléchargée précédement. ![Ajouter une configuration étape 4]  (${webleger.build.host}/images/documentation/configurer_eclipse/Eclipse_IDE_Ajouter_Configuration_4.png)
    Elle ne sera pas listé par défaut il faut l'ajouter dans Elcipse IDE ! En cliquant sur le bouton *installed JRE...* puis *add* puis en sélectionnant le dossier contenant le JDK télécharger précédement.
1. Enfin cliquer sur le bouton *apply* puis *Run* tout en bas

La vue "Console" devrait apparaitre avec des texte qui défile. Si tous se passe bien cela se terminra par le texte

```
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  2.861 s
    [INFO] Finished at: 2025-05-09T11:35:25+02:00
    [INFO] ------------------------------------------------------------------------
```
Faire un clique droit sur le dosser *website* puis selectionner **refresh**.
Vous pouvez alors consulter le site en faisant un clique droit sur le fichier _website/index.html_ puis en choisissant **Open With** puis **System Editor**.

### Ajouter une configuration pour publier le site sur votre gitHub
WebLeger est déja pré-configuré pour pouvoir publier le site surGitHubPages (inspiré par ce tutoriel [Tutoriel héberger sur gitHub Pages (gh-pages)]( https://www.lorenzobettini.it/2020/01/publishing-a-maven-site-to-github-pages/)).
Il y a cependant quelques éléments à modifier.

Ensuite créez une nouvelle configuration identique à la précédente en changeant : 
1. le nom par exemple "WebLeger Deploy"
2. en utilisant le goal suivant ``scm-publish:publish-scm``

**/!\ important** Cette configuration publie sur gitHub Pages la version **actuel** du dossier **website** sans reconstruire le projet. Cela vous permet de vérifier votre site en local et s'il est satisfaisant de le publier tel quel. Toutes modifcations effectuées depuis le dernier **build** du projet ne sera pas envoyées sur gitHub Pages.

