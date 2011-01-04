<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<%@page
	import="org.telscenter.sail.webapp.domain.grading.GradeWorkAggregate"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript">
	function popup(URL) {
  		window.open(URL, 'PremadeComments', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=800,height=740,left = 450,top = 150');
  	}
</script>
</head>
<body>

<h2>
brainstorm question: </h2>
<p>
${brainstorm.question.prompt}
</p>

<p>
<a href="javascript:popup('testpostanswer.html?brainstormId=${brainstorm.id}')" >CREATE A RESPONSE </a>
</p>

<p>
number of brainstorm answers: ${fn:length(brainstorm.answers)}
<br/></p>

<c:forEach var="answer" varStatus="answerStatus" items="${brainstorm.answers}">
<b>answer # ${answerStatus.index + 1}</b>
<br/>
number of revisions for this answer: ${fn:length(answer.revisions)}
<c:forEach var="revision" varStatus="revisionStatus" items="${answer.revisions}">
<br/>
revision # ${revisionStatus.index + 1}
<br/>
posted on: ${revision.timestamp}
<br/>
body: ${revision.body}
</c:forEach>
<br/><br/>

number of comments for this answer: ${fn:length(answer.comments)}
<c:forEach var="comment" varStatus="commentStatus" items="${answer.comments}">
<br/>
comment # ${commentStatus.index + 1}
<br/>
posted on: ${comment.timestamp}
<br/>
body: ${comment.body}
</c:forEach>
</c:forEach>
</body>
</html>
