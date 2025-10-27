title=Composant Inludes
date=2025-10-24
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants includes
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"commonInc"}
order=731
~~~~~~
Ce composant permet d'inclure d'autres composants dans les templates. 
Il a aussi à charge de gèrer les composants (qui sont des éléments incluable dans les templates) notament : 

 - les charger et les rendre disponible, aux autres composants et au template) via leur *namespace*. Les composants sont alors utilsables comme s'ils avaient étés importés dans le modèle (template) ou les composants.
 - Appeler leur fonction ``init()``.
 - Leur passer le contenu si le composant déclare ``"contentChainBefore":true`` dans leur ``getComponnentInfo``.

 Ce composant permet aussi d'afficher la documentation de chacuns des composants : 
 
 - subTemplate ``buildAllComponnentsInfos`` : affiche le détails de tous les composants définie dans le fichier de configuration avec le paramètre ``components``
 - subTemplate : ``buildComponnentInfos`` : affiche le détail d'un seul composant. Utilse lattribut d'entête de contenu ``documentationComponent`` pour déterminer le composant à afficher.
 
 