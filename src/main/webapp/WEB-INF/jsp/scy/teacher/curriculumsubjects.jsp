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

<!-- $Id: index.jsp 888 2007-08-06 23:47:19Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />  

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet" />" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src=".././javascript/general.js"></script> 
</head>

<body>
<h3 align="center"><spring:message code="teacher.curriculum.1a"/></h3>
<p><spring:message code="teacher.curriculum.1b"/></p>
<table style="font-style:bold;font-size:1.1em;">
<tr>
<td> 
<spring:message code="teacher.curriculum.2"/> 
</td>
<td><spring:message code="teacher.curriculum.3"/></td>
<td><spring:message code="teacher.curriculum.4"/></td>
</tr>
<tr>
<td>
<spring:message code="teacher.curriculum.5"/></td>
<td>
<spring:message code="teacher.curriculum.6"/></td>
<td>
<spring:message code="teacher.curriculum.7"/></td>
</tr>
<tr>
<td>
<spring:message code="teacher.curriculum.8"/></td>
<td>
<spring:message code="teacher.curriculum.9"/></td>
<td>
<spring:message code="teacher.curriculum.10"/></td>
</tr>
<tr>
<td>
<spring:message code="teacher.curriculum.11"/></td>
<td>
<spring:message code="teacher.curriculum.12"/></td>
<td>
<spring:message code="teacher.curriculum.13"/></td>
</tr>
<tr>
<td>
<spring:message code="teacher.curriculum.14"/></td>
<td>
<spring:message code="teacher.curriculum.15"/></td>
<td>
<spring:message code="teacher.curriculum.16"/></td>
</tr>
</table> 

<div align="center" style="position:relative;top:30px;">
<spring:message code="teacher.curriculum.17"/>
<br />
<a href="#">
 <img border="0px;" align="center" src="../<spring:theme code="register_save" />" />
</a>

<a href="#">
<img border="0px;" align="center" src="../<spring:theme code="register_cancel" />" />
</a>

</div>



</body>
</html>
