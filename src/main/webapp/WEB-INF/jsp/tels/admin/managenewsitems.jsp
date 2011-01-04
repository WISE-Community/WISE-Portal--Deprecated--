<%@ include file="../include.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script src="../javascript/tels/general.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/prototype.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/effects.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/scriptaculous.js" 		type="text/javascript"> </script>
<script src="../javascript/tels/rotator.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/rotatorT.js" 			type="text/javascript"> </script>

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
</head>
<body>
<%@ include file="adminheader.jsp"%>
<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<h5>Work with News Items</h5>

<br>
<h5><a href="#" onclick="javascript:popup640('addnewsitems.html');">Add a new News Item</a></h5>
<br><br>

<c:choose>
	<c:when test="${fn:length(all_news) > 0}">
		<table id="newsItems" border="2" cellpadding="2" cellspacing="0" align="center">
		<tr>
			<th><h5>Date</h5></th><th><h5>News Title</h5></th><th><h5>News Body</h5></th><th><h5>Actions</h5></th>
		</tr>
		<c:forEach var="news" items="${all_news}">
			<tr>
				<td><fmt:formatDate value="${news.date}" type="both" dateStyle="short" timeStyle="short" /></td>
				<td>${news.title}</td>
				<td>${news.news}</td>
				<td>
					<a href="#" onclick="javascript:popup640('editnewsitem.html?newsId=${news.id}');">Edit</a>
					<a href="#" onclick="javascript:popup640('removenewsconfirm.html?newsId=${news.id}&newsTitle=${news.title}');">Remove</a>
				</td>
			</tr>
		</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
		<h5>No News Items found</h5>
	</c:otherwise>
</c:choose>

</body>
</html>