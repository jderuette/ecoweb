<#if (config.site_langs_default)??>
	<#setting locale=config.site_langs_default>
</#if>
<#import "../tools/includes.ftl" as commonInc>
<@commonInc.buildIncludes />
<!DOCTYPE html>
<html lang="<#if (langHelper)??>${langHelper.getLang(content)}<#elseif (config.site_langs_default)??>${config.site_langs_default}<#else>fr_FR</#if>">
  <head>
    <meta charset="utf-8"/>
    <title><#if (content.title)??><#escape x as x?xml>${content.title}</#escape><#else>${propertiesHelper.retrieveAndDisplayConfigText("site.header.title")}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${propertiesHelper.retrieveAndDisplayConfigText("site.header.description")}">
    <meta name="author" content="${propertiesHelper.retrieveAndDisplayConfigText("site.header.author")}">
    <meta name="keywords" content="${propertiesHelper.retrieveAndDisplayConfigText("site.header.keyword")}">
    <meta name="generator" content="JBake">
    
    <#if ressourcesHelper??>
    	<@ressourcesHelper.buildExternalInjection config.site_script_header />
    </#if>
	
	<#-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"> -->

    <#-- Fav and touch icons -->
    <#--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="${common.buildRootPathAwareURL(propertiesHelper.retrieveAndDisplayConfigText("site.header.iconShortcut"))}">
  </head>
  <body class="${content.type}">
    <div id="wrap">
    	<div id="preHeader"  class="container preHeader">
    		<#if block??>
	    		<div class="header_blocks">
	    			<@block.build config.site_header_category/>
				</div>
			</#if>
    	</div>
    	<div id="header">
	    	<div id="up" class="container header" role="banner">
				<div id="pageTitle">
					<#if propertiesHelper.hasConfigValue("site.logoLeft.file")>
					<a href="${config.site_host}/index.html">
						<img src="${common.buildRootPathAwareURL(propertiesHelper.retrieveAndDisplayConfigText("site.logoLeft.file"))}" alt="${propertiesHelper.displayConfigText(propertiesHelper.retrieveAndDisplayConfigText("site.logoLeft.description"))}" id="logoLeft"/>
					</a>
					</#if>
					<h1 id="headerTitle">${propertiesHelper.retrieveAndDisplayConfigText("site.headline")}</h1>
					<#if propertiesHelper.hasConfigValue("site.logoRight.file")>
						<img src="${common.buildRootPathAwareURL(propertiesHelper.retrieveAndDisplayConfigText("site.logoRight.file"))}" alt="${propertiesHelper.displayConfigText(propertiesHelper.retrieveAndDisplayConfigText("site.logoRight.description"))}" id="logoRight"/>
					</#if>
				</div>
			</div>
		</div>