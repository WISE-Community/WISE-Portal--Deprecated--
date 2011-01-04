<%@ include file="../../include.jsp"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
     
<script type="text/javascript" src="../../javascript/general.js"></script>	

<title><spring:message code="forgot.student.index.1"/></title>
</head>

<body>

<div id="centeredDiv">
    	
<%@ include file="headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h1 id="lostTitleBar" class="blueText"><spring:message code="forgot.student.index.2"/></h1>
    	
<br /> <br /> 
<div align="center">
		<h2><spring:message code="forgot.student.index.3"/></h2> <br/>
		<h1><a href="username.html"><spring:message code="forgot.student.index.4"/></a></h1>
		<p align="center"><spring:message code="forgot.student.index.5"/></p>
		<h1><a href="password.html"><spring:message code="forgot.student.index.6"/></a></h1>
		
		<div id="forgotparagraph">
		<spring:message code="forgot.student.index.7"/><em><spring:message code="forgot.student.index.8"/></em> <spring:message code="forgot.student.index.9"/><em><spring:message code="forgot.student.index.10"/></em> <spring:message code="forgot.student.index.11"/>. </div>


		<div><a href="../../index.html"> <img id="return"
			src="../../<spring:theme code="return_to_homepage" />"
			onmouseover="swapImage('return', '../../<spring:theme code="return_to_homepage_roll" />');"
			onmouseout="swapImage('return', '../../<spring:theme code="return_to_homepage" />');" />
		</a></div>

</div>
</div>

</body>
</html>

