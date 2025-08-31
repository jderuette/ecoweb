title=Les type de contenus Weblegé : org_openCiLife_ecoweb
date=2025-06-23
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, création, V0.0.1
tags=Création de contenu
status=published
exerpt=Connaitre les types de contenus spécifique au template par défaut
contentImage=images/documentation/strcuture_page/file-word.svg
specificClass=Documentation
displayDate=true
order=725
~~~~~~
## org_openCiLife_block

Ce type est utilisé pour constituer une page contenant plusieurs bloques de contenu. Est utiliser pour la page d'accueil et pour le pied de page.
**category** permet de défnir où le bloque sera affiché : 

- **homepage** : sera afficher sur la page d'accueil du site.
- **footer** : sera affiché en pied de page sur toutes les pages du site.

### attributs

| nom | requis ? | exemple | description |
| :--- | :--- | :--- | :--- |
| title | **requis** | Nos engagements | le titre du bloc |
| date | optionnel | 2025-04-30  | date de publication. N'est pas affiché. |
| type | **requis** | org_openCiLife_block | le type de contenu : indique que se contenu sera intégré dans une autre page. |
| category | **requis** | homepage | est utiliser pour afficher le block sur la bonne page. Par exemple "homepage" est la valeur par defaut pour que se bloque soit affiche sur la page d'acueil. La valeur par defaut peut être changé dnas le fichier de configuration. |
| tags | optionnel | infos, tarifs | n'est pas affiché par le template. |
| status | **requis** | published | si "published" le bloque sera visible. Sinon il ne sera pas affiché. |
| contentImage | optionnel | images/principe.svg | image à afficher pour se contenu. Est affiché par defaut a gauche du contenu textuel |
| specificClass | optionnel | mainBlock style2 | permet d'ajouter un style CSS au bloque. |
| anchorId | **requis** | a_quoi_ca_sert | nom de l'ancre. Ce nom aparait dans l'URL de la page lorsque l'on n'avigue jusqu'au bloque via le menu. |
| order | **requis** | 050 | ordre d'affichage du block par rapports aux autres. |


## org_openCiLife_post

Le type de contenu le plus courrant. Permet d'afficher une "page". Contient différentes options pour afficher des éléments en plus du contenu textuel.



### attributs

| nom | requis ? | exemple | description |
| :--- | :--- | :--- | :--- |
| title | **requis** | Nos engagements | le titre du bloc |
| date | optionnel | 2025-04-30  | date de publication. est affiché uniquement si l'attribut ``displayDate`` vaut "true" . |
| type | **requis** | org_openCiLife_post | le type de contenu : indique que se contenu sera une page. |
| includeContent | optionnel | `{"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}` | inclut d'autre contenus dans la page.  |
| carouselData | optionnel | `{"id":"HomePageCarousel","control":{"previousLabel":"Précédent", "nextLabel":"Suivant"}, "displayIndicator":true, "style":"margin:auto" "slides":[{"type":"img", "data":"images/common/logo_left.png", "caption":"<h3>bob</h3><p>un texte</p>", "captionStyle":"color:black", "alt":"Une image", "style":"margin:auto;height:60%"}, {"type":"text", "caption":"<h3>Juste un texte sans images</h3><p>Et un peu de texte en plus qui prend un maximum de place pour voire ce que ca donne</p><p>avec un deuxième paragraphe</p>", "captionStyle":"color:black",}]}` | Inclut un carousel en dessous du contenu textuel |
| formData | optionnel | `{"to":"${webleger.site.forulaire.contact.general.email}", "method":"get" "enctype":"application/x-www-form-urlencoded", "sendLabel":"Contactez-moi", "fields":[{"id":"destinataire", "label":"Destinataire", "type":"text", "readOnly":"true", "value":"${webleger.site.forulaire.contact.general.email}", "specificClass":"form-control-plaintext"}, {"id":"motif", "label":"Motif", "type":"text", "name":"subject"}, {"id":"email", "label":"Votre e-mail", "type":"text", "name":"from"}, {"id":"message", "label":"Votre message", "type":"textarea", "rows":6, "name":"body"}]}` | inclut un formulaire en dessosu du contenu textuel |
| category | **requis** | documentation, création, V0.0.1 | est utiliser pour filter le contenu (notament via l'attribut ``includeContent``) |
| tags | optionnel | infos, tarifs | n'est pas affiché par le template. |
| status | **requis** | published | si "published" le bloque sera visible. Sinon il ne sera pas affiché. |
| contentImage | optionnel | images/principe.svg | Image à afficher pour se contenu. Est affiché par defaut a gauche du contenu textuel |
| specificClass | optionnel | mainBlock style2 | Permet d'ajouter un style CSS au bloque. |
| menu | optionnel | { `{"parent":"EthikNet", "specificClass":"menu_EthikNet"` | Permet d'ajouter un style CSS au menu pointant vers cet page. |
| order | **requis** | 050 | Ordre d'affichage du block par rapports aux autres. |
| exerpt | **recommandé** | Comprendre la structure d'une page de contenu | résumé bref de la page. Est utiliser lorsqu'il faut présenter le contenu parmis d'autres. |
| displayDate | optionnel (defaut : false) | true | si true la date de publication sera afficher en entete de la page |