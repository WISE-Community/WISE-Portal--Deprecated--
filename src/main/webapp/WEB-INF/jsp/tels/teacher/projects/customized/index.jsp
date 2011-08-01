<%@ include file="../../include.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="teacher.pro.custom.index.1"/></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

</head>

<body>

<%@ include file="../../headerteacher.jsp"%> 

<div id="page">
	<div class="pageContent">
		<div class="contentPanel">
			<div class="panelHeader"><spring:message code="teacher.pro.custom.index.1"/></div>
			<div class="panelContent">
				
			<%@ include file="projecttabs.jsp"%>
			
			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
</div>   <!-- End of page -->

<%@ include file="../../../footer.jsp"%>

</body>
</html>
