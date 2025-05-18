		</div>
		<img src="${ecoWeb.buildRootPathAwareURL("org_openCiLife_ecoWeb/images/pageup.svg")}" id="go_to_top" OnClick='window.location.href="#up"'>
		<div id="push"></div>
    </div>
    
    <div id="footer">
     <div class="container">
	     <div class="footer_blocks">
			<#list org_openCiLife_blocks?sort_by("order") as block>
				<#assign blockCategory = block.category>
				<#if ( ecoWeb.seq_containsOne(blockCategory, "footer"))>
					<div class="footer_block">
			            <img src="${ecoWeb.buildRootPathAwareURL(block.contentImage)}">
			            <div class="footer_block_text">
			            	${block.body}
			            </div>
			        </div>
				</#if>
			</#list>
	     </div>
	     <p class="muted credit">&copy; 2019 | Mixed with <a href="http://getbootstrap.com/">Bootstrap v3.1.1</a> and <a href="https://fontawesome.com/">https://fontawesome.com/</a> | Baked with <a href="http://jbake.org">JBake ${jbake_maven_plugin.version}</a> with recipe from <a href ="https://github.com/OpenCyLife/ecoweb">EcoWeb</a> by <a href="http://www.open-cy.life">open-cy.life</a> | Version ${version}</p>
      </div>
    </div>
    
    <!-- Javascript here load faster -->
    <@ecoWeb.buildExternalInjection config.site_script_footer />
  </body>
</html>