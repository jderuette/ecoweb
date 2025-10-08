	<!-- Fixed navbar -->
    <div class="container">
    	<@menu.buildMenu />
    </div>
    <#assign mainContainerClass = "container" />
    <#if content?? && content.specificClass??>
    	<#assign mainContainerClass = mainContainerClass + " " + content.specificClass>
    </#if>
    <div id="container" class="${mainContainerClass}" role="main">
    <#if content?? && content?has_content>
    	<#if breadcrumb??>
    		<@breadcrumb.build content/>
    	</#if>
    </#if>
    