<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"EcoWebMacro", "description":"All ecoWeb Macros. Need to be splited into smaller component.", "require":[{"value":"common", "type":"lib"}, {"value":"propertiesHelper", "type":"lib"}, {"value":"sequenceHelper", "type":"lib"}], "uses":[{"value":"Too many things !!", "type":"config, contentHeader, pomProperty"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#--  inspired by : https://subscription.packtpub.com/book/web_development/9781782163824/1/ch01lvl1sec06/top-9-features-you-need-to-know-about -->

<#function unObfuscateText obfucatedEmail, obfuscationMask>
	<#local humanReadableText = obfucatedEmail>
	<#if obfucatedEmail?? && obfuscationMask??>
		${stackDebugMessage("UnObfuscateText : decrypt text ! whith key : " + obfuscationMask)}
		<#local tokens=obfuscationMask?split(r"\s*,\s*", "r")>
		${stackDebugMessage(">>Email : " + tokens?size + " crypt token found")}
		<#list tokens as token>
			<#local tokenDetail=token?split(r"\s*:\s*", "r")>
			<#if tokenDetail?? && tokenDetail[0]?? && tokenDetail[1]??>
				${stackDebugMessage(">>>>UnObfuscateText : replacing " + tokenDetail[1] + " by " + tokenDetail[0])}
				<#local humanReadableText = humanReadableText?replace(tokenDetail[1], tokenDetail[0])>
			</#if>
			${stackDebugMessage(">>>>UnObfuscateText : Token has " + tokenDetail?size + " elements, current Human Readable e-mail : " + humanReadableText)}
		</#list>
	</#if>
	<#return humanReadableText>
</#function>


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

<#-- To create "link" header line or footer scripts injection.
param : content : JSON content describing inclusions.
-->
<#macro buildExternalInjection content>
	<#if (content)??>
		<#local jsonContent = propertiesHelper.parseJsonProperty(content)>
		
		<#if !(jsonContent.data)??>
			<#if logHelper??>
				${logHelper.stackDebugMessage("buildExternalInjection : Error missing 'data' attribute after JSON parsing of attribute ==> " + propertiesHelper.displayParseJsonError(jsonContent))}
			</#if>
		<#else>
		<#list jsonContent.data as injection>
			<#assign tagType = injection.tagType!"link">
			<#if ((injection.constraint)??)>
				<!--[${injection.constraint}]>
			</#if>
		<${tagType}<#if (injection.href??)> href="${common.buildRootPathAwareURL(injection.href)}"</#if><#if (injection.src??)> src="${common.buildRootPathAwareURL(injection.src)}"</#if><#if (injection.rel??)> rel="${injection.rel}"</#if>><#if (injection.tagType=="script")></script></#if>
			<#if ((injection.constraint)??)>
				<![endif]-->
			</#if>
		</#list>
		</#if>
	</#if>
</#macro>
