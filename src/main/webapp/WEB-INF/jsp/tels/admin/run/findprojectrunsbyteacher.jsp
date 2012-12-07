<%@ include file="../../include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

    
<title><spring:message code="admin.manage.runs.title" /></title>

</head>

<body onload="document.getElementById('userName').focus()">
<div id="pageWrapper">

	<%@ include file="../../headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="contentPanel">
<h5 style="color:#0000CC;"><a href="../index.html">Return to Main Menu</a></h5>
			
				<div class="panelHeader"><spring:message code="admin.manage.runs.findbyteacher.1" />
					<span class="pageTitle"><spring:message code="header.location.admin"/></span>
				</div>
				
				<div class="panelContent">

					<!-- Support for Spring errors object -->
					<div id="regErrorMessages" style="color:#FF8822">
						<spring:bind path="findProjectParameters.*">
					 		<c:forEach var="error" items="${status.errorMessages}">
					    		<b><br/><c:out value="${error}"/></b>
							</c:forEach>
						</spring:bind>
					</div>



					<form:form method="post" commandName="findProjectParameters" id="search" autocomplete='off'>
						<form:label path="userName"><spring:message code="admin.manage.runs.findbyteacher.2" /> </form:label>
						<form:input path="userName" id="userName" />
						
						<input type="submit" id="save" value="Submit" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../footer.jsp"%>
</div>

</body>
</html>