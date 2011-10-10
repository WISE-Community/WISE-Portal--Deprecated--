<%@ include file="../include.jsp"%>
<!-- $Id$ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<title><spring:message code="teacher.run.manage.archiverun.1"/></title>
</head>

<body style="background:#FFF;">

<div class="dialogContent">		

	<div class="sectionHead"><spring:message code="teacher.run.manage.archiverun.2"/>: ${endRunParameters.runName}</div>	    	

	<div class="sectionContent" style="color:red;"><spring:message code="teacher.run.manage.archiverun.3"/></div>
	<div class="sectionContent"><spring:message code="teacher.run.manage.archiverun.3b"/></div>
	<div class="sectionContent">
		<p class="info"><spring:message code="teacher.run.manage.archiverun.4"/></p>
		<p class="info"><spring:message code="teacher.run.manage.archiverun.5"/></p>
	</div>
	
	<!-- Support for Spring errors object -->
	<div class="errorMsgNoBg">
		<!-- Support for Spring errors object -->
		<spring:bind path="endRunParameters.*">
	  		<c:forEach var="error" items="${status.errorMessages}">
	   			 <p><c:out value="${error}"/></p>
	   		</c:forEach>
		</spring:bind>
	</div>
	
	<div class="sectionContent">

		<form:form method="post" action="archiveRun.html" commandName="endRunParameters" id="archiveRun" autocomplete='off'>
		  <div style="display:none;"><label for="runId"><spring:message code="teacher.run.manage.archiverun.5"/></label>
		      <form:input disabled="true" path="runId" id="runId"/>
		      <form:errors path="runId" />
		  </div>
		  
		  <input type="submit" name="archiveproject" value="<spring:message code="teacher.pro.runmanager.21"/>" />
		</form:form>	
	</div>

</div>

</body>
</html>