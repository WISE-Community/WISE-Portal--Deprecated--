<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
    
<title><spring:message code="wise.change-password" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
<script>
//alert('hi');
//alert(ChangePasswordParametersValidatorJS.test('hi'))
</script>

</head>
<body style="background:#FFFFFF;">

<div class="dialogContent">		

	<div class="sectionHead"><spring:message code="wise.change-password" /></div>

	<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
		<div class="sectionContent">
			<label><spring:message code="changepassword.password1" /></label>
			<form:password path="passwd1"/>
		</div>
		<div class="sectionContent">
			<label><spring:message code="changepassword.password2" /></label>
			<form:password path="passwd2"/>
		</div>
		
		<div class="errorMsgNoBg">
			<!-- Support for Spring errors object -->
			<spring:bind path="changeStudentPasswordParameters.*">
		  		<c:forEach var="error" items="${status.errorMessages}">
		   			 <p><c:out value="${error}"/></p>
		   		</c:forEach>
			</spring:bind>
		</div>

	    <div class="sectionContent"><input type="submit" value="<spring:message code="wise.save-changes"/>"/></div>
	</form:form>
</div>
	
</body>
</html>