<#if (config.site_locale)??>
	<#setting locale=config.site_locale>
</#if>
<#import "tools/marcos.ftl" as ecoWeb>
<!DOCTYPE html>
<html lang="${config.site_locale}">
  <head>
    <meta charset="utf-8"/>
    <title><#if (content.title)??><#escape x as x?xml>${content.title}</#escape><#else>${ecoWeb.displayConfigText(config.site_header_title)}</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${ecoWeb.displayConfigText(config.site_header_description)}">
    <meta name="author" content="${ecoWeb.displayConfigText(config.site_header_author)}">
    <meta name="keywords" content="${ecoWeb.displayConfigText(config.site_header_keyword)}">
    <meta name="generator" content="JBake">
    
    <@ecoWeb.buildExternalInjection config.site_script_header />
	
	<#-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"> -->

    <#-- Fav and touch icons -->
    <#--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="${ecoWeb.buildRootPathAwareURL(config.site_header_iconShortcut)}">
  </head>
  <body class="${content.type}">
    <div id="wrap">
    	<div id="up" class="container header" role="banner">
			<div id="pageTitle">
				<#if ecoWeb.hasConfigValue("site_logoLeft_file")>
				<a href="${config.site_host}/index.html">
					<img src="${ecoWeb.buildRootPathAwareURL(config.site_logoLeft_file)}" alt="${ecoWeb.displayConfigText(config.site_logoLeft_description)}" id="logoLeft"/>
				</a>
				</#if>
				<h1 id="headerTitle">${ecoWeb.displayConfigText(config.site_headline)}</h1>
				<#if ecoWeb.hasConfigValue("site_logoRight_file")>
				<img src="${ecoWeb.buildRootPathAwareURL(config.site_logoRight_file)}" alt="${ecoWeb.displayConfigText(config.site_logoRight_description)}" id="logoRight"/>
				</#if>
			</div>
		</div>