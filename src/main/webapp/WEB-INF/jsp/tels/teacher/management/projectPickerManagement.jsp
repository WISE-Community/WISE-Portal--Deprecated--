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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />  

<script type="text/javascript" src="../../javascript/tels/general.js"></script>

<title><spring:message code="teacher.manage.projectpicker.1"/></title>

<!--  styles.jsp needs to be separated...right now it has a bunch of files that we don't need -->

<%@ include file="../grading/styles.jsp"%>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="teachermanagementstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script>
// this is for the tabView
    var tabView
	function init() {
   		tabView = new YAHOO.widget.TabView('tabSystem');
		tabView.set('activeIndex', 0);
    }
    YAHOO.util.Event.onDOMReady(init);
</script>

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

<body class="yui-skin-sam">

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<h2 id="titleBar" class="headerText">Select a Project Run</h2>

<div id="tabSystem" class="yui-navset">
<ul class="yui-nav">
  <li id="tabPicker"><a href="Current Runs"><em><spring:message code="teacher.manage.projectpicker.4"/></em></a></li>	
  <li id="tabPicker"><a href="Shared Runs"><em><spring:message code="teacher.manage.projectpicker.5"/></em></a></li>	
  <li id="tabPicker"><a href="Archived Runs"><em><spring:message code="teacher.manage.projectpicker.6"/></em></a></li>	
</ul>
<div class="yui-content" style="background-color:#FFFFFF;">
<div>

<table id="projectPickerTable" style="margin-bottom:20px; margin-top:10px;" summary="project picker screen for management area">
	<thead>
		<tr>
			<th style="width:40%; text-align:left;" scope="col"><spring:message code="teacher.manage.projectpicker.7"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.8"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.9"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.10"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.11"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.12"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.13"/></th>
		</tr>
	</thead>
	<tbody>	
	    <c:forEach var="currentRun" varStatus="currentRunVarStatus" items="${current_run_list}" >
	    <c:choose>
	      <c:when test="${currentRunVarStatus.index % 2 == 1}">
      		<tr class="odd">
	      </c:when>
	      <c:otherwise>
	        <tr>
	      </c:otherwise>
	    </c:choose>
	    <tr>
			<th scope="row" id="projectTitle"><a href="viewmystudents.html?runId=${currentRun.id}">${currentRun.name}</a></th>
			<td><a href="viewmystudents.html?runId=${currentRun.id}">${currentRun.project.id}</a></td>
			<td><a href="viewmystudents.html?runId=${currentRun.id}"><fmt:formatDate value="${currentRun.starttime}" dateStyle="short" /></a></td>
			<td><a href="viewmystudents.html?runId=${currentRun.id}">[ongoing]</a></td>
			<td>
			    <a href="viewmystudents.html?runId=${currentRun.id}">
			    <c:forEach var="period" items="${currentRun.periods}">
			        <c:out value="${period.name}" />,
			    </c:forEach>
				</a>
			</td>
			<td><a href="viewmystudents.html?runId=${currentRun.id}">${currentRun.project.projectInfo.subject}</a></td>
			<td><a href="viewmystudents.html?runId=${currentRun.id}">[pending]</a></td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<div>

<table style="margin-bottom:20px; margin-top:10px;" summary="project picker screen for management area">
	<thead>
		<tr>
			<th style="width:50%;" scope="col"><spring:message code="teacher.manage.projectpicker.14"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.15"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.16"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.17"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.18"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.19"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.20"/></th>
		</tr>
	</thead>
	<tbody>	
		<tr>
			<th scope="row"><a href="#">Sample Title 1</a></th>
			<td>45345</td>
			<td>12/13/07</td>
			<td>ongoing</td>
			<td>1,2,4,6</td>
			<td>Physics</td>
			<td>12</td>
		</tr>
		<tr class="odd">
			<th scope="row"><a href="#">Sample Title 2</a></th>
			<td>45721</td>
			<td>12/22/07</td>
			<td>ongoing</td>
			<td>5,6,7,8</td>
			<td>Biology</td>
			<td>3</td>
		</tr>
	</tbody>
</table>
</div>

<div>

<table style="margin-bottom:20px; margin-top:10px;" summary="project picker screen for management area">
	<thead>
		<tr>
			<th style="width:50%;" scope="col"><spring:message code="teacher.manage.projectpicker.14"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.15"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.16"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.17"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.18"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.19"/></th>
			<th scope="col"><spring:message code="teacher.manage.projectpicker.20"/></th>
		</tr>
	</thead>
	<tbody>	
	    <c:forEach var="archivedRun" varStatus="archivedRunVarStatus" items="${archived_run_list}" >
	    <c:choose>
	      <c:when test="${archivedRunVarStatus.index % 2 == 1}">
      		<tr class="odd">
	      </c:when>
	      <c:otherwise>
	        <tr>
	      </c:otherwise>
	    </c:choose>
		<tr>
            <th scope="row"><a href="viewmystudents.html?runId=${archivedRun.id}">${archivedRun.name}</a></th>		
			<td>${archivedRun.project.id}</td>
			<td><fmt:formatDate value="${archivedRun.starttime}" dateStyle="short" /></td>
			<td><fmt:formatDate value="${archivedRun.endtime}" dateStyle="short" /></td>
			<td>
			    <c:forEach var="period" items="${archivedRun.periods}">
			        <c:out value="${period.name}" />,
			    </c:forEach>
			</td>
			<td>${archivedRun.project.projectInfo.subject}</td>
			<td>[NOT YET IMPLEMENTED]</td>		
		</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</div> <!--  end of yui-content Div -->

</div> <!-- end of tabSystem Div -->

<div id="returnToTopLink">
	<a href="../management/overview.html"><spring:message code="teacher.manage.projectpicker.21"/>&nbsp;<em><spring:message code="teacher.manage.projectpicker.22"/></em></a>
</div>

</div>   <!--End of Centered Div-->

</body>
</html>
