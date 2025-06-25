<#include "header.ftl">
	
	<#include "menu.ftl">
	
	<#if ((content.displayDate)?? && content.displayDate == "true")>
		<p>Publié le : <em>${content.date?string("dd MMMM yyyy")}</em></p>
	</#if>
	<#if (content.tags)?? && (content.tags?size > 0) >
		<span>Tags : </span>
		<ul class="content_tags">
		<#list content.tags as tag>
			<li>${tag}</li>
		</#list>
		</ul>
	</#if>
	
	<#if (content.title)??>
		<div class="page-header">
			<h1><#escape x as x?xml>${content.title}</#escape></h1>
		</div>
	</#if>
	${content.body}
	<@ecoWeb.buildsubContent content />
	<@ecoWeb.buildForm content />
	<@ecoWeb.buildCarousel content />
	
<#include "footer.ftl">