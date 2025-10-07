<#import "../tools/lib/propertiesHelper.ftl" as propertiesHelper>

<#function getComponnentInfo>
	<#return {"name":"includes", "description":"Include ftl file as import in templates", "require":[{"value":"propertiesHelper", "type":"lib"}, {"value":"components", "type":"config", "desc":"with *namespace* attributs"}]}>
</#function>

<#macro buildIncludes configPropertyName="components">
	<#if propertiesHelper.hasConfigValue(configPropertyName)>
		<#assign icludes = propertiesHelper.parseJsonProperty(propertiesHelper.retrieveAndDisplayConfigText(configPropertyName))>
		<#list icludes.data as include>
			<#if (include.namespace)??>
				<#assign fileName = include.file>
				<#assign includeNameSpace = include.namespace>
				<#import "../"+include.file as includeNameSpace>
				<@'<#global ${include.namespace} = includeNameSpace>'?interpret />
			</#if>
		</#list>
	</#if>
</#macro>