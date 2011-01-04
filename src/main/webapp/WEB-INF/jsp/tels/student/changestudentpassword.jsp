<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
<script>

//alert('hi');
//alert(ChangePasswordParametersValidatorJS.test('hi'))
</script>

</head>
<body>


<h1><spring:message code="student.changestudentpassword.1"/></h1>

<div id="errorMessageFormat">
	<!-- Support for Spring errors object -->
	<spring:bind path="changeStudentPasswordParameters.*">
  		<c:forEach var="error" items="${status.errorMessages}">
   			 <br /><c:out value="${error}"/>
   		</c:forEach>
	</spring:bind>
</div>

<div id="popUpWindowTeacherPassword">

	<div id="teacherchangepasswordbox">
	<dl>
		<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
		<dt><label for="changestudentpassword"><spring:message code="changepassword.password1" /></label></dt>
      	<dd><form:password path="passwd1" id="teacherchangePasswordField"/></dd>

		<dt><label for="changestudentpassword"><spring:message code="changepassword.password2" /></label></dt>
		<dd><form:password path="passwd2" id="teacherchangePasswordField"/></dd>
	</dl>
	
    <div id="teacherPasswordButtons">
    
		    <input type="image" id="teachersave" src="../<spring:theme code="register_save" />" 
		    onmouseover="swapImage('teachersave','../<spring:theme code="register_save_roll" />')" 
		    onmouseout="swapImage('teachersave','../../<spring:theme code="register_save" />')"/>
		    
		    <a href="index.html" onclick="javascript:window.close()">
		    <input type="image" id="teachercancel" src="../<spring:theme code="register_cancel" />" 
		    onmouseover="swapImage('teachercancel','../<spring:theme code="register_cancel_roll" />')" 
		    onmouseout="swapImage('teachercancel','../<spring:theme code="register_cancel" />')"
		    /> </a>
    </div>

	</form:form>
	 	
 	</div>
 	
</div>	<!--end of popUpWindowTeacherPassword div-->
 	

</body>
</html>