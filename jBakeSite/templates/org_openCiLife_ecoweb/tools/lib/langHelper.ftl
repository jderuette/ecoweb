<#function getComponnentInfo>
	<#return {"name":"debugHelper", "description":"Helper for multi-language", "recommandedNamespace":"lang", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"propertiesHelper", "type":"lib"}]}>
</#function>

<#-- get the language of the content
    @param content The content.
-->
<#function getLang content>
	<#local contentLang = "fr_FR">
	
	<#if (config.site_langs_default)??>
		<#local contentLang = config.site_langs_default>
	</#if>
	
	<#if (content)?? && (content.lang)??>
		<#local contentLang = content.lang>
	</#if>
	
	<#return contentLang>
</#function>

<#-- Determine if content has the correct lang
    @param content The content.
-->
<#function isCorectLang content lang>
	<#local isCorectLang = sequenceHelper.seq_containsOne(lang getLang(content))>
	<#return isCorectLang>
</#function>

<#-- build the language siwthcer menu -->
<#macro buildLanguageSwitcher content>
	<#if (content)?? && (content.languageSwitcher)?? && content.languageSwitcher = "true">
	
		<#if !(config.site_langs)??>
			<@debug "buildLanguageSwitcher : Error missing 'config.langs' config value" />
		<#else>
			<#local jsonContent = propertiesHelper.parseJsonProperty(config.site_langs)>
			<#if !(jsonContent.data)??>
				<#if logHelper??>
					${logHelper.stackDebugMessage("buildLanguageSwitcher : Error missing 'data' attribute after JSON parsing of attribute ==> " + propertiesHelper.displayParseJsonError(jsonContent))}
				</#if>
			<#else>
				<ul class="languageSwitcher">
				<#list jsonContent.data as languageData>
					<#local isCurrentLang = (languageData.local == getLang(content))>
					<li>
					<#if (languageData.icon)??>
						<img src="${common.buildRootPathAwareURL(languageData.icon)}">
					</#if>
					<#local languageFolder = "">
					<#if (languageData.folder)?? && (languageData.folder?has_content)>
						<#local languageFolder = "/"+languageData.folder>
					</#if>
					<span><a class="language" href="${config.site_host}${languageFolder}/index.html"><#escape x as x?xml>${languageData.title}</#escape></a></span>
					</li>
				</#list>
				</ul>
			</#if>
		</#if>
	</#if>
</#macro>