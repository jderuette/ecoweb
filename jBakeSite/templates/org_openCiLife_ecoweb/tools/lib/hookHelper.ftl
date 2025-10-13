<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"hookHelper", "description":"Helper for creating, rendering an res=gistering content for Hooks", "recommandedNamespace":"hookHelper", "require":[{"value":"commonHelper", "type":"lib"}], "uses":[{"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#assign contributors = {}>
<#function getContributors hookId>
	<#return contributors[hookId] />
</#function>

<#macro hook hookId blockContent>
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
			<#local contributorInterpretation = "<@${contributor} blockContent />"?interpret>
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