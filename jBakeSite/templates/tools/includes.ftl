<#import "../tools/lib/propertiesHelper.ftl" as propertiesHelper>

<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"includes", "description":"Include ftl file as import in templates", "recommandedNamespace":"commonInc", "require":[{"value":"propertiesHelper", "type":"lib"}, {"value":"common", "type":"lib"}, {"value":"components", "type":"config", "desc":"with *namespace* attributs"}, {"value":"init()", "type":"componentFunction"}, {"value":"getComponnentInfo()", "type":"componentFunction"}], "uses":[{"value":"logHelper", "type":"lib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#macro buildIncludes configPropertyName="components", autoInit=true>
	<#if propertiesHelper.hasConfigValue(configPropertyName)>
		<#local includeText = propertiesHelper.retrieveAndDisplayConfigText(configPropertyName)>
		<#if logHelper??>
			${logHelper.stackDebugMessage("commonInc.buildIncludes : Loading component with : " + includeText)}
		</#if>
		<#assign icludes = propertiesHelper.parseJsonProperty(includeText)>
		
		<#local addedComponents = []>
		<#list icludes.data as include>
			<#if (include.namespace)??>
				<#assign fileName = include.file>
				<#assign includeNameSpace = include.namespace>
				<#import "/"+include.file as includeNameSpace>
				<@'<#global ${include.namespace} = includeNameSpace>'?interpret />
				<#local addedComponents = addedComponents + [include.namespace]>
			<#else>
				<#if logHelper??>
					${logHelper.stackDebugMessage("commonInc.buildIncludes : Componnent NOT added (no namespace) : " + fileName)}
				</#if>
			</#if>
		</#list>
		
		<#if logHelper??>
			${logHelper.stackDebugMessage("commonInc.buildIncludes : Componnent added : " + common.toString(addedComponents))}
		</#if>
		
		<#if logHelper??>
				${logHelper.stackDebugMessage("commonInc.buildIncludes : calling init() on added components")}
			</#if>
		<#list icludes.data as include>
			<#attempt>
				<#local includeNameSpace = .vars[include.namespace]>
				<#local componentInfo = includeNameSpace.getComponnentInfo() >
				<#if componentInfo?? && (componentInfo.componnentVersion)?? && componentInfo.componnentVersion == 1>
					${includeNameSpace.init()}
				</#if>
			<#recover>
			</#attempt>
		</#list>
	</#if>
</#macro>

<#macro buildComponnentInfos content>
	<#local propName = "components">
	<#if propertiesHelper.hasConfigValue(propName)>
		<#local includProp = propertiesHelper.retrieveAndDisplayConfigText(propName)>
		<#assign icludes = propertiesHelper.parseJsonProperty(includProp)>
		<div class="componnentInfos">
		<h3>Informations extraites de : ${propName} : </h3>
		<pre>${includProp}</pre>
		<#list icludes.data as include>
			<#local includeNameSpace = .vars[include.namespace]>
			<div class="componnentInfo">
				<h2>${include.namespace}</h2>
				<div>file : ${include.file} </div>
			<#attempt>
				<#local compData = includeNameSpace.getComponnentInfo()>
				<div>Name : ${compData.name}</div>
				<#if (compData.description)??>
					<div>Description : ${compData.description}</div>
				</#if>
				<div>Requière : 
				<#if (compData.require)??>
				<table>
					<theader>
					<tr>
						<th>Type</th>
						<th>Valeur</th>
						<th>Description</th>
					</tr>
					</theader>
					<tr>
					<#list compData.require as requirement>
						<tr>
							<td>
							<#if (requirement.type)??>
								${requirement.type}
							</#if>
							</td>
							<td>
							<#if (requirement.value)??>
								${requirement.value}
							</#if>
							</td>
							<td>
							<#if (requirement.desc)??>
								${requirement.desc}
							</#if>
							</td>
						</tr>							
					</#list>
					</table>
				<#else>
					Aucun pre-requis.
				</#if>
				</div>
				<div>Utilise : 
				<#if (compData.uses)??>
				<table>
					<theader>
					<tr>
						<th>Type</th>
						<th>Valeur</th>
						<th>Description</th>
					</tr>
					</theader>
					<tr>
					<#list compData.uses as uses>
						<tr>
							<td>
							<#if (uses.type)??>
								${uses.type}
							</#if>
							</td>
							<td>
							<#if (uses.value)??>
								${uses.value}
							</#if>
							</td>
							<td>
							<#if (uses.desc)??>
								${uses.desc}
							</#if>
							</td>
						</tr>							
					</#list>
					</table>
				<#else>
					Aucune utilisation d'autre éléments.
				</#if>
				</div>
			<#recover>
				<div>Erreur lors de l'interpretation de getComponnentInfo() pour ce composant !!</div>
			</#attempt>
			</div>
		</#list>
		</div>
	</#if>
</#macro>
