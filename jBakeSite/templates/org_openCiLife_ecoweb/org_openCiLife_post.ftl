<#include "header.ftl">
	
	<#include "menu.ftl">
	
	<#if hookHelper??>
		<@hookHelper.hook "beforePageHeader" content/>
	</#if>
	
	<div class="pageContent">
	
	<#if hookHelper??>
		<@hookHelper.hook "beforeBody" content/>
	</#if>
	<#if (content.body)??>
		${content.body}
	</#if>
	
	<#if hookHelper??>
		<@hookHelper.hook "afterBody" content/>
	</#if>
	
	</div>
<#include "footer.ftl">