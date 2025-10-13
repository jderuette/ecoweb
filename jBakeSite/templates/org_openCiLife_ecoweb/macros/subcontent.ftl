<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"subcontent", "description":"Add subContent in content", "recommandedNamespace":"subcontent", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"commonHelper", "type":"lib"}, {"value":"includeContent", "type":"contentHeader"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#if hookHelper??>
		${hookHelper.registerHook("afterBody", "subcontent.build")}
	</#if>
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
			<#assign allSubContents = db.getPublishedContent(content.includeContent.type)>
			<#assign displaySelf = (content.includeContent.displaySelf)!"disabled">
			<#assign subContents = allSubContents>
			<#--  -- remove self if presents -->
			<#if (displaySelf == "none")>
				<#assign subContents = allSubContents?filter(ct -> ct.title != content.title)>
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
				<#assign subContentDisplayMode = (content.includeContent.display.type)!"bullet">
				<#assign subContentDisplayContentMode = (content.includeContent.display.content)!"link">
				<#assign subContentBeforeTitleImage = (content.includeContent.display.beforeTitleImage)!"">
				<#assign specificClass = (content.includeContent.specificClass)!"">
				
				<#assign theModalId = "basicModal">
				<#if (subContentDisplayContentMode == "modal")>
					<@buildModal modalId= theModalId/>
				</#if>
				
				<#if (subContentDisplayContentMode == "collapse_block")>
					<@buildCollapseBlock modalId= theModalId/>
				</#if>
				
				<#if logHelper??>
					<@logHelper.debug subContentDisplayMode = subContentDisplayMode subContentDisplayContentMode = subContentDisplayContentMode/>
				</#if>
				<#if (subContentDisplayMode == "table")>
					<table class="${subContentDisplayMode}_list content_type_${subContentDisplayContentMode} ${specificClass}">
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
							</tr>
						</thead>
						<tbody>
				<#else>
					<div class="${subContentDisplayMode}_list ${specificClass}">
				</#if>
				<#list subContents?sort_by("order") as subContent>
					<#local subContentCategory = (subContent.category)!"__none__">
					<#local includeContentFilter = content.includeContent.category!"all">
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
					
					<#if ((subContent.status == "published") && (includeContentFilter == "all" || sequenceHelper.seq_containsOne(includeContentFilter, subContentCategory)))>
						<#if logHelper??>
							<@logHelper.debug "ACEPTED : SubContent : " + (subContent.title)!"not_set", includeContentFilter  + " IN " + subContentCategory/>
						</#if>
						<#if (subContentDisplayMode == "table")>
									<tr<#rt>
										<#if (subContentDisplayContentMode == "link")>
											<#lt> data-href="${common.buildRootPathAwareURL(subContent.uri)}"<#rt>
										</#if>
										<#if (specificContentClass != "")>
											<#lt> class="${specificContentClass}"
										</#if>
									<#lt>>
										<td class="${subContentDisplayMode}_image">
											<#if (subContent.contentImage)??>
												<img src="${common.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image" />
											</#if>
										</td>
										<td class="${subContentDisplayMode}_title widget_title">
											<#if (subContentBeforeTitleImage?has_content)>
												<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
											</#if>
											${subContent.title!""}
										</td>
										<td class="${subContentDisplayMode}_exerpt widget_exerpt">
											${subContent.exerpt!""}
										</td>
										<#if (subContentDisplayContentMode == "modal")>
										<td>
											<button type="button" class="btn btn-primary btn-block ${subContentDisplayMode}_showMore showMore" data-toggle="modal" data-target="#${theModalId}">Détails</button>
										</td>
										</#if>
										<#if (subContentDisplayMode == "modal" || subContentDisplayMode == "visible")>
										<td class="${subContentDisplayMode}_content widget_content">
											${subContent.body!""}
										</td>
										</#if>
										<#if ((content.includeContent.display.additionalData)?? && content.includeContent.display.additionalData?is_hash)>
											<#list content.includeContent.display.additionalData as colName, colValue>
												<#if (subContent[colValue]?is_date)>
										<td>${subContent[colValue]?string('dd/MM/yyyy à HH:mm')}</td>
												<#else>
										<td>${subContent[colValue]}</td>
												</#if>
											</#list>
										</#if>
									</tr>
						<#else>
							<div class="${subContentDisplayMode} content_type_${subContentDisplayContentMode} ${specificContentClass}">
								<#switch subContentDisplayMode>
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
									<div class="${subContentDisplayMode}_image">
										<#if (subContent.contentImage)??>
										<img src="${common.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image"/>
										</#if>
									</div>
								</#if>
								<h3 class="${subContentDisplayMode}_title widget_title"><#rt>
								<#if (subContentBeforeTitleImage?has_content)>
									<img src="${common.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
								</#if>
									<#t>${subContent.title!""}
								<#lt></h3>
								
								<#if (subContent.exerpt??)>
									<div class="${subContentDisplayMode}_exerpt widget_exerpt">
										${subContent.exerpt!""}
									</div>
								</#if>
								<#if (subContentDisplayMode == "link" || subContentDisplayMode == "modal" || subContentDisplayMode == "collapse_block") || subContentDisplayContentMode == "link">
									</a>
								</#if>
								<#if (subContentDisplayMode == "modal")>
									<button type="button" class="btn btn-primary btn-block ${subContentDisplayMode}_showMore showMore" data-toggle="modal" data-target="#${theModalId}">Détails</button>
								</#if>
								<#if (subContentDisplayContentMode == "modal" || subContentDisplayContentMode == "visible")>
									<div class="${subContentDisplayMode}_content widget_content ${collapseClass}" 
									<#if (collapseId??)>
										id="${collapseId}"
									</#if>
									>
										${subContent.body!""}
									</div>
								</#if>
							</div>
						</#if> <#-- end onf contentDuisplayType "switch" -->
					<#else>
						<#if logHelper??>
							<@logHelper.debug "FILTRED (" + subContent.status + ") : SubContent : " + (subContent.title)!"not_set", includeContentFilter + " NOT IN " subContentCategory />
						</#if>
					</#if> <#-- end of category filter check -->
				</#list>
				<#if (subContentDisplayMode == "table")>
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