<#include "header.ftl">
	
	<#include "menu.ftl">

	<div class="page-header">
		<h1>${content.title}</h1>
	</div>
	
	<div>
		${content.body}
	</div>
	
	<div class="org_djer13_definitions_list">
		<#list org_djer13_definitions?sort_by("title") as definition>
			<#if (definition.status == "published")>
				<div class="org_djer13_definitions">
					<div class="org_djer13_definition_header">
						<div class="org_djer13_definition_intro">
							<a href="${definition.uri}"><h2>
							<#escape x as x?xml>${definition.title}</#escape>
							</h2></a>
						</div>
					</div>
					<div class="org_djer13_definition_content">
						${definition.body}
					</div>
				</div>
				<hr />
			</#if>
		</#list>
	</div>

<#include "footer.ftl">