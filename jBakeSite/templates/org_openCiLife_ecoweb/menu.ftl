	<!-- Fixed navbar -->
    <div id="beforeMainContent" class="container ${webleger.site.beforeMainContent.class}">
	<#if hookHelper??>
		<@hookHelper.hook "beforeMainContent" content/>
	</#if>
    </div>
    <#assign mainContainerClass = "container" />
    <#if content?? && content.specificClass??>
    	<#assign mainContainerClass = mainContainerClass + " @webleger.site.mainContent.class@ " + content.specificClass>
    </#if>
    <div id="mainContent" class="${mainContainerClass}" role="main">
    <#if content?? && content?has_content>
    	<#if hookHelper?? && hookHelper.hasContributors("topContentContainer")>
    		<div id="topContentContainer" class="${webleger.site.topContentContainer.class}">
			<@hookHelper.hook "topContentContainer" content/>
			</div>
		</#if>
    </#if>
    