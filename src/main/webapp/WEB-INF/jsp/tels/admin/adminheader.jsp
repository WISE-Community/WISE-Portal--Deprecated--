<script type="text/javascript" src="<spring:theme code="superfishsource"/>"></script>
<link rel="stylesheet" type="text/css" href="<spring:theme code="superfishstylesheet"/>" media="screen">

<script type="text/javascript">
	// initialise menu
	$(function(){
	    $('ul.sf-menu').superfish({
	    	autoArrows:  false
	    });
	});
</script>
<div id="header">
	<div id="bannerArea1" class="banner">
		<a href="/webapp/index.html">
	       <img src="<spring:theme code="wiselogonew"/>" alt="WISE Logo" border="0" id="wise-logo" />
	     </a>
		
		<%@ include file="../accountmenu.jsp"%>
	 	
	 	<div class="locationName"><span><spring:message code="header.location.admin"/></span></div>
	 		
	</div>
</div>