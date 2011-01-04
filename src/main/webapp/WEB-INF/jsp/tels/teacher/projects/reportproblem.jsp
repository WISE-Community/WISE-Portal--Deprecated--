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

<title><spring:message code="teacher.pro.reportproblem.1"/></title>

</head>

<body>
<%@ include file="../headerteacher.jsp"%>

 <a href="runmanager.html"><spring:message code="teacher.pro.reportproblem.2"/></a>
 <h2><spring:message code="teacher.pro.reportproblem.3"/></h2>

<div id="overviewContent"> 
<form>
<label><spring:message code="teacher.pro.reportproblem.4"/></label> <br />
<label><spring:message code="teacher.pro.reportproblem.5"/></label> <br />
<label><spring:message code="teacher.pro.reportproblem.6"/></label> <br />
<label><spring:message code="teacher.pro.reportproblem.7"/></label> 
<select> 
<option> <spring:message code="teacher.pro.reportproblem.8"/></option>
<option> <spring:message code="teacher.pro.reportproblem.9"/></option>
<option> <spring:message code="teacher.pro.reportproblem.10"/></option>
<option> <spring:message code="teacher.pro.reportproblem.11"/></option>
<option> <spring:message code="teacher.pro.reportproblem.12"/></option>
<option> <spring:message code="teacher.pro.reportproblem.13"/></option>
<option> <spring:message code="teacher.pro.reportproblem.14"/></option>
<option> <spring:message code="teacher.pro.reportproblem.15"/></option>
<option> <spring:message code="teacher.pro.reportproblem.16"/></option>
<option> <spring:message code="teacher.pro.reportproblem.17"/></option>
<option> <spring:message code="teacher.pro.reportproblem.18"/></option>
</select>
<br />
<label><spring:message code="teacher.pro.reportproblem.19"/></label> 
<select> 
<option> Windows Vista </option>
<option> All other Windows </option>
<option> Mac OS X </option>
<option> Mac OS 9 or older </option>
<option> Linus </option>
<option> Other/Unknown </option>
</select>
<br />
<label> Web Browser: </label> 
<select> 
<option> Firefox/Mozilla </option>
<option> Internet Explorer </option>
<option> Safari </option>
<option> Netscape 4.0 or older </option>
<option> Opera </option>
<option> Other </option>
</select>
<br />
<label><spring:message code="teacher.pro.reportproblem.20"/></label> <input type="text" size="100" /> <br />
<label><spring:message code="teacher.pro.reportproblem.21"/></label> <br />
<textarea cols="100" rows="10"> specify message </textarea> <br />
<ul>
<li><spring:message code="teacher.pro.reportproblem.22/></li>

<li><spring:message code="teacher.pro.reportproblem.23"/></li>

<li><spring:message code="teacher.pro.reportproblem.24"/>
</li>
</ul>

<input type="button" value="<spring:message code="teacher.pro.reportproblem.25"/>" />
<input type="submit" value="<spring:message code="teacher.pro.reportproblem.26"/>" />

</form>

<a href="runmanager.html"><spring:message code="teacher.pro.reportproblem.27"/></a>

</div>

</body>
</html>

