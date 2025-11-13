title=Composant sticker
date=2025-11-03
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants sticker
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"sticker"}
order=741
~~~~~~
Ce composant permet d'aficher des petit infos dans les contenu.

Ce composant se configure via l'entête de contenu

- ``stickers={"disposition":"center", "data":[{"label":"CMS Open Source & Écoconçu", "imageSpecificClass":"impact_img", "image":"<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' background-color='currentColor'><path d='M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z'></path><path d='M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12'></path></svg>"}]}``

- ``action.disposition`` : indique comment les stickers sont réparties entre eux. Valeurs possibles : **center**.
- ``action.specificClass`` : permet de définir une (ou plusieurs) classe CSS à appliquer au groupe de stickers.
- ``action.data`` : liste des stickers.
- ``action.data.label`` : texte affiché pour le sticker.
- ``action.data.image`` : (optionnel) image du sticker : soit une URL soit un SVG inline..
- ``action.data.imageSpecificClass`` : classe CSS à ajouter pour l'image.
- ``action.data.specificClass`` : classe CSS à ajouter pour le sticker (image + texte).

## Hook
Nécéiste la configuration d'une hook pour s'afficher. La hooks précisera où le sticker devra s'afficher.
Voici un exemple pour un **block**, en affichant les stickers juste avant le contenu du block

``hooks={"data":[{"position":"beforeBlockBody", "action":"sticker.build", "renderOnce":true}]}``
