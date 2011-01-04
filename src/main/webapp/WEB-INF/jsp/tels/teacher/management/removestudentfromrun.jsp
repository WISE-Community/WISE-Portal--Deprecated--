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
  * Foundation, Inc., 51 Franklin Street, Fift h Floor, Boston, MA  02110-1301  USA
-->

<!-- $Id$ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../.././javascript/tels/effects.js"></script>

  
<title><spring:message code="teacher.manage.removestudent.1"/></title>
</head>

<body>

<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<div id="popUpBoxBoundary">

<div id="largeHeader"><spring:message code="teacher.manage.removestudent.2"/></div>

<div id="blockHighlight" >
	<table>
		<tr>
			<td id="blockItem"><spring:message code="teacher.manage.removestudent.3A"/></td>
			<td>[full student name]</td>
		</tr>
		<tr>
			<td id="blockItem"><spring:message code="teacher.manage.removestudent.3B"/></td>
			<td>[student's Username]</td>
		</tr>
		<tr>
			<td id="blockItem"><spring:message code="teacher.manage.removestudent.4"/></td>
			<td>[registered period]</td>
		</tr>
		<tr>
			<td id="blockItem"><spring:message code="teacher.manage.removestudent.5"/></td>
			<td>[student code for the project run]</td>
		</tr>
		<tr>
			<td id="blockItem"><spring:message code="teacher.manage.removestudent.6"/></td>
			<td>[project title]</td>
		</tr>
	</table>
</div>			    	

	<div id="popUpNotice1">
		<h5><spring:message code="teacher.manage.removestudent.7"/></h5>
		<h5><spring:message code="teacher.manage.removestudent.8A"/>
				&nbsp;<em><spring:message code="teacher.manage.removestudent.8B"/></em>
				&nbsp;<spring:message code="teacher.manage.removestudent.8C"/></h5>
		<h5><spring:message code="teacher.manage.removestudent.9"/></h5>
    	<div id="popUpNotice2"><spring:message code="teacher.manage.removestudent.10"/></div>
	</div>
	
<!-- Support for Spring errors object -->
<spring:bind path="removeStudentFromRunParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <b>
      <br /><c:out value="${error}"/>
    </b>
  </c:forEach>
</spring:bind>

<form:form method="post" action="removestudentfromrun.html" commandName="removeStudentFromRunParameters" id="removeStudentFromRun" autocomplete='off'>
  <div style="visibility:hidden;"><label for="runId">Run ID:</label>
      <form:input disabled="true" path="runId" id="runId"/>
      <form:errors path="runId" />
  </div>
  <div style="visibility:hidden;"><label for="userId">User ID:</label>
      <form:input disabled="true" path="userId" id="userId"/>
      <form:errors path="userId" />
  </div>

<div id="responseButtons">
    <input type="submit" id="savebutton" value="<spring:message code="teacher.manage.removestudent.11"/>" />
    <input type="submit" onclick="javascript:window.close()" id="cancelbutton" value="<spring:message code="teacher.manage.removestudent.12"/>" />
</div>

</form:form>

</div>
</div>    <!--    End of popUpTextBoundary -->

 
</body>
</html>