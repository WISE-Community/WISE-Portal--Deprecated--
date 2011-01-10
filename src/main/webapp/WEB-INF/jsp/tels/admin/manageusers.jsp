<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="../javascript/tels/general.js"></script>
<script type="text/javascript" src="../javascript/tels/effects.js"></script>
    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>

</head>
<body>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="adminheader.jsp"%>

<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<c:choose>
<c:when test="${fn:length(loggedInTeacherUsernames) > 0 || fn:length(loggedInStudentUsernames) > 0}">

<div>Currently logged in teachers (${fn:length(loggedInTeacherUsernames)}):</div>
<table id="teachersTable" border="2">
	<c:forEach var="username" items="${loggedInTeacherUsernames}">
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${username}');">info</a></td>
		</tr>
	</c:forEach>
</table>
<br/>
<div>Currently logged in students (${fn:length(loggedInStudentUsernames)}):</div>
<table id="studentsTable" border="2">
	<c:forEach var="user" items="${loggedInStudentUsernames}">
	<!--  user[0] = student username
	      user[1] = run object that student is running
	-->
		<tr>
			<td>${user[0]}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${user[0]}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${user[0]}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${user[0]}');">info</a></td>
			<c:if test="${not empty user[1]}">
				<td>${user[1].name} (run ID ${user[1].id})</td>
			</c:if>
		</tr>
	</c:forEach>
</table>

</c:when>

<c:otherwise>

<c:choose>
<c:when test="${studentsWhoLoggedInSinceYesterday != null && teachersWhoLoggedInSinceYesterday != null}">
Teachers who logged in today (${fn:length(teachersWhoLoggedInSinceYesterday)}):
<table id="teachersTable" border="2">
	<c:forEach var="user" items="${teachersWhoLoggedInSinceYesterday}">
		<c:set var="username" value="${user.userDetails.username}"></c:set>
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${username}');">info</a></td>
			<td>${user.userDetails.schoolname},${user.userDetails.city},${user.userDetails.state},${user.userDetails.country}</td>
		</tr>
	</c:forEach>
</table>
<br/><br/>
Students who logged in today (${fn:length(studentsWhoLoggedInSinceYesterday)}):
<table id="teachersTable" border="2">
	<c:forEach var="user" items="${studentsWhoLoggedInSinceYesterday}">
		<c:set var="username" value="${user.userDetails.username}"></c:set>
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${username}');">info</a></td>
		</tr>
	</c:forEach>
</table>
		
</c:when>
<c:otherwise>

<c:choose>
<c:when test="${fn:length(teachers) > 0}">
<div>Total number of teachers: ${fn:length(teachers)}</div>
<table id="teachersTable" border="2">
	<c:forEach var="username" items="${teachers}">
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${username}');">info</a></td>
			<td><a href="#"
				onclick="javascript:popup640('enableaccount.html?username=${username}');">enable/disable</a></td>
		</tr>
	</c:forEach>
</table>
</c:when>
<c:otherwise>
<div>Total number of students: ${fn:length(students)}</div>
<table id="teachersTable" border="2">
	<c:forEach var="username" items="${students}">
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../teacherinfo.html?userName=${username}');">info</a></td>
		</tr>
	</c:forEach>
</table>
</c:otherwise>
</c:choose>

</c:otherwise>
</c:choose>


</c:otherwise>

</c:choose>

</body>
</html>