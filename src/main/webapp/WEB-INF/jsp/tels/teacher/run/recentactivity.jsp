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
		var div = $('#gradingDialog').html('<iframe id="gradingIfrm" width="100%" height="100%" style="overflow-y:hidden; min-width:1000px;"></iframe>');
		$('body').css('overflow-y','hidden');
		div.dialog({
			modal: true,
			width: $(window).width() - 32,
			height: $(window).height() - 32,
			position: 'center',
			title: title,
			close: function (e, ui) { $(this).html(''); $('body').css('overflow-y','auto'); },
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
		$('body').css('overflow-y','hidden');
		div.dialog({
			modal: true,
			width: '650',
			height: $(window).height() - 100,
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); $('body').css('overflow-y','auto'); },
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
		$('body').css('overflow-y','hidden');
		div.dialog({
			modal: true,
			width: '600',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); $('body').css('overflow-y','auto'); },
			buttons: {
				Close: function(){
					if(document.getElementById('editIfrm').contentWindow['runUpdated']){
						window.location.reload();
					}
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
		$('body').css('overflow-y','hidden');
		div.dialog({
			modal: true,
			width: '600',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); $('body').css('overflow-y','auto'); },
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#editAnnouncementsDialog > #announceIfrm").attr('src',path);
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
		$('body').css('overflow-y','hidden');
		div.dialog({
			modal: true,
			width: '800',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); $('body').css('overflow-y','auto'); },
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
				<p class="info">Your most recent classroom runs are shown below. To see all your project runs, go to the <a href="/webapp/teacher/management/classroomruns.html">Grade & Manage Classroom Runs</a> page.</p>
				<div class="runBox">
					
					<table id="currentRunTable" class="runTable" border="1" cellpadding="0" cellspacing="0">
						<thead>
						    <tr>
						       <th style="width:250px;"class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.3"/></th>
						       <th style="width:140px;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.4" /></th>      
						       <th style="width:290px;" class="tableHeaderMain"><spring:message code="teacher.run.myprojectruns.5" /></th>
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
							      				<a id="editRun_${run.id}" class="editRun" title="Edit Run Settings: ${run.name} (Run ID ${run.id})"><spring:message code="teacher.run.myprojectruns.48"/></a>
							      				</td>
							      			</tr>
									</table>
							      	
								</td>
															
							    <td style="vertical-align:top; padding:0;" >
							    	<table class="currentRunInfoTable" border="0" cellpadding="0" cellspacing="0">
							          <tr>
							            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.29"/></th>
							            <th style="display:none;" class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.8"/></th>
							            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.9"/></th>
							          </tr>
							          <c:forEach var="period" items="${run.periods}">
							            <tr>
							              <td style="width:20%;" class="tableInnerData">${period.name}</td>
							              <td style="display:none;"  style="width:45%;" class="tableInnerData">${run.runcode}</td>
							              <td style="width:35%;" class="tableInnerDataRight">
							                <a href="/webapp/teacher/management/viewmystudents.html?runId=${run.id}&periodName=${period.name}" target="_top">${fn:length(period.members)}&nbsp;<spring:message code="teacher.run.myprojectruns.10"/></a></td>
							            </tr>
							          </c:forEach>
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
											        <li>
											        	<spring:message code="teacher.run.myprojectruns.46"/>&nbsp;<a href="/webapp/previewproject.html?projectId=${run.project.id}" target="_blank"><spring:message code="teacher.run.myprojectruns.46A"/></a>
										    			|&nbsp;<a id="projectInfo_${run.project.id}" class="projectInfo" title="Project Details"><spring:message code="teacher.run.myprojectruns.46B"/></a></a>
											        	<sec:accesscontrollist domainObject="${run.project}" hasPermission="16">
											        		|&nbsp;<a onclick="if(confirm('<spring:message code="teacher.run.myprojectruns.47"/>')){window.top.location='/webapp/author/authorproject.html?projectId=${run.project.id}&versionId=${run.versionId}';} return true;"><spring:message code="teacher.run.myprojectruns.46C"/></a>
											        	</sec:accesscontrollist>
											        </li>
											    </ul>
											    <ul class="actionList">
													<li><spring:message code="teacher.run.myprojectruns.16"/>: <a class="grading" title="Grading & Feedback: ${run.name} (Run ID ${run.id})" id="runId=${run.id}&gradingType=step&getRevisions=false&minified=true"><spring:message code="teacher.run.myprojectruns.42"/></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (Run ID: ${run.id})"  id="runId=${run.id}&gradingType=step&getRevisions=true&minified=true"><spring:message code="teacher.run.myprojectruns.41"/></a></li>
							  	                    <li><spring:message code="teacher.run.myprojectruns.17"/>: <a class="grading" title="Grading & Feedback: ${run.name} (Run ID ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=false&minified=true"><spring:message code="teacher.run.myprojectruns.42"/></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (Run ID: ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=true&minified=true"><spring:message code="teacher.run.myprojectruns.41"/></a></li>
								                    <c:if test="${isXMPPEnabled && run.XMPPEnabled}">
		                    							<li><a class="classroomMonitor" title="Classroom Monitor: ${run.name} (Run ID ${run.id})" id="runId=${run.id}&gradingType=monitor">Classroom Monitor</a></li>
		                    						</c:if>
		                    						<li><a class="researchTools" title="Researcher Tools: ${run.name} (Run ID ${run.id})" id="runId=${run.id}&gradingType=export">Researcher Tools</a></li>
								               </ul>
								               </c:otherwise>
								           </c:choose>
									
									<ul class="actionList actionList2">
				
										<sec:accesscontrollist domainObject="${run}" hasPermission="16">
				   					      <li><a id="shareRun_${run.id}" class="shareRun" title="Sharing Permissions: ${run.name} (Run ID ${run.id})"><spring:message code="teacher.run.myprojectruns.18"/></a></li> 
				 	                    	</sec:accesscontrollist>
								    	
								    	<c:set var="isExternalProject" value="0"/>
								    	<sec:accesscontrollist domainObject="${run}" hasPermission="16">
								      		<!-- <li><a id="editAnnouncements_${run.id}" class="editAnnouncements" title="Manage Announcements: ${run.name} (Run ID ${run.id})" ><spring:message code="teacher.run.myprojectruns.50"/></a></li> -->
								        </sec:accesscontrollist>			    	
								    	<!-- 
								    	<li><a href="../run/brainstorm/createbrainstorm.html?runId=${run.id}" target="_top">Create Q&A Discussion</a></li>
								    	<c:if test="${not empty run.brainstorms}" >
								            <c:forEach var="brainstorm" items="${run.brainstorms}" varStatus="brainstormVS" >
								                <li class="qaBullet"><a href="../run/brainstorm/managebrainstorm.html?brainstormId=${brainstorm.id}">Manage Q&A #${brainstormVS.index+1}</a></li>
								            </c:forEach>
								    	</c:if>
								    	 -->		
										<li><a href="/webapp/contactwiseproject.html?projectId=${run.project.id}" target="_top"><spring:message code="teacher.run.myprojectruns.22"/></a></li>
					                    <sec:accesscontrollist domainObject="${run}" hasPermission="16">					    	
								    	  <li><a onclick="javascript:popup('/webapp/teacher/run/manage/archiveRun.html?runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />')"><spring:message code="teacher.run.myprojectruns.51"/></a></li>
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
<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>