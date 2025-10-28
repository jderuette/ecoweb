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
