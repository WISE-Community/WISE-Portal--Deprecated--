<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="studenthomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<title>View Announcements</title>

<%@ include file="styles.jsp"%>

<script src=".././javascript/tels/general.js" type="text/javascript" > </script>
<script src=".././javascript/tels/prototype.js" type="text/javascript" > </script>
<script src=".././javascript/tels/effects.js" type="text/javascript" > </script>

<script>
var getNewAnnouncements = function(dialog){
    	var newAnnouncement = false;
    	var announcementHTML = "";
    	<c:forEach var="runInfo" items="${current_run_list}">
    		<c:forEach var="announcement" items="${runInfo.run.announcements}">
    			<c:if test="${user.userDetails.lastLoginTime < announcement.timestamp || user.userDetails.lastLoginTime == null}">
    				newAnnouncement = true;
    				announcementHTML = announcementHTML + "<tr><td align='center'><h3>${announcement.title} (posted on:" + "${announcement.timestamp})</h3>" + "${announcement.announcement}<br><br></td></tr>";
   			</c:if>
    		</c:forEach>
    	</c:forEach>
    	
    	if(newAnnouncement){
    		document.getElementById('announcementsTable').innerHTML =  announcementHTML;
    		dialog.show();
    	};
    };
</script>

</head>

<body class="yui-skin-sam">

<div id="centeredDiv">

<%@ include file="./studentHeader.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<a href="index.html?showNewAnnouncements=false"><b>Go to Student Home Page</b></a>

<c:forEach var="run" items="${runs}">

<div id="studentAnnouncementHeader">Student Announcements for <i>${run.name}</i></div>

<div id="existingAnnouncements">
	<c:choose>
		<c:when test="${fn:length(run.announcements) > 0}">
			<c:forEach var="announcement" items="${run.announcements}">
			    <c:choose>
			    <c:when test="${user.userDetails.lastLoginTime < announcement.timestamp || user.userDetails.lastLoginTime == null}">
    				
    				<table id="announcementTable">
    					<tr class='newAnnouncement'>
    						<td class="col1">${announcement.title}</td>
    						<td class="col2"><fmt:formatDate value="${announcement.timestamp}" type="both" dateStyle="short" timeStyle="short" /></td>
    						<td class="col3">${announcement.announcement}</td>
    					</tr>
    				</table>
   			    </c:when>
   			    <c:otherwise>
				<table id="announcementTable">
    					<tr class='existingAnnouncement'>
    						<td class="col1">${announcement.title}</td>
    						<td class="col2"><fmt:formatDate value="${announcement.timestamp}" type="both" dateStyle="short" timeStyle="short" /></td>
    						<td class="col3">${announcement.announcement}</td>
    					</tr>
    				</table>
    			</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			This project currently has no announcements.
		</c:otherwise>
	</c:choose>
</div>
</c:forEach>

<br/>
<br/>
<a href="index.html?showNewAnnouncements=false"><b>Go to Student Home Page</b></a>

</div>

</body>
</html>