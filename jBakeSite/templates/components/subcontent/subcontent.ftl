<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"subcontent", "description":"Add subContent in content", "recommandedNamespace":"subcontent", "require":[{"value":"includeContent", "type":"contentHeader"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
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
				<#local subContentDisplayType = (content.includeContent.display.type)!"bullet">
				<#local subContentDisplayContentMode = (content.includeContent.display.content)!"link">
				<#local subContentBeforeTitleImage = (content.includeContent.display.beforeTitleImage)!"">
				<#local specificClass = (content.includeContent.specificClass)!"">
				
				<#if logHelper??>
					<@logHelper.debug subContentDisplayType = subContentDisplayType subContentDisplayContentMode = subContentDisplayContentMode/>
				</#if>
				
				<#local theModalId = "basicModal">
				<#if (subContentDisplayContentMode == "modal")>
					<@buildModal modalId= theModalId/>
				</#if>
				
				<#if (subContentDisplayContentMode == "collapse_block")>
					<@buildCollapseBlock modalId= theModalId/>
				</#if>
				
				<#if (subContentDisplayType == "table")>
					<table class="${subContentDisplayType}_list content_type_${subContentDisplayContentMode} ${specificClass}">
						<thead>
							<tr>
								<th>Logo</th>
								<th>Nom</th>
								<th>Résumé</th>
								<#if (content.includeContent.display.additionalData)??>
									<#list content.includeContent.display.additionalData as colName, colValue>
										<#if (colName?? && colName != "")>
								<th>${colName}</th>
										</#if>
									</#list>
								</#if>
								<#if (subContentDisplayContentMode == "modal")>
								<th></th>
								</#if>
							</tr>
						</thead>
						<tbody>
				<#else>
					<div class="${subContentDisplayType}_list ${specificClass}">
				</#if>
				<#list subContents?sort_by("order") as subContent>
					<#local subContentCategory = (subContent.category)!"__none__">
					<#local specificContentClass = (content.includeContent.display.specificClass)!"">
					<#local collapseClass = "">
					<#local collapseId = "">
					<#local isSelf = subContent.title == content.title>
					<#local slefSpecificClass = "">
					
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
					<#if logHelper??>
						<@logHelper.debug "ACEPTED : SubContent : " + (subContent.title)!"not_set", includeContentFilter  + " IN " + subContentCategory/>
					</#if>
					<#if (subContentDisplayType == "table")>
								<tr<#rt>
									<#if (subContentDisplayContentMode == "link")>
										<#lt> data-href="${common.buildRootPathAwareURL(subContent.uri)}"<#rt>
									</#if>
									<#if (specificContentClass != "")>
										<#lt> class="${specificContentClass}"
									</#if>
								<#lt>>
									<td class="${subContentDisplayType}_image">
										<#if (subContent.contentImage)??>
											<img src="${common.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image" />
										</#if>
									</td>
									<td class="${subContentDisplayType}_title widget_title">
										<#if (subContentBeforeTitleImage?has_content)>
											<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
										</#if>
										${subContent.title!""}
									</td>
									<td class="${subContentDisplayType}_exerpt widget_exerpt">
										${subContent.exerpt!""}
									</td>
									
									<#if ((content.includeContent.display.additionalData)?? && content.includeContent.display.additionalData?is_hash)>
										<#list content.includeContent.display.additionalData as colName, colValue>
											<#if (subContent[colValue])??>
												<#if (subContent[colValue]?is_date)>
										<td>${subContent[colValue]?string('dd/MM/yyyy à HH:mm')}</td>
												<#else>
										<td>${subContent[colValue]}</td>
												</#if>
												<#else>
										<td></td>
											</#if>
										</#list>
									</#if>
									<#if (subContentDisplayContentMode == "modal")>
									<td>
										<button type="button" class="btn btn-primary btn-block ${subContentDisplayType}_showMore showMore" data-toggle="modal" data-target="#${theModalId}">Détails</button>
									</td>
									</#if>
									<#if subContentDisplayContentMode == "visible">
									<td class="${subContentDisplayType}_content widget_content">
										${subContent.body!""}
									</td>
									</#if>
									<#if subContentDisplayContentMode == "modal">
									<td class="${subContentDisplayType}_content widget_content">
										${subContent.body!""}
									</td>
									</#if>
								</tr>
					<#else>
						<div class="${subContentDisplayType} content_type_${subContentDisplayContentMode} ${specificContentClass}">
							<#switch subContentDisplayType>
							<#case  "link">
								<a href="${common.buildRootPathAwareURL(subContent.uri)}" class="widget_link">
							<#break>
							<#case "modal">
								<a href="#" role="button" class="widget_link_modal" data-toggle="modal" data-target="#${theModalId}">
							<#break>
							<#case "collapse_block">
								<#local collapseClass = "collapse">
								<#local collapseId = common.randomNumber()>
								<a data-toggle="collapse" href="#${collapseId}" aria-expanded="false" aria-controls="${collapseId}">
							<#break>
							<#case "card">
								<#if (subContentDisplayContentMode == "link")>
									<a href="${common.buildRootPathAwareURL(subContent.uri)}">
								</#if>
							<#break>
							</#switch>
							<#if (subContent.contentImage??)>
								<div class="${subContentDisplayType}_image">
									<#if (subContent.contentImage)??>
									<img src="${common.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image"/>
									</#if>
								</div>
							</#if>
							<h3 class="${subContentDisplayType}_title widget_title"><#rt>
							<#if (subContentBeforeTitleImage?has_content)>
								<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
							</#if>
								<#t>${subContent.title!""}
							<#lt></h3>
							
							<#if (subContent.exerpt??)>
								<div class="${subContentDisplayType}_exerpt widget_exerpt">
									${subContent.exerpt!""}
								</div>
							</#if>
							<#if (subContentDisplayType == "link" || subContentDisplayType == "modal" || subContentDisplayType == "collapse_block") || subContentDisplayContentMode == "link">
								</a>
							</#if>
							<#if (subContentDisplayType == "modal")>
								<button type="button" class="btn btn-primary btn-block ${subContentDisplayType}_showMore showMore" data-toggle="modal" data-target="#${theModalId}">Détails</button>
							</#if>
							<#if (subContentDisplayContentMode == "modal" || subContentDisplayContentMode == "visible")>
								<div class="${subContentDisplayType}_content widget_content ${collapseClass}" 
								<#if (collapseId??)>
									id="${collapseId}"
								</#if>
								>
									${subContent.body!""}
								</div>
							</#if>
						</div>
					</#if> <#-- end onf contentDuisplayType "switch" -->
				</#list>
				<#if (subContentDisplayType == "table")>
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


<#-- build an modal block (using Boostrap)
param : modalId : *default* : basicModal : (html) ID of the modal (to be ued in link to target this modal)
param : closeButtonlabel : *default* : close : label of the botom close button
-->
<#macro buildModal modalId="basicModal" closeButtonlabel = "close">
	<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Basic Modal</h4>
      			</div>
				<div class="modal-body">
					<img src="none" class="modal-image"/>
					<div class="modal-body-content">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">${closeButtonlabel}</button>
				</div>
			</div>
		</div>
	</div>
</#macro>