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

<!-- $Id: login.jsp 341 2007-04-26 22:58:44Z hiroki $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherforgotstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="./javascript/tels/general.js"></script>			    
<title><spring:message code="forgot.teacher.error.1"/></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="../student/headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  Oh how I hate IE-->

<h1 id="lostTitleBar" class="blueText"><spring:message code="forgot.teacher.error.2"/></h1>
    	
<br /> 

<h2 class="center"><spring:message code="forgot.teacher.error.3"/></h2>

<!-- Support for Spring errors object -->
<div id="errorMessageFormat">
	<spring:bind path="userDetails.*">
	  <c:forEach var="error" items="${status.errorMessages}">
	      <br /><c:out value="${error}"/>
	  </c:forEach>
	</spring:bind>
</div>

<form id="username" method="post" action="index.html" commandName="userDetails" autocomplete='off'>

<div id="boxSecondary">
 <h2><b><spring:message code="forgot.teacher.index.1"/></b></h2>
 <h5><spring:message code="forgot.teacher.index.2"/><br/><spring:message code="forgot.teacher.index.3"/></h5>
 		<b><label for="send_username" /><spring:message code="login.username" /> </b>
		<input type="text" id="username" name="username" size="30" tabindex="1" /> <br /><br /><br />
		<input type="submit" name="sendpassword" id="sendpassword" value="<spring:message code="forgot.teacher.index.4"/>"  />
 </div>

<h3><spring:message code="forgot.teacher.index.5"/></h3>

<div id="boxSecondary">
	<h2><b><spring:message code="forgot.teacher.index.6"/></b></h2>
	<h5><spring:message code="forgot.teacher.index.7"/> <br/> <spring:message code="forgot.teacher.index.8"/></h5>
	<b><label for="send_usernamepassword" /><spring:message code="lostpassword.teacher.email" /></b>
	<input type="text" name="emailAddress" id="emailAddress" size="40" tabindex="2" /><br /><br /><br />
	<input type="submit" name="sendemailAndPwd" id="sendEmailAndPwd" value="<spring:message code="forgot.teacher.index.9"/>" />
</div>

<h3><spring:message code="forgot.teacher.index.10"/><a href="../../contactwisegeneral.html"><spring:message code="forgot.teacher.index.11"/></a></h3>

 </form>

</div>
</div>

</body>
</html>



