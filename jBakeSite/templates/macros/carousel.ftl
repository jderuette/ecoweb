<#function getComponnentInfo>
	<#return {"componnentVersion":1, "name":"carousel", "description":"Add carousel in content", "recommandedNamespace":"carousel", "require":[{"value":"common", "type":"lib"}, {"value":"carouselData", "type":"contentHeader"}, {"value":"bootstrap 3", "type":"frontLib"}]}>
</#function>

<#function init>
	<#return "" />
</#function>

<#-- build a carousel
param : content : content to search for carousel data
-->
<#macro build content>
	<#if (content.carouselData)??>
		<#assign slides=(content.carouselData.slides)! />
		<#assign carouselId=(content.carouselData.id)!common.randomNumber() />
		<#assign controls=(content.carouselData.controls)! />
		<#assign displayIndicator=(content.carouselData.displayIndicator)!false />
		<#assign carouselStyle=(content.carouselData.style)! />
		
		<div id="<#escape x as x?xml>${carouselId}</#escape>" class="carousel slide" data-ride="carousel" <#if (carouselStyle??)>style="${carouselStyle}"</#if>>
		
		<#if (displayIndicator)>
			<#assign isFirst=true />
			<#assign slideIndex=0 />
			<ol class="carousel-indicators">
			<#list slides as slide>
				<li data-target="#<#escape x as x?xml>${carouselId}</#escape>" data-slide-to="${slideIndex}" <#if (isFirst)>class="active"</#if>></li>
				<#assign slideIndex=slideIndex+1 />
				<#assign isFirst=false/>
			</#list>
			</ol>
		</#if>
		
		<div class="carousel-inner" role="listbox" aria-roledescription="caroussel" aria-readonly="true">
		<#--  ReInit isFirst for real slide (may be altered by indicator loop) -->
		<#assign isFirst=true/>
		
		<#list slides as slide>
			<div class="item carousel-item <#if (isFirst)>active" aria-selected="true"<#else>"</#if> role="option">
			<#assign isFirst=false/>
				<#if (slide.type)="img">
	      			<img class="d-block w-100" src="<#escape x as x?xml>${common.buildRootPathAwareURL(slide.data)}</#escape>" <#if (slide.style)??> style="<#escape x as x?xml>${slide.style}</#escape>"</#if><#if (slide.alt)??> alt="<#escape x as x?xml>${slide.alt}</#escape>"</#if>>
				</#if>
				<#if (slide.caption)??>
					<div class="carousel-caption d-none d-md-block" <#if (slide.captionStyle)??> style="<#escape x as x?xml>${slide.captionStyle}</#escape>" role="presentation"</#if>>
					${slide.caption}
					</div>
				</#if>
			</div>
		</#list>
		</div>
		
		
		<#if (controls??)>
			<a class="left carousel-control" href="#<#escape x as x?xml>${carouselId}</#escape>" role="button" data-slide="prev">
			<span class="icon-prev" aria-hidden="true"></span>
			<span class="sr-only">${controls.previousLabel!"précédent"}</span>
			</a>
			
			<a class="right carousel-control" href="#<#escape x as x?xml>${carouselId}</#escape>" role="button" data-slide="next">
			<span class="icon-next" aria-hidden="true"></span>
			<span class="sr-only">${controls.nextLabel!"suivant"}</span>
			</a>
		</#if>
		</div>
	</#if>
</#macro>