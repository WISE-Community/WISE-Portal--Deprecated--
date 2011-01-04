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

<!-- $Id: projectlibrary.jsp 2478 2009-09-19 00:36:07Z honchikun@gmail.com $ -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/connection/connection.js"></script>

<script type="text/javascript">
	
	function bookmark(pID){
		var checked = document.getElementById('check_' + pID).checked;
		var callback = {
			success:function(o){alert(o.responseText);},
			failure:function(o){alert('bookmark: failed update to server');}
		};
		YAHOO.util.Connect.asyncRequest('GET', 'bookmark.html?projectId=' + pID + '&checked=' + 
			checked, callback);
	};
	
	function bookmarked(){
		var bookmarked = false;
		<c:forEach var='project' items='${projectList}'>
			var bookmarked = false;
			<c:forEach var='bookmarker' items='${project.bookmarkers}'>
				<c:if test='${bookmarker.id==userId}'>
					bookmarked = true;
				</c:if>
			</c:forEach>
			if(bookmarked){
				document.getElementById('check_${project.id}').checked = true;
			};
		</c:forEach>
	};
	
	function copy(pID, type, name, filename, url, base){
		var escapedName = escape(name);
		var yes = confirm("Copying a project may take some time. If you proceed, please" +
			" do not click the 'make copy' button again. A message will be displayed when" +
			" the copy has completed.");
		if(yes){
			if(type=='LD'){
				var callback = {
					success:function(o){
						var fullPath = o.responseText;
						var portalPath = fullPath.substring(base.length, fullPath.length) + '/' + filename;
						var callback = {
							success:function(o){
								alert('Successfully copied the project\n\n' + name + '\n\nThe project can be found in the View My Projects section.');
							},
							failure:function(o){alert('Project files were copied but the project was not successfully registered in the portal.');},
							scope:this
						};

						YAHOO.util.Connect.asyncRequest('POST', "/webapp/author/authorproject.html", callback, 'command=createProject&parentProjectId='+pID+'&param1=' + portalPath + '&param2=' + escapedName);
					},
					failure:function(o){alert('Could not copy project folder, aborting copy.');},
					scope:this
				};
				
				YAHOO.util.Connect.asyncRequest('POST', '/webapp/author/authorproject.html', callback, 'forward=filemanager&projectId=' + pID + '&command=copyProject&param1=' + url + '&param2=' + base);
			} else {
				var callback = {
					success:function(o){alert(o.responseText);},
					failure:function(o){alert('copy: failed update to server');}
				};
				YAHOO.util.Connect.asyncRequest('GET', 'copyproject.html?projectId=' + pID, callback);
			};
		};
	};
</script>

<script type="text/javascript">

	/**
	 * Toggles the summary div
	 * projectId: id of project whose summary div to toggle
	 */
	function toggleDetails(projectId){
		var searchDiv = document.getElementById('details_'+projectId);
		if(searchDiv.style.display=='none'){
			searchDiv.style.display = 'block';
		} else {
			searchDiv.style.display = 'none';
		};
	};
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

<title><spring:message code="curnitlist.project.library" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Project Library<span id="navigationSubHeader1">projects</span></div> 

<!--<h2 id="titleBar" class="headerText"><spring:message code="curnitlist.tels.project.library" /></h2>-->
 
<div id="libraryHeader">
	<div id="libraryButtons"><a href="#" onclick="toggleDetails()">Show/Hide All Project Details</a></div>
	<div id="libraryResults">Search Results: ${fn:length(projectList) } projects found</div> 
</div>

<div id="libraryInstructions"><br/>To see lesson plans and additional information for a project, click its Title.</div>
  
<c:forEach var="project" items="${projectList}">
	<c:set var="projectName" value="${projectNameMap[project.id]}" />
	<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
	<table id="projectOverviewTable">
		<tr id="row1">
		<td id="titleCell" colspan="3"><a href="projectinfo.html?projectId=${project.id}">${projectName}</a></td>
		<td class="actions" colspan="7"> 
				<ul>
					<li><input type="checkbox" id="check_${project.id}" onclick="javascript:bookmark('${project.id}')"/><label for="check_${project.id}"><a href="#">Bookmark</a></label></li>
					<li><a target=_blank href="<c:url value="../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>">Preview</a></li>
					<li><a href="<c:url value="../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">SET UP PROJECT RUN</a></li>
					<li><a href="#" onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy to <i>My Projects</i></a></li>
					<li><c:if test="${project.projectType=='ROLOO'}"><a href="../vle/vle.html?runId=${project.previewRun.id}&summary=true">Project Summary</a></c:if></li>
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
									<a id="hideShowLink" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}" style="display:none;">
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
										</table>
									</div>									
								</td>
							</tr>
	</table>
	
</c:forEach>	
<script>bookmarked();</script>
</div>
<h5 class="center"><spring:message code="teacher.pro.lib.index.11"/> &nbsp; <a href="languagetranslations.html"><spring:message code="teacher.pro.lib.index.12"/></a></h5>

</body>
</html>
