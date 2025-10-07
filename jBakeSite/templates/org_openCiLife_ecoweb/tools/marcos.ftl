
<#function getComponnentInfo>
	<#return {"name":"EcoWebMacro", "description":"All ecoWeb Macros. Need to be splited into smaller component.", "require":[{"value":"common", "type":"lib"}, {"value":"propertiesHelper", "type":"lib"}, {"value":"sequenceHelper", "type":"lib"}], "uses":[{"value":"Too many things !!", "type":"config, contentHeader, pomProperty"}]}>
</#function>

<#--  inspired by : https://subscription.packtpub.com/book/web_development/9781782163824/1/ch01lvl1sec06/top-9-features-you-need-to-know-about -->

<#function unObfuscateText obfucatedEmail, obfuscationMask>
	<#local humanReadableText = obfucatedEmail>
	<#if obfucatedEmail?? && obfuscationMask??>
		${stackDebugMessage("UnObfuscateText : decrypt text ! whith key : " + obfuscationMask)}
		<#local tokens=obfuscationMask?split(r"\s*,\s*", "r")>
		${stackDebugMessage(">>Email : " + tokens?size + " crypt token found")}
		<#list tokens as token>
			<#local tokenDetail=token?split(r"\s*:\s*", "r")>
			<#if tokenDetail?? && tokenDetail[0]?? && tokenDetail[1]??>
				${stackDebugMessage(">>>>UnObfuscateText : replacing " + tokenDetail[1] + " by " + tokenDetail[0])}
				<#local humanReadableText = humanReadableText?replace(tokenDetail[1], tokenDetail[0])>
			</#if>
			${stackDebugMessage(">>>>UnObfuscateText : Token has " + tokenDetail?size + " elements, current Human Readable e-mail : " + humanReadableText)}
		</#list>
	</#if>
	<#return humanReadableText>
</#function>


<#macro buildComponnentInfos content>
	<#local propName = "components">
	<#if propertiesHelper.hasConfigValue(propName)>
		<#local includProp = propertiesHelper.retrieveAndDisplayConfigText(propName)>
		<#assign icludes = propertiesHelper.parseJsonProperty(includProp)>
		<div class="componnentInfos">
		<h3>Informations extraites de : ${propName} : </h3>
		<pre>${includProp}</pre>
		<#list icludes.data as include>
			<#local includeNameSpace = .vars[include.namespace]>
			<div class="componnentInfo">
				<h2>${include.namespace}</h2>
				<div>file : ${include.file} </div>
			<#attempt>
				<#local compData = includeNameSpace.getComponnentInfo()>
				<div>Name : ${compData.name}</div>
				<#if (compData.description)??>
					<div>Description : ${compData.description}</div>
				</#if>
				<div>Requière : 
				<#if (compData.require)??>
				<table>
					<theader>
					<tr>
						<th>Type</th>
						<th>Valeur</th>
						<th>Description</th>
					</tr>
					</theader>
					<tr>
					<#list compData.require as requirement>
						<tr>
							<td>
							<#if (requirement.type)??>
								${requirement.type}
							</#if>
							</td>
							<td>
							<#if (requirement.value)??>
								${requirement.value}
							</#if>
							</td>
							<td>
							<#if (requirement.desc)??>
								${requirement.desc}
							</#if>
							</td>
						</tr>							
					</#list>
					</table>
				<#else>
					Aucun pre-requis.
				</#if>
				</div>
				<div>Utilise : 
				<#if (compData.uses)??>
				<table>
					<theader>
					<tr>
						<th>Type</th>
						<th>Valeur</th>
						<th>Description</th>
					</tr>
					</theader>
					<tr>
					<#list compData.uses as uses>
						<tr>
							<td>
							<#if (uses.type)??>
								${uses.type}
							</#if>
							</td>
							<td>
							<#if (uses.value)??>
								${uses.value}
							</#if>
							</td>
							<td>
							<#if (uses.desc)??>
								${uses.desc}
							</#if>
							</td>
						</tr>							
					</#list>
					</table>
				<#else>
					Aucune utilisation d'autre éléments.
				</#if>
				</div>
			<#recover>
				<div>Erreur lors de l'interpretation de getComponnentInfo() pour ce composant !!</div>
			</#attempt>
			</div>
		</#list>
		</div>
	</#if>
</#macro>



<#-- build a content with blocks
    @param categoryFilter category to filter to get blocks. "config.site_homepage_category" for HomePage.
-->
<#macro buildBlocks categoryFilter>

	<#local blocks = org_openCiLife_blocks?filter(b -> b.status=="published")?sort_by("order")>
	<#if (langHelper)??>
		<#local blocks = blocks?filter(ct -> langHelper.isCorectLang(ct, langHelper.getLang(content)))>
	</#if>
	
	<#list blocks?sort_by("order") as block>
		<#assign blockCategory = block.category!"__empty_categ__">
		<#if logHelper??>
			<@logHelper.debug "Blocks : search if " + blockCategory + " in " + categoryFilter + " res : " + sequenceHelper.seq_containsOne(blockCategory, categoryFilter)?string("yes","no")/>
		</#if>
		<#if (sequenceHelper.seq_containsOne(blockCategory, categoryFilter))>
			<#local subTemplateName = "defaultBlockSubTemplate">
			<#if (block.subTemplate??)>
				<#local subTemplateName=block.subTemplate>
			</#if>
			<@.vars["${subTemplateName}"] block/>
		</#if>
  	</#list>

</#macro>

<#macro bob block>
	A Basic BOB template !!!!
</#macro>

<#macro defaultBlockSubTemplate block>
	<@imageRightSubTemplate block />
</#macro>

<#macro imageRightSubTemplate block>
	<div<#rt>
		<#if (block.anchorId)??>
			id="<#escape x as x?xml>${block.anchorId}</#escape>"<#rt>
		</#if>
		 
		<#local classes = "block">
		<#if (block.specificClass)??>
			<#local classes = classes + " " + block.specificClass>
		</#if>
		<#lt> class="<#escape x as x?xml>${classes}</#escape>">
		
		<#if (block.title)?? && block.title?has_content && !((block.displayTitle)?? && block.displayTitle == "false")>
			<h2	class="blockTitle"><#escape x as x?xml>${block.title}</#escape></h2>
		</#if>
			<div class="blockBody">
				<div class="blockContent">
					${block.body}
					<#if (langHelper)??>
						<@langHelper.buildLanguageSwitcher block />
					</#if>
					<@buildsubContent block />
					<@buildForm block />
					<@buildCarousel block />
				</div>	
				<#if (block.contentImage)??>
					<img src=${common.buildRootPathAwareURL(block.contentImage)} class="blockIcon"/>
				</#if>
			</div>
		</div>
</#macro>

<#macro imageLeftSubTemplate block>
	<div<#rt>
		<#if (block.anchorId)??>
			id="<#escape x as x?xml>${block.anchorId}</#escape>"<#rt>
		</#if>
		 
		<#local classes = "block">
		<#if (block.specificClass)??>
			<#local classes = classes + " " + block.specificClass>
		</#if>
		<#lt> class="<#escape x as x?xml>${classes}</#escape>">
		
		<#if (block.title)?? && block.title?has_content && !((block.displayTitle)?? && block.displayTitle == "false")>
			<h2	class="blockTitle"><#escape x as x?xml>${block.title}</#escape></h2>
		</#if>
			<div class="blockBody">
				<#if (block.contentImage)??>
					<img src=${common.buildRootPathAwareURL(block.contentImage)} class="blockIcon"/>
				</#if>
				<div class="blockContent">
					${block.body}
					<#if (langHelper)??>
						<@langHelper.buildLanguageSwitcher block />
					</#if>
					<@buildsubContent block />
					<@buildForm block />
					<@buildCarousel block />
				</div>	
			</div>
		</div>
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

<#assign oldRdnVal = 1>
<#function randomNumber salt = 7>
    <#local str= .now?long />
    <#local str = (str * salt)/3 />
    <#local random = str[(str?string?length-13)..] />
    <#local returnVal = random?replace("\\D+", "1", "r") />
    <#if returnVal?number == oldRdnVal?number>
    	<#local returnVal += 1>
    </#if>
    <#assign oldRdnVal = returnVal>
    <#return returnVal/>	
</#function>

<#-- To create "link" header line or footer scripts injection.
param : content : JSON content describing inclusions.
-->
<#macro buildExternalInjection content>
	<#if (content)??>
		<#local jsonContent = propertiesHelper.parseJsonProperty(content)>
		
		<#if !(jsonContent.data)??>
			<#if logHelper??>
				${logHelper.stackDebugMessage("buildExternalInjection : Error missing 'data' attribute after JSON parsing of attribute ==> " + propertiesHelper.displayParseJsonError(jsonContent))}
			</#if>
		<#else>
		<#list jsonContent.data as injection>
			<#assign tagType = injection.tagType!"link">
			<#if ((injection.constraint)??)>
				<!--[${injection.constraint}]>
			</#if>
		<${tagType}<#if (injection.href??)> href="${common.buildRootPathAwareURL(injection.href)}"</#if><#if (injection.src??)> src="${common.buildRootPathAwareURL(injection.src)}"</#if><#if (injection.rel??)> rel="${injection.rel}"</#if>><#if (injection.tagType=="script")></script></#if>
			<#if ((injection.constraint)??)>
				<![endif]-->
			</#if>
		</#list>
		</#if>
	</#if>
</#macro>


<#-- build an modal block or table listing (using Boostrap)
param : content : content to search for incluide content
-->
<#macro buildsubContent content>
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
									<#local collapseId = randomNumber()>
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

<#-- build a form
param : content : content to search for form data
-->
<#macro buildForm content>
	<#if (content.formData)??>
		<#local method=(content.formData.method)!"get" />
		<#local enctype=(content.formData.enctype)!"application/x-www-form-urlencoded" />
		<#local sendLabel=(content.formData.sendLabel)!"Contactez" />
		<#local formId=(content.formData.id)!"form1" />
		
		<#assign fields=(content.formData.fields)! />
		
		<#local isContactForm = false>
		<#local extraAtr = "">
		
		<#if (content.formData.to)??>
			<#local isContactForm = true>
			<#if (content.formData.dataTransform)?? && content.formData.dataTransform.type="obfuscated">
				<#local extraAtr = "data-obfuscatedMailTo=\"" + content.formData.to + "\" data-obfuscatedMailToKey=\""+content.formData.dataTransform.obfuscatedKey+"\"">
			</#if>
		</#if>
		
		<form id="<#escape x as x?xml>${formId}</#escape>"<#if (extraAtr!="")> ${extraAtr}</#if><#if (content.formData.action)??> action="<#escape x as x?xml>${content.formData.action}</#escape></#if>" method="<#escape x as x?xml>${method}</#escape>" enctype="<#escape x as x?xml>${enctype}</#escape>" class="contact_form">
		<div class="form-group">
		
		<#list fields as field>
			<#local fieldId = field.id>
			<label for="<#escape x as x?xml>${fieldId}</#escape>"><#escape x as x?xml>${field.label}</#escape></label>
			
			<#if field.type == "textarea">
				<#assign endTag = "textarea" />
				<textarea 
			<#else>
				<#assign endTag = "input" />
				<input type="<#escape x as x?xml>${field.type!"text"}</#escape>" 
			</#if>
			class="<#escape x as x?xml>${fieldspecificClass!"form-control"}</#escape>" id="<#escape x as x?xml>${field.id}</#escape>" 
			<#if (field.name)??>
				name="<#escape x as x?xml>${field.name}</#escape>"
			</#if>
			<#if (field.value)??>
				<#local fieldVal=field.value>
				<#if (field.dataTransform)?? && field.dataTransform.type == "obfuscated" && (field.dataTransform.obfuscatedKey)??>
					<#if (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
						<#local fieldVal="" />
					<#else>
						<#local fieldVal=(unObfuscateText(field.value, field.dataTransform.obfuscatedKey))!"invalid obfuscation key" />
					</#if>
				</#if>
				value="<#escape x as x?xml>${fieldVal}</#escape>"
			</#if>
			<#if (field.readOnly)?? && field.readOnly=="true">
				 readOnly
			</#if>
			<#if (field.rows)??>
				rows="<#escape x as x?xml>${field.rows}</#escape>"
			</#if>
			></${endTag}>
			
			<#if (field.dataTransform) ?? && (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
				</span>
			</#if>
			
			<#if (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
				<#local hiddenButtonLabel = field.dataTransform.hiddenButtonLabel!"afficher">
				<input type="button" id="<#escape x as x?xml>${field.dataTransform.id}</#escape>" value="<#escape x as x?xml>${hiddenButtonLabel}</#escape>" data-obfuscatedValue="<#escape x as x?xml>${field.value}</#escape>" data-obfuscatedKey="<#escape x as x?xml>${field.dataTransform.obfuscatedKey}</#escape>" data-obfuscatedTarget="#<#escape x as x?xml>${fieldId}</#escape>"></input>
			</#if>
		</#list>
		
		<input type="submit" value="<#escape x as x?xml>${sendLabel}</#escape>"/>
		</div>
		</form>
	<#else>
		<#if logHelper??>
			<@logHelper.debug "No form Data for this content"/>
		</#if>
	</#if>
</#macro>


<#-- build a carousel
param : content : content to search for carousel data
-->
<#macro buildCarousel content>
	<#if (content.carouselData)??>
		<#assign slides=(content.carouselData.slides)! />
		<#assign carouselId=(content.carouselData.id)!randomNumber() />
		<#assign controls=(content.carouselData.controls)! />
		<#assign displayIndicator=(content.carouselData.displayIndicator)!false />
		<#assign carouselStyle=(content.carouselData.style)! />
		
		<div id="<#escape x as x?xml>${carouselId}</#escape>" class="carousel slide" data-ride="carousel" <#if (carouselStyle??)>style="${carouselStyle}"</#if>>
		
		<#if (displayIndicator)>
			<#assign isFirst=true />
			<#assign slideIndex=0 />
			<ol class="carousel-indicators">
			<#list slides as slide>
				<li data-target="#<#escape x as x?xml>${carouselId}</#escape>" data-slide-to="${slideIndex}" <#if (isFirst)>class="active"</#if>></li>
				<#assign slideIndex=slideIndex+1 />
				<#assign isFirst=false/>
			</#list>
			</ol>
		</#if>
		
		<div class="carousel-inner" role="listbox" aria-roledescription="caroussel" aria-readonly="true">
		<#--  ReInit isFirst for real slide (may be altered by indicator loop) -->
		<#assign isFirst=true/>
		
		<#list slides as slide>
			<div class="item carousel-item <#if (isFirst)>active" aria-selected="true"<#else>"</#if> role="option">
			<#assign isFirst=false/>
				<#if (slide.type)="img">
	      			<img class="d-block w-100" src="<#escape x as x?xml>${common.buildRootPathAwareURL(slide.data)}</#escape>" <#if (slide.style)??> style="<#escape x as x?xml>${slide.style}</#escape>"</#if><#if (slide.alt)??> alt="<#escape x as x?xml>${slide.alt}</#escape>"</#if>>
				</#if>
				<#if (slide.caption)??>
					<div class="carousel-caption d-none d-md-block" <#if (slide.captionStyle)??> style="<#escape x as x?xml>${slide.captionStyle}</#escape>" role="presentation"</#if>>
					${slide.caption}
					</div>
				</#if>
			</div>
		</#list>
		</div>
		
		
		<#if (controls??)>
			<a class="left carousel-control" href="#<#escape x as x?xml>${carouselId}</#escape>" role="button" data-slide="prev">
			<span class="icon-prev" aria-hidden="true"></span>
			<span class="sr-only">${controls.previousLabel!"précédent"}</span>
			</a>
			
			<a class="right carousel-control" href="#<#escape x as x?xml>${carouselId}</#escape>" role="button" data-slide="next">
			<span class="icon-next" aria-hidden="true"></span>
			<span class="sr-only">${controls.nextLabel!"suivant"}</span>
			</a>
		</#if>
		</div>
	</#if>
</#macro>

<#-- build the breacrumb -->
<#macro buildBreadcrumb content>
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
