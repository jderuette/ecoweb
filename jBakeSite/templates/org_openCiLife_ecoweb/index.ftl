<#include "header.ftl">
	
	<#include "menu.ftl">

	<#list org_openCiLife_blocks?filter(b -> b.status=="published")?sort_by("order") as block>
		<#assign blockCategory = block.category!"__empty_categ__">
		<#if ( ecoWeb.seq_containsOne(blockCategory, config.site_homepage_category))>
		
		<div id="${block.anchorId}"<#rt>
		<#if (block.specificClass)??>
			<#lt> class="<#escape x as x?xml>${block.specificClass}</#escape>"<#rt>
		</#if>
		<#lt>>
		<#if (block.title)??>
			<h2	class="blockTitle"><#escape x as x?xml>${block.title}</#escape></h2>
		</#if>
				<div class="blockBody">
					<div class="blockContent">
						${block.body}
						<@ecoWeb.buildsubContent block />
						<@ecoWeb.buildForm block />
						<@ecoWeb.buildCarousel block />
					</div>	
					<#if (block.contentImage)??>
						<img src=${block.contentImage} class="blockIcon"/>
					<#else></#if>
				</div>
			</div>
		</#if>
  	</#list>

<#include "footer.ftl">