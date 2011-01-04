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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<title>Manage All Project Runs</title>

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script language="JavaScript">
	function popup(URL, title) 
  	{window.open(URL, title, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=640,height=480,left = 320,top = 240');}
</script>

</head>

<body>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="centeredDiv">

<%@ include file="adminheader.jsp"%>

<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>

<h4>Number of runs: ${fn:length(runList)}</h4>
<table id="adminManageRunsTable">
  <thead>
    <tr>
      <th>Project Run Id</th>
	  <th>Project Id</th>      
      <th>Project Run Name</th>
      <th>Overview</th>
      <th>Student Information</th>
      <th>Teacher(s)</th>
      <th>Started On</th>
      <th>Ended On</th>
      <th>Management Tasks</th>
    </tr>
  </thead>
  <c:forEach var="run" items="${runList}">
  <tr>
    <td>${run.id}</td>
    <td>
    	${run.project.id}
    	<c:if test="${run.project.parentProjectId != null}">
    	   (copy of ${run.project.parentProjectId})
    	</c:if>
    </td>
    <td>${run.name}</td>
    <td><a href="../teacher/projects/projectinfo.html?projectId=${run.project.id}">See Project Overview</a></td>
    <td>
      <table id="currentRunInfoTable" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.29"/></th>
		  <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.30"/></th>
		  <th class="tableInnerHeaderRight"><spring:message code="teacher.run.myprojectruns.31"/></th>
		</tr>
		<c:set var="totalnumstudentsinrun" value="0" scope="session" />
		<c:forEach var="period" items="${run.periods}">
		  <c:set var="totalnumstudentsinrun" value="${totalnumstudentsinrun + fn:length(period.members)}" scope="session" />		
		  <tr>
		   <td style="width:20%;" class="tableInnerData">${period.name}</td>
		   <td style="width:45%;" class="tableInnerData">${run.runcode}-${period.name}</td>
		   <td style="width:35%;" class="tableInnerDataRight">
		     ${fn:length(period.members)} <spring:message code="teacher.run.myprojectruns.32"/>
		   </td>
		  </tr>
		</c:forEach>
		<tr><td colspan="2">Total number of students:</td><td>${totalnumstudentsinrun} registered</td></tr>
	  </table>
	</td>
    <td><c:forEach var="owner" items="${run.owners}"><a href="../j_acegi_switch_user?j_username=${owner.userDetails.username}">${owner.userDetails.username}</a><br/>(${owner.userDetails.schoolname}, ${owner.userDetails.city}, ${owner.userDetails.state},${owner.userDetails.country})</c:forEach></td>
    <td><fmt:formatDate value="${run.starttime}" type="both" dateStyle="short" timeStyle="short" /></td>
    <td><fmt:formatDate value="${run.endtime}" type="both" dateStyle="short" timeStyle="short" /></td>
    <td><ul>
    <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
    		<li><a href="../teacher/grading/gradework.html?runId=${run.id}&gradingType=step">View/Grade/Export Work</a></li>    		
    </sec:authorize>
    		<li><a href="../teacher/run/shareprojectrun.html?runId=${run.id}">Manage shared teachers</a></li>    		
    		<li><a href="../teacher/management/viewmystudents.html?runId=${run.id}">Manage students</a></li>
    	<c:choose>    	
    		<c:when test="${run.endtime == null}">
    			<li><a href="#" onclick="javascript:popup('../teacher/run/manage/archiveRun.html?runId=${run.id}&runName=${run.name}');">Archive run</a></li>
    		</c:when>
    		<c:otherwise>
    			<li><a href="#" onclick="javascript:popup('../teacher/run/manage/startRun.html?runId=${run.id}&runName=${run.name}');">Un-Archive run</a></li>
    		</c:otherwise>
    	</c:choose>
    	</ul>
    </td>
   </tr>
  </c:forEach>
</table>

			
</div>

</body>
</html>