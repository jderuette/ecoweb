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
| title | **requis** | Nos engagements | Le titre du bloc |
| date | optionnel | 2025-04-30  | La date de publication. Est affiché uniquement si l'attribut ``displayDate`` vaut "true" . |
| type | **requis** | org_openCiLife_post | Le type de contenu : indique que se contenu sera une page. |
| includeContent | optionnel | `{"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "title":"Dans la même catégorie",  "display":{"type":"card", "content":"link"}}` | Inclut d'autre contenus dans la page.  |
| includeBlocks | optionnel | `{"category":"Ethiknet_block"}` | Inclut des block de contenu dans la page (après le contenu).  |
| carouselData | optionnel | `{"id":"HomePageCarousel","control":{"previousLabel":"Précédent", "nextLabel":"Suivant"}, "displayIndicator":true, "style":"margin:auto" "slides":[{"type":"img", "data":"images/common/logo_left.png", "caption":"<h3>bob</h3><p>un texte</p>", "captionStyle":"color:black", "alt":"Une image", "style":"margin:auto;height:60%"}, {"type":"text", "caption":"<h3>Juste un texte sans images</h3><p>Et un peu de texte en plus qui prend un maximum de place pour voire ce que ca donne</p><p>avec un deuxième paragraphe</p>", "captionStyle":"color:black",}]}` | Inclut un carrousel en dessous du contenu textuel |
| formData | optionnel | `{"to":"${webleger.site.forulaire.contact.general.email}", "method":"get" "enctype":"application/x-www-form-urlencoded", "sendLabel":"Contactez-moi", "fields":[{"id":"destinataire", "label":"Destinataire", "type":"text", "readOnly":"true", "value":"${webleger.site.forulaire.contact.general.email}", "specificClass":"form-control-plaintext"}, {"id":"motif", "label":"Motif", "type":"text", "name":"subject"}, {"id":"email", "label":"Votre e-mail", "type":"text", "name":"from"}, {"id":"message", "label":"Votre message", "type":"textarea", "rows":6, "name":"body"}]}` | inclut un formulaire en dessous du contenu textuel |
| action | optionnel | `action={"disposition":"center", "specificClass":"cta", "data":[{"type":"button", "label":"Demander un devis gratuit", "specificClass":"btn-primary", "operation":{"type":"anchor", "to":"lp_ethikNet_devis"}}, {"type":"button", "label":"Découvrir nos services", "operation":{"type":"anchor", "to":"lp_ethiknet_services"}}]}` | permet d'ajouter des bouttons via les hooks des template |
| hooks | optionnel | `hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos"}]}` | permet de contribuer à une hook existante |
| stickers | optionnel | `{"disposition":"center", "specificClass":"noText", "data":[{"image":"<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z'></path><path d='M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12'></path></svg>"}, {"image":"<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M4 14a1 1 0 0 1-.78-1.63l9.9-10.2a.5.5 0 0 1 .86.46l-1.92 6.02A1 1 0 0 0 13 10h7a1 1 0 0 1 .78 1.63l-9.9 10.2a.5.5 0 0 1-.86-.46l1.92-6.02A1 1 0 0 0 11 14z'></path></svg>"},{"image":"<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M4 10h12'></path><path d='M4 14h9'></path><path d='M19 6a7.7 7.7 0 0 0-5.2-2A7.9 7.9 0 0 0 6 12c0 4.4 3.5 8 7.8 8 2 0 3.8-.8 5.2-2'></path></svg>"}}` | permet d'ajouter des icon ou icon+texte dans un contenu |



| category | **requis** | documentation, création, V0.0.1 | Est utiliser pour filtrer le contenu (notament via l'attribut ``includeContent``) |
| tags | optionnel | infos, tarifs | Liste des tags de ce contenu. Est affiché sur certains type de contenus. |
| status | **requis** | published | Si "published" le bloque sera visible. Sinon il ne sera pas affiché. |
| contentImage | optionnel | images/principe.svg | Image à afficher pour se contenu. Est affiché par defaut a gauche du contenu textuel |
| specificClass | optionnel | mainBlock style2 | Permet d'ajouter un style CSS au bloque. |
| menu | optionnel | { `menu={"parent":{"title":"EthikNet", "specificClass":"menu_EthikNet"}, "dropDownSpecificClass":"dropDown_menu_EthikNet", "specificClass":"agence"}` | Permet d'ajouter des styles CSS au menu pointant vers cette page. Permet aussi de regrouper les elements de menu. Les contenue avec cette propriété seront automatiquement ajouté au (sous)menu. |
| lang | optionnel | en_EN | Lang du contenu : defaut : `site.langs.default` |
| specificClass | optionnel | mainBlock style2 | permet d'ajouter un style CSS au contenu. |
| pageSpecificClass | optionnel | lpEthikNet | permet d'ajouter un style CSS à la page entière (peut impacter le menu, footer, ...). |
| order | **requis** | 050 | Ordre d'affichage du block/page par rapports aux autres. |
| exerpt | **recommandé** | Comprendre la structure d'une page de contenu | Résumé bref de la page. Est utiliser lorsqu'il faut présenter le contenu parmis d'autres. |
| displayDate | optionnel (defaut : false) | true | Si true la date de publication sera affiché en entête de la page |
| displayMenu | optionnel (defaut : true) | false | Permet de masquer le menu (utile pour les Landing Pages) |
| displaySiteHeaderTitle | optionnel (defaut : true) | true | Permet de masquer le block de titre/logo de la page (utile pour les Landing Pages) |
| displayPreHeader | optionnel (defaut : true) | false | Permet de masquer les block en haut de la page (utile pour les Landing Pages) |
| displayTitle | optionnel (defaut : true) | true | Si false Le titre de publication ne sera pas affiché en entête de la page |
| displayBreadcrumb | optionnel (defaut : false) | true | Si false le fil d'ariane ne sera pas affiché en entête de la page |