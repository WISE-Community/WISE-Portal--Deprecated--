<%@ include file="../../include.jsp" %>

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

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

 <script type="text/javascript" src="../../.././javascript/tels/general.js"></script>
<title>Change Periods</title>
</head>

<body>

<%@ include file="../../headerteacher.jsp"%>

<div id="projectoptions">
   <SELECT NAME="projectnames">
	<option selected> Library Projects [default] </option>
	<option> TELS Projects </option>
	-------
    <option>Biology</option>
    <option>Ecology</option>
    <option>Health</option>
    <option>Environmental Science</option>
	-------
    <option>Chemistry</option>
    <option>Physics</option>
    <option>Astronomy</option>
    <option>Integrated Science</option>
	-------
    <option>Earth Science</option>
    <option>Inquiry Methods</option>
    <option>Mathematics</option>
    <option>Engineering</option>
    <option> TOPICS </option>
    <option> Heat Energy projects </option>
    <option> Disease Investigations </option>
    <option> ...MORE PENDING </option>
    </SELECT>
    
	<label>Grade:</label>
	<select name="gradelevels">
	<option selected> All Grades </option>
	<option> Grades 3-5 </option>
	<option> Grades 6-8 </option>
	<option> Grades 9-12 </option>
	<option> Grades 6-12 </option>
	<option> Grades 12+ </option>
	</select>
	
	<label> Total Time: </label>
	<select name="totaltime">
	<option selected> Any </option>
	<option> 3-5 hours </option>
	<option> 6-8 hours </option>
	<option> 9-10 hours </option>
	<option> 11+ hours </option>
	</select>
	
	<label> Computer Time: </label>
	<select name="computertime">
	<option selected> Any </option>
	<option> 3-5 hours </option>
	<option> 6-8 hours </option>
	<option> 9-10 hours </option>
	<option> 11+ hours </option>
	</select>

	<label> Lang: </label>
	<select name="lang">
	<option selected> English </option>
	<option> Norwegian </option>
	<option> Dutch </option>
	<option> Spanish </option>
	<option> Cantonese </option>
	<option> Korean </option>
	</select>
	
	<form style="display:inline;">
	<input type="button" value="Show" />
	<input type="button" value="Find" /> <br />
	<label> Search for: </label> <input type="text" size="25" /> 
	</form>
	
</div>

</body>
</html>

