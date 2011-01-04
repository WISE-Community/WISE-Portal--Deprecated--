<%@ include file="../../../include.jsp"%>
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

<!-- $Id: setuprunconfirm.jsp 2647 2010-01-08 22:46:32Z supersciencefish $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="setuprun.confirmation.title" /></title>

<script type="text/javascript" src="../../javascript/pas/utils.js"></script>
<script type="text/javascript" src="../../javascript/tels/rotator.js"></script>
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<div id="navigationSubHeader2">Project Run Setup<span id="navigationSubHeader1">projects</span></div> 

<h1 id="titleBarSetUpRun" class="blueText"><spring:message code="teacher.setup-project-classroom-run" /></h1>

<div id="setUpRunBoxConfirm">

	<div id="stepNumber"><span class="blueText"><spring:message code="teacher.run.setup.48"/></span></div>
	
		<h5><spring:message code="teacher.run.setup.49"/>&nbsp;<a href="myprojectruns.html">My Projects</a>&nbsp;<spring:message code="teacher.run.setup.51"/></h5>
		
		<table id="projectRunConfirmTable" border="1" cellpadding="5" cellspacing="0" >
				<tr>
					<td style="width:14%;"><spring:message code="setuprun.confirmation.run.title" /></td>
					<td style="width:40%;"><strong><c:out value="${run.project.name}" /></strong></td>
					<td class="instructions" style="width:46%;"></td>
				</tr>
				<tr>
					<td style="width:14%;">Project ID:</td>
					<td style="width:40%;"><strong><c:out value="${run.project.id}" /></strong></td>
					<td class="instructions"  style="width:46%;">Every source project has a unique ID number.</td>
				</tr>
				<tr>
					<td><spring:message code="setuprun.confirmation.run.createdtime" /></td>
					<td><strong><c:out value="${run.starttime}" /></strong></td>
					<td class="instructions" ></td>
				</tr>
				<tr>
					<td>Project Run ID:</td>
					<td><strong><c:out value="${run.id}" /></strong></td>
					<td class="instructions" >Each of your project runs also has a unique ID number.</td>
				</tr>
				<tr>
					<td>Access Code:</td>
					<td>
				    	<strong><c:out value="${run.runcode}" /></strong>
				    	&nbsp;<spring:message code="setuprun.confirmation.run.projectcodes.foryourstudentsinperiod" />
						<c:forEach var="period" items="${run.periods}">
				    		<c:out value="${period.name}" /><c:out value="," />
				  		</c:forEach>
				    	<br />
				    </td>
				    <td class="instructions" >
				    	Each Project Run has an individual Access Code that you give to your students.<br/><br/>
				    	Note: Students will manually specify their class period after entering this Access Code.<br/><br/>
				    </td>
				</tr>
			</table>
		
</div>      <!-- end setUpRunBoxConfirm"-->
		
<div id="gotoMyRunsButton" class="center">
	<a href="myprojectruns.html"  	
		onmouseout="MM_swapImgRestore()" 
		onmouseover="MM_swapImage('projectRuns','','../../themes/tels/default/images/teacher/Go-to-My-Proj-Runs-Roll.png',1)">
		<img src="../../themes/tels/default/images/teacher/Go-to-My-Proj-Runs.png" alt="My Project Runs" id="projectRuns" /> </a>
</div>
    	

</div>    <!-- end CenteredDiv" -->

</body>

</html>