<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
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
<%@ include file="adminheader.jsp"%>


If you see this, you have admin privileges.<br><br>

Found User<br><br>

	First Name: <c:out value="${userInfoMap['First Name']}"/><br>
	Last Name: <c:out value="${userInfoMap['Last Name']}"/><br>
	Last Login: <c:out value="${userInfoMap['Last Login']}"/><br>
	Sign Up Date: <c:out value="${userInfoMap['Sign Up Date']}"/><br>
	Number of Logins: <c:out value="${userInfoMap['Number of Logins']}"/><br>


</body>
</html>