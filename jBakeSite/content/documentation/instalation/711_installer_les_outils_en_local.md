title=Installer les outils en local
date=2025-04-07
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"documentation", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, preparation, V0.0.1
tags=installer WebLeger
status=published
exerpt=Outils à installer en local pour créer un site WebLègé
contentImage=images/common/logo_left.png
displayDate=true
order=711
~~~~~~
# Java

Nécéssaire pour transformer les pages de texte en HTML (JBake et Maven) et utiliser Elcipse IDE.

Il faut au minimum java 1.8 et un JDK Java Developement Kit ("Java for devellopers").

Il est recommandé de télécharger les versions **ZIP** et d'éviter le MSI ou l'installeur. En effet il s'agit d'une ancienne version de JAVA et il n'ai pas nécéssaire de remplacer votre version actuel sur votre ordinateur.
Il est recommandé de décompresser le ZIP dans un dossier sans espaces et pas trop long (_C:/MyProgram/Java_ par exemple).

## Oracle 

La version **1.8.0_191** d'Oracle à été testée, mais d'autres versions 1.8 devraient fonctionner sans problèmes.
vous pouvez télécharger Java Oracle ici : [https://www.oracle.com/fr/java/technologies/javase/javase8-archive-downloads.html](https://www.oracle.com/fr/java/technologies/javase/javase8-archive-downloads.html)

## Open JDK

La version **1.8.0_452** d'Open JDK à été testée. Mais d'aurets version 1.8 devraient fonctionenr sans problèmes.
Vous pouvez télécharger Java Open JDK ici : [https://www.openlogic.com/openjdk-downloads?field_java_parent_version_target_id=416&field_operating_system_target_id=All&field_architecture_target_id=All&field_java_package_target_id=All](https://www.openlogic.com/openjdk-downloads?field_java_parent_version_target_id=416&field_operating_system_target_id=All&field_architecture_target_id=All&field_java_package_target_id=All)

# Eclipse IDE
Très très utile pour : 

- éditer les fichier texte et avoir un prévisualisation minimal
- lancer le build de votre site
- partager votre code avec Git

## Installation
La version suivante à été testée d' *Eclipse IDE for Enterprise Java and Web Developers*. Cependant la dernière version disponible devrait fonctionner : 
    
    Version: 2023-12 (4.30.0)
    Build id: 20231201-2043
    
## Configuration
La version par défaut est tout à fait utilisable. Il y aura quelques règlage à faire (notament pour utiliser la bonne version de Java) qui seront expliquer lors de la création de votre premier site.

# optionel : KeyGen

Nécéssaire si vous souhaitez utiliser un système de clef de chiffrement pour échanger avec GitHub (recommandé).


