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
	
	<#if (content.title)?? && ((content.displayTitle)?? && !(content.displayTitle=="false"))>
		<div class="page-header">
			<h1><#escape x as x?xml>${content.title}</#escape></h1>
		</div>
	</#if>
	<div class="pageContent">
	
	<#if (content.body)??>
		${content.body}
	</#if>
	
	<#if form??>
		<@form.build content />
	</#if>
	<#if carousel??>
		<@carousel.build content />
	</#if>
					
	<#if (content.includeBlocks)??>
		<#if block??>
			<@block.build content.includeBlocks.category/>
		</#if>
	</#if>
	
	</div>
	
	<#if subcontent??>
		<@subcontent.build content />
	</#if>
	
<#include "footer.ftl">