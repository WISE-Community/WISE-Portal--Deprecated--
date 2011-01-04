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

<!-- $Id: login.jsp 341 2007-04-26 22:58:44Z hiroki $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script src="../javascript/tels/general.js" type="text/javascript" > </script>

<title><spring:message code="lostpassword.title" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  Oh how I hate IE-->

<h1 id="lostTitleBar" class="blueText"><spring:message code="selectaccounttype.1"/></h1>
 
 <div id="boxSecondary">
 
	 <div>   
	  	
			<div id="lostSubHeader"><spring:message code="selectaccounttype.2"/></div><br/>
			 
			<a href="student/passwordreminder.html" >
			  <img id="studentAccount" alt="<spring:message code="selectaccounttype.3"/>" 
			  src="../<spring:theme code="create_student_account" />" width="228" height="41"
			  onmouseover="swapImage('studentAccount','../<spring:theme code="create_student_account_rollover" />');" 
			  onmouseout="swapImage('studentAccount','../<spring:theme code="create_student_account" />');" /></a>
			<br/>
			<div style="margin:8px 0 0px 0;"><spring:message code="selectaccounttype.4"/></div>
			<br/>
			<a href="teacher/index.html" > 
			<img id="teacherAccount" alt="<spring:message code="selectaccounttype.5"/>"
			src="../<spring:theme code="create_teacher_account" />" height="46"
			  onmouseover="swapImage('teacherAccount','../<spring:theme code="create_teacher_account_rollover" />');" 
			  onmouseout="swapImage('teacherAccount','../<spring:theme code="create_teacher_account" />');" /></a>
						
			<div id="forgotparagraph"><spring:message code="selectaccounttype.6"/></div>
						
	</div>
	</div>
	
	<div id="returnHomePageButton">
			<a href="../index.html"> <img id="return" alt="<spring:message code="selectaccounttype.7"/>"
			src="../<spring:theme code="return_to_homepage" />"
			onmouseover="swapImage('return', '..//<spring:theme code="return_to_homepage_roll" />');"
			onmouseout="swapImage('return', '../<spring:theme code="return_to_homepage" />');" /></a></div>
</div>
</div>

</body>
</html>
