<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"EcoWebMacro", "description":"EcoWeb Template", "recommandedNamespace":"obfuscator", "uses":[{"value":"logHelper", "type":"lib"}, {"value":"displayDate", "type":"contentHeader"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#--  inspired by : https://subscription.packtpub.com/book/web_development/9781782163824/1/ch01lvl1sec06/top-9-features-you-need-to-know-about -->


<#macro displayPublicationDate content>
	<#if ((content.displayDate)?? && content.displayDate == "true")>
		<p>Publié le : <em>${content.date?string("dd MMMM yyyy")}</em></p>
	</#if>
</#macro>

<#macro displayTags content>
	<#if (content.tags)?? && (content.tags?size > 0) >
		<span>Tags : </span>
		<ul class="content_tags">
		<#list content.tags as tag>
			<li>${tag}</li>
		</#list>
		</ul>
	</#if>
</#macro>


<#macro bob block>
	A Basic BOB template !!!!
</#macro>

<#-- build an modal block (using Boostrap)
param : modalId : *default* : basicModal : (html) ID of the modal (to be ued in link to target this modal)
param : closeButtonlabel : *default* : close : label of the botom close button
-->
<#macro buildModal modalId="basicModal" closeButtonlabel = "close">
	<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Basic Modal</h4>
      			</div>
				<div class="modal-body">
					<img src="none" class="modal-image"/>
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
