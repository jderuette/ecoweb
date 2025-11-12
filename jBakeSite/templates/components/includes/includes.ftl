<#import "../../components/propertiesHelper/propertiesHelper.ftl" as propertiesHelper>

<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"includes", "description":"Include ftl file as import in templates", "recommandedNamespace":"commonInc", "require":[{"value":"propertiesHelper", "type":"lib"}, {"value":"common", "type":"lib"}, {"value":"components", "type":"config", "desc":"with *namespace* attributs"}, {"value":"init()", "type":"componentFunction"}, {"value":"getComponnentInfo()", "type":"componentFunction"}], "uses":[{"value":"logHelper", "type":"lib"}, {"value":"documentationComponent", "type":"contentHeader", "description":"To display component documentation in an other content"}]}>
</#function>

<#function init>
	<#return "" />
</#function>


<#assign allComponentsData = []>
<#macro buildIncludes configPropertyName="components", autoInit=true>
	<#if propertiesHelper.hasConfigValue(configPropertyName)>
		<#local includeText = propertiesHelper.retrieveAndDisplayConfigText(configPropertyName)>
		<#local icludes = propertiesHelper.parseJsonProperty(includeText)>
		<#assign allComponentsJSONData = icludes.data>
		
		<#local addedComponents = []>
		<#list allComponentsJSONData as include>
			<#if (include.namespace)??>
				<#local namespaceAlias = include.namespace>
			<#else>
				<#import "/"+include.file as tmpNamespace>
				<#local componentInfo = tmpNamespace.getComponnentInfo() >
				<#if componentInfo?? && (componentInfo.recommandedNamespace)??>
					<#local namespaceAlias = componentInfo.recommandedNamespace>
				</#if>
			</#if>
			
			<#local fileName = include.file>
			<#assign includeNameSpace = namespaceAlias>
			<#import "/"+include.file as includeNameSpace>
			<@'<#global ${namespaceAlias} = includeNameSpace>'?interpret />
			<#local addedComponents = addedComponents + [namespaceAlias]>
			<#assign allComponentsData = allComponentsData + [{"file":fileName, "namespace":namespaceAlias, "configNamespace":include.namespace!""}]>
		</#list>
		
		<#if logHelper??>
			${logHelper.stackDebugMessage("commonInc.buildIncludes : Component added : " + common.toString(addedComponents))}
		</#if>
		
		<#if logHelper??>
			${logHelper.stackDebugMessage("commonInc.buildIncludes : calling init() on added components")}
		</#if>
		<#list allComponentsData as include>
			<#attempt>
				<#local component = .vars[include.namespace]>
				<#local componentInfo = component.getComponnentInfo() >
				<#if componentInfo?? && (componentInfo.componnentVersion)?? && componentInfo.componnentVersion == 1>
					${component.init()}
				</#if>
			<#recover>
			</#attempt>
		</#list>
	</#if>
</#macro>

<#-- pass content to all componnent wihich need a per content actions. -->
<#function propagateContentChain content>
	<#list allComponentsData as include>
			<#attempt>
				<#local includeNameSpace = .vars[include.namespace]>
				<#local componentInfo = includeNameSpace.getComponnentInfo() >
				<#if componentInfo?? && (componentInfo.componnentVersion)?? && componentInfo.componnentVersion == 1 
					&& (componentInfo.contentChainBefore)?? && componentInfo.contentChainBefore == true>
					<#if logHelper??>
						<#local contentUri = content.uri!"no_uri">
						${logHelper.stackDebugMessage("commonInc.propagateContentChain : INFO : send content to component : " + include.file + " for " + contentUri + ", from : " + .caller_template_name)}
					</#if>
					${includeNameSpace.handleContentChain(content)}
				</#if>
			<#recover>
			</#attempt>
		</#list>
</#function>


<#-- Display informations about all registred components 
   Could be used as a subTemplate -->
<#macro buildAllComponnentsInfos content>
	<#local propName = "components">
	<#if propertiesHelper.hasConfigValue(propName)>
		<#local includProp = propertiesHelper.retrieveAndDisplayConfigText(propName)>
		<#assign icludes = propertiesHelper.parseJsonProperty(includProp)>
		<div class="componnentInfos">
		<h3>Informations extraites de : ${propName} : </h3>
		<pre>${includProp}</pre>
		<#list allComponentsData as include>
			<@buildACompnnentInfos include />
		</#list>
		</div>
	</#if>
</#macro>


<#macro buildComponnentInfos content>
	<#if content.documentationComponent??>
		<#local include = content.documentationComponent>
		<div class="componnentInfo">
		<@buildACompnnentInfos include />
		</div>
	</#if>
</#macro>

<#-- display information abut a component
@param  include : Json of the include-->
<#macro buildACompnnentInfos include>
	<div class="componnentInfo">
	<#if (include.namespace)?? && (.vars[include.namespace])??>
		<#local includeNameSpace = .vars[include.namespace]>
		
			<h2>${include.namespace}</h2>
			<div>file : ${include.file!"non précisé"} </div>
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
			<#local isHandleContent = false>
			<#if (compData.contentChainBefore)?? && compData.contentChainBefore == true>
				<#local isHandleContent = true>
			</#if>
			<div>Traite le contenu en pre-traitement : ${isHandleContent?string('Oui','Non')}</div>
			</div>
		<#recover>
			<div class="error">Erreur lors de l'interpretation de getComponnentInfo() pour ce composant !!</div>
		</#attempt>
	<#else>
		<div class="eror">Erreur lors de l'intégration du composant : ${include.namespace!"__EMPTY__"} n'est pas importé !!</div>
	</#if>
	</div>
</#macro>
