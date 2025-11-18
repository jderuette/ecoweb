<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"block", "description":"Add blocks in content", "recommandedNamespace":"block", "version":"0.1.0", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"hookHelper", "type":"lib"}, {"value":"common", "type":"lib"}, {"value":"org_openCiLife_blocks", "type":"contentType"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}, {"value":"subTemplate", "type":"contentHeader"}]}>
</#function>

<#function init>
	<#return "" />
</#function>


<#macro build content>
	<#if (content.includeBlocks)?? && (content.includeBlocks.category)??>
		<@buildWithCategory content.includeBlocks.category />
	</#if>
</#macro>

<#-- build a content with blocks
    @param categoryFilter category to filter to get blocks. "config.site_homepage_category" for HomePage.
-->
<#macro buildWithCategory categoryFilter>

	<#local blocks = org_openCiLife_blocks?filter(b -> b.status=="published")?sort_by("order")>
	<#if (langHelper)??>
		<#local blocks = blocks?filter(ct -> langHelper.isCorectLang(ct, langHelper.getLang(content)))>
	</#if>
	
	<#if logHelper??>
		<@logHelper.debug "Blocks : search if " + categoryFilter + " exists in " + blocks?size + " blocks"/>
	</#if>
	
	<#list blocks?sort_by("order") as block>
		<#local blockCategory = block.category!"__empty_categ__">
		<#if (sequenceHelper.seq_containsOne(blockCategory, categoryFilter))>
			<#local uselessTempVar = commonInc.propagateContentChain(block) />
			<#local subTemplateName = "defaultBlockSubTemplate">
			<#if (block.subTemplate??)>
				<#local subTemplateName=block.subTemplate>
			</#if>
			
			<#local subTemplateInterpretation = "<@${subTemplateName} block />"?interpret>
			<@subTemplateInterpretation/>
		</#if>
  	</#list>
</#macro>

<#macro generateAnchor block>
	<#if (block.anchorId)??>
		id="<#escape x as x?xml>${block.anchorId}</#escape>"<#rt>
	</#if>
</#macro>

<#macro generateCssClass block customCssClass="">
	<#local classes = "block">
	<#if (block.specificClass)?? && block.specificClass?has_content>
		<#local classes = classes + " " + block.specificClass>
	</#if>
	<#if (customCssClass)?? && customCssClass?has_content>
		<#local classes = classes + " " + customCssClass>
	</#if>
	<#lt>class="<#escape x as x?xml>${classes}</#escape>"
</#macro>

<#macro generateTitle block contentImageBefore=false>
	<#if (block.title)?? && block.title?has_content && !((block.displayTitle)?? && block.displayTitle == "false")>
		<#local titleTag = "h2">
		<#if (block.titleTag)??>
			<#local titleTag = block.titleTag>
		</#if>
		<${titleTag} class="blockTitle"><#escape x as x?xml>
		<#if (block.beforeTitleImage?has_content)>
			<@common.addImageIcon block.beforeTitleImage "block_title_image"/>
		</#if>
		<#if (contentImageBefore)>
			<@common.addImageIcon block.contentImage "block_title_image"/>
		</#if>
		${block.title}</#escape>
		</${titleTag}>
	</#if>
</#macro>

<#macro generateBodyContent block>
	<#if hookHelper??>
		<@hookHelper.hook "beforeBlockContent" block/>
	</#if>
	<div class="blockContent">
		<#if hookHelper??>
			<@hookHelper.hook "beforeBlockBody" block/>
		</#if>
		${block.body}
		<#if hookHelper??>
			<@hookHelper.hook "afterBlockBody" block/>
		</#if>
	</div>
	<#if hookHelper??>
		<@hookHelper.hook "afterBlockContent" block/>
	</#if>
</#macro>

<#macro defaultBlockSubTemplate block>
	<@imageRightSubTemplate block />
</#macro>

<#macro imageRightSubTemplate block>
	<div <@generateAnchor block/> <@generateCssClass block "imageRightSubTemplate"/>>
		<@generateTitle block/>
		<div class="blockBody">
			<@generateBodyContent block/>
			<#if (block.contentImage)??>
				<@common.addImageIcon block.contentImage "blockIcon"/>
			</#if>
		</div>
	</div>
</#macro>

<#macro imageLeftSubTemplate block>
	<div <@generateAnchor block/> <@generateCssClass block "imageLeftSubTemplate"/>>
		<@generateTitle block/>
		<div class="blockBody">
			<#if (block.contentImage)??>
				<@common.addImageIcon block.contentImage "blockIcon"/>
			</#if>
			<@generateBodyContent block/>
		</div>
	</div>
</#macro>

<#macro imageLeftTitleAndContentSubTemplate block>
	<div <@generateAnchor block/> <@generateCssClass block "imageLeftTitleAndContentSubTemplate"/>>
		<#if (block.contentImage)??>
				<@common.addImageIcon block.contentImage "blockIcon"/>
		</#if>
		<div class="groupe_content">
			<@generateTitle block/>
			<div class="blockBody">
				<@generateBodyContent block/>
			</div>
		</div>
	</div>
</#macro>

<#macro imageBeforeTitleSubTemplate block customCssStyle="">
	<div <@generateAnchor block/> <@generateCssClass block "imageBeforeTitleSubTemplate"/> <#if customCssStyle?has_content>style="${customCssStyle}"</#if>>
		<@generateTitle block true/>
		<div class="blockBody">
			<@generateBodyContent block/>
		</div>
	</div>
</#macro>

<#macro noImageSubTemplate block customCssStyle="">
	<div <@generateAnchor block/> <@generateCssClass block "noImageSubTemplate"/> <#if customCssStyle?has_content>style="${customCssStyle}"</#if>>
		<@generateTitle block/>
		<div class="blockBody">
			<@generateBodyContent block/>
		</div>
	</div>
</#macro>

<#macro backGroundImageCoverSubTemplate block>
	<#local customCssStyle = "background-image: url('"+common.buildRootPathAwareURL(block.contentImage)+"'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
	<@noImageSubTemplate block customCssStyle/>
</#macro>


<#macro backGroundImageContainSubTemplate block>
	<#local customCssStyle = "background-image: url('"+common.buildRootPathAwareURL(block.contentImage)+"'); background-repeat: no-repeat; background-size: contain;">
	<@noImageSubTemplate block customCssStyle/>
</#macro>

