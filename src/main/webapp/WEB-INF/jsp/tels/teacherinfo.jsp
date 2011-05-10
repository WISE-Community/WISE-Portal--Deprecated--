<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="./javascript/tels/general.js"></script>

<title>Teacher Information</title>

<!-- FOR LATER REFACTOR <script src="../javascript/tels/custom-yui/changegroupdnd.js" type="text/javascript"> </script> -->

<%@ include file="teacher/grading/styles.jsp"%>
<script type="text/javascript" src="./javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/event/event.js"></script>  
<script type="text/javascript" src="./javascript/tels/yui/connection/connection.js"></script> 
<script type="text/javascript" src="./javascript/tels/utils.js"></script>
<script type="text/javascript" src="./javascript/tels/teacher/management/viewmystudents.js"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

</head>

<body class="yui-skin-sam">
<h3>Teacher Information</h3>

<table id="teacherInfoTable" border="2" cellpadding="2" cellspacing="0" align="center">
	<tr>
		<th>Name</th>
		<td><c:out value="${userInfoMap['First Name']}"/>&nbsp;<c:out value="${userInfoMap['Last Name']}"/> </td>
	</tr>
	<tr>
		<th>Username</th>
		<td><c:out value="${userInfoMap['Username']}"/></td>
	</tr>
	<tr>
		<th>Display Name</th>
		<td><c:out value="${userInfoMap['Display Name']}"/></td>
	</tr>
	<tr>
		<th>Email Address</th>
		<td><c:out value="${userInfoMap['Email']}"/></td>
	</tr>
	<tr>
		<th>Signup Date</th>
		<td><fmt:formatDate value="${userInfoMap['Sign Up Date']}" type="both" dateStyle="short" timeStyle="short"/></td>
	</tr>
	<tr>
		<th>City</th>
		<td><c:out value="${userInfoMap['City']}"/></td>
	</tr>
	<tr>
		<th>State</th>
		<td><c:out value="${userInfoMap['State']}"/></td>
	</tr>
	<tr>
		<th>Country</th>
		<td><c:out value="${userInfoMap['Country']}"/></td>
	</tr>
	<tr>
		<th>School Name</th>
		<td><c:out value="${userInfoMap['School Name']}"/></td>
	</tr>
	<tr>
		<th>School Level</th>
		<td><span style="text-transform:lowercase;"><c:out value="${userInfoMap['School Level']}"/></td>
	</tr>
	<tr>
		<th>Curriculum Subjects</th>
		<td><span style="text-transform:lowercase;"><c:out value="${userInfoMap['Curriculum Subjects']}"/></td>
	</tr>
	<tr>
		<th>Number of logins</th>
		<td><c:out value="${userInfoMap['Number of Logins']}"/></td>
	</tr>
	<tr>
		<th>Last Login</th>
		<td><fmt:formatDate value="${userInfoMap['Last Login']}" type="both" dateStyle="short" timeStyle="short"/></td>
	</tr>
</table>
<br>

<a href="#" onclick="javascript:window.close()"><spring:message code="teacher.manage.changeworkgroup.5"/></a>
</body>
</html>