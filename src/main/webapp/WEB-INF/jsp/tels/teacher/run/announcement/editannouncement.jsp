<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../<spring:theme code="teacherrunstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Edit Announcement</title>

<script src="../javascript/tels/general.js" type="text/javascript"> </script>
<script src="../javascript/tels/prototype.js" type="text/javascript"> </script>

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

<spring:bind path="announcementParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <b>
      <br /><c:out value="${error}"/>
    </b>
  </c:forEach>
</spring:bind>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%>

<div id="navigationSubHeader2">Announcements<span id="navigationSubHeader1">Management: My Project Runs</span></div>

<h3>Edit Announcement</h3>
<form:form method="post" action="editannouncement.html" commandName="announcementParameters" id="editannouncement" autocomplete='off'>
	<label for="titleField">Title</label>
	<form:input path="title" id="titleField"/>
	<label for="announcementField">Announcement</label>
	<form:input path="announcement" id="announcementField"/>
	<input type="image" id="save" src="../<spring:theme code="register_save" />" 
    	onmouseover="swapSaveImage('save',1)"onmouseout="swapSaveImage('save',0)"/>
</form:form>

</div>
</body>