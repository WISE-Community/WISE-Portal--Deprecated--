<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="application.title" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="adminheader.jsp"%>
<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<h3>Runs run ${period} (${fn:length(runs)} runs)</h3>
<table id="runStatsTable">
	<thead>
		<tr><td>Run ID</td><td>Run Name</td><td>Last Access Time</td><td>Total access count</td><td>Owners (click to login as user)</td><td>Actions</td></tr>
	</thead>
	<tbody>
		<tr></tr>
		<c:forEach var="run" items="${runs}">
			<tr>
				<td>${run.id}</td>
				<td>${run.name}</td>
				<td><fmt:formatDate value="${run.lastRun}" type="both" dateStyle="short" timeStyle="short" /></td>
				<td>${run.timesRun}</td>
				<td>
					<c:forEach var="owner" items="${run.owners}">
						<a href="../j_acegi_switch_user?j_username=${owner.userDetails.username}">${owner.userDetails.username}</a><br/>
						(${owner.userDetails.schoolname}, ${owner.userDetails.city}, ${owner.userDetails.state},${owner.userDetails.country})
					</c:forEach>
				</td>
			    <td>
			    	<ul>
			    		<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
			    		  <li><a href="../teacher/run/shareprojectrun.html?runId=${run.id}">Manage shared teachers</a></li>
			    		  <li><a href="../teacher/management/viewmystudents.html?runId=${run.id}">Manage students</a></li>
			    		</sec:authorize>
			    	</ul>
			    </td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</body>
</html>