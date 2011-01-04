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

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherhelpstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
  
<script type="text/javascript" src="../javascript/general.js"></script> 

<title><spring:message code="teacher.help.contactwise.1"/></title>
</head>

<body>

<div id="overviewContent">
<h3><spring:message code="teacher.help.contactwise.2"/></h3>
<p><spring:message code="teacher.help.contactwise.3"/></p>
<p><spring:message code="teacher.help.contactwise.4"/></p>

<form>
<label> <spring:message code="teacher.help.contactwise.5"/> </label> <input type="text" size="100" /><br />
<label> <spring:message code="teacher.help.contactwise.6"/> </label> <input type="text" size="100" /><br />
<label> <spring:message code="teacher.help.contactwise.7"/> </label> 
<select> 
<option> <spring:message code="teacher.help.contactwise.8"/></option>
<option> <spring:message code="teacher.help.contactwise.9"/> </option>
<option> <spring:message code="teacher.help.contactwise.10"/></option>
<option> <spring:message code="teacher.help.contactwise.11"/> </option>
<option> <spring:message code="teacher.help.contactwise.12"/> </option>
<option> <spring:message code="teacher.help.contactwise.13"/></option>
<option> <spring:message code="teacher.help.contactwise.14"/></option>
<option> <spring:message code="teacher.help.contactwise.15"/></option>
<option> <spring:message code="teacher.help.contactwise.16"/></option>
<option> <spring:message code="teacher.help.contactwise.17"/></option>
</select>
<br />
<label> <spring:message code="teacher.help.contactwise.18"/></label> 
<select> 
<option> Mac OS 9 </option>
<option> Mac OS X Tiger </option>
<option> Mac OS X Leopard</option>
<option> Windows 98/2000 </option>
<option> Windows Vista </option>
<option> Linux </option>
<option> Other </option>
</select>

<br />
<label> Web Browser: </label> 
<select> 
<option> Internet Explorer (Windows) </option>
<option> Firefox (Windows) </option>
<option> Firefox (Mac) </option>
<option> Safari (Windows) </option>
<option> Safari (Macintosh) </option>
</select>
<br />
<label> <spring:message code="teacher.help.contactwise.19"/> </label> <input type="text" size="100" /> <br />
<label> <spring:message code="teacher.help.contactwise.20"/> </label> <br />
<textarea cols="100" rows="10">  </textarea> <br />
<input type="submit" value="Send Email to WISE" />
<input type="button" value="Cancel" />

</form>

</div>


</body>
</html>
