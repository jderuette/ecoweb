title=Les outils Weblegé
date=2025-08-31
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, création, V0.0.1
tags=Création de contenu
status=draft
exerpt=Découvrir les outils spécifique au template par défaut
contentImage=images/documentation/strcuture_page/file-word.svg
specificClass=Documentation
displayDate=true
order=727
~~~~~~
## Obfuscation de texte (adresse e-mail)

### Dans la page

    <span data-obfuscatedkey="clef">contenu masqué</span>
 
### Dans un formulaire
En ajoutant un attribut **dataTransform** de type **obfuscated** le contenue d'un champs peut être 

    "dataTransform":{"type":"obfuscated", "id":"emailHideButton", "obfuscatedKey":"clef", "hiddenByButton":"true", "hiddenButtonLabel":"afficher l'e-mail"
 
## Gestion du "root" des liens

Pour permtre le changement facilement de l'URL du site (notament pour déployer en local, en local et en prod) il faut pouvoir parmètrer l'URL du site. Cela se fait via le fichier de configuration ``jbake.properties`` via le paramètre **site.host**. LE fichier de propriété de JBake est accessible dasn els templates et composants mais pas dans les contenus. Pour le rendre accessible un paramètre du fichier (maven) ``ecoWeb-build.properties`` existe. Il est utilisé pour la valeur de ``site.host`` et peut être utilisé dnas les contenus : **webleger.build.host**.
Dans un contenu il est possible d'utiliser ce dernier paramètre par exemple : 
    ![Ajouter une configuration étape 1](${webleger.build.host}/images/documentation/configurer_eclipse/Eclipse_IDE_Ajouter_Configuration_1.png)
 
## Paramètrage des fichiers CSS
Pour rendre le template ré-utilisable il est utile de rendre paramètrable certaisn élément qui sont utilisé dans les fichier CSS. Ces paramètre sont définie dans le fichier ``ecoWeb-build.properties`` et peuvent être utilisé via la syntaxe ``${xxxx}`` dans n'importe quel fichier y compris les fichiers CSS. Cela permet notament de choisir les couleurs principales du site. Par exemple : 
    .style1 {
	   border: 2px solid lightgrey;
	   background-color: ${webleger.site.style.style1.background-color};
    }
Dans l'exemple ci dessus la valeur de ``background-color`` est définie par le paramètre **webleger.site.style.style1.background-color** du fichier de propriété maven : ``ecoWeb-build.properties``

## Gestion des menus

### menu automatique

Les menu peuvent être construit autoamtiquement vial le paramètrage dans le fichier ``jbake.properties``. 3 éléments permettent de trouver les éléments qui doivent avoir un entre dans le menu

- Les block (via le paramètre **site.menu.includeBlock** : booleen )
- Les tags (via le paramètre **site.menu.tags.include** : liste des tags pour lesquels le contenu aura un lien dans le menu)*
- Les catégories (via le paramètre **webleger.site.menu.includeCategories** : liste des catégories pour lesquels le contenu aura un lien dans le menu)

Le menu autoatique évite à l'utilisateur de mondifier un modèle (template) lorsqu'il souhaite ajouter un élément dans le menu.

### regreoupement
Il est possible de regrouper plusieurs element de menu dans un même menu. Cela se configure via le contenue en ajoutant un paramètre en entete du contenu ``menu``. Par exemple 
    menu={"parent":{"title":"EthikNet", "specificClass":"menu_EthikNet"}


 