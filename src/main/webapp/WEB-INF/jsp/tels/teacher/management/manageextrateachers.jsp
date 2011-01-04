<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>
<script type="text/javascript" src=".././javascript/tels/general.js"></script>
    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
</head>
<body>
<br>
Manage Extra Teachers!
<br>
<br>

<a href="addsharedteacher.html?runId=${run.id}">Add a shared teacher</a>

<br>
Shared Teachers associated with Run:
<br><br>
	
	<c:choose>
		<c:when test="${fn:length(run.sharedOwners) == 0}">
			None
		</c:when>
		<c:otherwise>
			<c:forEach var="owner" items="${run.sharedOwners}">
				<li>${owner.userDetails.firstname} ${owner.userDetails.lastname}
					<a href="editextrateacherroles.html?${run.id}${owner.id}">edit</a>
				</li>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
</body>
</html>