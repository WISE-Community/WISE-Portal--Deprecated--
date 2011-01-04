<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="./javascript/tels/general.js"></script>

<title><spring:message code="teacher.manage.studentinfo.1"/></title>

<!-- FOR LATER REFACTOR <script src="../javascript/tels/custom-yui/changegroupdnd.js" type="text/javascript"> </script> -->

<%@ include file="teacher/grading/styles.jsp"%>
<script type="text/javascript" src="./javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/event/event.js"></script>  
<script type="text/javascript" src="./javascript/tels/yui/connection/connection.js"></script> 
<script type="text/javascript" src="./javascript/tels/utils.js"></script>
<script type="text/javascript" src="./javascript/tels/teacher/management/viewmystudents.js"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="viewmystudentsstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /><link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

</head>

<body class="yui-skin-sam">

<div id="studentInfoNameHeader"><spring:message code="teacher.manage.studentinfo.2"/></div> 

<table id="studentInfoTable">
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.3"/></th>
		<td><c:out value="${userInfoMap['First Name']}"/>&nbsp;<c:out value="${userInfoMap['Last Name']}"/> </td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.4"/></th>
		<td><c:out value="${userInfoMap['username']}"/></td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.5"/></th>
		<td><fmt:formatDate value="${userInfoMap['Last Login']}" type="both" dateStyle="short" timeStyle="short" /></td>
			</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.6"/></th>
		<td><fmt:formatDate value="${userInfoMap['Sign Up Date']}" type="both" dateStyle="short" timeStyle="short" /></td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.7"/></th>
		<td><span style="text-transform:lowercase;"><c:out value="${userInfoMap['Gender']}"/></span></td> 
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.8"/><br/><span class="studentInfoSmallText"><spring:message code="teacher.manage.studentinfo.9"/></span></th>
		<td><fmt:formatDate value="${userInfoMap['Birthday']}" pattern="M/d" /></td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.studentinfo.10"/></th>
		<td><c:out value="${userInfoMap['Number of Logins']}"/></td>
	</tr>
</table>

<div><a href="#" onclick="javascript:window.close()"><spring:message code="teacher.manage.changeworkgroup.5"/></div>

    
 
</body>
</html>