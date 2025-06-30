title=Tutoriel héberger sur gitHub Pages (gh-pages)
date=2025-05-02
type=org_openCiLife_post
includeContent={"type":"org_openCiLife_post", "category":"preparation", "specificClass":"documentation", "display":{"type":"card", "content":"link"}}
category=documentation, preparation, V0.0.1
tags=autonomie IT
status=published
exerpt=Comment herbger un site sur gitHub Pages (pour démo ou partage avec relecteurs)
contentImage=images/documentation/deploy_github/gitHub-logo.svg
displayDate=true
order=716
~~~~~~
## Pour quel contenus ? 

GitHub Pages ne peut héberger que des site web statiques, sans php ni java ni autre technologie "serveur" qui serait nécéssaire pour afficher les pages.

## Principe général

Cette articles vous donnera plus d'information sur comment héberger un site sur gitHubPage indépendament de l'outils que vous utilisez [https://www.lorenzobettini.it/2020/01/publishing-a-maven-site-to-github-pages/](https://www.lorenzobettini.it/2020/01/publishing-a-maven-site-to-github-pages/).

## Avec Webleger ?

Avec WebLeger  cela est encore plus simple car intégré.
1-Changez l'URL de publication dans le fichier *pom.xml* en changeant **jderuette/ecoweb.git** par l'URL de votre repository.

    <properties>
      ...
      <publish.url>scm:git:git@github.com:jderuette/ecoweb.git</publish.url>
      ...
    </properties>
    
2- créez une clef SSH pour acceder à vore rerpository [https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh).
3- Créez la branche gh-pages. **Attention** cette action va vous faire perdre tout contenus **non commité** sur votre branches acutel.

    git checkout --orphan gh-pages
    rm .git/index ; git clean -fdx
    echo "It works" > index.html
    git add . && git commit -m "initial site content" && git push origin gh-pages
4- Construisez le site comme d'habitude

    mvn clean initialize resources:resources jbake:generate
5- Lancez le déploiement

    scm-publish:publish-scm

6- Attendez quelques minutes puis aller visualiser le résultat

## Limites
La mise à jour du site peut prendre plusieurs minutes. En effet gitHub Pages n'est pas fait pour héberger rapidement des sites. Ce mode d'hébergement est cependant pratique pour des démos ou pour partager occasionnellement le site avec les relecteurs.
