<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>New Announcements</title>

</head>

<body class="yui-skin-sam">

<div id="centeredDiv" align="center">

<c:forEach var="announcement" items="${announces}">
	<h3>${announcement.title}</h3>
	${announcement.announcement}
	<br><br>
</c:forEach>


</div>
</body>
</html>