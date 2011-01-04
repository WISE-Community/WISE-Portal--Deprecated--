<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
</head>

<body>
<div>
	<form:form commandName="rooloProjectParameters" method="post" action="createrooloproject.html" id="createrooloprojectform" autocomplete='off'>
		Enter project name: <form:input path="projectname" id="projectname" size="30" maxlength="50"/>
		Enter xml for project content: <form:input path="xml" id="xml" size="50"/><br>
		<input type="submit" value="Create Project"/>
	</form:form>
</div>
</body>
</html>