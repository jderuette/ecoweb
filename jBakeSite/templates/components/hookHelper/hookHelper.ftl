<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"hookHelper", "description":"Helper for creating, rendering an registering content for Hooks", "version":"0.1.0", "recommandedNamespace":"hookHelper", "contentChainBefore":true, "require":[{"value":"commonHelper", "type":"lib"},{"value":"propertiesHelper", "type":"lib"}, {"value":"hooks", "type":"config"}], "uses":[{"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	${registerHooks()}
	<#return "" />
</#function>

<#function handleContentChain content>
	${registerContentHook(content)}
	<#return "" />
</#function>

<#function getContentIdentifier content>
	<#return content.uri!content.title!"no ID">
</#function>

<#function registerContentHook content>
	<#if (content.hooks)??>
		<#if logHelper??>
			${logHelper.stackDebugMessage("hookHelper.registerContentHook : INFO hooks content : registering hooks from : " + common.toString(content.hooks))}
		</#if>
		${registerHookFromJson(content.hooks)}
	</#if>
	<#return "" />
</#function>

<#function registerHooks configPropertyName = "hooks">
	<#if propertiesHelper.hasConfigValue(configPropertyName)>
		<#local includeText = propertiesHelper.retrieveAndDisplayConfigText(configPropertyName)>
		<#assign hooksDeclarations = propertiesHelper.parseJsonProperty(includeText)>
		<#if logHelper??>
			${logHelper.stackDebugMessage("hookHelper.registerHooks : INFO global hooks : registering hooks from : " + common.toString(hooksDeclarations))}
		</#if>
		${registerHookFromJson(hooksDeclarations)}
	</#if>
</#function>

<#function registerHookFromJson hooksJsonData>
	<#if hooksJsonData?? && (hooksJsonData.data)??>
		<#if logHelper??>
			<#local contentId = "no_content">
			<#if content??>
				<#local contentId = content.uri!"no_uri">
			</#if>
			${logHelper.stackDebugMessage("hookHelper.registerHookFromJson : INFO for content : " + contentId + " (or blocks, or subContents) registering " + hooksJsonData.data?size + " hooks from : " + common.toString(hooksJsonData))}
		</#if>
		<#list hooksJsonData.data as hookDeclaration>
			<#if (hookDeclaration.position)?? && (hookDeclaration.action)??>
				<#local renderOnce = false>
				<#if (hookDeclaration.renderOnce)?? && hookDeclaration.renderOnce == true>
					<#local renderOnce = true>
				</#if>
				<#local hookOrder = 50>
				<#if (hookDeclaration.order)??>
					<#local hookOrder = hookDeclaration.order?number>
				</#if>
				<#if !hookOrder?? || !hookOrder?is_number>
					<#if logHelper??>
						${logHelper.stackDebugMessage("hookHelper.registerHookFromJson : ERROR Invalid hook order value for :" + common.toString(hookDeclaration))}
					</#if>
				<#else>
					${registerHook(hookDeclaration.position, hookDeclaration.action, renderOnce, hookOrder)}
				</#if>
			<#else>
				<#if logHelper??>
					${logHelper.stackDebugMessage("hookHelper.registerHookFromJson : ERROR Invalid hook structure :" + common.toString(hookDeclaration))}
				</#if>
			</#if>
		</#list>
	</#if>
	<#return "">
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
			<#local nbContributors = hookContributors?size>
			<#if logHelper??>
				${logHelper.stackDebugMessage("Hook : Rendering " + hookId + " with " + nbContributors + " contributors (" + common.toString(hookContributors) + ") for " + getContentIdentifier(theContent) +" from : " + .caller_template_name)}
			</#if>
		</#if>
		<#list hookContributors?sort_by("order") as contributor>
			<#local contributorInterpretation = "<@${contributor.action} theContent />"?interpret>
			<@contributorInterpretation/>
			<#if contributor.renderOnce == true >
				${unRegisterHook(hookId, contributor.action)}
			</#if>
		</#list>
	</#if>
</#macro>

<#function registerHook location, action, renderOnce, order=50>
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : REGISTER hook : " + action + ", for location : " + location + ", renderOnce : " + renderOnce?string("true","false") + ", order : " + order + " from : " + .caller_template_name)}
	</#if>
	
	<#if !(contributors[location])??>
		<#local contributorForLocation = {location, [{"action":action, "renderOnce":renderOnce, "order":order}]}>
	<#else>
		<#local contributorForLocation = {location, contributors[location] + [{"action":action, "renderOnce":renderOnce, "order":order}]}>
	</#if>
	<#assign contributors = contributors + contributorForLocation>
	
	<#return ""/>
</#function>

<#function unRegisterHook location action>
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : UNREGISTER hook : " + action + " for location : " + location + " (" + displayContributorsSizeForLogs()+ ") from : " + .caller_template_name)}
	</#if>
	
	<#-- "filter" contributors -->
	<#local filteredContributors = contributors>
	<#list contributors as contributorLocation, contributorActions>
		<#if contributorLocation == location>
			<#local newContributors = []>
			<#list contributorActions as contributor>
				<#if contributor.action != action>
					<#local newContributors = newContributors + [contributor]>
				</#if>
			</#list>
			<#local filteredContributors = filteredContributors + {contributorLocation, newContributors}>
		</#if>
	</#list>
	<#assign contributors = filteredContributors>
	
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : UNREGISTER hook : Contributors after unregister (" + displayContributorsSizeForLogs()+ ")")}
	</#if>
	<#return ""/>
</#function>

<#function displayContributorsSizeForLogs>
	<#local totalContributor = 0>
	<#local dataToDisplay = "Nb location : " + contributors?size + " locations : ">
	<#list contributors as contributorLocation, contributorActions>
		<#local dataToDisplay = dataToDisplay + " [" + contributorLocation + "]:" + contributorActions?size>
		<#local totalContributor = totalContributor + contributorActions?size>
	</#list>
	
	<#local dataToDisplay = dataToDisplay + " TOTAL : " + totalContributor>
	<#return dataToDisplay>
</#function>