title=Composant Inludes
date=2025-10-24
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants includes
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos"}]}
documentationComponent={"file":"components/includes/includes.ftl", "namespace":"commonInc"}
order=730
~~~~~~
Ce composant permet d'inclure d'autres composants dans les templates. 
Il a aussi à charge de gèrer les composants (qui sont des éléments incluable dans les templates) notament : 

 - les charger et les rendre disponible, aux autres composants et au template) via leur *namespace*
 - Appeler leur fonction ``init()``
 - Leur passer le contenu si le composant déclare ``"contentChainBefore":true`` dans leur ``getComponnentInfo`` 
