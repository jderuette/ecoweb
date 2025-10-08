<#function getComponnentInfo>
	<#return {"name":"breadcrumb", "description":"Display breadcrumb", "recommandedNamespace":"breadcrumb", "require":[{"value":"commonHelper", "type":"lib"}, {"value":"site_breakcrumb_display", "type":"config"}, {"value":"site_breakcrumb_seprator", "type":"config"}], "uses":[{"value":"logHelper", "type":"lib"}, {"value":"displayBreadcrumb", "type":"contentHeader"}]}>
</#function>


<#-- build the breacrumb -->
<#macro build content>
	<#if config.site_breakcrumb_display == "true" && !((content.displayBreadcrumb)?? && content.displayBreadcrumb=="false")>
		<#if content?? && content.uri??>
		 	<ul id="breadcrumb">
		 	<#if logHelper??>
		 		${logHelper.stackDebugMessage("Breadcrumb : Current page URI : ${content.uri}")}
		 	</#if>
			 <#local pathElements = getContentsFromUri(content.uri)>
			 <#local isFirst=true>
			 <#list pathElements as element>
			 	<li>
			 	<#if isFirst>
			 		<#local isFirst=false>
			 	<#else>
			 		${config.site_breakcrumb_seprator!" >>> "}
			 	</#if>
			 	<#if element.uri??>
			 		<a href="${common.buildRootPathAwareURL(element.uri)}">
			 	</#if>
				${element.title!"__missing_title__"}
				<#if element.uri??>
			 		</a>
			 	</#if>
			 	</li>
			</#list>
			</ul>
		</#if>
	</#if>
</#macro>

<#assign maxLoop = 10>
<#assign foundContents = []>
<#--  Help build Breacrumb.
Using URI strucutre, for each element search for the first (using Order attribute) content.
Retur a LIST of content for each **directory** in URI structure. First content is for the firts element.
-->
<#function getContentsFromUri uri>
	<#if logHelper??>
		${logHelper.stackDebugMessage(">>Breadcrumb : Search content for URI '"+uri+"'")}
	</#if>
	<#local pageFound = false>
	<#if (maxLoop > 0) && uri?? && uri != "">
		<#local allSubContents = db.getPublishedContent("org_openCiLife_post")>
		
		<#list allSubContents as aContent>
			<#if aContent.uri?? && (aContent.uri == uri)>
				<#-- content is a standard page -->
				<#if logHelper??>
					${logHelper.stackDebugMessage(">>>> Breadcrumb : Content Page found !")}
				</#if>
				<#assign foundContents = [aContent] + foundContents>
				<#local pageFound = true>
				<#break>
			</#if>
		</#list>
		
		<#if !pageFound>
			<#-- uri : is a directory, search for "main page" of the dirtectory (page with the lowest order attribute) -->
			<#local lowestOrderContentFound = []>
			<#local foundUri = "">
			<#list allSubContents as aContent>
				<#local contentTile = aContent.title!"no_title">
				<#local contentOrder = aContent.order!-999>
				<#if (aContent.uri)?? && contentOrder?? && aContent.uri?keep_before_last("/") == uri>
					<#if lowestOrderContentFound?size == 0>
						<#if logHelper??>
							${logHelper.stackDebugMessage(">>>> Breadcrumb '${contentTile}' with order ${contentOrder} is the first candidate")}
						</#if>
						<#local lowestOrderContentFound = aContent>
						<#local foundUri = aContent.uri>
					<#else>
						<#if (contentOrder?number < lowestOrderContentFound.order?number) >
							<#if logHelper??>
								${logHelper.stackDebugMessage(">>>> Breadcrumb '${contentTile}' has order ${contentOrder} lowest than previous found content '${lowestOrderContentFound.title}' with order ${lowestOrderContentFound.order}")}
							</#if>
							<#local lowestOrderContentFound = aContent>
							<#local foundUri = aContent.uri>
						</#if>
					</#if>
				</#if>
			</#list>
			<#-- if found content *for a folder* is the curent page we are on a "dispatch" page, wich is a "duplicate" of the current page.
	    	Remove this item. -->
	    	<#if  foundUri == content.uri>
	    		<#if logHelper??>
					${logHelper.stackDebugMessage(">>>>>> Breadcrumb : directory content ("+lowestOrderContentFound.uri+") found IS the CURRENT page("+content.uri+"), this element will be removed")}
				</#if>
				<#local lowestOrderContentFound = []>
			</#if>
			<#if lowestOrderContentFound?size != 0>
				<#assign foundContents = [lowestOrderContentFound] + foundContents>
			</#if>
		</#if>
		
		<#--  remove the last part of URI -->
		<#if  uri?contains("/")>
			<#local newUri = uri?keep_before_last("/")>
		<#else>
			<#local newUri = "">
		</#if>
		
		<#if newUri?? && newUri !="">
			<#--  RECURSIVE call -->
			<#assign maxLoop = maxLoop -1>
			<#local foundContents = getContentsFromUri(newUri) />
		</#if>
	 	
	 </#if>
	<#return foundContents>
</#function>