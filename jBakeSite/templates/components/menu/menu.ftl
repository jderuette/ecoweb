<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"menu", "description":"Build dynamic menus bases on content", "recommandedNamespace":"menu", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"bootstrap3", "type":"lib"}], "uses":[{"value":"langHelper", "type":"lib"},{"value":"logHelper", "type":"lib"}, {"value":"site.debug.enabled", "type":"config"}, {"value":"menu", "type":"contentHeader"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#-- Filter a menu list
@param  menuName : "parent" menu list
#param language : optionel : the language of item to keep. if not set no language filtering.-->
<#function filterMenuList list menuName language = "__NONE__">
	<#local result=[]>
	<#local filteredList = list>
	<#if (language != "__NONE__")>
		<#if (langHelper)??>
			<#local filteredList = list?filter(mi -> langHelper.isCorectLang(mi, language))>
		</#if>
	</#if>
	<#list filteredList as menuItem>
		<#if menuName == "__GLOBAL__">
			<#if !menuItem.menu??>
				<#local result=result + [menuItem]>
			</#if>
		<#else>
			<#if menuItem.menu?? && menuItem.menu.parent?? && menuItem.menu.parent.title?? && menuItem.menu.parent.title == menuName>
				<#local result=result + [menuItem]>
			</#if>
		</#if>
	 </#list>
	<#return result>
</#function>

<#-- Create a multi-level menu.
@param list : list of content for menu
@param language : optionel : the lang of item to keep. -->
<#function createMultiLevelMenu list language = "__NONE__">
	<#if (logHelper??)>
		${logHelper.stackDebugMessage("MENU : Creating a menu with : " + list?size + " item for language : " + language)}
	</#if>
  	<#local result={}>
  	<#list list as blockMenu>
  		<#if blockMenu.menu?? && blockMenu.menu.parent?? && blockMenu.menu.parent.title??>
	    	<#if !result[blockMenu.menu.parent.title]??>
	    		<#local subItemList = filterMenuList(list, blockMenu.menu.parent.title, language)>
	    		<#if subItemList?size gt 0>
	      			<#local result=result + {blockMenu.menu.parent.title: subItemList }>
	      		</#if>
	    	</#if>
		<#else>
			<#local result=result + {"__GLOBAL__": filterMenuList(list, "__GLOBAL__", language) }>
		</#if>
  	</#list>
    <#return result>
</#function>


<#function collectDropDownClasses list>
  <#local AllDropDownClasses=[]>
  <#list list as blockMenu>
  	<#if blockMenu.menu?? && blockMenu.menu.dropDownSpecificClass??>
	    <#if !AllDropDownClasses?seq_contains(blockMenu.menu.dropDownSpecificClass)>
	      <#local AllDropDownClasses=AllDropDownClasses + [blockMenu.menu.dropDownSpecificClass]>
	    </#if>
	</#if>
  </#list>
  
  <#local result = "">
  <#list AllDropDownClasses as aDropDownClass>
  	<#local result = result + " " + aDropDownClass>
  </#list>
  
  <#return result>
</#function>

<#function collectMenuParentClasses list>
  <#local AllMenuParentClasses=[]>
  <#list list as blockMenu>
  	<#if blockMenu.menu?? && blockMenu.menu.parent?? && blockMenu.menu.parent.specificClass??>
	    <#if !AllMenuParentClasses?seq_contains(blockMenu.menu.parent.specificClass)>
	      <#local AllMenuParentClasses=AllMenuParentClasses + [blockMenu.menu.parent.specificClass]>
	    </#if>
	</#if>
  </#list>
  
  <#local result = "">
  <#list AllMenuParentClasses as aMenuParentClass>
  	<#local result = result + " " + aMenuParentClass>
  </#list>
  
  <#return result>
</#function>

<#macro debugMenu menuItems>
	<#if (config["site_debug_enabled"])??>
		<#if debub.isEnabled()>
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
		</#if>
	</#if>
</#macro>


<#-- build the site menu (using Boostrap) -->
<#macro build content>
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
			<#if ((block_menu.category) ?? && sequenceHelper.seq_containsOne(block_menu.category, config.site_menu_includeCategories))>
				<#if (block_menu.anchorId)?? && block_menu.status == "published">
					<#local menu_list = menu_list + [block_menu]>
				</#if>
			</#if>
		</#list>
	</#if>
	
	<#if (config.site_menu_includeCategories)??>
		<#list org_openCiLife_posts?sort_by("order") as blog_menu>
			<#if   (blog_menu.category)?? && (sequenceHelper.seq_containsOne(blog_menu.category, config.site_menu_tags_include)|| (blog_menu.menu)??)>
				<#if (blog_menu.uri)?? && blog_menu.status == "published">
					<#local menu_list = menu_list + [blog_menu]>
				<#else></#if>
			</#if>
		</#list>
	</#if>
	
	<#if (langHelper)??>
		<#local language = langHelper.getLang(content)>
	</#if>
	
	<#local hierachical_menu = createMultiLevelMenu(menu_list, language)>
	
	<#list hierachical_menu as top_level_menu_name, top_level_menu_items>
		<#if top_level_menu_name != "__GLOBAL__">
			<li class="dropdown${collectMenuParentClasses(top_level_menu_items)}">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">${top_level_menu_name} <b class="caret"></b></a>
				<ul class="dropdown-menu${collectDropDownClasses(top_level_menu_items)}">
		</#if>
		<#list top_level_menu_items as menu_item>
				<#local menuSpecificClass = "">
				<#if menu_item.menu?? && menu_item.menu.specificClass??>
					<#local menuSpecificClass = " class=\"" + menu_item.menu.specificClass + "\"">
				</#if>
				<#local link = "">
				<#if menu_item.anchorId??>
					<#local anchorUrl = "index.html">
					<#if (menu_item.anchorUrl)??>
						<#local anchorUrl = menu_item.anchorUrl>
					</#if>
					<#local link = anchorUrl+"#"+menu_item.anchorId>
				<#else>
					<#local link = menu_item.uri>
				</#if>
				
				<li${menuSpecificClass}><a href="${common.buildRootPathAwareURL(link)}" role="menuitem">${menu_item.title}</a></li>
		</#list>
		<#if top_level_menu_name != "__GLOBAL__">
			</li>
				</ul>
		</#if>
	</#list>
	
    <#-- <li><a href="${common.buildRootPathAwareURL("/")}">Home</a></li> -->
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