<#function getComponnentInfo>
	<#return {"name":"commonHelper", "description":"general purpose tools", "recommandedNamespace":"common"}>
</#function>


<#-- Build URL, using the root.path if required 
param : relativeUrl : the relative URL to adapt
return : URL prepend with rootPath (if configured)
-->
<#function buildRootPathAwareURL relativeUrl>
	<#assign rootPathAwareURL = relativeUrl>
	
	<#if (content.rootpath)??>
		<#assign rootPathAwareURL = content.rootpath + relativeUrl>
	</#if>
	
	<#return rootPathAwareURL>
</#function>

<#-- search for absolute URL in content and preprend the RootPath
param : text : the teh text to search for relative URL
param : rootPath : default ${content.rootpath} : the rootPath of teh webSite
return : text with URL transformed
-->
<#-- 
<#function findAndReplaceUrlAddAwareRootPath text rootPath = content.rootpath>
	<#assign contentRootPathAwareURL = text>
	
	<#if (config.rootPath)??>
		<#assign contentRootPathAwareURL = text?replace("/images/", rootPath + "/images/", "r")>
	</#if>
	
	<#return contentRootPathAwareURL>
</#function>
 -->

<#-- convert hash, sequence, boolean to String
param : value : object to transform in String
-->
<#function toString value>
	<#local stringVal = "">
	<#if (value?is_hash)>
		<#local stringVal = stringVal + "{" />
		<#local separator = "">
		<#list value as key, value>
			<#local stringVal = stringVal + separator + toString(key) + ":"/>
			<#local stringVal = stringVal + toString(value)/>
			<#local separator = ",">
		</#list>
		<#local stringVal = stringVal + "}" />
	<#elseif (value?is_sequence)>
		<#local stringVal = stringVal + "[" />
		<#local separator = "">
		<#list value as value>
			<#local stringVal = stringVal + separator + toString(value)/>
			<#local separator = ",">
		</#list>
		<#local stringVal = stringVal + "]" />
	<#elseif (value?is_boolean)>
		<#local stringVal = stringVal + value?string('true', 'false') />
	<#else>
		<#local stringVal = stringVal + "\"" + value + "\"" />
	</#if>
	<#return stringVal>
</#function>

<#assign oldRdnVal = 1>
<#function randomNumber salt = 7>
    <#local str= .now?long />
    <#local str = (str * salt)/3 />
    <#local random = str[(str?string?length-13)..] />
    <#local returnVal = random?replace("\\D+", "1", "r") />
    <#if returnVal?number == oldRdnVal?number>
    	<#local returnVal += 1>
    </#if>
    <#assign oldRdnVal = returnVal>
    <#return returnVal/>	
</#function>