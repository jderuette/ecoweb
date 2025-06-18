title=Qu'est-ce qu'un site eco-conçu ?
date=2019-10-15
type=org_openCiLife_post
category=main
tags=économie datas
status=published
exerpt=comprendre l'éco-conception pour le Web
contentImage=images/articles/eco_conception/eco_conception.png
order=610
~~~~~~
## Le poid d'une page internent
Le poids moyen des pages web a augmenté de (entre 2015 et 2018)

- 29,5 % pour le poids en desktop à 1,72 Mo 
- 93,7 % pour le poids en mobile à 1, 56 Mo.

On a envoyé apollo 11 sur la Lune avec la capacité de calcul d'une carte SIM (72Ko). Toute l'approche d'OpenCyLife est orienté dans ce sens avec le partenariat de Green.it pour un web plus sobre. [115 bonnes pratiques de l'écoconception](https://www.greenit.fr/2019/05/07/ecoconception-web-les-115-bonnes-pratiques-3eme-edition/)

## Comment le réduire
Le principe générale est de réduire : 

- le poid des images
- le poid des fichier CSS (mise en forme des pages)
- le poid de fichier javaScript (animation du contenu et mise en forme des pages)

## Quel intéret ? 
En réduisant le poid des pages on réduit le débit internet nécéssaire et on réduit la puissance necesaire du naviguateur pour afficher les pages.

## La partie masqué de l'emprunte
Depuis plusieurs années l'éco-conception de site web vise à réduire la taille des pages. C'est une bonne choses mais insufisant. En effet les pages affichées sont très souvent générées dynamiquement sur les serveurs Web. Cela nécéssite pour chaque page affichée à un utilisateur d'effectuer de nombreux calculs pour afficher le contenus.
Parfois cela est nécéssaire (notmament lorsque les informations affichées **doivent** être différentes pour chaque visiteur).
Souvent ce n'est pas très utile car tous les visiteurs verront la même page. Cependant les developpeurs ont pris l'habitude d'utiliser ces outils de génération dynamique des pages et l'utilise donc même pour des site qui n'en ont pas besoin.

**WebLeger** propose une solution pour éviter tous ces calculs sur les serveurs et est **100%** compatible avec les technique d'éco-conception existantes.



