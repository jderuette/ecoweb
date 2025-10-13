<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"form", "description":"Add form in content", "recommandedNamespace":"form", "require":[{"value":"sequenceHelper", "type":"lib"}, {"value":"formData", "type":"contentHeader"}], "uses":[{"value":"langHelper", "type":"lib"}, {"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#if hookHelper??>
		${hookHelper.registerHook("afterBody", "form.build")}
	</#if>
	<#return "" />
</#function>

<#-- build a form
param : content : content to search for form data
-->
<#macro build content>
	<#if (content.formData)??>
		<#local method=(content.formData.method)!"get" />
		<#local enctype=(content.formData.enctype)!"application/x-www-form-urlencoded" />
		<#local sendLabel=(content.formData.sendLabel)!"Contactez" />
		<#local formId=(content.formData.id)!"form1" />
		
		<#assign fields=(content.formData.fields)! />
		
		<#local isContactForm = false>
		<#local extraAtr = "">
		
		<#if (content.formData.to)??>
			<#local isContactForm = true>
			<#if (content.formData.dataTransform)?? && content.formData.dataTransform.type="obfuscated">
				<#local extraAtr = "data-obfuscatedMailTo=\"" + content.formData.to + "\" data-obfuscatedMailToKey=\""+content.formData.dataTransform.obfuscatedKey+"\"">
			</#if>
		</#if>
		
		<form id="<#escape x as x?xml>${formId}</#escape>"<#if (extraAtr!="")> ${extraAtr}</#if><#if (content.formData.action)??> action="<#escape x as x?xml>${content.formData.action}</#escape></#if>" method="<#escape x as x?xml>${method}</#escape>" enctype="<#escape x as x?xml>${enctype}</#escape>" class="contact_form">
		<div class="form-group">
		
		<#list fields as field>
			<#local fieldId = field.id>
			<label for="<#escape x as x?xml>${fieldId}</#escape>"><#escape x as x?xml>${field.label}</#escape></label>
			
			<#if field.type == "textarea">
				<#assign endTag = "textarea" />
				<textarea 
			<#else>
				<#assign endTag = "input" />
				<input type="<#escape x as x?xml>${field.type!"text"}</#escape>" 
			</#if>
			class="<#escape x as x?xml>${fieldspecificClass!"form-control"}</#escape>" id="<#escape x as x?xml>${field.id}</#escape>" 
			<#if (field.name)??>
				name="<#escape x as x?xml>${field.name}</#escape>"
			</#if>
			<#if (field.value)??>
				<#local fieldVal=field.value>
				<#if (field.dataTransform)?? && field.dataTransform.type == "obfuscated" && (field.dataTransform.obfuscatedKey)??>
					<#if (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
						<#local fieldVal="" />
					<#else>
						<#local fieldVal=(unObfuscateText(field.value, field.dataTransform.obfuscatedKey))!"invalid obfuscation key" />
					</#if>
				</#if>
				value="<#escape x as x?xml>${fieldVal}</#escape>"
			</#if>
			<#if (field.readOnly)?? && field.readOnly=="true">
				 readOnly
			</#if>
			<#if (field.rows)??>
				rows="<#escape x as x?xml>${field.rows}</#escape>"
			</#if>
			></${endTag}>
			
			<#if (field.dataTransform) ?? && (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
				</span>
			</#if>
			
			<#if (field.dataTransform.hiddenByButton)?? && field.dataTransform.hiddenByButton == "true">
				<#local hiddenButtonLabel = field.dataTransform.hiddenButtonLabel!"afficher">
				<input type="button" id="<#escape x as x?xml>${field.dataTransform.id}</#escape>" value="<#escape x as x?xml>${hiddenButtonLabel}</#escape>" data-obfuscatedValue="<#escape x as x?xml>${field.value}</#escape>" data-obfuscatedKey="<#escape x as x?xml>${field.dataTransform.obfuscatedKey}</#escape>" data-obfuscatedTarget="#<#escape x as x?xml>${fieldId}</#escape>"></input>
			</#if>
		</#list>
		
		<input type="submit" value="<#escape x as x?xml>${sendLabel}</#escape>"/>
		</div>
		</form>
	<#else>
		<#if logHelper??>
			<@logHelper.debug "No form Data for this content"/>
		</#if>
	</#if>
</#macro>