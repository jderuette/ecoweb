<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"obfuscator", "description":"Obfuscate text (to hide content from web crawler)", "recommandedNamespace":"obfuscator", "uses":[{"value":"logHelper", "type":"lib"}, {"value":"displayDate", "type":"contentHeader"}]}>
</#function>

<#function init>
	<#return "" />
</#function>


<#function unObfuscateText obfucatedEmail, obfuscationMask>
	<#local humanReadableText = obfucatedEmail>
	<#if obfucatedEmail?? && obfuscationMask??>
		<#if logHelper??>
			${stackDebugMessage("UnObfuscateText : decrypt text ! whith key : " + obfuscationMask)}
		</#if>
		<#local tokens=obfuscationMask?split(r"\s*,\s*", "r")>
		<#if logHelper??>
			${stackDebugMessage(">>Email : " + tokens?size + " crypt token found")}
		</#if>
		<#list tokens as token>
			<#local tokenDetail=token?split(r"\s*:\s*", "r")>
			<#if tokenDetail?? && tokenDetail[0]?? && tokenDetail[1]??>
				<#if logHelper??>
					${stackDebugMessage(">>>>UnObfuscateText : replacing " + tokenDetail[1] + " by " + tokenDetail[0])}
				</#if>
				<#local humanReadableText = humanReadableText?replace(tokenDetail[1], tokenDetail[0])>
			</#if>
			<#if logHelper??>
				${stackDebugMessage(">>>>UnObfuscateText : Token has " + tokenDetail?size + " elements, current Human Readable e-mail : " + humanReadableText)}
				</#if>
		</#list>
	</#if>
	<#return humanReadableText>
</#function>