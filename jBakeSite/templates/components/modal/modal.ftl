<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"modal", "description":"Generate and display modal (use boostrap)", "recommandedNamespace":"modal", "require":[{"value":"common", "type":"lib"}, {"value":"bootstrap3", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#-- build an modal block (using Boostrap)
param : modalId : *default* : basicModal : (html) ID of the modal (to be ued in link to target this modal)
param : closeButtonlabel : *default* : close : label of the botom close button
-->
<#macro buildModalContainer modalId="basicModal" closeButtonlabel="close">
	<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="détails" aria-inert="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Basic Modal</h4>
      			</div>
				<div class="modal-body">
					<div class="modal-image"></div>
					<div class="modal-body-content">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">${closeButtonlabel}</button>
				</div>
			</div>
		</div>
	</div>
</#macro>

<#-- !!!! if  interactionType="link" the link end tag must be added MANUALLY. This macro only create the *start* link tag (and required content for modal bases on extract param) -->
<#macro extractContentForModal theContent interactionType="button", cssPrefix="widget", buttonLabel="Détails", extract=["title", "contentImage", "content"] theModalId="basicModal">
	<#switch interactionType>
		<#case "button">
			<button type="button" class="btn btn-primary btn-block ${cssPrefix}_showMore showMore" data-toggle="modal" data-target="#${theModalId}" data-content-position="parent" data-content-class-prefix="${cssPrefix}">${buttonLabel}</button>
		<#case "link">
			<a href="#" data-toggle="modal" data-target="#${theModalId}" data-content-position="inside" data-content-class-prefix="${cssPrefix}">
	</#switch>
	
	<#if extract?seq_contains("content")>
		<div class="${cssPrefix}_content contentHidden">
			${theContent.body!""}
		</div>
	</#if>
	<#if extract?seq_contains("title")>
		<span class="${cssPrefix}_title contentHidden">${theContent.title}</span>
	</#if>
	
	<#if extract?seq_contains("contentImage")>
		<span class="${cssPrefix}_title contentHidden">${theContent.title}</span>
	</#if>
	<#if (theContent.contentImage)??>
		<@common.addImageIcon theContent.contentImage cssPrefix+"_image contentHidden"/>
	</#if>
</#macro>

