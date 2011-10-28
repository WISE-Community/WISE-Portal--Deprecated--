<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript">
	
	function popup(URL, title) {
		window.open(URL, title, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=640,height=480,left = 320,top = 240');
	};
 </script>

<script type="text/javascript">
	function checkRuns(){
		//if(${current_run_list} == 0){          
			//  document.getElementById('runBox').innerHTML = '<div id="noRuns"><br/><h5>You have no current project runs.</h5><br/><h5>Explore the Project Library (in PROJECTS) to find a curriculum project and set it up for a run in your classroom.</h5><br/><h5>Or review <a href="#" style="text-decoration:line-through;">Setting Up a Project Run</a> in the WISE 4.0 Help Guide.</h5></div>';
		// }
	}
	
	// setup grading dialogs
	$('.grading, .researchTools, .classroomMonitor').live('click',function(){
		var settings = $(this).attr('id');
		var title = $(this).attr('title');
		var path = "/webapp/teacher/grading/gradework.html?" + settings;
		var div = $('#gradingDialog').html('<iframe id="gradingIfrm" width="100%" height="100%" style="overflow-y:hidden;"></iframe>');
		$('body').css('overflow','hidden');
		div.dialog({
			modal: true,
			width: $(window).width() - 32,
			height: $(window).height() - 32,
			position: 'center',
			title: title,
			close: function (e, ui) { $(this).html(''); $('body').css('overflow','auto'); },
			buttons: {
				Exit: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#gradingDialog > #gradingIfrm").attr('src',path);
	});
	
	// setup share project run dialog
	$('.shareRun').live('click',function(){
		var title = $(this).attr('title');
		var runId = $(this).attr('id').replace('shareRun_','');
		var path = "/webapp/teacher/run/shareprojectrun.html?runId=" + runId;
		var div = $('#shareDialog').html('<iframe id="shareIfrm" width="100%" height="100%"></iframe>');
		$('body').css('overflow','hidden');
		div.dialog({
			modal: true,
			width: '650',
			height: '450',
			title: title,
			position: 'center',
			close: function(){
				$(this).html('');
				$('body').css('overflow','auto');
			},
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#shareDialog > #shareIfrm").attr('src',path);
	});
	
	// setup edit run settings dialog
	$('.editRun').live('click',function(){
		var title = $(this).attr('title');
		var runId = $(this).attr('id').replace('editRun_','');
		var path = "/webapp/teacher/run/editrun.html?runId=" + runId;
		var div = $('#editRunDialog').html('<iframe id="editIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '600',
			height: '400',
			title: title,
			position: 'center',
			close: function(){
				if(document.getElementById('editIfrm').contentWindow['runUpdated']){
					window.location.reload();
				}
				$(this).html('');
			},
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#editRunDialog > #editIfrm").attr('src',path);
	});
	
	// setup edit manage announcements dialog
	$('.editAnnouncements').live('click',function(){
		var title = $(this).attr('title');
		var runId = $(this).attr('id').replace('editAnnouncements_','');
		var path = "/webapp/teacher/run/announcement/manageannouncement.html?runId=" + runId;
		var div = $('#editAnnouncementsDialog').html('<iframe id="announceIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '600',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); },
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#editAnnouncementsDialog > #announceIfrm").attr('src',path);
	});
	
	// setup manage students dialog
	$('.manageStudents').live('click',function(){
		var title = $(this).attr('title');
		var params = $(this).attr('id').replace('manageStudents_','');
		var path = "/webapp/teacher/management/viewmystudents.html?" + params;
		var div = $('#manageStudentsDialog').html('<iframe id="manageStudentsIfrm" width="100%" height="100%"></iframe>');
		$('body').css('overflow','hidden');
		div.dialog({
			modal: true,
			width: $(window).width() - 32,
			height: $(window).height() - 32,
			title: title,
			position: 'center',
			beforeClose: function() {
				// check for unsaved changes and alert user if necessary
				if(document.getElementById('manageStudentsIfrm').contentWindow['unsavedChanges']){
					var answer = confirm("Warning: You currently have unsaved changes to student teams. If you exit now, they will be discarded. To save your changes, choose 'Cancel' and click the 'SAVE CHANGES' button in the upper right corner.\n\nAre you sure you want to exit without saving?")
					if(answer){
						return true;
					} else {
						return false;
					};
				} else {
					return true;
				}
			},
			close: function(){
				// refresh page if required (run title or student periods have been modified)
				if(document.getElementById('manageStudentsIfrm').contentWindow['refreshRequired']){
					window.location.reload();
				}
				$(this).html('');
				$('body').css('overflow','auto');
			},
			buttons: {
				Exit: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#manageStudentsDialog > #manageStudentsIfrm").attr('src',path);
	});
	
	// setup archive and restore run dialogs
	$('.archiveRun, .activateRun').live('click',function(){
		var title = $(this).attr('title');
		if($(this).hasClass('archiveRun')){
			var params = $(this).attr('id').replace('archiveRun_','');
			var path = "/webapp/teacher/run/manage/archiveRun.html?" + params;
		} else if($(this).hasClass('activateRun')){
			var params = $(this).attr('id').replace('activateRun_','');
			var path = "/webapp/teacher/run/manage/startRun.html?" + params;
		}
		var div = $('#archiveRunDialog').html('<iframe id="archiveIfrm" width="100%" height="100%"></iframe>');
		$('body').css('overflow','hidden');
		div.dialog({
			modal: true,
			width: '600',
			height: '450',
			title: title,
			position: 'center',
			close: function(){
				if(document.getElementById('archiveIfrm').contentWindow['refreshRequired']){
					window.location.reload();
				}
				$(this).html('');
				$('body').css('overflow','auto');
			},
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#archiveRunDialog > #archiveIfrm").attr('src',path);
	});
	
	// Set up view project details click action for each project id link
	$('a.projectDetail, a.projectInfo').live('click',function(){
		var title = $(this).attr('title');
		if($(this).hasClass('projectDetail')){
			var projectId = $(this).attr('id').replace('projectDetail_','');
		} else if($(this).hasClass('projectInfo')){
			var projectId = $(this).attr('id').replace('projectInfo_','');
		}
		var path = "/webapp/teacher/projects/projectinfo.html?projectId=" + projectId;
		var div = $('#projectDetailDialog').html('<iframe id="projectIfrm" width="100%" height="100%"></iframe>');
		$('body').css('overflow','hidden');
		div.dialog({
			modal: true,
			width: '800',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); $('body').css('overflow','auto'); },
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#projectDetailDialog > #projectIfrm").attr('src',path);
	});

</script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<c:choose>
		<c:when test="${fn:length(current_run_list) > 0}">
			<div class="runBox">
				
				<table id="currentRunTable" class="runTable" border="1" cellpadding="0" cellspacing="0">
					<thead>
					    <tr>
					       <th style="width:215px;"class="tableHeaderMain runHeader"><spring:message code="teacher.run.myprojectruns.3"/></th>
					       <th style="width:155px;" class="tableHeaderMain studentHeader"><spring:message code="teacher.run.myprojectruns.4" /></th>      
					       <th style="width:285px;" class="tableHeaderMain toolsHeader"><spring:message code="teacher.run.myprojectruns.5" /></th>
					       <th style="display:none;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.58A" /></th>
					       <th style="display:none;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.58B" /></th>
					       <th style="display:none;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.58C" /></th>
					       <th style="display:none;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.58D" /></th>
					       <th style="display:none;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.58E" /></th>
					    </tr>
					</thead>
					<tbody>
					  <c:if test="${fn:length(current_run_list) > 0}">
						  <c:forEach var="run" items="${current_run_list}">
						  
						  <tr id="runTitleRow_${run.id}" class="runRow">
						    <td class="titleCell">
						    	<div class="runTitle">${run.name}</div>
						    		<c:set var="ownership" value="owned" />
									<c:forEach var="sharedowner" items="${run.sharedowners}">
							    	    <c:if test="${sharedowner == user}">
							    	    	<c:set var="ownership" value="shared" />
							    	    	<div class="sharedIcon">
								    	    	<img src="/webapp/themes/tels/default/images/shared.png" alt="shared project" /> <spring:message code="teacher.run.myprojectruns.6"/>
								    	    	<c:forEach var="owner" items="${run.owners}">
								    	    		${owner.userDetails.firstname} ${owner.userDetails.lastname}
								    	    	</c:forEach>
							    	    	</div>
							    	    </c:if>
							    	</c:forEach>
						     
								<table class="runTitleTable">
						      			<tr>
											<th><spring:message code="teacher.run.myprojectruns.8" /></th>
											<td class="accesscode">${run.runcode}</td>
										</tr>
										
						      			<tr>
						      				<th><spring:message code="teacher.run.myprojectruns.11" /></th>
						      				<td>${run.id}</td>
						      			</tr>
						      			<tr>
						      				<th><spring:message code="teacher.run.myprojectruns.13"/></th>
						      				<td><fmt:formatDate value="${run.starttime}" type="date" dateStyle="medium" /></td>
						      			</tr>
						      			<!-- <tr>
						      				<th><spring:message code="teacher.run.myprojectruns.12"/></th> TODO: decide whether to include or not -->
						      				<c:set var="source" value="custom" />
						      				<c:choose>
						      				<c:when test="${run.project.familytag == 'TELS'}"> <!-- TODO: modify this to include ALL library projects (not just TELS) -->
							      				<c:set var="source" value="library" />
							      				<!-- <td><spring:message code="teacher.run.myprojectruns.43"/></td> -->
						      				</c:when>
						      				<c:otherwise>
							      				<!-- <td><spring:message code="teacher.run.myprojectruns.44"/></td> -->
						      				</c:otherwise>
						      				</c:choose>
						      			<!-- </tr>  -->
										<tr>
						      				<th><spring:message code="teacher.run.myprojectruns.11A"/></th>
						      				<td><a id="projectDetail_${run.project.id}" class="projectDetail" title="Project Details">${run.project.id}</a></td>
						      			</tr>
						      			<tr>
						      				<c:if test="${run.project.parentProjectId != null}">
						      				<th><spring:message code="teacher.run.myprojectruns.40"/></th>
											<td><a id="projectDetail_${run.project.parentProjectId}" class="projectDetail" title="Project Details">${run.project.parentProjectId}</a></td>
											</c:if>
						      			</tr>
						      			<tr>
						      				<td colspan="2" style="padding-top:.5em;">
						      				<a id="editRun_${run.id}" class="editRun" title="<spring:message code="teacher.run.myprojectruns.48"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="settings" src="/webapp/themes/tels/default/images/icons/teal/processing.png" /><span><spring:message code="teacher.run.myprojectruns.48"/></span></a>
						      				</td>
						      			</tr>
								</table>
						      	
							</td>
														
						    <td style="vertical-align: top; padding:.5em 0;" >
						    	<table class="currentRunInfoTable" border="0" cellpadding="0" cellspacing="0">
						          <tr>
						            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.29"/></th>
						            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.9"/></th>
						          </tr>
						          <c:forEach var="period" items="${run.periods}">
						            <tr>
						              <td style="width:35%;" class="tableInnerData">${period.name}</td>
						              <td style="width:65%;" class="tableInnerDataRight">
						              	<a class="manageStudents" title="<spring:message code="teacher.run.myprojectruns.62"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&periodName=${period.name}">${fn:length(period.members)}&nbsp;<spring:message code="teacher.run.myprojectruns.10"/></a>
						              </td>
						            </tr>
						          </c:forEach>
						          <tr><td colspan="2" class="manageStudentGroups"><a class="manageStudents" title="<spring:message code="teacher.run.myprojectruns.62"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}"><img class="icon" alt="groups" src="/webapp/themes/tels/default/images/icons/teal/connected.png" /><span><spring:message code="teacher.run.myprojectruns.62"/></span></a></td></tr>
						        </table>
						    </td> 
						    <td style="vertical-align: top; padding: 0.25em 0;">
							    <c:set var="isExternalProject" value="0"/>
							    
							        <c:forEach var="external_run" items="${externalprojectruns}">
							           <c:if test="${run.id == external_run.id}">
							                   <c:set var="isExternalProject" value="1"/>
							           </c:if>
							        </c:forEach>
							           <c:choose>
							               <c:when test="${isExternalProject == 1}">
							               	  <ul class="actionList">
							                  	<li><spring:message code="teacher.run.myprojectruns.45"/> <c:forEach var="periodInRun" items="${run.periods}"><a href="report.html?runId=${run.id}&groupId=${periodInRun.id}">${periodInRun.name}</a>&nbsp;</c:forEach></li>
							               	  </ul>
							               </c:when>
							               <c:otherwise>
										    <ul class="actionList">
												<li><span style="font-weight:bold;"><spring:message code="teacher.run.myprojectruns.16"/>:</span> <a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=step&getRevisions=false&minified=true"><spring:message code="teacher.run.myprojectruns.42"/></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/>: ${run.id})"  id="runId=${run.id}&gradingType=step&getRevisions=true&minified=true"><spring:message code="teacher.run.myprojectruns.41"/></a></li>
						  	                    <li><span style="font-weight:bold;"><spring:message code="teacher.run.myprojectruns.17"/>:</span> <a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=false&minified=true"><spring:message code="teacher.run.myprojectruns.42"/></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/>: ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=true&minified=true"><spring:message code="teacher.run.myprojectruns.41"/></a></li>
							                    <c:if test="${isXMPPEnabled && run.XMPPEnabled}">
	                    							<li><a class="classroomMonitor" title="<spring:message code="teacher.run.myprojectruns.65"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=monitor"><spring:message code="teacher.run.myprojectruns.65"/></a></li>
	                    						</c:if>
							               </ul>
							               <ul class="actionList">
										        <li>
										        	<spring:message code="teacher.run.myprojectruns.46"/>&nbsp;<a href="/webapp/previewproject.html?projectId=${run.project.id}" target="_blank"><img class="icon" alt="preview" src="/webapp/themes/tels/default/images/icons/teal/screen.png" /><span><spring:message code="teacher.run.myprojectruns.46A"/></span></a>
									    			|&nbsp;<a id="projectInfo_${run.project.id}" class="projectInfo" title="Project Details"><img class="icon" alt="info" src="/webapp/themes/tels/default/images/icons/teal/ID.png" /><span><spring:message code="teacher.run.myprojectruns.46B"/></span></a>
										        	<sec:accesscontrollist domainObject="${run.project}" hasPermission="16">
										        		|&nbsp;<a onclick="if(confirm('<spring:message code="teacher.run.myprojectruns.47"/>')){window.top.location='/webapp/author/authorproject.html?projectId=${run.project.id}&versionId=${run.versionId}';} return true;"><img class="icon" alt="edit" src="/webapp/themes/tels/default/images/icons/teal/edit.png" /><span><spring:message code="teacher.run.myprojectruns.46C"/></span></a>
										        	</sec:accesscontrollist>
										        </li>
										    </ul>
							               </c:otherwise>
							           </c:choose>
								
								<ul class="actionList actionList2">
			
									<sec:accesscontrollist domainObject="${run}" hasPermission="16">
			   					      <li><a id="shareRun_${run.id}" class="shareRun" title="<spring:message code="teacher.run.myprojectruns.63"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="share" src="/webapp/themes/tels/default/images/icons/teal/agent.png" /><span><spring:message code="teacher.run.myprojectruns.18"/></span></a></li> 
			 	                    	</sec:accesscontrollist>
							    	
							    	<c:set var="isExternalProject" value="0"/>
							    	<sec:accesscontrollist domainObject="${run}" hasPermission="16">
							      		<!-- <li><a id="editAnnouncements_${run.id}" class="editAnnouncements" title="Manage Announcements: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" ><spring:message code="teacher.run.myprojectruns.50"/></a></li> -->
							        </sec:accesscontrollist>
							        <li><a class="researchTools" title="<spring:message code="teacher.run.myprojectruns.64"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=export"><img class="icon" alt="export" src="/webapp/themes/tels/default/images/icons/teal/save.png" /><span><spring:message code="teacher.run.myprojectruns.64"/> <spring:message code="teacher.run.myprojectruns.66"/></span></a></li>			    	
							    	<!-- 
							    	<li><a href="../run/brainstorm/createbrainstorm.html?runId=${run.id}" target="_top">Create Q&A Discussion</a></li>
							    	<c:if test="${not empty run.brainstorms}" >
							            <c:forEach var="brainstorm" items="${run.brainstorms}" varStatus="brainstormVS" >
							                <li class="qaBullet"><a href="../run/brainstorm/managebrainstorm.html?brainstormId=${brainstorm.id}">Manage Q&A #${brainstormVS.index+1}</a></li>
							            </c:forEach>
							    	</c:if>
							    	 -->		
									<li><a href="/webapp/contactwiseproject.html?projectId=${run.project.id}"><img class="icon" alt="contact" src="/webapp/themes/tels/default/images/icons/teal/email.png" /><span><spring:message code="teacher.run.myprojectruns.22"/></span></a></li>
				                    <sec:accesscontrollist domainObject="${run}" hasPermission="16">					    	
							    	  <li><a class="archiveRun" id="archiveRun_runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />" title="<spring:message code="teacher.run.myprojectruns.67"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="archive" src="/webapp/themes/tels/default/images/icons/teal/lock.png" /><span><spring:message code="teacher.run.myprojectruns.51"/></span></a></li>
							    	</sec:accesscontrollist>
							    	
							    </ul>
			
							</td>
							<td style="display:none;">${run.starttime}</td>
							<td style="display:none;"></td>
							<td style="display:none;">${source}</td>
							<td style="display:none;">${ownership}</td>
							<td style="display:none;">
								<c:forEach var="period" items="${run.periods}">${period.name},</c:forEach>
						   </td>
						   </tr>
						  </c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</c:when>
		<c:otherwise>
			<p class="info"><spring:message code="teacher.run.myprojectruns.52"/> <a href="/webapp/teacher/management/library.html">
				<spring:message code="teacher.run.myprojectruns.52A"/></a> <spring:message code="teacher.run.myprojectruns.52D"/>	<a href="/webapp/author/authorproject.html">
				<spring:message code="teacher.run.myprojectruns.52E"/></a>.</p>
		</c:otherwise>
	</c:choose>

<div id="gradingDialog" class="dialog"></div>
<div id="shareDialog" class="dialog"></div>
<div id="editRunDialog" class="dialog"></div>
<div id="editAnnouncementsDialog" class="dialog"></div>
<div id="manageStudentsDialog" style="overflow:hidden;" class="dialog"></div>
<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
<div id="archiveRunDialog" style="overflow:hidden;" class="dialog"></div>