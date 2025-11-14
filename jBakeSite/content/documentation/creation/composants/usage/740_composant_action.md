title=Composant action
date=2025-11-03
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants action
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"action"}
order=740
~~~~~~
Ce composant permet d'aficher des actions à l'intérieur des contenu (par exemple des bouton : call to action).

Ce composant se configure via l'entête de contenu

- ``action={"disposition":"center", "specificClass":"cta", "data":[{"type":"button", "label":"Commencer gratuitement", "specificClass":"btn-primary", "operation":{"type":"anchor", "to":"lp_start"}}, {"type":"button", "label":"Découvrir les fonctionnalités", "operation":{"type":"anchor", "to":"lp_fonctionalities"}}]}``

- ``action.disposition`` : indique comment les boutons sont réparties entre eux. Valeurs possibles : **center**.
- ``action.specificClass`` : permet de définir une (ou plusieurs) classe CSS à appliquer au groupe d'actions.
- ``action.data`` : liste des actions.
- ``action.data.type`` : type d'action. Valeurs possibles : **button**.
- ``action.data.label`` : texte affiché pour l'action.
- ``action.data.operation`` : défini l'opaation à appliquer lorsque l'utilsiateur inter-agit (clique) avec l'action.
- ``action.data.operation.type`` : type d'opération à effectuer. Valeurs possibles : anchor, link, mailto.
- ``action.data.operation.to`` : destination de l'action.
- ``action.data.operation.obfuscationMask`` : (optionnel) si défini le *label* sera décodé avec le masque présent.

### Hook
Nécéiste la configuration d'une hook pour s'afficher. La hooks précisera où le sticker devra s'afficher.
Voici un exemple pour un **block**, en affichant les stickers juste après le contenu du block (et avant les autres contenu par defaut dans cette hook).

``hooks={"data":[{"position":"afterBlockBody", "action":"action.build", "renderOnce":true, "order":30}]}``
