<%@ include file="../../include.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="teacher.manage.library.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

<script type='text/javascript'>
var isTeacherIndex = true; //global var used by spawned pages (i.e. archive run)
</script>

</head>
    
<body>
<div id="pageWrapper">

	<%@ include file="../headerteacher.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
			
				<div class="panelHeader">
					<spring:message code="teacher.manage.library.title" />
					<span class="pageTitle"><spring:message code="header.location.teacher.management"/></span>
				</div>
				
				<div class="panelContent">
					
					<%@ include file="projectlibrarydisplay.jsp"%>
					
				</div>
					
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="../../footer.jsp"%>
</div>

</body>

</html>