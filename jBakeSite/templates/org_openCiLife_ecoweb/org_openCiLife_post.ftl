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
	<div class="pageContent">
	${content.body}
	
	<@ecoWeb.buildForm content />
	<@ecoWeb.buildCarousel content />
	</div>
	
	<div class="subContent">
	<@ecoWeb.buildsubContent content />
	</div>
	
	<@ecoWeb.displayDebugFunctionMessages />
<#include "footer.ftl">