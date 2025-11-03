title=Composant menu
date=2025-11-03
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants menu
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"menu"}
order=736
~~~~~~
Ce composant permet de créer le menu du site de façon automatique à partir des contenus. Il se configure via le fichier de configuration.

- ``site.menu.includeBlock=true`` : indique sir les bloque de paghe d'accueil doivent être dnas le menu
- ``site.menu.tags.include=global`` : indique les **tags** des contenus qui devront etre présent dasn le menu
- ``site.menu.includeCategories=homepage``: indique les **catégories** des contenus qui devront etre présent dasn le menu