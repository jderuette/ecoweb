title=Composant hooks
date=2025-10-24
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants hooks
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"hookHelper"}
order=732
~~~~~~
Ce composant permet de déclarer des **hook** : une zone dans le template qui conteindra du contenu déclaré par d'autres composants. 

```
<#if hookHelper??>
	<@hookHelper.hook "topMenuContainer" content/>
</#if>
```

Le composant **hooks** permet d'ajouter du contenu dans une hook via sont identifiant. Soit de facçon globale : via le fichier de configuration

```
webleger.hooks={"data":[{"position":"afterBody", "action":"langHelper.build"}, {"position":"afterBody", "action":"form.build"}, ...
```

soit dans un contenu spécifique via les attributs d'entete d'un contenu

```
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos"}]}
```

Il est possible de configurer un délcenchement du rendu d'une hook de façon unique (pour la page en cour). Cela est pratique dans le cas d'une hook qui serait présent plusieurs fois dans une page mais pour lequel on ne souhaite la déclencher qu'une fois.
Par exemple avec le composant **block** si plusieurs blocks intégré dans un même autre contenu enregistre une hook, alors cette hook sera presente 2 fois au deuxièle block, 3 fois au troisème, ... Le paramètre ``"renderOnce":true`` permet d'éviter cette acumation car dès que la hook effectue le rendu, cette hook est supprimée. Les autre blocks peuvnt alors à nouveau l'ajouter (en précisant à nouveau ``"renderOnce":true`` ce qui fait que la hook est en faite ajouté au début du traitement du contenue, puis rendue, puis supprimée).