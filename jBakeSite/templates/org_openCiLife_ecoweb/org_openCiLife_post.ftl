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
	
	<#if (content.body)??>
		<#if hookHelper??>
			<@hookHelper.hook "beforeBody" content/>
		</#if>
		${content.body}
		<#if hookHelper??>
			<@hookHelper.hook "afterBody" content/>
		</#if>
	</#if>
	
	<#if (content.includeBlocks)??>
		<#if block??>
			<@block.build content.includeBlocks.category/>
		</#if>
	</#if>
	
	</div>
<#include "footer.ftl">