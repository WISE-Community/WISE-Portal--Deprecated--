<%@ include file="include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<title>Preview A Project</title>

<script type="text/javascript" src="./javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="./javascript/tels/jquerycookie.js"></script>
<script type="text/javascript" src="./javascript/tels/browserdetect.js"></script>
<script type="text/javascript" src="./javascript/tels/checkCompatibility.js"></script>
<script type="text/javascript" src="./javascript/pas/utils.js"></script> 
<script type="text/javascript" src="./javascript/tels/general.js"></script>

<script type="text/javascript">
// only alert user about browser comptibility issue once.
if ($.cookie("hasBeenAlertedBrowserCompatibility") != "true") {
	alertBrowserCompatibility();
}
$.cookie("hasBeenAlertedBrowserCompatibility","true");           
</script>
</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain_nousername.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  -->

<h1 id="previewProjectTitle" class="blueText"><spring:message code="previewprojectlist.1"/></h1>

<div id="boxPreviewProject">

<div id="previewProjectHeader2"><spring:message code="previewprojectlist.2"/></div>

<div id="previewProjectDetails">
	<ul>
		<li><spring:message code="previewprojectlist.3"/> <em><spring:message code="previewprojectlist.4"/></em> to load a project in your web browser.
You need to be running a recent web browser (Firefox, Safari, or Internet Explorer) and Javascript must be turned on in your browser settings.</li>
		<li><spring:message code="previewprojectlist.13"/></li>
		<li><spring:message code="previewprojectlist.14"/> <a href="http://www.telscenter.org/confluence/display/WPSD/Classroom+computer+lab+requirements+to+run+SAIL+projects"><spring:message code="previewprojectlist.15"/></a> <spring:message code="previewprojectlist.16"/></li>
	</ul> 
</div>

<table id="previewProjectTable" width="80%" border="1" cellpadding="5" summary="Displays W3 Projects that can be instantly previewed (no user data saved; registration not required).">
   <tr>
    <th><spring:message code="previewprojectlist.21"/></th>
    <th><spring:message code="previewprojectlist.22"/></th>
    <th><spring:message code="previewprojectlist.23"/></th>
    <th><spring:message code="previewprojectlist.24"/></th>
  </tr>
<c:forEach var="project" items="${projectList}">
  <tr>
  <td><c:out value="${project.name}"/></td>
  <td>${project.metadata.subject}</td>
  <td>${project.metadata.gradeRange}</td>
  <td id="previewActionLinks"><a href="<c:url value="previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>">
	       Preview Project
      </a> <br /> 
      <a style="display:none;" href="<c:url value="http://tels-develop.soe.berkeley.edu:8080/maven-jnlp-snapshot/jnlp-tests/jardiff/javachecker-1.1.jnlp"></c:url>">
           Check My Computer's Compatibility with this Project
      </a>
  </td>
  </tr>
</c:forEach>
</table>

</div>   <!--  end of boxNewAccountReg -->

<div style="text-align:center;"><a href="index.html"> <img id="return"
	src="<spring:theme code="return_to_homepage" />"
	onmouseover="swapImage('return', '<spring:theme code="return_to_homepage_roll" />');"
	onmouseout="swapImage('return', '<spring:theme code="return_to_homepage" />');" /></a></div>

</div>
</div>   <!-- end of centered div-->
   
</body>
</html>


