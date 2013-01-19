<%@ include file="../../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
    
<title><spring:message code="application.title" /></title>

<script type="text/javascript">
// does a form POST to find the project by runId.
function findRunByRunId(runId) {
	$("#findProjectRunsFormRunId").val(runId);
	$("#findProjectRunsByIdForm").submit();
};
</script>
</head>
<body>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h5 style="color:#0000CC;"><a href="../index.html">Return to Main Menu</a></h5>

<c:choose>
<c:when test="${fn:length(loggedInTeacherUsernames) > 0 || fn:length(loggedInStudentUsernames) > 0}">

<div>Currently logged in teachers (${fn:length(loggedInTeacherUsernames)}):</div>
<table id="teachersTable" border="2">
    <tr><th>username</th><th colspan="3">Actions</th></tr>
	<c:forEach var="username" items="${loggedInTeacherUsernames}">
		<tr>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacherinfo.html?userName=${username}');">info</a></td>
		</tr>
	</c:forEach>
</table>
<br/>
<div>Currently logged in students (${fn:length(loggedInStudentUsernames)}):</div>
<table id="studentsTable" border="2">
<tr><th>username</th><th colspan="3">Actions</th><th>Run Info (if run is in process)</th></tr>
	<c:forEach var="user" items="${loggedInStudentUsernames}">
	<!--  user[0] = student username
	      user[1] = run object that student is running
	-->
		<tr>
			<td>${user[0]}</td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${user[0]}');">Change
			Password</a></td> 
			<td><a href="../j_acegi_switch_user?j_username=${user[0]}">Log
			in as this user</a></td> 
			<td><a href="#"
				onclick="javascript:popup640('../../teacherinfo.html?userName=${user[0]}');">info</a></td>
			<c:if test="${not empty user[1]}">
				<td>
				<a style="color:blue;text-decoration:underline; cursor:pointer" onclick="findRunByRunId(${user[1].id})">(Run ID: ${user[1].id}) | Run Title: "${user[1].name}"  
				<c:forEach var="owner" items="${user[1].owners}">
					| Teacher: ${owner.userDetails.username}
					${owner.userDetails.schoolname}, ${owner.userDetails.city}, ${owner.userDetails.state},${owner.userDetails.country}
				</c:forEach>
				</a></td>
			</c:if>
		</tr>
	</c:forEach>
</table>

</c:when>

<c:otherwise>

<c:choose>
<c:when test="${studentsWhoLoggedInSinceYesterday != null && teachersWhoLoggedInSinceYesterday != null}">
Teachers who logged in today (${fn:length(teachersWhoLoggedInSinceYesterday)}). New teachers will have a lightpink background.
<table id="teachersTable" border="2">
	<c:forEach var="user" items="${teachersWhoLoggedInSinceYesterday}">
		<c:set var="username" value="${user.userDetails.username}"></c:set>
		<c:choose>
		<c:when test="${user.userDetails.numberOfLogins == 1}">
			<tr style="background-color:lightpink">
		</c:when>
		<c:otherwise>
			<tr>
		</c:otherwise>
		</c:choose>
			<td>${username}</td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacherinfo.html?userName=${username}');">info</a></td>
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
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacherinfo.html?userName=${username}');">info</a></td>
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
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../../teacherinfo.html?userName=${username}');">info</a></td>
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
				onclick="javascript:popup640('../../teacher/management/changepassword.html?userName=${username}');">Change
			Password</a></td>
			<td><a href="../../j_acegi_switch_user?j_username=${username}">Log
			in as this user</a></td>
			<td><a href="#"
				onclick="javascript:popup640('../../studentinfo.html?userName=${username}');">info</a></td>
		</tr>
	</c:forEach>
</table>
</c:otherwise>
</c:choose>

</c:otherwise>
</c:choose>


</c:otherwise>

</c:choose>
<form style="visibility:hidden" id="findProjectRunsByIdForm" method="post" action="../run/findprojectrunsbyrunid.html">
<input type="hidden" id="findProjectRunsFormRunId" name="runId" value=""></input>
</form>
</body>
</html>