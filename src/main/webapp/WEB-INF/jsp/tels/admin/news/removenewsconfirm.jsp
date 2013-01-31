<%@ include file="../../include.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
    
<title><spring:message code="application.title" /></title>

</head>
<body>
<%@ include file="../adminheader.jsp"%>

Confirm removal of News Item: ${newsTitle}
<br><br>
<a href="removenewssuccess.html?newsId=${newsId}">Confirm</a><br><br>
<a href="#" onclick="javascript:window.close()">Cancel</a>

</body>
</html>