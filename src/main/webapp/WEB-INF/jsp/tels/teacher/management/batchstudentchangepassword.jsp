<%@ include file="include.jsp"%>

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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
  
<title><spring:message code="run.list" /></title>

<script type="text/javascript" src="../../javascript/tels/general.js"></script>    

<script language="JavaScript">

function popup(URL, title) {
  window.open(URL, title, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=300,height=300,left = 570,top = 300');
}
</script>

</head>

<body>

<div id="popUpWindowViewStudents">

<h2><spring:message code="teacher.manage.batchpassword.1"/><br/><spring:message code="teacher.manage.batchpassword.2"/></h2>

<h5><spring:message code="teacher.manage.batchpassword.3"/>&nbsp;<em><spring:message code="teacher.manage.batchpassword.4"/></em>&nbsp;<spring:message code="teacher.manage.batchpassword.5"/><br/><spring:message code="teacher.manage.batchpassword.6"/></h5>

<div id="errorMessage">
		<!-- Support for Spring errors object -->
		<spring:bind path="batchStudentChangePasswordParameters.*">
		  <c:forEach var="error" items="${status.errorMessages}">
		    <br /><c:out value="${error}"/>
		    </c:forEach>
		</spring:bind>
</div>

<div id="studentchangepasswordbox">

	<form:form method="post" action="batchstudentchangepassword.html" 
	commandName="batchStudentChangePasswordParameters" id="batchstudentchangepassword" autocomplete='off'>

<dl>
	<dt><label for="batchstudentchangepassword"><spring:message code="teacher.manage.batchpassword.7"/></label></dt>
    <dd><form:password path="passwd1" size="30" id="batchstudentchangepassword"/></dd>

	<dt><label for="batchstudentchangepassword"><spring:message code="teacher.manage.batchpassword.8"/></label></dt>
	<dd><form:password path="passwd2" size="30" id="batchstudentchangepassword"/></dd>
</dl>

    <div id="saveCancelButtons">
    
   <input id="savePasswordButton" type="image" src="../../<spring:theme code="register_save" />" 
    onmouseover="swapImage('savePasswordButton','../../<spring:theme code="register_save_roll" />');" 
    onmouseout="swapImage('savePasswordButton','../../<spring:theme code="register_save"/>');" />
    
    <a href="index.html" onclick="javascript:window.close()">
    	<input type="image" id="cancelPasswordButton" src="../../<spring:theme code="register_cancel" />" 
    	onmouseover="swapImage('cancelPasswordButton','../../<spring:theme code="register_cancel_roll" />');" 
    	onmouseout="swapImage('cancelPasswordButton','../../<spring:theme code="register_cancel"/>');" /> </a>
    	
    </div>

</form:form>

</div>


</div>

</body>
</html>