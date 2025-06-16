title=Tutoriel héberger sur gitHub Pages (gh-pages)
date=2025-06-16
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"documentation", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation
tags=autonomie IT
status=published
exerpt=Herbeger le site
contentImage=images/servers.svg
displayDate=true
order=750
~~~~~~
## Pré-requis

Le serveur web doit être accessible sur internet.
Vous devez avoir un nom de domaine. Cela peut être un nom "par defaut" proposer par votre hébergeur ou un nom de domaine personnalisé (vous devrez alors acheter le Nom de Domaine).

Le serveur à besoin uniquement un d'un serveur web classique (par exemple [HTTPD (apache)](https://httpd.apache.org/) ou [Nginx](https://nginx.org/)).
Même si Weblèger est par conception sécurisé soyez vigilant sur la sécurité.

## Instlation de votre site

Il suffit de déposer sur votre serveur (soit via l'interface dédiée fournie par votre hébergeur soit via FTP) le dossier **website** de votre projet ![dossier website dans le projet](../images/documentation/heberger_site/dossier_website_dans_le_projet.png)