<%@ include file="../include.jsp"%>
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

<!-- $Id$ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="application.title" /></title>
</head>

<body>

<div id="teamSelect" class="teamMargin1">

	<div id="teamSelectHeader"><spring:message code="student.selectteam.1"/></div>
	<div id="teamSelectChoices">
		<ul>
			<li><a href="startproject.html?runId=${runId}&bymyself=true" onclick="setTimeout('self.close()', 15000);" id="byMyself"><spring:message code="student.selectteam.2"/></a></li>
      		<li><a href="teamsignin.html?runId=${runId}" id="withTeam"><spring:message code="student.selectteam.3" arguments="${maxWorkgroupSize}" /></a></li>
    	</ul>
	</div>

</div>


</body>
</html>
