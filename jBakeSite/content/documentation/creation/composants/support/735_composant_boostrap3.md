title=Composant bootstrap3
date=2025-10-26
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants bootstrap3
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"boostrap3"}
order=735
~~~~~~
Ce composant permet d'intégrer BootStrap (version3) ainsi que JQuery 1.11.1. Les fichier CSS et JS du composant doivent être intégré manuellement dans le fichier de configuration. Les fichiers sont automatiquement disponible dans le dossier *templates/components/bootstrap3/copyToAssests/noAgregation*, mais ne sont pas automatiquement référencé dans le header/footer de la page.

 - *site.script.header* : ajouter ``"href":"templates/components/bootstrap3/copyToAssests/noAgregation/html5shiv.min.js", "rel":"stylesheet", "constraint":"if lt IE 9"}``
 - *webleger.site.script.footer* : ajouter ``{"tagType":"script", "src":"templates/components/bootstrap3/copyToAssests/noAgregation/jquery-1.11.1.min.js"}, {"tagType":"script", "src":"templates/components/bootstrap3/copyToAssests/noAgregation/bootstrap.min.js"}``