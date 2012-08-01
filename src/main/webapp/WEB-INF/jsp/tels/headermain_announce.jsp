<div id="header">
	<div id="bannerArea1" class="banner">
		<div class="announce">
			<spring:htmlEscape defaultHtmlEscape="false">
				<spring:escapeBody htmlEscape="false">
					<spring:message code="home.announce.newurl" />
				</spring:escapeBody>
			</spring:htmlEscape>
		</div>
		<img class="announceIcon" src="/webapp/themes/tels/default/images/icons/marker.png" alt="announcement" />
		<a id="name" href="/webapp/" title="WISE Homepage">WISE
			<!-- <img src="<spring:theme code="wiselogonew"/>" alt="WISE Logo" border="0" id="wise-logo" />  -->
		</a>
		
		<%@ include file="accountmenu.jsp"%>
	 		
	</div>
</div>