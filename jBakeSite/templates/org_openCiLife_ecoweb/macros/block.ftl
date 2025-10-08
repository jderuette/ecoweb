<#function getComponnentInfo>
	<#return {"name":"block", "description":"Add blocks in content", "recommandedNamespace":"block", "require":[{"value":"sequenceHelper", "type":"lib"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
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
		<#assign blockCategory = block.category!"__empty_categ__">
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
					<#if subcontent??>
						<@subcontent.build block />
					</#if>
					<#if form??>
						<@form.build block />
					</#if>
					<#if carousel??>
						<@carousel.build block />
					</#if>
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
					<#if subcontent??>
						<@subcontent.build block />
					</#if>
					<#if form??>
						<@form.build block />
					</#if>
					<#if carousel??>
						<@carousel.build block />
					</#if>
				</div>	
			</div>
		</div>
</#macro>