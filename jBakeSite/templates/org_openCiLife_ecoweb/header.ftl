<#if (config.site_langs_default)??>
	<#setting locale=config.site_langs_default>
</#if>
<#import "tools/marcos.ftl" as ecoWeb>
<!DOCTYPE html>
<html lang="${ecoWeb.getLang(content)}">
  <head>
    <meta charset="utf-8"/>
    <title><#if (content.title)??><#escape x as x?xml>${content.title}</#escape><#else>${ecoWeb.retrieveAndDisplayConfigText("site.header.title")}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${ecoWeb.retrieveAndDisplayConfigText("site.header.description")}">
    <meta name="author" content="${ecoWeb.retrieveAndDisplayConfigText("site.header.author")}">
    <meta name="keywords" content="${ecoWeb.retrieveAndDisplayConfigText("site.header.keyword")}">
    <meta name="generator" content="JBake">
    
    <@ecoWeb.buildExternalInjection config.site_script_header />
	
	<#-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"> -->

    <#-- Fav and touch icons -->
    <#--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="${ecoWeb.buildRootPathAwareURL(ecoWeb.retrieveAndDisplayConfigText("site.header.iconShortcut"))}">
  </head>
  <body class="${content.type}">
    <div id="wrap">
    	<div id="preHeader"  class="container preHeader">
    		<div class="header_blocks">
    			<@ecoWeb.buildBlocks config.site_header_category/>
			</div>
    	</div>
    	<div id="header">
	    	<div id="up" class="container header" role="banner">
				<div id="pageTitle">
					<#if ecoWeb.hasConfigValue("site_logoLeft_file")>
					<a href="${config.site_host}/index.html">
						<img src="${ecoWeb.buildRootPathAwareURL(ecoWeb.retrieveAndDisplayConfigText("site.logoLeft.file"))}" alt="${ecoWeb.displayConfigText(ecoWeb.retrieveAndDisplayConfigText("site.logoLeft.description"))}" id="logoLeft"/>
					</a>
					</#if>
					<h1 id="headerTitle">${ecoWeb.retrieveAndDisplayConfigText("site.headline")}</h1>
					<#if ecoWeb.hasConfigValue("site_logoRight_file")>
					<img src="${ecoWeb.buildRootPathAwareURL(ecoWeb.retrieveAndDisplayConfigText("site.logoRight.file"))}" alt="${ecoWeb.displayConfigText(ecoWeb.retrieveAndDisplayConfigText("site.logoRight.description"))}" id="logoRight"/>
					</#if>
				</div>
			</div>
		</div>