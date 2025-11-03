$('*[data-href]').on('click', function() {
    window.location = $(this).data("href");
});

function changeValue(targetId, newValue) {
  var input1 = document.getElementById(targetId);
  input1.value = newValue;
}

$('*[data-obfuscatedMailTo]').on('submit', function() {
	console.log ("data-obfuscatedMailTo : Handling obfuscated action for form : " + $(this).attr('id'));
	var obfuscatedEmail = $(this).data("obfuscatedmailto");
	var obfuscatedEmailKey = $(this).data("obfuscatedmailtokey");
	console.log ("data-obfuscatedMailTo : prepare to unobfuscate data : " + obfuscatedEmail + " using key : " + obfuscatedEmailKey);
	
	var humanReadeableEmail = unObfuscText(obfuscatedEmail, obfuscatedEmailKey);
	var newAction = "mailto:"+humanReadeableEmail
	$(this).attr('action', newAction);
    return true;
});

$('*[data-obfuscatedValue]').on('click', function() {
	var obfuscatedValue = $(this).data("obfuscatedvalue");
	var obfuscatedKey = $(this).data("obfuscatedkey");
	var obfuscatedTarget = $(this).data("obfuscatedtarget");
	console.log ("data-obfuscatedValue : Handling obfuscated action for : " + obfuscatedTarget  + " ("+obfuscatedValue+" using key : "+obfuscatedKey+") cliked on : " + $(this).attr('id'));
	var humanReadeableText = unObfuscText(obfuscatedValue, obfuscatedKey);
	$(obfuscatedTarget).val(humanReadeableText);
	$(obfuscatedTarget).attr("readonly", false);
});

$('span[data-obfuscatedkey]').on('click', function() {
	var obfuscatedValue = $(this).text();
	var obfuscatedKey = $(this).data("obfuscatedkey");
	console.log ("data-obfuscatedkey : Handling obfuscated ("+obfuscatedValue+" using key : "+obfuscatedKey+")");
	var humanReadeableText = unObfuscText(obfuscatedValue, obfuscatedKey);
	$(this).text(humanReadeableText);
	$(this).off('click');
	$(this).next('img.showHiddenDataAppendedButton').remove();
});

$('span[data-obfuscatedkey]').append('<img class="showHiddenDataAppendedButton" style="width: 24px;margin: 0 4px 0 4px;" src="${webleger.build.host}/${webleger.site.template}/images/eyes.svg" alt="clickez pour voir l\'e-mail en clair"></img>');

function unObfuscText(source, key){
	//console.log ("unObfuscText : key : " + key);
	var unOfuscatedText = source;
	var tokens = key.split(",");
	//console.log ("unObfuscText : tokens : " + tokens);
	for (i = 0; i< tokens.length; i++ ){
		var token = tokens[i];
		//console.log ("unObfuscText : parsing token : " + token);
		var tokenDetails = token.split(":");
		//console.log ("unObfuscText : Replacing : " + tokenDetails[1] + " by : " + tokenDetails[0]);
		unOfuscatedText = unOfuscatedText.replace(tokenDetails[1], tokenDetails[0]);
	}
	return unOfuscatedText;
}