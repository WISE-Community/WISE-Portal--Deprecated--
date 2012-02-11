<%@ include file="../include.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerydatatables.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="facetedfilter.js"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerydatatables.css"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="facetedfilter.css"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="admin.manage.runs.title" /></title>

<!-- TODO: move to separate js setup file (will require js i18n implementation for portal) -->
<script type="text/javascript">
	$(document).ready(function() {
		var oTable = $('.runTable').dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 10,
			"aLengthMenu": [[10, 25, 100, -1], [10, 25, 100, "All"]],
			"bSort": false,
			"oLanguage": {
				"sInfo": "<spring:message code="teacher.datatables.1"/> _START_-_END_ <spring:message code="teacher.datatables.2"/> _TOTAL_",
				"sInfoEmpty": "<spring:message code="teacher.datatables.3"/>",
				"sInfoFiltered": "<spring:message code="teacher.datatables.4"/>", // (from _MAX_ total)
				"sLengthMenu": "<spring:message code="teacher.datatables.5"/> _MENU_ <spring:message code="teacher.datatables.6"/>",
				"sProcessing": "<spring:message code="teacher.datatables.7"/>",
				"sZeroRecords": "<spring:message code="teacher.datatables.8"/>",
				"sInfoPostFix":  "<spring:message code="teacher.datatables.9"/>",
				"sSearch": "<spring:message code="teacher.datatables.10"/>",
				"sUrl": "<spring:message code="teacher.datatables.11"/>",
				"oPaginate": {
					"sFirst":    "<spring:message code="teacher.datatables.12"/>",
					"sPrevious": "<spring:message code="teacher.datatables.13"/>",
					"sNext":     "<spring:message code="teacher.datatables.14"/>",
					"sLast":     "<spring:message code="teacher.datatables.15"/>"
				}
			},
			"fnDrawCallback": function( oSettings ){
				// automatically scroll to top on page change
				var tableID = $(this).attr('id');
				var targetOffset = $('#' + tableID).offset().top - 14;
				if ($(window).scrollTop() > targetOffset){
					$('html,body').scrollTop(targetOffset);
				}
			},
			"sDom":'<"top"lip>rt<"bottom"ip><"clear">'
		});
		
		// define sort options
		var sortParams = {
			"items": [
				{"label": "<spring:message code="teacher.datatables.sort.1a"/>", "column": 7, "direction": "desc" },
				{"label": "<spring:message code="teacher.datatables.sort.1b"/>", "column": 7, "direction": "asc" },
				{"label": "<spring:message code="teacher.datatables.sort.1c"/>", "column": 0, "direction": "asc" },
				{"label": "<spring:message code="teacher.datatables.sort.1d"/>", "column": 0, "direction": "desc" }
			]
		};
		
		// setup sorting
		function setSort(index,sortParams,wrapper) {
			if(sortParams.items.length){
				// insert sort options into DOM
				var sortHtml = '<div class="dataTables_sort"><spring:message code="teacher.datatables.sort.label"/> <select id="' + 'sort_' + index + '"  size="1">';
				$.each(sortParams.items,function(){
					sortHtml += '<option>' + this.label + '</option>';
				});
				sortHtml +=	'</select></div>';
				$(wrapper).children('.top').prepend(sortHtml);
				
				$('#sort_' + index).change(function(){
					$.fn.dataTableExt.iApiIndex = index;
					var i = $('option:selected', '#sort_' + index).index();
					oTable.fnSort( [ [sortParams.items[i].column,sortParams.items[i].direction] ] );
				});
			}
		};
		
		var i;
		for(i=0; i<oTable.length; i++){
			oTable.dataTableExt.iApiIndex = i;
			var wrapper = oTable.fnSettings().nTableWrapper;
			var table = oTable.fnSettings();
			var id = $(table.oInstance).attr('id');
			
			// Define FacetedFilter options
			var facets = new FacetedFilter( table, {
				"bScroll": false,
				"sClearFilterLabel": "<spring:message code="teacher.datatables.filter.clear"/>",
				"sClearSearchLabel": "<spring:message code="teacher.datatables.search.clear"/>",
				"sFilterLabel": "<spring:message code="teacher.datatables.filter.label"/>",
				"sSearchLabel": "<spring:message code="teacher.datatables.search.label"/>",
				"aSearchOpts": [
					{
						"identifier": "<spring:message code="teacher.datatables.search.1a"/>", "label": "<spring:message code="teacher.datatables.search.1b"/> ", "column": 0, "maxlength": 50
					}
				 ],
				"aFilterOpts": [
					<c:if test="${empty param.q}">
					{
						"identifier": "<spring:message code="admin.datatables.filter.1a"/>", "label": "<spring:message code="admin.datatables.filter.1b"/>", "column": 10,
						"options": [
							{"query": "current", "display": "<spring:message code="admin.datatables.filter.1c"/>"},
							{"query": "archived", "display": "<spring:message code="admin.datatables.filter.1d"/>"}
						]
					}
					</c:if>
					/*{
						"identifier": "<spring:message code="teacher.run.myprojectruns.58C"/>", "label": "<spring:message code="teacher.datatables.filter.2a"/>", "column": 5,
						"options": [
							{"query": "custom", "display": "<spring:message code="teacher.datatables.filter.2b"/>"},
							{"query": "library", "display": "<spring:message code="teacher.datatables.filter.2c"/>"}
						]
					}*/
				]
			});
			
			// add sort logic
			setSort(i,sortParams,wrapper);
			
			// reset cloumn widths on run tables (datatables seems to change these)
			$('.runHeader').width(215);
			$('.studentHeader').width(145);
			$('.teacherHeader').width(115);
			$('.toolsHeader').width(170);
			
			oTable.fnSort( [ [7,'desc'] ] );
		}
		
		// Make top header scroll with page
		var $stickyEl = $('.dataTables_wrapper .top');
		if($stickyEl.length>0){
			var elTop = $stickyEl.offset().top,
			width = $stickyEl.width();
			$(window).scroll(function() {
		        var windowTop = $(window).scrollTop();
		        if (windowTop > elTop) {
		            $stickyEl.addClass('sticky');
		        	$stickyEl.css('width',width);
		        } else {
		            $stickyEl.removeClass('sticky');
		        	$stickyEl.css('width','auto');
		        }
		    });
		}
	});

	//setup grading and classroom monitor dialogs
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
		div.dialog({
			modal: true,
			width: '650',
			height: '450',
			title: title,
			position: 'center',
			close: function(){ 
				$(this).html('');
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

	//setup archive and restore run dialogs
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
			},
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#archiveRunDialog > #archiveIfrm").attr('src',path);
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

	//Set up view project details click action for each project id link
	$('a.projectDetail').live('click',function(){
		var title = $(this).attr('title');
		if($(this).hasClass('projectDetail')){
			var projectId = $(this).attr('id').replace('projectDetail_','');
		} else if($(this).hasClass('projectInfo')){
			var projectId = $(this).attr('id').replace('projectInfo_','');
		}
		var path = "/webapp/teacher/projects/projectinfo.html?projectId=" + projectId;
		var div = $('#projectDetailDialog').html('<iframe id="projectIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '800',
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
		$("#projectDetailDialog > #projectIfrm").attr('src',path);
	});
</script>

</head>

<body>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="contentPanel">
				<div class="panelHeader"><spring:message code="admin.manage.runs.1" />
					<span class="pageTitle"><spring:message code="header.location.admin"/></span>
				</div>
				
				<div class="panelContent">
					<table id="adminManageRunsTable" class="runTable">
					  <thead>
					    <tr>
					      <th class="tableHeaderMain runHeader" style="width:215px;"><spring:message code="admin.manage.runs.2" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.3" /></th>
						  <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.4" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.5" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.6" /></th>
					      <th class="tableHeaderMain studentHeader" style="width:145px;"><spring:message code="admin.manage.runs.7" /></th>
					      <th class="tableHeaderMain teacherHeader" style="width:115px;"><spring:message code="admin.manage.runs.8" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.9" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.10" /></th>
					      <th class="tableHeaderMain toolsHeader" style="width:195px;"><spring:message code="admin.manage.runs.11" /></th>
					      <th class="tableHeaderMain hidden"><spring:message code="admin.manage.runs.23" /></th>
					    </tr>
					  </thead>
					  <c:forEach var="run" items="${runList}">
					  <tr>
					    <td>
					    	<div class="runTitle">${run.name}</div>
				    		<table class="runTitleTable admin">
				      			<tr>
									<th><spring:message code="admin.manage.runs.20" /></th>
									<td class="accesscode">${run.runcode}</td>
								</tr>
								
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.11" /></th>
				      				<td>${run.id}</td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="admin.manage.runs.21"/></th>
				      				<td><fmt:formatDate value="${run.starttime}" type="date" dateStyle="medium" /></td>
				      			</tr>
				      			<c:if test="${run.endtime != null}">
				      				<tr>
					      				<th><spring:message code="admin.manage.runs.22"/></th>
					      				<td class="archivedDate"><fmt:formatDate value="${run.endtime}" type="date" dateStyle="medium" /></td>
					      			</tr>
					      		</c:if>
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
						<td class="hidden">${run.id}</td>
					    <td class="hidden">
					    	<a id="projectDetail_${run.project.id}" class="projectDetail" title="<spring:message code="teacher.pro.info"/>">${run.project.id}</a>
					    	<c:if test="${run.project.parentProjectId != null}">
					    	   (copy of <a id="projectDetail_${run.project.parentProjectId}" class="projectDetail" title="<spring:message code="teacher.pro.info"/>">${run.project.parentProjectId}</a>)
					    	</c:if>
					    </td>
					    <td class="hidden">${run.name}</td>
					    <td class="hidden">${run.runcode}</td>
					    <td style="padding:.5em 0;" >
					    	<table class="currentRunInfoTable">
					          <tr>
					            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.29"/></th>
					            <th class="tableInnerHeader"><spring:message code="teacher.run.myprojectruns.9"/></th>
					          </tr>
					          <c:set var="totalnumstudentsinrun" value="0" scope="session" />
					          <c:forEach var="period" items="${run.periods}">
					          	<c:set var="totalnumstudentsinrun" value="${totalnumstudentsinrun + fn:length(period.members)}" scope="session" />
					            <tr>
					              <td style="width:35%;" class="tableInnerData">${period.name}</td>
					              <td style="width:65%;" class="tableInnerDataRight">
					              	<a class="manageStudents" title="<spring:message code="teacher.run.myprojectruns.62"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&periodName=${period.name}">${fn:length(period.members)}&nbsp;<spring:message code="teacher.run.myprojectruns.10"/></a>
					              </td>
					            </tr>
					          </c:forEach>
					          <tr><td colspan="2" class="manageStudentGroups"><spring:message code="admin.manage.runs.12" /> ${totalnumstudentsinrun}</td></tr>
					          <tr>
					          	<td colspan="2" class="manageStudentGroups">
					          		<a class="manageStudents" title="<spring:message code="teacher.run.myprojectruns.62"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}"><img class="icon" alt="groups" src="/webapp/themes/tels/default/images/icons/teal/connected.png" /><span><spring:message code="teacher.run.myprojectruns.62"/></span></a>
					          	</td>
					          </tr>
					        </table>
					    </td>
					    <td style="font-size:.95em;"><c:forEach var="owner" items="${run.owners}"><a href="../j_acegi_switch_user?j_username=${owner.userDetails.username}" title="<spring:message code="admin.manage.runs.13" />">${owner.userDetails.firstname} ${owner.userDetails.lastname}</a><br/>(${owner.userDetails.schoolname}, ${owner.userDetails.city}, ${owner.userDetails.state}, ${owner.userDetails.country})</c:forEach></td>
					    <td class="hidden"><fmt:formatDate value="${run.starttime}" type="both" dateStyle="short" timeStyle="short" /></td>
					    <td class="hidden"><fmt:formatDate value="${run.endtime}" type="both" dateStyle="short" timeStyle="short" /></td>
					    <td>
				    		<ul class="actionList">
								<li><span style="font-weight:bold;"><spring:message code="teacher.run.myprojectruns.16"/>:</span> <a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=step&getRevisions=false&minified=true"><spring:message code="admin.manage.runs.14" /></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/>: ${run.id})" id="runId=${run.id}&gradingType=step&getRevisions=true&minified=true"><spring:message code="admin.manage.runs.15" /></a></li>
		  	                    <li><span style="font-weight:bold;"><spring:message code="teacher.run.myprojectruns.17"/>:</span> <a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=false&minified=true"><spring:message code="admin.manage.runs.14" /></a>&nbsp;|&nbsp;<a class="grading" title="Grading & Feedback: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/>: ${run.id})" id="runId=${run.id}&gradingType=team&getRevisions=true&minified=true"><spring:message code="admin.manage.runs.15" /></a></li>
			               </ul> 
					   		<ul class="actionList">
					   			<li><a class="researchTools" title="<spring:message code="teacher.run.myprojectruns.64"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})" id="runId=${run.id}&gradingType=export"><img class="icon" alt="export" src="/webapp/themes/tels/default/images/icons/teal/save.png" /><span><spring:message code="teacher.run.myprojectruns.64"/></span></a></li>	
					   			<li><a id="shareRun_${run.id}" class="shareRun" title="<spring:message code="teacher.run.myprojectruns.63"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="share" src="/webapp/themes/tels/default/images/icons/teal/agent.png" /><span><spring:message code="admin.manage.runs.16" /></span></a></li>
					   			<c:choose>    	
						    		<c:when test="${run.endtime != null}">
						    			<li><a class="activateRun" id="activateRun_runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />" title="<spring:message code="teacher.run.myprojectruns.68"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="archive" src="/webapp/themes/tels/default/images/icons/teal/unlock.png" /><span><spring:message code="admin.manage.runs.18" /></span></a></li>
						    		</c:when>
						    		<c:otherwise>
						    			<li><a class="archiveRun" id="archiveRun_runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />" title="<spring:message code="teacher.run.myprojectruns.67"/>: ${run.name} (<spring:message code="teacher.run.myprojectruns.11B"/> ${run.id})"><img class="icon" alt="archive" src="/webapp/themes/tels/default/images/icons/teal/lock.png" /><span><spring:message code="admin.manage.runs.17" /></span></a></li>
						    		</c:otherwise>
						    	</c:choose>
					   		</ul>
					    </td>
					    <td class="hidden">
					    	<c:choose>
					    		<c:when test="${run.endtime != null}">archived</c:when>
					    		<c:otherwise>current</c:otherwise>
					    	</c:choose>
					    </td>
					   </tr>
					  </c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
</div>

<div id="gradingDialog" class="dialog"></div>
<div id="shareDialog" class="dialog"></div>
<div id="editRunDialog" class="dialog"></div>
<div id="manageStudentsDialog" style="overflow:hidden;" class="dialog"></div>
<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
<div id="archiveRunDialog" style="overflow:hidden;" class="dialog"></div>

</body>
</html>