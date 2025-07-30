title=Contact
date=2025-05-15
type=org_openCiLife_block
category=homepage
tags=
status=published
formData={"to":"${webleger.site.forulaire.contact.general.email}", "method":"get" "enctype":"application/x-www-form-urlencoded", "sendLabel":"Contactez-moi", "dataTransform":{"type":"obfuscated", "obfuscatedKey":"${webleger.site.forulaire.contact.general.email.ofuscation-mask}"}  "fields":[{"id":"destinataire", "label":"Destinataire", "type":"text", "readOnly":"true", "value":"${webleger.site.forulaire.contact.general.email}", "specificClass":"form-control-plaintext", "dataTransform":{"type":"obfuscated", "id":"emailHideButton", "obfuscatedKey":"${webleger.site.forulaire.contact.general.email.ofuscation-mask}", "hiddenByButton":"true", "hiddenButtonLabel":"afficher l'e-mail"}}, {"id":"motif", "label":"Motif", "type":"text", "name":"subject"}, {"id":"email", "label":"Votre e-mail", "type":"text", "name":"from"}, {"id":"message", "label":"Votre message", "type":"textarea", "rows":6, "name":"body"}]}
specificClass=mainBlock style2
contentImage=images/contact.svg
anchorId=Contact
order=050
~~~~~~
Contactez-moi en remplissant le formulaire ci-dessous.

Pour eviter de stocker votre message dans une Base De Données le formulaire va pré-remplir un e-mail. Vous n'aurez plus qu'a cliquer sur "envoyer". Si vous n'avez pas de client e-mail de configuré vous pouvez envoyer votre e-mail directement à l'adresse indiqué dans le formulaire en cliquant sur le bouton "afficher l'e-mail".