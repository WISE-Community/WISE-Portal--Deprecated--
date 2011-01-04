<%@ include file="../include.jsp" %>

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

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >

<html lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>

<title>Teacher:Projects - Send Student Message </title>
</head>

<body>

<%@ include file="../headerteacher.jsp"%>

 <a href="runmanager.html"> Back to Project Run Manager </a>
 <h2>STUDENT MESSAGE </h2>

<div id="overviewContent"> 
When should this message be sent?
(click one or more checkboxes below)

<ul>
<li> Message is seen by student(s) the next time they sign into WISE. </li>
<li> Message is seen by student(s) immediately. May take a few minutes to get delivered. </li>
</ul>

<form>
<input type="button" value="Back" />
<input type="button" value="Cancel" />
<input type="button" value="Next" />
</form>

</div>

</body>
</html>

