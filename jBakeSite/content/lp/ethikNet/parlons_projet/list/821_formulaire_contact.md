title=Formulaire de contact
date=2025-11-14
type=org_openCiLife_block
category=lp_ethiknet_parlons_projet
formData={"to":"${webleger.site.forulaire.contact.general.email}", "method":"get" "enctype":"application/x-www-form-urlencoded", "sendLabel":"Contactez-moi", "dataTransform":{"type":"obfuscated", "obfuscatedKey":"${webleger.site.forulaire.contact.general.email.obfuscation-mask}"}  "fields":[{"id":"destinataire", "label":"Destinataire", "type":"text", "readOnly":"true", "value":"${webleger.site.forulaire.contact.general.email}", "specificClass":"form-control-plaintext", "dataTransform":{"type":"obfuscated", "id":"emailHideButton", "obfuscatedKey":"${webleger.site.forulaire.contact.general.email.obfuscation-mask}", "hiddenByButton":"true", "hiddenButtonLabel":"afficher l'e-mail"}}, {"id":"motif", "label":"Motif", "type":"text", "name":"subject"}, {"id":"message", "label":"Votre message", "type":"textarea", "rows":6, "name":"body"}]}
anchorId=lp_ethikNet_devis
status=published
order=821
~~~~~~
Remplissez ce formulaire pour recevoir un devis