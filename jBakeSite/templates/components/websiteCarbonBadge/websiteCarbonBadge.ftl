<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"WebsiteCarbonBadge", "description":"Display an estimation of carbon footprint for pages", "version":"0.1.0", "recommandedNamespace":"websiteCarbonBadge", "require":[{"value":"includeContent", "type":"contentHeader"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#macro build content>
	<div id="wcb" class="carbonbadge"></div>
</#macro>
