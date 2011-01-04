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

<script type="text/javascript" src="../../javascript/general.js"></script>	
<title><spring:message code="forgot.teacher.error.1"/></title>
</head>

<body>

<h2 id="heading"><spring:message code="forgot.teacher.error.2"/></h2>
<h2 id="heading2"><spring:message code="forgot.teacher.error.3"/></h2>

<div id="forgot2"> 
 <ul id="forgotList2">
	<li> <b>${email}${username}</b>, <spring:message code="forgot.teacher.error.4"/></li>
 </ul>
</div>
 
</body>
</html>

