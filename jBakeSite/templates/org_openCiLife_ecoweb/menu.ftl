	<!-- Fixed navbar -->
    <div class="container">
	<#if hookHelper??>
		<@hookHelper.hook "topMenuContainer" content/>
	</#if>
    </div>
    <#assign mainContainerClass = "container" />
    <#if content?? && content.specificClass??>
    	<#assign mainContainerClass = mainContainerClass + " " + content.specificClass>
    </#if>
    <div id="container" class="${mainContainerClass}" role="main">
    <#if content?? && content?has_content>
    	<#if hookHelper??>
			<@hookHelper.hook "topContentContainer" content/>
		</#if>
    </#if>
    