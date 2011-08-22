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

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
  
<title><spring:message code="signup.title" /></title>

<script type="text/javascript" src="<spring:theme code="utilssource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
</head>


<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="student.registerstudentconfirm.1"/></div>
				<div class="infoContentBox">
					<div>
						<h4><spring:message code="student.registerstudentconfirm.2"/></h4>
						<h4><spring:message code="student.registerstudentconfirm.3"/> <span class="usernameDisplay">${username}</span></h4>
						<div style="color:#ff563f;"><spring:message code="student.registerstudentconfirm.4"/></div>
					    <div class="instructions"><spring:message code="student.registerstudentconfirm.7"/></div>
					    <div class="instructions"><spring:message code="student.registerstudentconfirm.5"/></div>
					</div>
					<div><spring:message code="student.registerstudentconfirm.8"/></div>
					<div><a href="registerstudent.html" class="wisebutton"><spring:message code="student.registerstudentconfirm.12"/></a></div>
					<div><spring:message code="student.registerstudentconfirm.9"/></div>
					<div><a href="/webapp/login.html" class="wisebutton"><spring:message code="student.registerstudentconfirm.10"/></a></div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>

</html>




