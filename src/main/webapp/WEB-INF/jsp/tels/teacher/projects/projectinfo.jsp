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
<%@ include file="styles.jsp"%>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>

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

<script type="text/javascript">

	/**
	 * Toggles the summary div
	 */
	function toggleDetails(){
		var searchDiv = document.getElementById('toggleProjectSummaryCurrent');
		if(searchDiv.style.display=='none'){
			searchDiv.style.display = 'block';
		} else {
			searchDiv.style.display = 'none';
		};
	};
</script>


<title><spring:message code="teacher.pro.projinfo.1"/></title>

</head>

<body class="yui-skin-sam">

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2 id="titleBar" class="headerText"><spring:message code="teacher.pro.projinfo.1"/></h2> 

<!--<div id="projectInfoInstructions">Click any tab below for more information.</div>-->

<div id="projectInfoTabs" class="yui-navset">
    <ul class="yui-nav" >
        <li style="margin-left:4px;"><a href="#tab1"><em><spring:message code="teacher.pro.projinfo.2"/></em></a></li>
        <li style="margin-left:4px;"><a href="#tab2"><em>Lesson Plan & Learning Goals</em></a></li>
        <li style="margin-left:4px;"><a href="#tab3"><em><spring:message code="teacher.pro.projinfo.5"/></em></a></li>
    </ul>            
    <div class="yui-content">
        <div id="tab1">
  			<br/>
            <table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCellUnlinked" colspan="3">${project.name}</td>
							<td class="actions" colspan="7"> 
									<ul>
										<li><a href="<c:url value="../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>">Preview</a></li>
										<li><a href="<c:url value="../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Project Run</a></li>
										<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
											<li><a href="../../author/authorproject.html?projectId=${project.id}">Edit/Author</a></li>
										</sec:accesscontrollist>
										<sec:accesscontrollist domainObject="${project}" hasPermission="16">
											<li><a href="customized/shareproject.html?projectId=${project.id}">Share</a>
										</sec:accesscontrollist>										
										<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
									</ul>
							</tr>
							<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title2" style="width:90px;">Project Family</th>
								<th id="title3" style="width:280px;" >Subject</th>
								<th id="title4" style="width:70px;">Grade Level</th>
								<th id="title5" style="width:105px;">Total Hours</th>
								<th id="title6" style="width:110px;">Computer Hours</th>
								<th id="title7" style="width:72px;">Language</th>
								<th id="title9" style="width:60px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">${project.metadata.language}</td>
								<td class="dataCell">${usageMap[project.id]}</td>
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails()">Hide/Show project details</a>
									<div id="toggleAllCurrent">
									<div id="toggleProjectSummaryCurrent">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">${project.metadata.keywords}</td>
											</tr>

											<tr>
												<th>Tech Details:</th>
												<td>${project.metadata.techDetailsString}</td>
											</tr>
											<tr>
												<th>Lesson Plan:</th>
												<td>${project.metadata.lessonPlan}</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<!-- 
											<tr> 
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											-->
											<tr>
												<th>Contact Info:</th>
												<td>${project.metadata.contact}</td>
											</tr>
											<tr>
												<th>Copy of Project ID:</th>
												<c:choose>
											  		<c:when test="${project.parentProjectId != null}">
											    		<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>${project.parentProjectId}</a></td>
											  		</c:when>
											  		<c:otherwise>
											    		<td>N/A</td>
											  		</c:otherwise>
											 	</c:choose>
											</tr>
										</table>
									</div>
									</div>
								</td>
							</tr>
						</table>
	         
	    </div>       <!--	    End of Tab 1 content-->
        
        <div id="tab2">
            
            <div id="projectInfoProjectTitle">${project.name}</div>
            
            <div style="margin-top:30px; font-weight:bold">Lesson Plan</div>

            <div id="teacherGuideIntro">The Lesson Plan offers feedback on technical or classroom requirements for the step, 
            common misconceptions/mistakes students may encounter in the step, and suggestions for making the project more effective with students.</div>
            
			            
			<div id="projectLessonPlan" style="padding:25px">${project.metadata.lessonPlan}</div>

            <div style="margin-top:30px; font-weight:bold">Learning Goals and Standards</div>
			
			<div id="teacherGuideIntro">This section describes all curriculum standards covered by the project, the
            overall learning goals of the project, and the learning goals of each main Activity in the project.</div>

			<div id="projectStandards" style="padding:25px">${project.metadata.standards}</div>

			<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
				<div id="editInfoLink"><a href="../../author/authorproject.html?projectId=${project.id}">Edit Lesson Plan & Learning Goals</a></div>
			</sec:accesscontrollist>
			
			<!--                
            <table id="teacherGuideTable">
            	<tr class="rowTwo">
            		<td class="column1">step</td>
            		<td>feedback</td>
            	</tr>
            	<tr>
            		<td>[Activity X, Step Y]</td>
            		<td>[sample feedback goes here <br/>Aliquip dolore lobortis blandit esse suscipit duis magna vel odio dolore ipsum ut at magna iusto et ex ex. Eros illum, luptatum, ea nulla, in nostrud eu consectetuer augue accumsan feugiat qui iusto consequat duis vel nulla. Consequat duis, vero elit suscipit, at in feugait dignissim vero zzril blandit, eum lorem, feugiat erat feugait ut vel nonummy zzril accumsan velit dolor in accumsan.
Aliquip suscipit sit amet vero, enim duis minim in, ut duis minim tation. </td>
				</tr>
				<tr>
            		<td>[Activity X, Step Y]</td>
            		<td>[sample feedback goes here</td>
				</tr>
				<tr>
            		<td>[Activity X, Step Y]</td>
            		<td>[sample feedback goes here</td>
				</tr>
			</table>
			-->			
        </div>
        
        <div id="tab3">
            <div id="projectInfoProjectTitle">${project.name}</div>
            
            <div id="teacherGuideIntro">The following people contributed to this WISE project:</div>

            <table id="projectCreditsTable">
	            <tr>
    	        	<td class="col1">Project Last Edited On:</td>
    	        	<td><fmt:formatDate value="${project.metadata.lastEdited}" type="both" dateStyle="short" timeStyle="short" /></td>
            	</tr>
            	<tr> 
            		<td class="col1">Contact</td>
            		<td>${project.metadata.contact}</td>
				</tr>
				<tr>
					<td class="col1">Contributors:</td>
            		<td>${project.metadata.author}</td>
				</tr>
			</table>

			<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
            	<div id="editInfoLink"><a href="../../author/authorproject.html?projectId=${project.id}">edit credits information</a></div>
			</sec:accesscontrollist>
			
        </div>
    </div>
</div>
  
	
</div>

<script type="text/javascript">
    var tabView = new YAHOO.widget.TabView('projectInfoTabs');
    tabView.set('activeIndex', 0);
</script>

</body>
</html>
