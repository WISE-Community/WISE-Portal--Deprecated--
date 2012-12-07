<%@ include file="../../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
    
<title><spring:message code="application.title" /></title>


</head>

<body>
<%@ include file="../adminheader.jsp"%>
<div id="page">
<div id="pageContent" class="contentPanel">

<h5 style="color:#0000CC;"><a href="../index.html">Return to Main Menu</a></h5>

<!-- Support for Spring errors object -->
<div id="regErrorMessages" style="color:#FF8822">
	<spring:bind path="findProjectParameters.*">
 		<c:forEach var="error" items="${status.errorMessages}">
    		<b><br/><c:out value="${error}"/></b>
		</c:forEach>
	</spring:bind>
</div>



<form:form method="post" commandName="findProjectParameters" id="search" autocomplete='off'>
	<form:label path="runId">Enter the run Id: </form:label>
	<form:input path="runId" id="runId"/>
	
	<input type="image" id="save" src="<spring:theme code="register_save" />" 
    	onmouseover="swapSaveImage('save',1)"onmouseout="swapSaveImage('save',0)"   />
</form:form>

</div></div>
</body>
</html>