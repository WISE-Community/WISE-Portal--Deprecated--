<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<%@page
	import="org.telscenter.sail.webapp.domain.grading.GradeWorkAggregate"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
</head>
<body>

<h2>Question</h2>
<p>
brainstorm question: ${brainstorm.question.prompt}
<br/></p>

<h2>Response</h2>
<form:form id="postanswerform" commandName="revision" method="post" action="testpostanswer.html?brainstormId=${brainstorm.id}" autocomplete='off'>
<textarea cols="100" rows="10">  </textarea> <br />
<input type="submit" value="post answer" />

</form:form>
</body>
</html>
