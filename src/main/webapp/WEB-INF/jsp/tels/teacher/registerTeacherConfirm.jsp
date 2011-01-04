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
<link href="../<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
  
<title><spring:message code="signup.title" /></title>

<script type="text/javascript" src=".././javascript/pas/utils.js"></script>
<script type="text/javascript" src=".././javascript/tels/general.js"></script>
</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain.jsp"%>

<div style="text-align:center;">
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h1 id="registrationTitle" class="blueText"><spring:message code="teacher.registerteacher.1"/></h1>

<div id="subtitleConfirm">
			<h4><spring:message code="teacher.registerconfirm.1"/></h4>
			<h4><spring:message code="teacher.registerconfirm.2"/>&nbsp;<span><input disabled id="usernameConfirm" name="username" value="${username}"/></span></h4>
			
			<ul>
		    <li><spring:message code="teacher.registerconfirm.3"/></li>
		    <li><spring:message code="teacher.registerconfirm.4"/></li>
		    <li><spring:message code="teacher.registerconfirm.5"/></li>
			</ul>
			
			<h5><spring:message code="teacher.registerconfirm.9"/><input disabled id="userClassnameConfirm" name="" value="${displayname}"/><a href="management/updatemyaccountinfo.html" style="margin-left:10px;"><spring:message code="teacher.registerconfirm.10"/></a></h5>
			
</div>

<div class="center">
  <a href="../index.html" 
    onmouseout="MM_swapImgRestore()" 
    onmouseover="MM_swapImage('Return to Home Page','','../themes/tels/default/images/Go-To-Home-Page-Roll.png',1)">
    <img src="../themes/tels/default/images/Go-To-Home-Page.png" alt="Go to Home Page & Sign In" width="161" height="52"  
    id="Return to Home Page" /></a>
 </div>

<div id="buttonText1">
	<spring:message code="teacher.registerconfirm.6"/>&nbsp;<em><spring:message code="teacher.registerconfirm.7"/></em> <spring:message code="teacher.registerconfirm.8"/>
</div>

</div>
</div>  <!-- /* End of the CenteredDiv */-->

</body>

</html>




