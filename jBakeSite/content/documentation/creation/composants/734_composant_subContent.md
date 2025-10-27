title=Composant subContent
date=2025-10-26
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants subContent
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"subcontent"}
order=734
~~~~~~
Ce composant permet d'inclure des contenues dans un autre contenu. Il est assez simillaire au composant *block* mais **subContent* sert à effectuer des listing.
Par exemple "dans la même catégorie" ou "vous pourriez aussi aimer".

Pour ajouter des sous contenue il faut utiliser le paramètre d'entête de contenu ``includeContent``. Voici un exemple d'utilisation : 

```
includeContent={"type":"org_openCiLife_post", "category":"création", "specificClass":"documentation", "title":"Dans la même catégorie", "display":{"type":"card", "content":"link"}}
```

Choix des contenus : 

 - ``type`` : le type de contenu à conserver.
 - ``category`` : la catégorie de contenu à conserver.
 
Personalisation : 

 - ``specificClass`` permet d'ajouter une classe spécific pour permetre la personalisation de l'affichage (via le CSS).
 - ``title`` : permet de personaliser le titre de la section.

Le format d'affichae des éléments : 

- ``display.type`` : les formats supportés sont : 
  - **table** : les sous-contenus sont affiché sous forme d'un tableau. Chq=aque ligne affiche : l'image du contenue, le titre puis le contenu. Des colonnes supplémentaires peuvent être affiché à partir des attributs d'entête de chacun des sous contenue via l'attribut **additionalData**.
  - **link** : chaque contenu est un simple lien.
  - **modal** : ????
  - **visible** : ???
  - **collapse_block** : ??
  - **card** : ??
- ``display.content``
  - **modal** : lorsque l'utilsiateur cloque sur un element une fenêtre modal (une sorte de "popup" interne au site) s'affiche avec le contenu
  - **collapse_block** : lorssque l'utilisateur cloque sur un contenue le contenu s'affiche en dessous (comme dans une FaQ)
  - **link** : lorsque l'utilisateur clique sur le contenu une nouvelle page s'affiche
  - **visible** : le contenu est directement intégré
