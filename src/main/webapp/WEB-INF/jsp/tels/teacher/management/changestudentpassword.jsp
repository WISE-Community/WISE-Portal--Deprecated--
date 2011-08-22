<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
<script>
//alert('hi');
//alert(ChangePasswordParametersValidatorJS.test('hi'))
</script>

</head>
<body style="background:#FFFFFF;">

<div class="dialogContent">		

	<div class="dialogSection"><spring:message code="wise.change-password" /></div>

	<div class="errorMsgNoBg">
		<!-- Support for Spring errors object -->
		<spring:bind path="changeStudentPasswordParameters.*">
	  		<c:forEach var="error" items="${status.errorMessages}">
	   			 <p><c:out value="${error}"/></p>
	   		</c:forEach>
		</spring:bind>
	</div>
	<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
		<div>
			<dl>
				<dt><label for="changestudentpassword"><spring:message code="changepassword.password1" /></label></dt>
		      	<dd><form:password path="passwd1" id="teacherchangePasswordField"/></dd>
		
				<dt><label for="changestudentpassword"><spring:message code="changepassword.password2" /></label></dt>
				<dd><form:password path="passwd2" id="teacherchangePasswordField"/></dd>
			</dl>
		</div>

	    <div><input type="submit" class="wisebutton" value="<spring:message code="wise.save-changes"/>"/></div>
	</form:form>
</div>
	
</body>
</html>