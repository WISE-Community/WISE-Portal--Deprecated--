<%@ include file="../../include.jsp"%>

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
<%@ include file="../adminheader.jsp"%>

<!-- Support for Spring errors object -->
<spring:bind path="newsItemParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <b>
      <br /><c:out value="${error}"/>
    </b>
  </c:forEach>
</spring:bind>

<br>
<h5>Add a new News Item</h5>

	<form:form method="post" action="addnewsitems.html" commandName="newsItemParameters" id="addnewsitems" autocomplete='off'>
		<dl>
		<dt><label for="titleField"><spring:message code="newsitem.title" /></label></dt>
		<dd><form:input path="title" size="50" id="titleField"/> </dd>
		<dt><label for="newsField"><spring:message code="newsitem.news" /></label></dt>
		<dd><form:textarea rows="10" cols="50" path="news" id="newsField"/></dd>
		</dl>
 	
 	   <input type="image" id="save" src="<spring:theme code="register_save" />" 
    	onmouseover="swapSaveImage('save',1)"onmouseout="swapSaveImage('save',0)"   />

	</form:form>
</body>
</html>