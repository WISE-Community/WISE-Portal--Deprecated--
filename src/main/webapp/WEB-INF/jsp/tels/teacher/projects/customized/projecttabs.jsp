<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerydatatables.css"/>" media="screen" rel="stylesheet"  type="text/css" />
<script type="text/javascript" src="<spring:theme code="jquerydatatables.js"/>"></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Page-specific script -->

<script type="text/javascript">

	$(function() {
		$( "#projectInfoTabs" ).tabs({ selected: 2 });
	});
	
	$(document).ready(function() {
		$('#customProjects, #sharedProjects').dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 5,
			"aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
			"bSort": false,
			"sDom":'<"top"lfip<"clear">>rt<"bottom"ip><"clear">'
		});
	});
	
	// un-bookmarks the specified project. pID=projectID of project to remove bookmark
	function unbookmark(pID){
		var callback = {
			success:function(o){
				alert(o.responseText);
				document.getElementById('bookmarked_' + pID).parentNode.removeChild(document.getElementById('bookmarked_' + pID));
			},
			failure:function(o){alert('failed update to server');}
		};
		YAHOO.util.Connect.asyncRequest('GET', '../bookmark.html?projectId=' + pID + '&checked=' + 
			false, callback);
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
								alert('Successfully copied the project\n\n' + name + '\n\nThe copy can be found in the View My Projects section. If you are already on the View My Projects page, please refresh the page.');
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
	
	function changePublic(id){
		var callback = {
			success:function(o){alert(o.responseText);},
			failure:function(o){alert('failed update of public access');}
		};

		YAHOO.util.Connect.asyncRequest('GET', 'public.html?projectId=' + id + '&checked=' + document.getElementById('public_'+id).checked, callback);
	};

	function minifyProject(id){
		var callback= {
				success:function(o){alert(o.responseText);},
				failure:function(o){alert('Unable to minify project file, please clean up any old node references and make sure that all node content is in valid JSON format.');},
				scope:this
		};

		YAHOO.util.Connect.asyncRequest('GET', '../minifyproject.html?projectId=' + id, callback);
	};
</script>

<div id="projectInfoTabs" class="panelTabs">
			    
    <ul>
        <!-- <li><a href="#tab5"><spring:message code="teacher.pro.custom.index.13"/></a></li>  
        <li><a href="#tab4"><spring:message code="teacher.pro.custom.index.14"/></a></li> -->
        <li><a href="#tab3"><spring:message code="teacher.pro.custom.index.12B"/></a></li>
        <li><a href="#tab2"><spring:message code="teacher.pro.custom.index.12A"/></a></li>
        <li><a href="#tab1"><spring:message code="teacher.pro.custom.index.12"/></a></li>
    </ul>

	<div id="tab1"> <!-- custom projects tab -->
					
		<!-- <table id="customProjectsButtons">
			<tr>
				<td><a href="/webapp/author/authorproject.html?command=launchAuthoring&param1=createProject">Create New Project<br/>using Author Tool</a></td>
				<c:if test="${fn:length(currentOwnedProjectsList) > 0}">
					<td><a href="#" onclick="toggleProjectSummaryAll()">Hide/Show All<br/> Project Details Below</a></td>
				</c:if>
				
			</tr>
		</table> -->
		
		<div class="ui-state-highlight ui-corner-all" style="margin:0 auto 1em;"> 
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			You own the projects listed below. To see projects shared with you by other WISE users, click the "Shared" link above. To review projects you have bookmarked, click the "Bookmarked" link above. To manage WISE projects running in your classrooms, go to <a href="/webapp/teacher/run/myprojectruns.html">My Project Runs</a> in the <a href="/webapp/teacher/management/overview.html">Management</a> section.</p>
		</div>
				
		<c:choose>
			<c:when test="${fn:length(currentOwnedProjectsList) > 0}">
				<table id="customProjects" class="projectTable">
					<thead>
						<tr>
							<th class="tableHeaderMain">Custom Projects (${fn:length(currentOwnedProjectsList)})</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="project" items="${currentOwnedProjectsList}">
							<c:set var="projectName" value="${projectNameMap[project.id]}" />
							<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
							<tr class="projectRow">
								<td>
									<div class="projectBox">
										<table class="projectOverviewTable">
											<tr>
												<td colspan="6" class="projectTitle">
													<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
												</td>
												
												<td colspan="2" style="text-align:right;">
													<div class="projectDetailsLink"><a href="../projectinfo.html?projectId=${project.id}">More Details/Lesson Plans</a></div>
												</td>
											</tr>
											<tr>
												<td colspan="8">
													<c:if test="${fn:length(project.sharedowners) > 0}">
														<div class="sharedTeacherMsg1">
															This project is shared with: 
															<c:forEach var="sharedowner" items="${project.sharedowners}" varStatus="status">
															  <c:out value="${sharedowner.userDetails.firstname}"/>
															  <c:out value="${sharedowner.userDetails.lastname}"/>
															  ${not status.last ? ', ' : ''}
															</c:forEach>
														</div>
													</c:if>
												</td>
											</tr>
											
											<tr>
												<th class="infoHead" style="width:70px;">Project ID</th>
												<th class="infoHead" style="width:120px;">Project Family</th>
												<th class="infoHead" style="width:190px;" >Subject</th>
												<th class="infoHead" style="width:80px;">Grade Level</th>
												<th class="infoHead" style="width:100px;">Total Duration</th>
												<th class="infoHead" style="width:120px;">Computer Time</th>
												<th class="infoHead" style="width:110px;">Language</th>
												<th class="infoHead" style="width:60px;">Usage</th>
											</tr>
											<tr>
												<td class="projectInfo">${project.id}</td>       		   
												<td class="projectInfo">${project.familytag}</td>       		   
												<td class="projectInfo">${project.metadata.subject}</td>
												<td class="projectInfo">${project.metadata.gradeRange}</td>              
												<td class="projectInfo">${project.metadata.totalTime}</td>              
												<td class="projectInfo">${project.metadata.compTime}</td> 
												<td class="projectInfo">${project.metadata.language}</td> 
												<td class="projectInfo">${usageMap[project.id]}</td>
											</tr>
											<tr>
												<td colspan="8">
													<table class="projectDetails" id="details_${project.id}">
														<tr>
															<th>Summary:</th>
															<td>${project.metadata.summary}</td>
														</tr>
														<tr>
															<th>Keywords:</th>
															<td>${project.metadata.keywords}</td>
														</tr>
														<tr>
															<th>Tech Requirements:</th>
															<td>${project.metadata.techDetailsString}</td>
														</tr>
														<tr>
															<th>Created:</th>
															<td><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="medium" timeStyle="short" /></td>
														</tr>
														<!-- <tr>
															<th>Original Author:</th>
															<td>${project.metadata.author}</td>
														</tr>  -->
														<c:if test="${project.parentProjectId != null}">
														<tr>
															<th>Copy of Project:</th>
															<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>${project.parentProjectId}</a></td>
														</tr>
														</c:if>
														<c:if test="${project.rootProjectId != null}">
														<tr>
															<th>Root Project:</th>
															<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.rootProjectId}'>${project.rootProjectId}</a></td>
														</tr>
														</c:if>
													</table>
												</td>
											</tr>
											<ul class="actions">
												<li>Tools:&nbsp;&nbsp;
												<li><a href="<c:url value="../../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank">Preview</a>&nbsp;|</li>
												<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Classroom Run</a>&nbsp;|</li>
												<li><a href="../../../author/authorproject.html?projectId=${project.id}">Edit/Author</a>&nbsp;|</li>
												<li><a href="shareproject.html?projectId=${project.id}">Share</a>&nbsp;|</li>
												<li><a onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy</a>&nbsp;|</li>
												<li><a style="color:#666;">Archive</a>
												<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
											</ul>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:when>
			<c:otherwise>
				<p class="info">You currently do not own any WISE projects. To add a project to your personal collection, choose one from the <a href="/webapp/teacher/projects/telsprojectlibrary.html">
					WISE Project Library</a> or from your Shared/Bookmarked projects and select "Copy". You can then customize your new project by clicking the "Edit" link. Create brand new projects using the
					<a href="/webapp/author/authorproject.html">WISE Authoring Tool</a>.</p>
			</c:otherwise>
		</c:choose>
	
	</div>	<!-- End of custom projects tab -->
		
	<div id="tab2">  <!-- shared projects -->
	
		<!--  
		<table id="customProjectsButtons">
			<tr>
				<td><a href="#" onclick="toggleProjectSummaryAll()">Hide/Show All Project Details</a></td>
			</tr>
		</table>
		-->
		
		<div class="ui-state-highlight ui-corner-all" style="margin:0 auto 1em;"> 
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			The projects listed below have been shared with you by other WISE users.</p>
		</div>
		
		<c:choose>
			<c:when test="${fn:length(currentSharedProjectsList) > 0}">
		
			<table id="sharedProjects" class="projectTable">
				<thead>
					<tr>
						<th class="tableHeaderMain">Shared Projects (${fn:length(currentSharedProjectsList)})</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach var="project" items="${currentSharedProjectsList}">
							<c:set var="projectName" value="${projectNameMap[project.id]}" />
							<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
							<tr class="projectRow">
								<td>
									<div class="projectBox">
										<table class="projectOverviewTable">
											<tr>
												<td colspan="6" class="projectTitle">
													<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
												</td>
												
												<td colspan="2" style="text-align:right;">
													<div class="projectDetailsLink"><a href="../projectinfo.html?projectId=${project.id}">More Details/Lesson Plans</a></div>
												</td>
											</tr>
											<tr>
												<td colspan="8">
													<c:if test="${fn:length(project.sharedowners) > 0}">
														<div class="sharedTeacherMsg1" style="display:inline-block;">
															This project is owned by: 
															<c:forEach var="projectowner" items="${project.owners}" varStatus="status">
																<c:out value="${projectowner.userDetails.firstname}" />
									  							<c:out value="${projectowner.userDetails.lastname}" />
															</c:forEach>
														</div>
														<div class="sharedTeacherMsg1" style="display:inline-block;">
															This project is shared with: 
															<c:forEach var="sharedowner" items="${project.sharedowners}" varStatus="status">
															  <c:out value="${sharedowner.userDetails.firstname}"/>
															  <c:out value="${sharedowner.userDetails.lastname}"/>${not status.last ? ', ' : ''}
															</c:forEach>
														</div>
													</c:if>
												</td>
											</tr>
											
											<tr>
												<th class="infoHead" style="width:70px;">Project ID</th>
												<th class="infoHead" style="width:120px;">Project Family</th>
												<th class="infoHead" style="width:190px;" >Subject</th>
												<th class="infoHead" style="width:80px;">Grade Level</th>
												<th class="infoHead" style="width:100px;">Total Duration</th>
												<th class="infoHead" style="width:120px;">Computer Time</th>
												<th class="infoHead" style="width:110px;">Language</th>
												<th class="infoHead" style="width:60px;">Usage</th>
											</tr>
											<tr>
												<td class="projectInfo">${project.id}</td>       		   
												<td class="projectInfo">${project.familytag}</td>       		   
												<td class="projectInfo">${project.metadata.subject}</td>
												<td class="projectInfo">${project.metadata.gradeRange}</td>              
												<td class="projectInfo">${project.metadata.totalTime}</td>              
												<td class="projectInfo">${project.metadata.compTime}</td> 
												<td class="projectInfo">${project.metadata.language}</td> 
												<td class="projectInfo">${usageMap[project.id]}</td>
											</tr>
											<tr>
												<td colspan="8">
													<table class="projectDetails" id="details_${project.id}">
														<tr>
															<th>Summary:</th>
															<td>${project.metadata.summary}</td>
														</tr>
														<tr>
															<th>Keywords:</th>
															<td>${project.metadata.keywords}</td>
														</tr>
														<tr>
															<th>Tech Requirements:</th>
															<td>${project.metadata.techDetailsString}</td>
														</tr>
														<tr>
															<th>Created:</th>
															<td><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="medium" timeStyle="short" /></td>
														</tr>
														<tr>
															<th>Contact Info:</th>
															<td>${project.metadata.contact}</td>
														</tr>
														<c:if test="${project.parentProjectId != null}">
														<tr>
															<th>Copy of Project:</th>
															<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>${project.parentProjectId}</a></td>
														</tr>
														</c:if>
													</table>
												</td>
											</tr>
											<ul class="actions">
												<li>Tools:&nbsp;&nbsp;
												<li><a href="<c:url value="../../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank">Preview</a>&nbsp;|</li>
												<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Classroom Run</a>&nbsp;|</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a href="../../../author/authorproject.html?projectId=${project.id}">Edit/Author</a>&nbsp;|</li>
												</sec:accesscontrollist>
												<sec:accesscontrollist domainObject="${project}" hasPermission="16">
													<li><a href="shareproject.html?projectId=${project.id}">Share</a>&nbsp;|</li>
												</sec:accesscontrollist>
												<li><a onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy</a>&nbsp;|</li>
												<li><a style="color:#666;">Archive</a>
												<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
											</ul>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:when>
			<c:otherwise>
				<p class="info">You currently have no shared projects.</p>
			</c:otherwise>
		</c:choose>
		
	</div> <!-- End of shared projects tab -->
		
		
		
	<div id="tab3">  <!-- bookmarked projects -->
		<div class="ui-state-highlight ui-corner-all" style="margin:0 auto 1em;"> 
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			The projects listed below have been bookmarked by you.</p>
		</div>
		
		<c:choose>
			<c:when test="${fn:length(bookmarkedProjectsList) > 0}">
				<table id="sharedProjects" class="projectTable">
				<thead>
					<tr>
						<th class="tableHeaderMain">Bookmarked Projects (${fn:length(bookmarkedProjectsList)})</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach var="project" items="${bookmarkedProjectsList}">
							<c:set var="projectName" value="${projectNameMap[project.id]}" />
							<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
							<tr class="projectRow">
								<td>
									<div class="projectBox">
										<table class="projectOverviewTable">
											<tr>
												<td colspan="6" class="projectTitle">
													<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
												</td>
												
												<td colspan="2" style="text-align:right;">
													<div class="projectDetailsLink"><a href="../projectinfo.html?projectId=${project.id}">More Details/Lesson Plans</a></div>
												</td>
											</tr>
											<tr>
												<td colspan="8">
													<c:if test="${fn:length(project.sharedowners) > 0}">
														<div class="sharedTeacherMsg1" style="display:inline-block;">
															This project is owned by: 
															<c:forEach var="projectowner" items="${project.owners}" varStatus="status">
																<c:out value="${projectowner.userDetails.firstname}" />
									  							<c:out value="${projectowner.userDetails.lastname}" />
															</c:forEach>
														</div>
														<div class="sharedTeacherMsg1" style="display:inline-block;">
															This project is shared with: 
															<c:forEach var="sharedowner" items="${project.sharedowners}" varStatus="status">
															  <c:out value="${sharedowner.userDetails.firstname}"/>
															  <c:out value="${sharedowner.userDetails.lastname}"/>${not status.last ? ', ' : ''}
															</c:forEach>
														</div>
													</c:if>
												</td>
											</tr>
											
											<tr>
												<th class="infoHead" style="width:70px;">Project ID</th>
												<th class="infoHead" style="width:120px;">Project Family</th>
												<th class="infoHead" style="width:190px;" >Subject</th>
												<th class="infoHead" style="width:80px;">Grade Level</th>
												<th class="infoHead" style="width:100px;">Total Duration</th>
												<th class="infoHead" style="width:120px;">Computer Time</th>
												<th class="infoHead" style="width:110px;">Language</th>
												<th class="infoHead" style="width:60px;">Usage</th>
											</tr>
											<tr>
												<td class="projectInfo">${project.id}</td>       		   
												<td class="projectInfo">${project.familytag}</td>       		   
												<td class="projectInfo">${project.metadata.subject}</td>
												<td class="projectInfo">${project.metadata.gradeRange}</td>              
												<td class="projectInfo">${project.metadata.totalTime}</td>              
												<td class="projectInfo">${project.metadata.compTime}</td> 
												<td class="projectInfo">${project.metadata.language}</td> 
												<td class="projectInfo">${usageMap[project.id]}</td>
											</tr>
											<tr>
												<td colspan="8">
													<table class="projectDetails" id="details_${project.id}">
														<tr>
															<th>Summary:</th>
															<td>${project.metadata.summary}</td>
														</tr>
														<tr>
															<th>Keywords:</th>
															<td>${project.metadata.keywords}</td>
														</tr>
														<tr>
															<th>Tech Requirements:</th>
															<td>${project.metadata.techDetailsString}</td>
														</tr>
														<tr>
															<th>Created:</th>
															<td><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="medium" timeStyle="short" /></td>
														</tr>
														<tr>
															<th>Contact Info:</th>
															<td>${project.metadata.contact}</td>
														</tr>
														<c:if test="${project.parentProjectId != null}">
														<tr>
															<th>Copy of Project:</th>
															<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>${project.parentProjectId}</a></td>
														</tr>
														</c:if>
													</table>
												</td>
											</tr>
											<ul class="actions">
												<li>Tools:&nbsp;&nbsp;
												<li><a href="<c:url value="../../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank">Preview</a>&nbsp;|</li>
												<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Classroom Run</a>&nbsp;|</li>
												<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">
													<li><a href="../../../author/authorproject.html?projectId=${project.id}">Edit/Author</a>&nbsp;|</li>
												</sec:accesscontrollist>
												<sec:accesscontrollist domainObject="${project}" hasPermission="16">
													<li><a href="shareproject.html?projectId=${project.id}">Share</a>&nbsp;|</li>
												</sec:accesscontrollist>
												<li><a onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy</a>&nbsp;|</li>
												<li><a style="color:#666;">Archive</a>
												<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
											</ul>
										</table>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<p class="info">You currently have not bookmarked any projects. You can bookmark projects for future use by browsing the <a href="/webapp/teacher/projects/telsprojectlibrary.html">WISE Project Library</a>.</p>
			</c:otherwise>
		</c:choose>
	
	</div>
		
		
	<!-- <div id="tab4"> --> <!-- Archived projects tab -->
	
		<!-- <c:choose>
			<c:when test="${fn:length(archivedOwnedProjectsList) == 0 && fn:length(archivedSharedProjectsList) == 0}">
			   <h5>You currently do not have any archived projects.</h5>
			</c:when>
			<c:otherwise>
			    
	
	
			    <div id="customProjectInstructions">Archived Projects which you owned:</div>
				<c:if test="${fn:length(archivedOwnedProjectsList) == 0}">
					<h5>None</h5>
				</c:if>
				<c:forEach var="project" items="${archivedOwnedProjectsList}">
					<c:choose>
						<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
							<c:set var="projectName" value="${project.metadata.title}"/>
						</c:when>
						<c:otherwise>
							<c:set var="projectName" value="${project.name}"/>
						</c:otherwise>
					</c:choose>
	
						<table id="projectOverviewTable">
								<tr id="row1">
								<td id="titleCell" colspan="3">
										<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
										<c:if test="${fn:length(project.sharedowners) > 0}">
											<div id="sharedNamesContainerArchived">
												This project is shared with:
												<div id="sharedNames">
													<c:forEach var="sharedowner" items="${project.sharedowners}">
													  <c:out value="${sharedowner.userDetails.firstname}"/>
													  <c:out value="${sharedowner.userDetails.lastname}"/>
													  <c:out value=",  "/>
													</c:forEach>
												</div>
											</div>
										</c:if>
								</td>
								<td class="actions" colspan="8"> 
										<ul>
											<li><a href="#" style="color:#666;">Un-Archived this Project</a></li>
										</ul>
								</td>
									<tr id="row2">
									<th id="title1" style="width:60px;">Project ID</th>
									<th id="title2" style="width:90px;">Project Family</th>
									<th id="title3" style="width:280px;" >Subject</th>
									<th id="title4" style="width:70px;">Grade Level</th>
									<th id="title5" style="width:105px;">Total Hours</th>
									<th id="title6" style="width:110px;">Computer Hours</th>
									<th id="title7" style="width:72px;">Language</th>
									<th id="title8" style="width:82px;">Tech Needs</th>
									<th id="title9" style="width:60px;">Usage</th>
								</tr>
								<tr id="row3">
									<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
									<td class="dataCell">${project.metadata.gradeRange}</td>              
									<td class="dataCell">${project.metadata.totalTime}</td>              
									<td class="dataCell">${project.metadata.compTime}</td> 
									<td class="dataCell">[English]</td> 
									<td class="dataCell">[Flash, Java]</td> 
									<td class="dataCell">${usageMap[project.id]}</td>
								</tr>
								<tr id="row4">  
									<td colspan="9">
										<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
										<div id="details_${project.id}">
											<table id="detailsTable">
												<tr>
													<th>Summary:</th>
													<td class="summary">${project.metadata.summary}</td>
												</tr>
												<tr>
													<th>Keywords:</th>
													<td class="keywords">[List of comma-separated keywords go here]</td>
												</tr>
	
												<tr>
													<th>Tech Details:</th>
													<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
												</tr>
												<tr>
													<th>Created On:</th>
													<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
												</tr>
												<tr> 
													<th>Original Author:</th>
													<td>[Name goes here]</td>
												</tr>
												<tr>
													<th>Contact Info:</th>
													<td>[Name and Email goes here]</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
	
		</c:forEach>
		
			    <div id="customProjectInstructions">Archived Projects which were shared with you:</div>
				<c:if test="${fn:length(archivedSharedProjectsList) == 0}">
					<h5>None.</h5>
				</c:if>
				<c:forEach var="project" items="${archivedSharedProjectsList}">
					<c:choose>
						<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
							<c:set var="projectName" value="${project.metadata.title}"/>
						</c:when>
						<c:otherwise>
							<c:set var="projectName" value="${project.name}"/>
						</c:otherwise>
					</c:choose>
						<table id="projectOverviewTable">
								<tr id="row1">
								<td id="titleCell" colspan="3">
										<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
										<c:if test="${fn:length(project.sharedowners) > 0}">
											<div id="sharedNamesContainerArchived">
												This project is shared with:
												<div id="sharedNames">
													<c:forEach var="sharedowner" items="${project.sharedowners}">
													  <c:out value="${sharedowner.userDetails.firstname}"/>
													  <c:out value="${sharedowner.userDetails.lastname}"/>
													  <c:out value=",  "/>
													</c:forEach>
												</div>
											</div>
										</c:if>
										
								</td>
								<td class="actions" colspan="8"> 
								</tr>
								<tr id="row2">
									<th id="title1" style="width:60px;">Project ID</th>
									<th id="title1" style="width:90px;">Project Family</th>
									<th id="title2" style="width:292px;" >Subject(s)</th>
									<th id="title3" style="width:100px;">Grades</th>
									<th id="title4" style="width:110px;">Total Time (hrs)</th>
									<th id="title5" style="width:110px;">Computer Time (hrs)</th>
									<th id="title6" style="width:92px;">Language</th>
									<th id="title7" style="width:90px;">Usage</th>
								</tr>
								<tr id="row3">
									<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
									<td class="dataCell">${project.metadata.gradeRange}</td>              
									<td class="dataCell">${project.metadata.totalTime}</td>              
									<td class="dataCell">${project.metadata.compTime}</td> 
									<td class="dataCell">[English]</td> 
									<td class="dataCell">${usageMap[project.id]} runs</td>
						
								</tr>
								<tr id="row4">  
									<td colspan="9">
										<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
										<div id="details_${project.id}">
											<table id="detailsTable">
												<tr>
													<th>Summary:</th>
													<td class="summary">${project.metadata.summary}</td>
												</tr>
												<tr>
													<th>Keywords:</th>
													<td class="keywords">[List of comma-separated keywords go here]</td>
												</tr>
	
												<tr>
													<th>Tech Details:</th>
													<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
												</tr>
												<tr>
													<th>Created On:</th>
													<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
												</tr>
												<tr> 
													<th>Original Author:</th>
													<td>[Name goes here]</td>
												</tr>
												<tr>
													<th>Contact Info:</th>
													<td>[Name and Email goes here]</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
	
		</c:forEach>	
			</c:otherwise>
		</c:choose>
	
	
	</div> -->
		
	<!-- <div id="tab5"> --> <!--  My Project Runs tab -->
	<!-- <h5>A listing of the project runs you have set up for classroom use can be found on the <a href="/webapp/teacher/index.html">Home Page</a> or in the <a href="/webapp/teacher/run/myprojectruns.html">Management/My Project Runs</a> section.</h5>
	</div> -->
</div>