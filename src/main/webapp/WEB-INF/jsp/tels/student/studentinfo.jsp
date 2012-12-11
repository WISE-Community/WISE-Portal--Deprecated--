<%@ include file="../include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<title><spring:message code="teacher.manage.studentinfo.1"/></title>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

</head>

<body style="background:#FFFFFF;">
	<div class="dialogContent">

		<div class="sectionHead"><spring:message code="teacher.manage.studentinfo.2"/></div> 
		<div class="dialogSection sectionContent">
			<table style="margin: 0 auto;">
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.3"/></th>
					<td><c:out value="${userInfoMap['First Name']}"/>&nbsp;<c:out value="${userInfoMap['Last Name']}"/> </td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.4"/></th>
					<td><c:out value="${userInfoMap['Username']}"/></td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.5"/></th>
					<td><fmt:formatDate value="${userInfoMap['Last Login']}" type="both" dateStyle="medium" timeStyle="short" /></td>
						</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.6"/></th>
					<td><fmt:formatDate value="${userInfoMap['Sign Up Date']}" type="both" dateStyle="medium" timeStyle="short" /></td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.7"/></th>
					<td><span style="text-transform:lowercase;"><c:out value="${userInfoMap['Gender']}"/></span></td> 
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.8"/></th>
					<td><fmt:formatDate value="${userInfoMap['Birthday']}" pattern="MMM dd" /> (<fmt:formatDate value="${userInfoMap['Birthday']}" pattern="MM/dd" />)</td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.studentinfo.9"/></th>
					<td><c:out value="${userInfoMap['Number of Logins']}"/></td>
				</tr>
			</table>
			<br>
			<table style="margin: 0 auto;">
				<tr>
					<th colspan="2"><u>Run List</u></th>
				</tr>

				<c:forEach var="run" items="${runList}">
					<tr>
						<th>Run Id</th>
						<td><c:out value="${run.id}"></c:out></td>
					</tr>

					<tr>
						<th>Run Name</th>
						<td><c:out value="${run.name}"></c:out></td>
					</tr>

					<tr>
						<th>Run Start Time</th>
						<td><c:out value="${run.starttime}"></c:out></td>
					</tr>

					<c:forEach var="owner" items="${run.owners}">
						<tr>
							<th>Teacher Username</th>
							<td><c:out value="${owner.userDetails.username}"></c:out></td>
						</tr>

						<tr>
							<th>Teacher Email</th>
							<td><c:out value="${owner.userDetails.emailAddress}"></c:out></td>
						</tr>
					</c:forEach>

					<tr>
						<th colspan="2"><hr></hr></th>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
 
</body>
</html>