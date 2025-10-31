<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"commonHelper", "description":"general purpose tools", "recommandedNamespace":"common", "uses":[{"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
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

<#-- 
<#function functionExists namespace functionName>
	<#local exists = false>
	<#local includeNameSpace = .vars[namespace]>
	<#local namespaceExists = (includeNameSpace)??>
	
	<#local functionExistsInNamespace = false>
	<#if namespaceExists>
		<#local functionExistsInNamespace = ("${namespace}.${functionName}"?interpret)??>
		<#if functionExistsInNamespace>
			<#local exists = true>
		</#if>
	</#if>
	
	<#if logHelper??>
		${logHelper.stackDebugMessage("functionExists : namespace '" +namespace +"' exists : " + namespaceExists?string('yes', 'no') + " ==> '" + functionName + "()' exists ? " + functionExistsInNamespace?string('yes', 'no'))}
	</#if>
	<#return exists>
</#function>


<#function callFunctionIfExists namespace functionName>
	<#if functionExists(namespace, functionName)>
		<#if logHelper??>
			${logHelper.stackDebugMessage("callFunctionIfExists : calling '" +namespace +"." + functionName + "' (==>" + "${namespace}.${functionName}()" +")")}
		</#if>
		<#assign tempAutoLoadVar = "${namespace}.${functionName}"?interpret>
	</#if>
	<#return "">
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

<#assign oldRdnValues = []>
<#function randomNumber salt = 7>
    <#local str= .now?long />
    <#local str = (str * salt)/3 />
    <#local random = str[(str?string?length-13)..] />
    <#local returnVal = random?replace("\\D+", "1", "r") />
    <#list 0..100 as _>
    	<#if  !oldRdnValues?seq_contains(returnVal)>
    		<#break>
    	</#if>
    	<#if logHelper??>
			${logHelper.stackDebugMessage("common.randomNumber : (" + _?counter + ") " + returnVal + " already used, adding 1")}
		</#if>
    	<#local returnVal += 1>
    </#list>
    <#assign oldRdnValues = oldRdnValues + [returnVal]>
    <#return returnVal/>	
</#function>