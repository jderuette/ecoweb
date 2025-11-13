<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"subcontent", "description":"Add subContent in content", "recommandedNamespace":"subcontent", "version":"0.1.0", "require":[{"value":"includeContent", "type":"contentHeader"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#-- build an block or table listing (using Boostrap)
param : content : content to search for include content
-->
<#macro build content>
	<#if (content.includeContent)??>
		<#if logHelper??>
			<@logHelper.debug "(sub)Content should be included"/>
		</#if>
		<#local allSubContents = db.getPublishedContent(content.includeContent.type)>
		<#local displaySelf = (content.includeContent.displaySelf)!"disabled">
		<#local includeContentFilter = content.includeContent.category!"all">
		<#local subContents = allSubContents>
		
		<#--  filter by categories -->
		<#local subContents = subContents?filter(ct -> (includeContentFilter == "all" || sequenceHelper.seq_containsOne(includeContentFilter, ct.category)))>
		
		<#--  -- remove self if presents -->
		<#if (displaySelf == "none")>
			<#local subContents = subContents?filter(ct -> ct.title != content.title)>
		</#if>
		
		<#if (langHelper)??>
			<#local currentLang = langHelper.getLang(content)>
			<#local subContents = subContents?filter(ct -> langHelper.isCorectLang(ct, currentLang))>
			<#if logHelper??>
				<@logHelper.debug "Included Type " + content.includeContent.type + ", for lang " + currentLang + " : number of subContent to display " + subContents?size/>
			</#if>
		<#else>	
			<#if logHelper??>
				<@logHelper.debug "Included Type " + content.includeContent.type + " : number of subContent to display " + subContents?size/>
			</#if>
		</#if>
		
		<div class="subContent">
		<#if (subContents?size > 0)>
			<#if (content.includeContent.title)??>
				<div class="title">${content.includeContent.title}</div>
			</#if>
			<#local listDisplayType = (content.includeContent.display.type)!"bullet">
			<#local subContentDisplayContentMode = (content.includeContent.display.content)!"link">
			<#local subContentBeforeTitleImage = (content.includeContent.display.beforeTitleImage)!"">
			<#local specificClass = (content.includeContent.specificClass)!"">
			<#local subContentmodaleCloseButton = (content.includeContent.display.closeButton)!"close">
			
			<#if logHelper??>
				<@logHelper.debug listDisplayType = listDisplayType subContentDisplayContentMode = subContentDisplayContentMode/>
			</#if>
			
			<#local theModalId = "basicModal">
			<#if (subContentDisplayContentMode == "modal")>
				<@modal.buildModalContainer theModalId, subContentmodaleCloseButton />
			</#if>
			
			<#if (listDisplayType == "table")>
				<table class="${listDisplayType}_list content_type_${subContentDisplayContentMode} ${specificClass}">
					<thead>
						<tr>
							<#if (content.includeContent.display.columns)??>
								<#list content.includeContent.display.columns as column>
									<#if ((column.name)?? && (column.name != ""))>
							<th>${column.name}</th>
									</#if>
								</#list>
							<#else>
								No colums for this table.
							</#if>
							<#if (subContentDisplayContentMode == "modal")>
							<th></th>
							</#if>
						</tr>
					</thead>
					<tbody>
			<#else>
				<div class="${listDisplayType}_list ${specificClass}">
			</#if>
			<#list subContents?sort_by("order") as subContent>
				
					<#local uselessTempVar = commonInc.propagateContentChain(subContent) />
				
				<#local subContentCategory = (subContent.category)!"__none__">
				<#local specificContentClass = (content.includeContent.display.specificClass)!"">
				<#local displayTitle = true>
				<#if (content.includeContent.display.displayTitle)?? && content.includeContent.display.displayTitle == false>
					<#local displayTitle = false>
				</#if>
				<#local collapseClass = "">
				<#local collapseId = "">
				<#local isSelf = subContent.title == content.title>
				<#local featauredText = "">
				
				<#if isSelf>
					<#local specificContentClass += " self">
					<#switch displaySelf>
						<#case "disabled">
							<#local specificContentClass += " self_disabled">
						<#break>
						<#case "none">
							<#-- Nothing to do content is not in list -->
						<#break>
					</#switch>
				</#if>
				
				<#if (subContent.featured)??>
					<#local specificContentClass = specificContentClass + " featured">
					<#if (subContent.featured.text)??>
						<#local featauredText = subContent.featured.text>
					</#if>
				</#if>
				<#if logHelper??>
					<@logHelper.debug "ACEPTED : SubContent : " + (subContent.title)!"not_set", includeContentFilter  + " IN " + subContentCategory/>
				</#if>
				<#if (listDisplayType == "table")>
					<#local specificClassForContent = specificContentClass>
					<#if (subContent.featured)??>
						<#local specificClassForContent = specificClassForContent + "featured">
					</#if>
					
					<tr<#rt>
						<#if (subContentDisplayContentMode == "link")>
							<#lt> data-href="${common.buildRootPathAwareURL(subContent.uri)}"<#rt>
						</#if>
						
						<#if (specificContentClass != "")>
							<#lt> class="${specificContentClass}"
						</#if>
						
					<#lt>>
						<#local isFirstColumn = true>
						<#if ((content.includeContent.display.columns)?? && content.includeContent.display.columns?is_sequence)>
							<#list content.includeContent.display.columns?sort_by("order") as column>
								<td>
									<#if isFirstColumn>
										<#if featauredText?has_content>
											<span class="featured_label">${featauredText}</span>
										</#if>
									</#if>
									<#if (column.attr)?? && column.attr?has_content>
										<#local contentAtttrName = column.attr>
										<#if (subContent[contentAtttrName])??>
											<#local contentAtttrValue = subContent[contentAtttrName]>
											
											<#if contentAtttrName=="title">
												<#if (subContentBeforeTitleImage?has_content)>
													<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
												</#if>
											</#if>
											<#if (contentAtttrValue?is_date)>
												${contentAtttrValue?string('dd/MM/yyyy à HH:mm')}
											<#elseif contentAtttrName=="contentImage">
												<#if (subContent.contentImage)??>
													<@common.addImageIcon subContent.contentImage />
												</#if>
											<#else>
												${contentAtttrValue}
											</#if>
										</#if>
									</#if>
								</td>
								<#local isFirstColumn = false>
							</#list>
						</#if>
						<#if (subContentDisplayContentMode == "modal")>
						<td>
							<@modal.extractContentForModal subContent, "button", listDisplayType, "voir plus" />
						</td>
						</#if>
						<#if subContentDisplayContentMode == "visible">
						<td class="${listDisplayType}_content">
							${subContent.body!""}
						</td>
						</#if>
					</tr>
				<#elseif listDisplayType == "steps" >
					<#if featauredText?has_content>
						<div class="featured_label">${featauredText}</div>
					</#if>
					<#if hookHelper??>
						<@hookHelper.hook "BeforeItemSubContent" subContent/>
					</#if>
					<div class="${listDisplayType} content_type_${subContentDisplayContentMode} ${specificContentClass}">
						<#if hookHelper??>
							<@hookHelper.hook "BeginItemSubContent" subContent/>
						</#if>
						<div class="step_icon">
							<#if (subContent.contentImage??)>
								<#if (subContent.contentImage)??>
									<@common.addImageIcon subContent.contentImage listDisplayType+"_image"/>
								</#if>
							</#if>
							<div class="vertical_line"></div>
						</div>
						<div class="step_content">
							<#if (subContent.exerpt??)>
								<div class="${listDisplayType}_exerpt">
									${subContent.exerpt!""}
								</div>
							</#if>
							<#if displayTitle>						
								<h3 class="${listDisplayType}_title"><#rt>
								<#if (subContentBeforeTitleImage?has_content)>
									<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
								</#if>
									<#t>${subContent.title!""}
								<#lt></h3>
							</#if>
							<div class="${listDisplayType}_content<#if subContentDisplayContentMode == "modalLink"> contentHidden</#if>">
								${subContent.body!""}
							</div>
						</div>
						<#if hookHelper??>
							<@hookHelper.hook "EndItemSubContent" subContent/>
						</#if>
					</div>
					<#if hookHelper??>
						<@hookHelper.hook "AfterItemSubContent" subContent/>
					</#if>
				<#else><#-- NOT a table -->
					<#if hookHelper??>
						<@hookHelper.hook "BeforeItemSubContent" subContent/>
					</#if>
					<div class="${listDisplayType} content_type_${subContentDisplayContentMode} ${specificContentClass}">
						<#if featauredText?has_content>
							<div class="featured_label">${featauredText}</div>
						</#if>
						<#if hookHelper??>
							<@hookHelper.hook "BeginItemSubContent" subContent/>
						</#if>
						<#switch listDisplayType>
						<#case  "link">
							<a href="${common.buildRootPathAwareURL(subContent.uri)}" class="widget_link">
						<#break>
						<#case "collapse_block">
							<#local collapseClass = "collapse">
							<#local collapseId = common.randomNumber()>
							<a data-toggle="collapse" href="#${collapseId}" aria-expanded="false" aria-controls="${collapseId}">
						<#break>
						<#case "card">
							<#if (subContentDisplayContentMode == "modalLink")>
								<@modal.extractContentForModal subContent, "link", listDisplayType, "", []/>
							<#elseif (subContentDisplayContentMode == "link")>
								<a href="${common.buildRootPathAwareURL(subContent.uri)}">
							</#if>
						<#break>
						</#switch>
						<#if listDisplayType == "card">
							<#if (subContent.contentImage??)>
								<#if (subContent.contentImage)??>
									<@common.addImageIcon subContent.contentImage listDisplayType+"_image"/>
								</#if>
							</#if>
						</#if>
						<#if displayTitle>						
							<h3 class="${listDisplayType}_title"><#rt>
							<#if (subContentBeforeTitleImage?has_content)>
								<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
							</#if>
								<#t>${subContent.title!""}
							<#lt></h3>
						</#if>
						
						<#if listDisplayType == "collapse_block">
							<div class="${listDisplayType}_content ${collapseClass}" id="${collapseId}">
						</#if>
						
						<#if listDisplayType != "card">
							<#if (subContent.contentImage??)>
								<#if (subContent.contentImage)??>
								<@common.addImageIcon subContent.contentImage listDisplayType+"_image"/>
								</#if>
							</#if>
						</#if>
						
						<#if (subContent.exerpt??)>
							<div class="${listDisplayType}_exerpt">
								${subContent.exerpt!""}
							</div>
						</#if>
						
						<#if listDisplayType == "collapse_block">
							</a>
						</#if>
						
						<#if (subContentDisplayContentMode == "modal")>
							<@modal.extractContentForModal subContent, "button", listDisplayType, "voir plus" />
						</#if>
						<#if (subContentDisplayContentMode == "visible" || subContentDisplayContentMode == "modalLink")>
							<div class="${listDisplayType}_content<#if subContentDisplayContentMode == "modalLink"> contentHidden</#if>">
								${subContent.body!""}
							</div>
						</#if>
						<#if (listDisplayType == "link" || subContentDisplayContentMode == "modalLink") || subContentDisplayContentMode == "link" || subContentDisplayContentMode == "modal">
							</a>
						</#if>
						<#if listDisplayType == "collapse_block">
							</div>
						</#if>
						<#if hookHelper??>
							<@hookHelper.hook "EndItemSubContent" subContent/>
						</#if>
					</div>
					<#if hookHelper??>
						<@hookHelper.hook "AfterItemSubContent" subContent/>
					</#if>
				</#if> <#-- end onf contentDuisplayType "switch" -->
			</#list>
			<#if (listDisplayType == "table")>
					</tbody>
				</table>
			<#else>
				</div>
			</#if>
		<#else>
			pas de contenus (pour le moment).
		</#if>
		</div>
	<#else>
		<#if logHelper??>
			<@logHelper.debug "No SubContent for this content"/>
		</#if>
	</#if>
</#macro>
