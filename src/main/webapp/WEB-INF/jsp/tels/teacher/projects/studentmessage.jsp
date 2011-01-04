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
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>

<title>Teacher:Projects - Send Student Message </title>
</head>

<body>
<%@ include file="../headerteacher.jsp"%>

 <a href="runmanager.html"> Back to Project Run Manager </a>
 <h2>STUDENT MESSAGE </h2>

<div id="overviewContent"> 

<p>Leads back to Project Run Manager for the currentStudent Messages are a convenient way to send an informational update, warning, or project.
commendation to some or all your students. The message will appear as an Alert window the
next time each student signs into WISE.</p>

<b>Examples:</b>
<ul>
<li> Keep up the good work Period 3! Excellent focus. </li>
<li> All Classes: do not forget to sign out early today. Class ends 10 minutes earlier than usual. </li>
<li> Lakisha and John: remember to cite evidence when you write your Notes. Notes w/out supporting evidence will have to be revised! </li>
<li> To whom should this message be sent? (click one or more checkboxes below) </li>
</ul>
<form>
<input type="button" value="Back" />
<input type="button" value="Cancel" />
<input type="button" value="Next" />
</form>

</div>

</body>
</html>

