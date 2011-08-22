<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
<script>

//alert('hi');
//alert(ChangePasswordParametersValidatorJS.test('hi'))
</script>

</head>
<body style="background:#fff;">

<div class="dialogContent">

	<div id="teacherchangepasswordbox">
		<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
			
		<dl>
			<dt><label for="changestudentpassword"><spring:message code="changepassword.password1" /></label></dt>
	      	<dd><form:password path="passwd1" /></dd>
	
			<dt><label for="changestudentpassword"><spring:message code="changepassword.password2" /></label></dt>
			<dd><form:password path="passwd2" /></dd>
		</dl>
		
		<!-- Support for Spring errors object -->
		<div class="errorMsgNoBg">
			<spring:bind path="changeStudentPasswordParameters.*">
			  <c:forEach var="error" items="${status.errorMessages}">
			    <p><c:out value="${error}"/></p>
			  </c:forEach>
			</spring:bind>
		</div>
		
		<div id="teacherPasswordButtons">
		    <input type="submit" id="teachersave" value="<spring:message code="wise.save-changes"/>" />
    	</div>
	
		</form:form>
	 	
 	</div>
 	
</div>
 	

</body>
</html>