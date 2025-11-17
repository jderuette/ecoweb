title=Les composants
date=2025-10-23
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "title":"Dans la même catégorie", "display":{"type":"card", "content":"link"}}
includeBlocks={"category":"doc_composants"}
category=documentation, doc_chapter, création, V0.0.1
tags=Création de contenu
status=published
exerpt=Ré-utilisation de fonctionnalitées
contentImage=images/documentation/paint.svg
specificClass=Documentation
displayDate=true
order=730
~~~~~~
Les composants permettent de créer de "petites" fonctionnalitées qui peuvent être ré-utilisée dans les templates.
Il s'agit simplement d'un fichier FreeMarker, avec 2 méthodes qui permettent des les identifier : 

- ``getComponnentInfo`` qui renvoie des information sur le composant
- ``init`` qui permet au composant de signaliser si besoin.

Dans la **version 1** des composants la méthode ``getComponnentInfo`` doit renvoyer un JSON.

Les composant peuvent ajouter des fonctionalitées : 
 - de supports (logs, documentation)
 - de structure (sous templates, listing)
 - d'usage (carousel, menu, multi-langue, fils d'ariane)