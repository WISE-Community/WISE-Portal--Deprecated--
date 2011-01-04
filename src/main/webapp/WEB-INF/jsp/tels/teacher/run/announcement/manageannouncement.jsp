<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../<spring:theme code="teacherrunstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Manage Announcements</title>

<script type="text/javascript">
	function popup(URL) {
  		window.open(URL, 'View Announcement', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=500,height=400,left = 450,top = 150');
  	}
</script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>
</head>

<body class="yui-skin-sam">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%>

<div id="navigationSubHeader2">Announcements<span id="navigationSubHeader1">Management: My Project Runs</span></div>


<h3>Manage Announcements</h3>

<div id="createNew">
	<input type="button" value="Create New Announcement" onClick="window.location='createannouncement.html?runId=${run.id}'"/>
</div>
<br>
<div id="existingAnnouncements">
	<c:choose>
		<c:when test="${fn:length(run.announcements) > 0}">
			<ul id="announcementList">
				<c:forEach var="announcement" items="${run.announcements}">
					<li>
						${announcement.title}
						<a href="javascript:popup('viewannouncement.html?announcementId=${announcement.id}')">view</a>
						<a href="editannouncement.html?runId=${run.id}&announcementId=${announcement.id}">edit</a>
						<a href="removeannouncement.html?runId=${run.id}&announcementId=${announcement.id}">remove</a>
					</li>
				</c:forEach>
			</ul>
		</c:when>
		<c:otherwise>
			No existing announcements found for this run.
		</c:otherwise>
	</c:choose>
</div>

</div>
</body>
</html>