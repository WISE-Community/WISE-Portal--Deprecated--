<%@ include file="../include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

  
<title><spring:message code="teacher.manage.removestudent.1"/></title>
</head>

<body style="background:#FFF;">

<div class="dialogContent">		

	<div class="sectionHead"><spring:message code="teacher.manage.removestudent.2"/></div>
	
	<div class="sectionContent"><spring:message code="teacher.manage.removestudent.7"/></div>
	
	<div class="sectionContent"><span style="color:red;"><spring:message code="teacher.manage.removestudent.8"/></span></div>
	
	<div class="sectionContent">
		<p class="info"><spring:message code="teacher.manage.removestudent.9"/></p>
		<p class="info"><spring:message code="teacher.manage.removestudent.10"/></p>
	</div>
	
	<!-- Support for Spring errors object -->
	<div class="errorMsgNoBg">
		<spring:bind path="removeStudentFromRunParameters.*">
		  <c:forEach var="error" items="${status.errorMessages}">
		    <p><c:out value="${error}"/></p>
		  </c:forEach>
		</spring:bind>
	</div>

	<form:form method="post" action="removestudentfromrun.html" commandName="removeStudentFromRunParameters" id="removeStudentFromRun" autocomplete='off'>
		 <div style="display:none;"><label for="runId">Run ID:</label>
		     <form:input disabled="true" path="runId" id="runId"/>
		     <form:errors path="runId" />
		 </div>
		 <div style="display:none;"><label for="userId">User ID:</label>
		     <form:input disabled="true" path="userId" id="userId"/>
		     <form:errors path="userId" />
		 </div>
	
		<div class="sectionContent">
		    <input type="submit" value="<spring:message code="teacher.manage.removestudent.11"/>" />
		</div>
	</form:form>

</div>
 
</body>
</html>