<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"hookHelper", "description":"Helper for creating, rendering an registering content for Hooks", "recommandedNamespace":"hookHelper", "contentChainBefore":true, "require":[{"value":"commonHelper", "type":"lib"},{"value":"propertiesHelper", "type":"lib"}, {"value":"hooks", "type":"config"}], "uses":[{"value":"logHelper", "type":"lib"}]}>
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
		<#local contentHooksString = common.toString(propertiesHelper.secureStringJsonData(content.hooks))>
		<#if logHelper??>
			<#if contentHooksString??>
				${logHelper.stackDebugMessage("hookHelper.registerContentHook : ADDING contentHooks : " + contentHooksString) + " for : " + content.uri}
			</#if>
		</#if>
		<#local contentHooks = propertiesHelper.parseJsonProperty(contentHooksString)>
		<#if hookHelper?? && contentHooks?? && (contentHooks.data)??>
			<#list contentHooks.data as hookDeclaration>
				<#if logHelper??>
					${logHelper.stackDebugMessage("hookHelper.registerContentHook : trying to register hook : " + common.toString(hookDeclaration))}
				</#if>
				<#if (hookDeclaration.position)?? && (hookDeclaration.action)??>
					<#local renderOnce = false>
					<#if (hookDeclaration.renderOnce)?? && hookDeclaration.renderOnce == true>
						<#local renderOnce = true>
					</#if>
					${hookHelper.registerHook(hookDeclaration.position, hookDeclaration.action, renderOnce)}
				<#else>
					<#if logHelper??>
					${logHelper.stackDebugMessage("hookHelper.registerContentHook : ERROR Invalid hook structure :" + common.toString(hookDeclaration))}
				</#if>
				</#if>
			</#list>
		</#if>
	</#if>
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
			<#local renderOnce = false>
			<#if (hookDeclaration.renderOnce)?? && hookDeclaration.renderOnce == true>
				<#local renderOnce = true>
			</#if>
			${registerHook(hookDeclaration.position, hookDeclaration.action, renderOnce)}
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
			<#local nbContributors = hookContributors?size>
			${logHelper.stackDebugMessage("Hook : Rendering " + hookId + " with " + nbContributors + " contributors (" + common.toString(hookContributors) + ") for " + getContentIdentifier(theContent) +" from : " + .caller_template_name)}
		</#if>
		<#list hookContributors as contributor>
			<#local contributorInterpretation = "<@${contributor.action} theContent />"?interpret>
			<@contributorInterpretation/>
			<#if contributor.renderOnce == true >
				${unRegisterHook(hookId, contributor.action)}
			</#if>
		</#list>
	</#if>
</#macro>

<#function registerHook location, action, renderOnce>
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : Registering function : " + action + " for location : " + location + " from : " + .caller_template_name)}
	</#if>
	
	<#if !(contributors[location])??>
		<#local contributorForLocation = {location, [{"action":action, "renderOnce":renderOnce}]}>
	<#else>
		<#local contributorForLocation = {location, contributors[location] + [{"action":action, "renderOnce":renderOnce}]}>
	</#if>
	<#assign contributors = contributors + contributorForLocation>
	
	<#return ""/>
</#function>

<#function unRegisterHook location action>
	<#if logHelper??>
		${logHelper.stackDebugMessage("Hook : UnRegistering function : " + action + " for location : " + location + " from : " + .caller_template_name)}
	</#if>
	
	<#-- "filter" contributors -->
	<#local filteredContributors = {}>
	<#list contributors as contributorLocation, contributorActions>
		<#list contributorActions as contributor>
			<#if contributorLocation == location && contributor.action == action>
				<#continue>
			</#if>
			<#local contributorForLocation = {contributorLocation, [{"action":contributor.action, "renderOnce":contributor.renderOnce}]}>
		</#list>
		<#local filteredContributors = filteredContributors + contributorForLocation>
	</#list>
	<#assign contributors = filteredContributors>
	
	<#return ""/>
</#function>