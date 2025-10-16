<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"hookHelper", "description":"Helper for creating, rendering an res=gistering content for Hooks", "recommandedNamespace":"hookHelper", "require":[{"value":"commonHelper", "type":"lib"},{"value":"propertiesHelper", "type":"lib"}, {"value":"hooks", "type":"config"}], "uses":[{"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	${registerHooks()}
	<#return "" />
</#function>

<#function registerHooks configPropertyName = "hooks">
	<#if propertiesHelper.hasConfigValue(configPropertyName)>
		<#local includeText = propertiesHelper.retrieveAndDisplayConfigText(configPropertyName)>
		<#if logHelper??>
			${logHelper.stackDebugMessage("hookHelper.registerHooks : Loading hooks declaration with : " + includeText)}
		</#if>
		<#assign hooksDeclarations = propertiesHelper.parseJsonProperty(includeText)>
		<#list hooksDeclarations.data as hookDeclaration>
			${registerHook(hookDeclaration.position, hookDeclaration.action)}
		</#list>
	</#if>
</#function>

<#assign contributors = {}>
<#function getContributors hookId>
	<#return contributors[hookId] />
</#function>

<#-- 
Activate a hook.
@param hookId : Id (position) of hook
@param theContent : content passed to the hooked call (can be used to détermine how/what content should provide hooked macro).
  -->
<#macro hook hookId theContent>
	<#local hookContributors = getContributors(hookId)!"">
	
	<#if hookContributors?? && hookContributors?has_content>
		<#if logHelper??>
			<#local nbContributors = 0>
				<#if (contributors[hookId])??>
					<#local nbContributors = hookContributors?size>
				</#if>
				${logHelper.stackDebugMessage("Hook : Rendering " + hookId + " with " + nbContributors + " contributors (" + common.toString(hookContributors) + ") from : " + .caller_template_name)}
			</#if>
		<#list hookContributors as contributor>
			<#local contributorInterpretation = "<@${contributor} theContent />"?interpret>
			<@contributorInterpretation/>
		</#list>
	</#if>
</#macro>

<#function registerHook location functionName>
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : Registering function : " + functionName + " for location : " + location + " from : " + .caller_template_name)}
	</#if>
	
	<#if !(contributors[location])??>
		<#local contributorForLocation = {location, [functionName]}>
	<#else>
		<#local contributorForLocation = {location, contributors[location] + [functionName]}>
	</#if>
	<#assign contributors = contributors + contributorForLocation>
	
	<#return ""/>
</#function>