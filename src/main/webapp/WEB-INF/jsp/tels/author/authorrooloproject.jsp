<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
</head>
<body>
<div>
	<form:form commandName="rooloProjectParameters" method="post" action="authorrooloproject.html" id="authorrooloprojectform" autocomplete='off'>
		Edit project name: <form:input path="projectname" id="projectname" size="30" maxlength="50"/><br><br>
		Edit xml for project content: <form:textarea path="xml" rows="10" cols="110"/><br>
		<h3>If there are major changes, you may wish to edit a file and then upload the file <a href="./uploadxml.html?projectId=${projectId}">here</a></h3>
		<input type="submit" value="Save Project"/>
	</form:form>
</div>
</body>
</html>