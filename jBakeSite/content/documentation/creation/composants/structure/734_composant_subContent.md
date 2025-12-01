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
 - ``hooks`` : permet d'ajouter des contenu via les Hooks interne du composant, par exemple pour activer les formulaire et les block dans **les** sous-contenus : 
 
 ```
 "hooks":{"data":[{"position":"endItemSubContent", "action":"block.build", "renderOnce":true}, {"position":"endItemSubContent", "action":"form.build", "renderOnce":true}]}, "display":{"type":"card", "content":"visible"}
 ```

Le format d'affichage des éléments : 

- ``display.type`` : les formats supportés sont : 
	- **table** : les sous-contenus sont affiché sous forme d'un tableau. Chaque ligne affiche : l'image du contenu, le titre puis le résumé du contenu. Des colonnes supplémentaires peuvent être affichée à partir des attributs d'entête de chacun des sous contenu via l'attribut **columns**.
	- **link** : chaque contenu est un simple lien.
	- **collapse_block** : les sous-contenus sont affiché sous forme d'un paragraphe avec un titre le contenu s'affiche en dessous lorsque l'utilisateur clique sur le titre (comme dans une FaQ)
	- **card** : chaque contenu est fficher sous forme d'une petite carte.
- ``display.content``
	- **modal** : Un bouton est affiché permetant d'afficher le détail du contenu dans une fenêtre modal (une sorte de "popup" interne au site) s'affiche avec le contenu
	- **modalLink** : Lorsque l'utilisateur clique une fenêtre modal apparait avec le détail du contenu.
	- **link** : lorsque l'utilisateur clique sur le contenu une nouvelle page s'affiche
	- **visible** : le contenu est directement intégré
  
Des exmples des différentes combinaisons sont diponibles : [subContent_exemples/735_composant_subContent_exemples.html](subContent_exemples/735_composant_subContent_exemples.html)

Les autres attributs : 

``includeContent.display.columns`` : liste des colonnes du tableau a afficher. Le format d'un colone est le suivant : ``{"name":"titre_de_la_colnne", "attr":"nom_de_l'attribut", "order":1}`` par exemple : {"name":"logo", "attr":"contentImage", "order":1}. **nom_de_l'attribut** est un attribut d'entête du contenu.

``includeContent.display.closeButton`` : texte du bouton permetant de fermer la fenêtre modal.

``includeContent.display.beforeTitleImage`` : image à afficher avant le titre pour les bloque de textes rétractables.