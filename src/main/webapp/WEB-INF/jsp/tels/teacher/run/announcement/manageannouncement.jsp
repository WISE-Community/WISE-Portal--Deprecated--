<%@ include file="../include.jsp"%>

<!DOCTYPE html >
<html xml:lang="en" lang="en">
<head>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Manage Announcements</title>

</head>

<body style="background:#FFFFFF;">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="dialogContent">
	<div class="sectionHead">Existing Announcements</div>
	<div id="existingAnnouncements" class="dialogSection">
		<c:choose>
			<c:when test="${fn:length(run.announcements) > 0}">
				<ul id="announcementList">
					<c:forEach var="announcement" items="${run.announcements}">
						<li>
							<span>
								<c:choose>
									<c:when test="${!empty announcement.title}">
										${announcement.title}
									</c:when>
									<c:otherwise>
										[No Title]
									</c:otherwise>
								</c:choose>
							</span> <span class="aDate">(<fmt:formatDate value="${announcement.timestamp}" type="both" timeStyle="short" dateStyle="medium" />)</span>
							<a href="viewannouncement.html?runId=${run.id}&announcementId=${announcement.id}">View</a>
							<a href="editannouncement.html?runId=${run.id}&announcementId=${announcement.id}">Edit</a>
							<a href="removeannouncement.html?runId=${run.id}&announcementId=${announcement.id}">Delete</a>
						</li>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				No announcements found for this run.
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="dialogSection">
		<input type="button" value="New Announcement +" onClick="window.location='createannouncement.html?runId=${run.id}'"/> 
	</div>
	<div class="dialogSection">
		<p class="info">New announcements will be shown to all students in this classroom run the next time they log in to WISE. Students can also review old announcements for each run by clicking the 'View Announcements' button on the student home page.</p>
	</div>

</div>
</body>
</html>