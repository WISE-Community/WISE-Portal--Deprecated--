<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="application.title" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="adminheader.jsp"%>
<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<h3>Runs by activity</h3>
<table id="runStatsTable">
	<thead>
		<tr><td>Name</td><td>Run ID</td><td>Owners</td><td>Number of times run</td></tr>
	</thead>
	<tbody>
		<tr></tr>
		<c:forEach var="run" items="${runs}">
			<tr>
				<td>${run.name}</td>
				<td>${run.id}</td>
				<td>
					<c:forEach var="owner" items="${run.owners}">
						${owner.userDetails.username}&nbsp;
					</c:forEach>
				</td>
				<td>${run.timesRun}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</body>
</html>