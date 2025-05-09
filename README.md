# EcoWeb
Outil de constrcution de site web avec comme objectif de réduire l'emprunte carbonne.

# Utilisation

## Creation du site
Dans le fichier ``ecoWeb-build.properties`` changer la valeur de la variable ``webleger.build.host`` avec l'URL de votre site Web.
Créer vos contenus en MarkDown dans le dossier ``jBakeSite``
Construisez votre site avec les goals maven : ``clean install``
Visualisez votre site en affichant la page ``website/index.html``


## Mise en production du site
Dans le fichier ``ecoWeb-build.properties`` changer la valeur de la variable ``webleger.build.host`` avec l'URL de votre site Web.
Construisez votre site avec les goals maven : ``clean install``
Déposez le dossier ``website`` sur votre serveur Web
Visualiser votre site en allant sur l'URL du site.