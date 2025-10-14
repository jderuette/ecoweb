<#include "header.ftl">
	
	<#include "menu.ftl">
	
	<#if hookHelper??>
		<@hookHelper.hook "beforePageHeader" content/>
	</#if>
	
	<#if (content.title)?? && ((content.displayTitle)?? && !(content.displayTitle=="false"))>
		<div class="page-header">
			<h1><#escape x as x?xml>${content.title}</#escape></h1>
		</div>
	</#if>
	<div class="pageContent">
	
	<#if hookHelper??>
		<@hookHelper.hook "beforeBody" content/>
	</#if>
	<#if (content.body)??>
		${content.body}
	</#if>
	<#if (content.includeBlocks)??>
		<#if block??>
			<@block.build content.includeBlocks.category/>
		</#if>
	</#if>
	
	<#if hookHelper??>
		<@hookHelper.hook "afterBody" content/>
	</#if>
	
	</div>
<#include "footer.ftl">