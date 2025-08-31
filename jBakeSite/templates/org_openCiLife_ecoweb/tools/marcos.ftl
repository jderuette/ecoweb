<#--  inspired by : https://subscription.packtpub.com/book/web_development/9781782163824/1/ch01lvl1sec06/top-9-features-you-need-to-know-about -->

<#-- Search if an element on a list, belong to another list 
param : aSequence : the sequence to search for matches
param : lookupItems : item or items to search for
param : **default** : , : autoSplitChar : String containing this Char will be converted to Sequence with autoSplitChar as separator
return : true in a least one lookupItems is found in aSequence
-->
<#function seq_containsOne aSequence lookupItems autoSplitChar = ",">
	<#assign found=false>
	
	<#assign transformedASequence=aSequence>
	<#assign transformedLookupItems=lookupItems>
	
	<#if autoSplitChar?? && autoSplitChar != "">
		<#if (aSequence?is_string && aSequence?contains(autoSplitChar))>
			<#assign transformedASequence = splitStringToSequence(aSequence)>
		</#if>
		
		<#if (lookupItems?is_string && lookupItems?contains(autoSplitChar))>
			<#assign transformedLookupItems=lookupItems?split(r"\s*,\s*", "r")>
		</#if>
	
	</#if>
	
	<#if (transformedLookupItems?is_sequence)>
		<#if (transformedASequence?is_sequence)>
			<#list transformedLookupItems as item>
				<#if (!found)>
					<#assign found = transformedASequence?seq_contains(item)>
				</#if>
			</#list>
		<#else> <#-- transformedASequence is not a Sequence, but transformedLookupItems IS -->
			<#assign found = transformedLookupItems?seq_contains(transformedASequence)>
		</#if>
	<#else> <#-- transformedLookupItems is not a Sequence -->
		<#if (transformedASequence?is_sequence)>
			<#assign found = transformedASequence?seq_contains(transformedLookupItems)>
		<#else> <#-- both params are NOT lists -->
			<#assign found = transformedLookupItems == transformedASequence>
		</#if>>
	</#if>
	
	<#return found>
</#function>

<#-- convert a String to a Sequence
param : value : the String to convert
param : **default** : , : autoSplitChar : String containing this Char will be converted to Sequence with autoSplitChar as separator
return : A sequence with all elements after splitting
-->
<#function splitStringToSequence stringValue autoSplitChar = ",">
	<#if (stringValue?is_string && stringValue?contains(autoSplitChar))>
		<#assign sequence=stringValue?split(r"\s*,\s*", "r")>
	<#else>
		<#assign sequence=[stringValue]>
	</#if>
	
	<#return sequence>
</#function>

<#-- Build URL, using the root.path if required 
param : relativeUrl : the relative URL to adapt
return : URL prepend with rootPath (if configured)
-->
<#function buildRootPathAwareURL relativeUrl>
	<#assign rootPathAwareURL = relativeUrl>
	
	<#if (content.rootpath)??>
		<#assign rootPathAwareURL = content.rootpath + relativeUrl>
	</#if>
	
	<#return rootPathAwareURL>
</#function>

<#-- search for absolute URL in content and preprend the RootPath
param : text : the teh text to search for relative URL
param : rootPath : default ${content.rootpath} : the rootPath of teh webSite
return : text with URL transformed
-->
<#-- 
<#function findAndReplaceUrlAddAwareRootPath text rootPath = content.rootpath>
	<#assign contentRootPathAwareURL = text>
	
	<#if (config.rootPath)??>
		<#assign contentRootPathAwareURL = text?replace("/images/", rootPath + "/images/", "r")>
	</#if>
	
	<#return contentRootPathAwareURL>
</#function>
 -->
 
<#-- display text from config file. Handle corectly when coma "," in text
param : theText : the text to display (may be a "sequence")
return : a text (with original coma ",")
-->
<#function displayConfigText theText>
	<#if theText?is_sequence>
		<#assign text = theText?join(", ")>
	<#else>
		<#assign text = theText>
	</#if>
	<#return text>
</#function>


<#function hasConfigValue theValue>
	<#local hasValue = false>
	<#if (config[theValue])??>
		<#if (config[theValue] != "$\{webleger."+theValue?replace("_", ".")+"}")>
			<#local hasValue = true>
		</#if>
	</#if>
	<#return hasValue>
</#function>


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

<#-- display debug messages in HTML page. Only displayend if "site.debug.enabled" exist and is "true"
param : message : the message to display (a String)
-->
<#macro debug message...>
	<#if (config.site_debug_enabled)?? && config.site_debug_enabled == "true">
		<div class="debug">
		<#if (message?is_hash)>
			<#-- Called using <@macro debug "A message"> OR <@macro debug "first message", "Second message"> OR <@macro debug "first message", ["Second message", "And an other"]> -->
			<#list message as key, value>
				<#if value?is_sequence>
					<#list value as aMessage>
						<p class="debug"> ${key} = ${aMessage}</p>
					</#list>
				<#else>
					<p class="debug">${key} = ${value}</p>
				</#if>
			</#list>
		<#elseif (message?is_sequence)>
			<#-- Called using <@macro debug ["A message"]> OR <@macro debug ["first message", "Second message"]> -->
			<#list message as value>
				<#if value?is_sequence>
					<#list value as aMessage>
						<p class="debug"> ${aMessage}</p>
					</#list>
				<#elseif (value?is_boolean)>
					<p class="debug">${value?string('yes', 'no')}</p>
				<#else>
					<p class="debug">${value}</p>
				</#if>
			</#list>
		<#else>
			<p class="debug"> ${message}</p>
		</#if>
		</div>
	</#if>
</#macro>


<#assign stackedDebugMessage = "">
<#-- allow function to debug. Message are starcked in a sequence, and rendered at the end of the page. -->
<#function stackDebugMessage message>
	<#assign stackedDebugMessage = stackedDebugMessage + "<br/>" + message>
	<#return ""/>
</#function>

<#macro displayDebugFunctionMessages>
	<@debug stackedDebugMessage />
</#macro>


<#-- Find the **displayName** of a custom document type
param : postType : the name of the document type
return : a text, the configured display name (in jbake.properties) or the original post type name
-->
<#function getDisplayName postType>
	<#assign postTypeDisplayName = postType>
	<#assign postTypeDisplayNameProp = "ecoweb_type_" + postType + "_displayName">
	
	<#if (config[postTypeDisplayNameProp])??>
		<#assign postTypeDisplayName = config[postTypeDisplayNameProp]>
	</#if>
	
	<#return postTypeDisplayName>
</#function>


<#function filterMenuList list menuName>
  <#local result=[]>
  <#list list as menuItem>
  	<#if menuName == "__GLOBAL__">
  		<#if !menuItem.menu??>
  			<#local result=result + [menuItem]>
  		</#if>
    <#else>
    	<#if menuItem.menu?? && menuItem.menu.parent?? && menuItem.menu.parent == menuName>
      		<#local result=result + [menuItem]>
      	</#if>
    </#if>
  </#list>
  <#return result>
</#function>

<#function createMultiLevelMenu list>
  <#local result={}>
  <#list list as blockMenu>
  	<#if blockMenu.menu?? && blockMenu.menu.parent??>
	    <#if !result[blockMenu.menu.parent]??>
	      <#local result=result + {blockMenu.menu.parent: filterMenuList(list, blockMenu.menu.parent) }>
	    </#if>
	<#else>
		<#local result=result + {"__GLOBAL__": filterMenuList(list, "__GLOBAL__") }>
	</#if>
  </#list>
  <#return result>
</#function>

<#-- macro debugMenu menuItems>
	<div class="debug">
	debug du menu<br/>
	<#list menuItems as parentName, menuItems>
		- ${parentName}<br/>
		<#list menuItems as subMenu >
			--- ${subMenu.title}
		</#list>
		<br/>
	</#list>
	</div>
</#macro>
-->

<#-- build the site menu (using Boostrap) -->
<#macro buildMenu>
<div class="navbar navbar-light bg-white" role="navigation">
      <div class="navbar-header">
  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  </button>
</div>
<div class="navbar-collapse collapse">
  <ul class="nav navbar-nav" role="menubar">
  	<#local menu_list = []>
  	<#if (config.site_menu_includeBlock == "true")>
  		<#list org_openCiLife_blocks?sort_by("order") as block_menu>
			<#if (ecoWeb.seq_containsOne(block_menu.category, config.site_menu_includeCategories))>
				<#if (block_menu.anchorId)?? && block_menu.status == "published">
					<#local menu_list = menu_list + [block_menu]>
				</#if>
			</#if>
		</#list>
	</#if>
	
	<#if (config.site_menu_includeCategories)??>
		<#list org_openCiLife_posts?sort_by("order") as blog_menu>
			<#if   (ecoWeb.seq_containsOne(blog_menu.category, config.site_menu_tags_include))>
				<#if (blog_menu.uri)?? && blog_menu.status == "published">
					<#local menu_list = menu_list + [blog_menu]>
				<#else></#if>
			</#if>
		</#list>
	</#if>
	
	<@debug menu_list?size/>
	<#local hierachical_menu = createMultiLevelMenu(menu_list)>
	
	
	<#list hierachical_menu as top_level_menu_name, top_level_menu_items>
		<#if top_level_menu_name != "__GLOBAL__">
			<#local parentMenuSpecificClass = "class=\"dropdown-toggle\"">
			<#--
			<#if menu_item.menu?? && menu_item.menu.parentSpecificClass??>
				<#local parentMenuSpecificClass = " class=\"dropdown-toggle " + menu_item.menu.parentSpecificClass + "\"">
			</#if>
			-->
			<li class="dropdown">
				<a href="#" ${parentMenuSpecificClass} data-toggle="dropdown">${top_level_menu_name} <b class="caret"></b></a>
				<ul class="dropdown-menu">
		</#if>
		<#list top_level_menu_items as menu_item>
				<#assign menuSpecificClass = "">
				<#if menu_item.menu?? && menu_item.menu.specificClass??>
					<#assign menuSpecificClass = " class=\"" + menu_item.menu.specificClass + "\"">
				</#if>
				<#local link = "">
				<#if menu_item.anchorId??>
					<#local link = "index.html#"+menu_item.anchorId>
				<#else>
					<#local link = menu_item.uri>
				</#if>
				
				<li${menuSpecificClass}><a href="${ecoWeb.buildRootPathAwareURL(link)}" role="menuitem">${menu_item.title}</a></li>
		</#list>
		<#if top_level_menu_name != "__GLOBAL__">
			</li>
				</ul>
		</#if>
	</#list>
	
    <#-- <li><a href="${ecoWeb.buildRootPathAwareURL("/")}">Home</a></li> -->
   <#--
    <li class="dropdown">
      <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a href="#">Action</a></li>
        <li><a href="#">Another action</a></li>
        <li><a href="#">Something else here</a></li>
        <li class="divider"></li>
        <li class="dropdown-header">Nav header</li>
        <li><a href="#">Separated link</a></li>
        <li><a href="#">One more separated link</a></li>
      </ul>
    </li>
    -->
  </ul>
</div><#--/.nav-collapse -->
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
		<#assign fullContent = content>
		<#if content?is_sequence>
			<#assign fullContent = "">
			<#assign separator = "">
			<#list content as fakeItem>
				<#assign fullContent = fullContent + separator + fakeItem>
				<#assign separator = ",">
			</#list>
		</#if>
		
		<#assign jsonContent = fullContent?eval_json>
		
		<#list jsonContent.data as injection>
			<#assign tagType = injection.tagType!"link">
			<#if ((injection.constraint)??)>
				<!--[${injection.constraint}]>
			</#if>
		<${tagType}<#if (injection.href??)> href="${buildRootPathAwareURL(injection.href)}"</#if><#if (injection.src??)> src="${buildRootPathAwareURL(injection.src)}"</#if><#if (injection.rel??)> rel="${injection.rel}"</#if>><#if (injection.tagType=="script")></script></#if>
			<#if ((injection.constraint)??)>
				<![endif]-->
			</#if>
		</#list>
	</#if>
</#macro>


<#-- build an modal block or table listing (using Boostrap)
param : content : content to search for incluide content
-->
<#macro buildsubContent content>
	<#if (content.includeContent)??>
		<@debug "(sub)Content should be included"/>
			<#assign allSubContents = db.getPublishedContent(content.includeContent.type)>
			<#assign displaySelf = (content.includeContent.displaySelf)!"disabled">
			<#assign subContents = allSubContents>
			<#--  -- remove self if presents -->
			<#if (displaySelf == "none")>
				<#assign subContents = allSubContents?filter(ct -> ct.title != content.title)>
			</#if>
			<@debug "Included Type " + content.includeContent.type, "Number of subContent to display " + subContents?size/>
			
			<#if (subContents?size > 0)>
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
				
				<@debug subContentDisplayMode = subContentDisplayMode subContentDisplayContentMode = subContentDisplayContentMode/>
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
					<#assign subContentCategory = (subContent.category)!"__none__">
					<#assign includeContentFilter = content.includeContent.category!"all">
					<#assign specificContentClass = (content.includeContent.display.specificClass)!"">
					<#assign collapseClass = "">
					<#assign collapseId = "">
					<#local isSelf = subContent.title == content.title>
					<#local slefSpecificClass = "">
					
					<#if isSelf>
						<#assign specificContentClass += " self">
						<#switch displaySelf>
							<#case "disabled">
								<#assign specificContentClass += " self_disabled">
							<#break>
							<#case "none">
								<#-- Nothing to do content is not in list -->
							<#break>
						</#switch>
					</#if>
					
					<#if ((subContent.status == "published") && (includeContentFilter == "all" || seq_containsOne(includeContentFilter, subContentCategory)))>
						<@debug "ACEPTED : SubContent : " + (subContent.title)!"not_set", includeContentFilter  + " IN " + subContentCategory/>
						<#if (subContentDisplayMode == "table")>
									<tr<#rt>
										<#if (subContentDisplayContentMode == "link")>
											<#lt> data-href="${ecoWeb.buildRootPathAwareURL(subContent.uri)}"<#rt>
										</#if>
										<#if (specificContentClass != "")>
											<#lt> class="${specificContentClass}"
										</#if>
									<#lt>>
										<td class="${subContentDisplayMode}_image">
											<#if (subContent.contentImage)??>
												<img src="${ecoWeb.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image" />
											</#if>
										</td>
										<td class="${subContentDisplayMode}_title widget_title">
											<#if (subContentBeforeTitleImage?has_content)>
												<img src="${ecoWeb.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
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
									<a href="${ecoWeb.buildRootPathAwareURL(subContent.uri)}" class="widget_link">
								<#break>
								<#case "modal">
									<a href="#" role="button" class="widget_link_modal" data-toggle="modal" data-target="#${theModalId}">
								<#break>
								<#case "collapse_block">
									<#assign collapseClass = "collapse">
									<#assign collapseId = randomNumber()>
    								<a data-toggle="collapse" href="#${collapseId}" aria-expanded="false" aria-controls="${collapseId}">
								<#break>
								<#case "card">
									<#if (subContentDisplayContentMode == "link")>
										<a href="${ecoWeb.buildRootPathAwareURL(subContent.uri)}">
									</#if>
								<#break>
								</#switch>
								<#if (subContent.contentImage??)>
									<div class="${subContentDisplayMode}_image">
										<#if (subContent.contentImage)??>
										<img src="${ecoWeb.buildRootPathAwareURL(subContent.contentImage)}" class="widget_image"/>
										</#if>
									</div>
								</#if>
								<h3 class="${subContentDisplayMode}_title widget_title"><#rt>
								<#if (subContentBeforeTitleImage?has_content)>
									<img src="${ecoWeb.buildRootPathAwareURL(subContentBeforeTitleImage)}" class="widget_title_image icon"/>
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
						<@debug "FILTRED (" + subContent.status + ") : SubContent : " + (subContent.title)!"not_set", includeContentFilter + " NOT IN " subContentCategory />
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
	<#else>
		<@debug "No SubContent for this content"/>
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
		<@debug "No form Data for this content"/>
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
	      			<img class="d-block w-100" src="<#escape x as x?xml>${ecoWeb.buildRootPathAwareURL(slide.data)}</#escape>" <#if (slide.style)??> style="<#escape x as x?xml>${slide.style}</#escape>"</#if><#if (slide.alt)??> alt="<#escape x as x?xml>${slide.alt}</#escape>"</#if>>
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
	<#if config.site_breakcrumb_display == "true">
		<#if content?? && content.uri??>
		 	<ul id="breadcrumb">
		 	${stackDebugMessage("Breadcrumb : Current page URI : ${content.uri}")}
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
			 		<a href="${buildRootPathAwareURL(element.uri)}">
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
	${stackDebugMessage(">>Breadcrumb : Search content for URI '"+uri+"'")}
	<#local pageFound = false>
	<#if (maxLoop > 0) && uri?? && uri != "">
		<#local allSubContents = db.getPublishedContent("org_openCiLife_post")>
		
		<#list allSubContents as aContent>
			<#if aContent.uri?? && (aContent.uri == uri)>
				<#-- content is a standard page -->
				${stackDebugMessage(">>>> Breadcrumb : Content Page found !")}
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
				<#if (aContent.uri)?? && aContent.order?? && aContent.uri?keep_before_last("/") == uri>
					<#if lowestOrderContentFound?size == 0>
						${stackDebugMessage(">>>> Breadcrumb '${aContent.title}' with order ${aContent.order} is the first candidate")}
						<#local lowestOrderContentFound = aContent>
						<#local foundUri = aContent.uri>
					<#else>
						<#if (aContent.order?number < lowestOrderContentFound.order?number) >
							${stackDebugMessage(">>>> Breadcrumb '${aContent.title}' has order ${aContent.order} lowest than previous found content '${lowestOrderContentFound.title}' with order ${lowestOrderContentFound.order}")}
							<#local lowestOrderContentFound = aContent>
							<#local foundUri = aContent.uri>
						</#if>
					</#if>
				</#if>
			</#list>
			<#-- if found content *for a folder* is the curent page we are on a "dispatch" page, wich is a "duplicate" of the current page.
	    	Remove this item. -->
	    	<#if  foundUri == content.uri>
				${stackDebugMessage(">>>>>> Breadcrumb : directory content ("+lowestOrderContentFound.uri+") found IS the CURRENT page("+content.uri+"), this element will be removed")}
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
