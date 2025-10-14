<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"ressourcesHelper", "description":"Help manage required HTML ressources like CSS and JS", "recommandedNamespace":"ressourcesHelper"}>
</#function>

<#function init>
	<#return "" />
</#function>


<#assign allRessources = {}>

#-- To create "link" header line or footer scripts injection.
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
