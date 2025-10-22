title=Structure d'une page
date=2025-06-18
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, création, V0.0.1
tags=Création de contenu
status=published
exerpt=Comprendre la structure d'une page de contenu
contentImage=images/documentation/strcuture_page/file-word.svg
specificClass=Documentation
displayDate=true
order=723
~~~~~~
## l'entête
Le début de la page contient l'entete. L'entete contient des informations sur la page. Les symboles ``~~~~~~`` marquent la fin de l'entete et le début du corps de la page.
Dans l'entete chaque ligne est un attribut de la page composé de 2 parties : 

- le nom de la l'attribut 
- le contenu de l'attribut sépraré par **=**.

### Attributs requis
**title** : titre de la page : sera affiché au début du contenu et en titre de l'onglet
**type** : le type de contenu : le type ``org_openCiLife_post`` est le plus courrant, il représente une "page" classique du site et gère des attributs spécifiques
**order** : ordre d'affichage du contenu par rapports aux autres.

Il existe de nombreux attributs et les templates et composants peuvent en créer de nouveaux.

## le corps de la page
Contient le contenu de la page. Le language MarkDown peut être utilisé pour : 

- modifier le texte (titres, en gras, italique, ....)
- insérer des liens
- insérer des images

Les plugins peuvent ajouter de nouveau marquage markdown.