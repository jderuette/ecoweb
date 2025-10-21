$('#basicModal').on('show.bs.modal', function (event) {
        console.log (event);
        console.log ('we are showing');
        
        
        var button = $(event.relatedTarget) // Button that triggered the modal
        //var recipient = button.data('whatever') // Extract info from data-* attributes
        var widget = button.parent();
        console.log (widget);
        
        var bodyContent = widget.find('.widget_content').html();
        console.log (bodyContent);
        
        var bodyTitle = widget.find('.widget_title').html();
        console.log (bodyTitle);
        
        var bodyImage = widget.find('.widget_image');
        console.log (bodyImage);
        console.log (bodyImage.attr('src'));
        
        var modal = $(this);
        modal.find('.modal-title').text(bodyTitle);
        modal.find('.modal-body-content').replaceWith('<div class="modal-body-content">' + bodyContent + '</div>');
        console.log (modal.find('.modal-image').attr('src'));
        modal.find('.modal-image').attr('src', bodyImage.attr('src'));
        /*
        var button = $(event.relatedTarget) // Button that triggered the modal
        var recipient = button.data('whatever') // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)
        modal.find('.modal-title').text('New message to ' + recipient)
        modal.find('.modal-body input').val(recipient)*/
     })


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
	console.log ("data-obfuscatedText : Handling obfuscated ("+obfuscatedValue+" using key : "+obfuscatedKey+")");
	var humanReadeableText = unObfuscText(obfuscatedValue, obfuscatedKey);
	$(this).text(humanReadeableText);
	$(this).off('click');
	$(this).next('img.showHiddenDataAppendedButton').remove();
});

$('span[data-obfuscatedkey]').append('<img class="showHiddenDataAppendedButton" style="width: 24px;margin: 0 4px 0 4px;" src="${webleger.build.host}/${webleger.site.template}/images/eyes.svg" alt="clickez pour voir l\'e-mail en clair"></img>');

function unObfuscText(source, key){
	var unOfuscatedText = source;
	var tokens = key.split(",");
	for (var token in tokens){
		var tokenDetails = token.split(":");
		//console.log ("unObfuscText : Replacing : " + tokenDetails[1] + " by : " + tokenDetails[0]);
		unOfuscatedText = unOfuscatedText.replace(tokenDetails[1], tokenDetails[0]);
	}
	return unOfuscatedText;
}
