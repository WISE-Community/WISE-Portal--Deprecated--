<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<%@ include file="adminhead.jsp" %>

</head>
<body>
<%@ include file="adminheader.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="centeredDiv">


<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<h5><c:out value="${message}" /></h5>

<h5>Statistics</h5>
<table border="1">
<tr><td>Teachers</td><td>${fn:length(teachers)}</td></tr>
<tr><td>Students</td><td>${fn:length(students)}</td></tr>
<tr><td>Admins</td><td>${fn:length(admins)}</td></tr>
</table>
<c:choose>
	<c:when test="${fn:length(teachers) > 0}">
		<table id="teachersTable" border="2">
		<h5>Teachers</h5>
			<tr>
				<th>Firstname / Lastname</th>
				<th>Change password</th>
				<th>Login as this user</th>
				<th>User information</th>
			</tr>
			<c:forEach var="teacher" items="${teachers}">
				<tr>
					<td>${teacher.userDetails.firstname} ${teacher.userDetails.lastname}</td>
					<td><a href="#" onclick="javascript:popup640('../teacher/management/changestudentpassword.html?userName=${teacher.userDetails.username}');">Change Password</a></td>
					<td><a href="../j_acegi_switch_user?j_username=${teacher.userDetails.username}">Log in as this user</a></td>
					<td><a href="#" onclick="javascript:popup640('../teacherinfo.html?userName=${teacher.userDetails.username}');">info</a></td>
				</tr>
			</c:forEach>
		</table>
		<br>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${fn:length(students) > 0}">
		<table id="studentsTable" border="2">
		<h5>Students</h5>
			<tr>
				<th>Firstname / Lastname</th>
				<th>Change password</th>
				<th>Login as this user</th>
				<th>User information</th>
			</tr>
			<c:forEach var="student" items="${students}">
				<tr>
					<td>${student.userDetails.firstname} ${student.userDetails.lastname}</td>
					<td><a href="#" onclick="javascript:popup640('../teacher/management/changestudentpassword.html?userName=${student.userDetails.username}');">Change Password</a></td>
					<td><a href="../j_acegi_switch_user?j_username=${student.userDetails.username}">Log in as this user</a></td>
					<td><a href="#" onclick="javascript:popup640('../studentinfo.html?userName=${student.userDetails.username}');">info</a></td>
				</tr>
			</c:forEach>
		</table>
		<br>
	</c:when>
</c:choose>


<c:choose>
	<c:when test="${fn:length(admins) > 0}">
		<table id="administratorsTable" border="2">
		<h5>Administrators</h5>
			<tr>
				<th>Firstname / Lastname</th>
				<th>Change password</th>
				<th>Login as this user</th>
			</tr>
			<c:forEach var="admin" items="${admins}">
				<tr>
					<td>${admin.userDetails.firstname} ${admin.userDetails.lastname}</td>
					<td><a href="#" onclick="javascript:popup640('../teacher/management/changestudentpassword.html?userName=${admin.userDetails.username}');">Change Password</a></td>
					<td><a href="../j_acegi_switch_user?j_username=${admin.userDetails.username}">Log in as this user</a></td>
				</tr>
			</c:forEach>
		</table>
		<br>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${fn:length(other) > 0}">
		<table id="otherTable" border="2">
		<h5>Other</h5>
			<tr>
				<th>Firstname / Lastname</th>
				<th>Change password</th>
				<th>Login as this user</th>
			</tr>
			<c:forEach var="user" items="${other}">
				<tr>
					<td>${user.userDetails.firstname} ${user.userDetails.lastname}</td>
					<td><a href="#" onclick="javascript:popup640('../teacher/management/changestudentpassword.html?userName=${user.userDetails.username}');">Change Password</a></td>
					<td><a href="../j_acegi_switch_user?j_username=${user.userDetails.username}">Log in as this user</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
</c:choose>


</body>
</html>