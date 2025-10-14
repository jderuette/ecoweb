		</div>
		<img src="${common.buildRootPathAwareURL("org_openCiLife_ecoWeb/images/pageup.svg")}" id="go_to_top" OnClick='window.location.href="#up"' alt="go to top">
		<div id="push"></div>
    </div>
    
    <div id="footer" role="contentinfo">
     <div class="container">
     	<#if block??>
		     <div class="footer_blocks">
		     	<@block.build config.site_footer_category/>
		     </div>
	     </#if>
	     <p class="muted credit">&copy; 2019 | Mixed with <a href="http://getbootstrap.com/">Bootstrap v3.1.1</a> and <a href="https://fontawesome.com/">https://fontawesome.com/</a> | Baked with <a href="http://jbake.org">JBake ${jbake_maven_plugin.version}</a> with recipe from <a href ="https://github.com/OpenCyLife/ecoweb">EcoWeb</a> by <a href="http://www.open-cy.life">open-cy.life</a> and <a href="http://www.webleger.fr">WebLeger</a> | Version ${version} at ${published_date?datetime}</p>
      </div>
    </div>
    
    <#if hookHelper??>
		<@hookHelper.hook "afterFooter" content/>
	</#if>
    
    <!-- Javascript here load faster -->
    <@ecoWeb.buildExternalInjection config.site_script_footer />
  </body>
</html>