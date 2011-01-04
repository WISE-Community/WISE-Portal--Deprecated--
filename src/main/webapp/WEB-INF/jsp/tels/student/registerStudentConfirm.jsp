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

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
  
<title><spring:message code="signup.title" /></title>

<script type="text/javascript" src=".././javascript/pas/utils.js"></script>
<script type="text/javascript" src=".././javascript/tels/general.js"></script>
</head>


<body>

<div id="centeredDiv">

<%@ include file="header.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  Oh how I hate IE-->

<h1 id="registrationTitle" class="blueText"><spring:message code="student.registerstudentconfirm.1"/></h1>

<div id="subtitleConfirm">
			<h4><spring:message code="student.registerstudentconfirm.2"/></h4>
			<h4><spring:message code="student.registerstudentconfirm.3"/> <span id="usernameConfirm">${username}</span></h4>
			<ul>
		    <li><b style="color:red;">WRITE DOWN your Username and Password!</b></li>
		    <li>REMEMBER: your Username is your <b>FIRST</b> name, the <b>LETTER</b> of your last name, and your <b>BIRTHDAY</b> numbers. 
				Example:<b>JohnD0322</b> is the Username for John Doe with birthday on 3/22.</li>
			</ul>
</div>

<table id="confirmationButtons" border="0" cellpadding="5" cellspacing="5">
  <tr>
	<td><a href="../login.html" 
    onmouseout="MM_swapImgRestore()" 
    onmouseover="MM_swapImage('Return to Home Page','','../themes/tels/default/images/Go-To-Home-Page-Roll.png',1)">
    <img src="../themes/tels/default/images/Go-To-Home-Page.png" alt="Go to Home Page & Sign In" id="Return to Home Page" /></a></td>
  </tr>
  <tr >
	<td class="text"><spring:message code="student.registerstudentconfirm.9"/></td>
  </tr>
  <tr>
	<td><a href="registerstudent.html" 
    onmouseout="MM_swapImgRestore()" 
    onmouseover="MM_swapImage('Register Another Student','','../themes/tels/default/images/student/Register-Another-Roll.png',1)">
    <img src="../themes/tels/default/images/student/Register-Another.png" alt="Register Another Student" id="Register Another Student"/></a></td>
   </tr>
  <tr>
   	 <td class="text"><spring:message code="student.registerstudentconfirm.8"/></td>
  </tr>
</table>

</div>

</div>  <!-- /* End of the CenteredDiv */-->

</body>

</html>




