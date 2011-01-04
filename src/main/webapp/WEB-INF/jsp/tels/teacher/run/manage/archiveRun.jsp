<%@ include file="../include.jsp"%>
<!--
  * Copyright (c) 2006 Encore Research Group, University of Toronto
  * 
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
  * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->

<!-- $Id$ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="../../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/effects.js"></script>

<script type="text/javascript">
/**
 * Checks to see if this page was opened from the teacher index page. If so, some extra
 * work on the parent page needs to be done.
 */
function checkB4Submit(){
	//submit the form
	document.getElementById('archiveRun').submit();
};
</script>
    
<title><spring:message code="teacher.run.manage.archiverun.1"/></title>
</head>

<body>

<div id="popUpBoxBoundary">

<div id="largeHeader"><spring:message code="teacher.run.manage.archiverun.2"/></div>

<div id="blockHighlight" >
	<div id="runTitle">${endRunParameters.runName}</div>
</div>			    	

	<div id="popUpNotice1"><spring:message code="teacher.run.manage.archiverun.3"/></div>
	<div id="popUpNotice2"><spring:message code="teacher.run.manage.archiverun.3b"/></div>
	<div id="popUpNotice2"><spring:message code="teacher.run.manage.archiverun.4"/></div>

<!-- Support for Spring errors object -->
<spring:bind path="endRunParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <b>
      <br /><c:out value="${error}"/>
    </b>
  </c:forEach>
</spring:bind>


<form:form method="post" action="archiveRun.html" commandName="endRunParameters" id="archiveRun" autocomplete='off'>
  <div style="visibility:hidden;"><label for="runId"><spring:message code="teacher.run.manage.archiverun.5"/></label>
      <form:input disabled="true" path="runId" id="runId"/>
      <form:errors path="runId" />
  </div>


<div id="responseButtons">
   
<input type="button" onclick='checkB4Submit()' name="archiveproject" value="<spring:message code="teacher.pro.runmanager.21"/>" />

<input type="reset" onclick="javascript:window.close()" name="cancelarchive" value="<spring:message code="navigate.cancel"/>" />

</div>



</form:form>

</div>    <!--    End of popUpTextBoundary -->

</body>
</html>