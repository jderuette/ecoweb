title=Composant carousel
date=2025-11-03
type=org_openCiLife_block
category=documentation, doc_composants, V0.0.1
tags=Création de contenu
status=published
exerpt=Composants carousel
specificClass=Documentation
displayDate=true
hooks={"data":[{"position":"afterBody", "action":"commonInc.buildComponnentInfos", "renderOnce":true}]}
documentationComponent={"namespace":"carousel"}
order=738
~~~~~~
Ce composant permet d'afficher un carousel d'images.

Il se configure via les attributs d'entête du contenu.

``carouselData={"id":"HomePageCarousel","control":{"previousLabel":"Précédent", "nextLabel":"Suivant"}, "displayIndicator":true, "style":"margin:auto" "slides":[{"type":"img", "data":"images/common/logo_left.png", "caption":"<h3>bob</h3><p>un texte</p>", "captionStyle":"color:black", "alt":"Une image", "style":"margin:auto;height:60%"}, {"type":"text", "caption":"<h3>Juste un texte sans images</h3><p>Et un peu de texte en plus qui prend un maximum de place pour voire ce que ca donne</p><p>avec un deuxième paragraphe</p>", "captionStyle":"color:black"}]}``


- ``carouselData.id`` : id CSS du carousel.
- ``carouselData.control.previousLabel`` : texte du bouton permettant d'afficher la diapositive précédente.
- ``carouselData.control.nextLabel`` : texte du bouton permettant d'afficher la diapositive suivante.
- ``carouselData.control.displayIndicator`` : indique si les boutons de navigations sont affiché ou non.
- ``carouselData.slides.type`` :  soit **img** soit **text**
- ``carouselData.slides.data`` : contenu de la diapositive (soit l'URL de l'image, soit le texte)
- ``carouselData.slides.caption`` : titre de la diapositive
- ``carouselData.slides.captionStyle`` : Style CSS à appliuer au titre (caption)
- ``carouselData.slides.alt`` : texte alternatif si l'image ne s'affiche pas
- ``carouselData.slides.style`` : style CSS de la diapositive.
