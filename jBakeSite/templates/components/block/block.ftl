<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"block", "description":"Add blocks in content", "recommandedNamespace":"block", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"hookHelper", "type":"lib"}, {"value":"common", "type":"lib"}, {"value":"org_openCiLife_blocks", "type":"contentType"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}, {"value":"subTemplate", "type":"contentHeader"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#-- build a content with blocks
    @param categoryFilter category to filter to get blocks. "config.site_homepage_category" for HomePage.
-->
<#macro build categoryFilter>

	<#local blocks = org_openCiLife_blocks?filter(b -> b.status=="published")?sort_by("order")>
	<#if (langHelper)??>
		<#local blocks = blocks?filter(ct -> langHelper.isCorectLang(ct, langHelper.getLang(content)))>
	</#if>
	
	<#list blocks?sort_by("order") as block>
		<#local blockCategory = block.category!"__empty_categ__">
		<#if logHelper??>
			<@logHelper.debug "Blocks : search if " + blockCategory + " in " + categoryFilter + " res : " + sequenceHelper.seq_containsOne(blockCategory, categoryFilter)?string("yes","no")/>
		</#if>
		<#if (sequenceHelper.seq_containsOne(blockCategory, categoryFilter))>
			<#local subTemplateName = "defaultBlockSubTemplate">
			<#if (block.subTemplate??)>
				<#local subTemplateName=block.subTemplate>
			</#if>
			
			<#local subTemplateInterpretation = "<@${subTemplateName} block />"?interpret>
			<@subTemplateInterpretation/>
		</#if>
  	</#list>
</#macro>

<#macro addImageIcon block>
	<#if (block.contentImage)??>
		<img src=${common.buildRootPathAwareURL(block.contentImage)} class="blockIcon"/>
	</#if>
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
			<#if hookHelper??>
				<@hookHelper.hook "beforeBlockContent" block/>
			</#if>
			<div class="blockContent">
				<#if hookHelper??>
					<@hookHelper.hook "beforeBody" block/>
				</#if>
				${block.body}
				<#if hookHelper??>
					<@hookHelper.hook "afterBody" block/>
				</#if>
			</div>
			<#if hookHelper??>
				<@hookHelper.hook "afterBlockContent" block/>
			</#if>
			<@addImageIcon block />
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
				<@addImageIcon block />
				<#if hookHelper??>
					<@hookHelper.hook "beforeBlockContent" block/>
				</#if>
				<div class="blockContent">
					<#if hookHelper??>
						<@hookHelper.hook "beforeBody" block/>
					</#if>
					${block.body}
					<#if hookHelper??>
						<@hookHelper.hook "afterBody" block/>
					</#if>
				</div>
				<#if hookHelper??>
					<@hookHelper.hook "afterBlockContent" block/>
				</#if>
			</div>
		</div>
</#macro>