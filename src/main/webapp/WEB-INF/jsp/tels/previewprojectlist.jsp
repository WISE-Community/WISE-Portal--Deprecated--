<%@ include file="include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html lang="en">
<head>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryprintelement.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerydatatables.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="facetedfilter.js"/>"></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerydatatables.css"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="facetedfilter.css"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="teacher.manage.library.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

<script type='text/javascript'>
var isTeacherIndex = true; //global var used by spawned pages (i.e. archive run)

//load thumbnails for each project by looking for curriculum_folder/assets/project_thumb.png (makes a ajax GET request)
// If found (returns 200 status), it will replace the default image with the fetched image.
// If not found (returns 400 status), it will do nothing, and the default image will be used.
function loadProjectThumbnails() {		
	$(".projectThumb").each(
		function() {
			var thumbUrl = $(this).attr("thumbUrl");
			// check if thumbUrl exists
			$.ajax({
				url:thumbUrl,
				context:this,
				statusCode: {
					200:function() {
			  		    // found, use it
						$(this).html("<img src='"+$(this).attr("thumbUrl")+"' alt='thumb'></img>");
					},
					404:function() {
					    // not found, leave alone
						//$(this).html("<img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></img>");
					}
				}
			});
		});
};

$(document).ready(function() {
	// load project thumbnails		
	loadProjectThumbnails();
	
	// Set up more details toggle click action for each project
	$('.detailsToggle, .projectTitle').live("click",function(){
		var id;
		if($(this).hasClass('detailsToggle')){
			id = $(this).attr('id').replace('detailsToggle_','');
		} else if($(this).hasClass('projectTitle')){
			id = $(this).attr('id').replace('project_','');
		}
		
		if($('#detailsToggle_' + id).hasClass('expanded')){
			toggleDetails(id,false);
		} else {
			toggleDetails(id,true);
		}
	});
	
	// Set up view project details click action for each project id link
	$('a.projectDetail').live('click',function(){
		var title = $(this).attr('title');
		var projectId = $(this).attr('id').replace('projectDetail_','');
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
	
	// Set up view lesson plan click action for each project
	$('a.viewLesson').live('click',function(){
		var id = $(this).attr('id').replace('viewLesson_','');
		$('#lessonPlan_' + id).dialog({
			width: 800,
			height: 400, // TODO: modify so height is set to 'auto', but if content results in dialog taller than window on load, set height smaller than window
			buttons: { "Close": function() { $(this).dialog("close"); } }
		});
	});
	
	// Set up print lesson click action for each project
	$('.printLesson').live('click',function(){
		var id = $(this).attr('id').replace('printLesson_','');
		var printstyle = "<spring:theme code="teacherrunstylesheet"/>"; // TODO: create print-optimized stylesheet
		$('#lessonPlan_' + id).printElement({
			pageTitle:'LessonPlan-WISE4-Project-' + id + '.html',
			overrideElementCSS:[{href:printstyle, media:'print'}] // TODO: create print-optimized stylesheet
		});
	});
	
	var otable = $('#libraryTable').dataTable({
		"iDisplayLength": -1,
		"aaSorting": [ [0,'asc'] ],
		"oLanguage": {
			"sInfo": "_TOTAL_ <spring:message code="teacher.datatables.16"/>",
			// TODO: Mofidy these entries in ui-html.properties (make separate entries for datatables - not teacher.datatables.1, for ex.)
			"sInfoEmpty": "<spring:message code="teacher.datatables.3"/>",
			"sInfoFiltered": "<spring:message code="teacher.datatables.17"/> _MAX_ <spring:message code="teacher.datatables.18"/>", // (from _MAX_ total)
			"sLengthMenu": "<spring:message code="teacher.datatables.5"/> _MENU_ <spring:message code="teacher.datatables.6"/>",
			"sProcessing": "<spring:message code="teacher.datatables.7"/>",
			"sZeroRecords": "<spring:message code="teacher.datatables.8"/>",
			"sInfoPostFix":  "<spring:message code="teacher.datatables.9"/>",
			"sSearch": "<spring:message code="teacher.datatables.10"/>",
			"sUrl": "<spring:message code="teacher.datatables.11"/>"
		},
		"sDom":'<"top"i<"clear">>rt<"bottom"i<"clear">><"clear">'
	});
	
	var facets = new FacetedFilter( otable.fnSettings(), {
		"bScroll": false,
		"sClearFilterLabel": "Clear",
		"aSearchOpts": [
			{
				"identifier": "<spring:message code="teacher.datatables.search.1a"/>", "label": "<spring:message code="teacher.datatables.search.1b"/> ", "column": 0, "maxlength": 50
			}
		 ],
		"aFilterOpts": [
			{
				"identifier": "subject", "label": "Subject:", "column": 1,
				"options": [
					{"query": "Earth Science", "display": "Earth Science"},
					{"query": "Life Science", "display": "Life Science"},
					{"query": "Physical Science", "display": "Physical Science"},
					{"query": "Biology", "display": "Biology"},
					{"query": "Chemistry", "display": "Chemistry"},
					{"query": "Physics", "display": "Physics"}
				]
			}
		]
	});
	
	function toggleDetails(id,open){
		if (typeof open == 'undefined'){
			open = false;
		}
		if (open){
			if($('#projectBox_' + id).hasClass('childProject')){
				$('#projectBox_' + id + ' .childDate').hide();
				$('#projectBox_' + id + ' ul.actions').show();
				$('#projectBox_' + id + ' .projectSummary').slideDown('fast');
				$('#projectBox_' + id + ' .detailsLinks').slideDown('fast');
			} else {
				$('#summaryText_' + id + ' .ellipsis').remove();
				$('#summaryText_' + id + ' .truncated').slideDown('fast');
				$('#summaryText_' + id + ' .truncated').css('display','inline');
			}
			$('#detailsToggle_' + id).addClass('expanded').text('Details -');
			$('#details_' + id).slideDown('fast');
		} else {
			if($('#projectBox_' + id).hasClass('childProject')){
				$('#projectBox_' + id + ' .childDate').show();
				$('#projectBox_' + id + ' ul.actions').hide();
				if($('#projectBox_' + id).is(":hidden")) {
					$('#projectBox_' + id + ' .projectSummary').hide();
					$('#projectBox_' + id + ' .detailsLinks').hide();
				} else {
					$('#projectBox_' + id + ' .projectSummary').slideUp('fast');
					$('#projectBox_' + id + ' .detailsLinks').slideUp('fast');
				}
			} else {
				if($('#summaryText_' + id + ' span.ellipsis').length == 0){
					$('#summaryText_' + id + ' .truncated').before('<span class="ellipsis">...</span>');	
				}
				if($('#projectBox_' + id).is(":hidden")) {
					$('#summaryText_' + id + ' .truncated').hide();
				} else {
					$('#summaryText_' + id + ' .truncated').slideUp('fast');
				}
			}
			if($('#projectBox_' + id).is(":hidden")) {
				$('#details_' + id).hide();
			} else {
				$('#details_' + id).slideUp('fast');
			}
			$('#detailsToggle_' + id).removeClass('expanded').text('Details +');
		}
	};
});
	
</script>

</head>
    
<body>
<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
			
				<div class="panelHeader">Preview WISE Curricula</div>
				
				<div class="panelContent">
					
					<div class="featureContent">
						<table id="libraryTable" class="projectTable">
							<thead class="tableHeaderMain">
								<tr style="display:none;">
									<th>project</th>
									<th>subject</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="project" items="${projectList}">
								<tr class="projectRow" id="projectRow_${project.id}">
									<td>
										<c:set var="projectClass" value="projectBox" />
										<div class="${projectClass}" id="projectBox_${project.id}">
											<div class="projectOverview">
												<div class="projectHeader">
													<div class="projectInfo">
														<c:set var="bookmarked" value="false" />
														<c:forEach var="bookmark" items="${bookmarkedProjectsList}">
															<c:if test="${bookmark.id == project.id}">
																<c:set var="bookmarked" value="true" />
															</c:if>
														</c:forEach>
														<a class="projectTitle" id="project_${project.id}">${project.name}</a>
														<span>(ID: ${project.id})</span>
													</div>
													<div class="projectTools">
														<ul class="actions">
															<li><a style="font-weight:bold;" href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank">Preview</a></li>
														</ul>
													</div>
												</div>
												<div style="clear:both;"></div>
												<div class="projectSummary">
													<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
													<div class="summaryInfo">
														<div class="libraryIcon"><img src="/webapp/themes/tels/default/images/open_book.png" alt="library project" /> WISE Library Project</div>
														<div class="basicInfo">
															<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
															<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}">Grades ${project.metadata.gradeRange} | </c:if>
															<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}">Duration: ${project.metadata.totalTime} | </c:if>
															<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
															<div style="float:right;">Created: <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></div>
														</div>
														<div id="summaryText_${project.id}" class="summaryText">
														<c:if test="${fn:length(project.metadata.summary) != null && fn:length(project.metadata.summary) != ''}">
															<c:choose>
																<c:when test="${(fn:length(project.metadata.summary) > 170) && (projectClass != 'projectBox childProject')}">
																	<c:set var="length" value="${fn:length(project.metadata.summary)}" />
																	<c:set var="summary" value="${fn:substring(project.metadata.summary,0,170)}" />
																	<c:set var="truncated" value="${fn:substring(project.metadata.summary,170,length)}" />
																	<span style="font-weight:bold;">Summary:</span> ${summary}<span class="ellipsis">...</span><span class="truncated">${truncated}</span>
																</c:when>
																<c:otherwise>
																	<span style="font-weight:bold;">Summary:</span> ${project.metadata.summary}
																</c:otherwise>
															</c:choose>
														</c:if>
														</div>
														<div class="details" id="details_${project.id}">
															<c:if test="${project.metadata.keywords != null && project.metadata.keywords != ''}"><p><span style="font-weight:bold;">Tags:</span> ${project.metadata.keywords}</p></c:if>
															<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;">Tech Requirements:</span> ${project.metadata.techDetailsString} (<a href="/webapp/check.html" target="_blank">Check Compatibility</a>)</p></c:if>
															<c:if test="${project.metadata.compTime != null && project.metadata.compTime != ''}"><p><span style="font-weight:bold;">Computer Time:</span> ${project.metadata.compTime}</p></c:if>
															<p><span style="font-weight:bold;">Questions/Comments:</span> <a href="/webapp/contactwiseproject.html?projectId=${project.id}">Contact WISE</a></p>
															<c:if test="${project.metadata.author != null && project.metadata.author != ''}"><p><span style="font-weight:bold;">Contributors:</span> ${project.metadata.author}</p></c:if>
															<c:set var="lastEdited" value="${project.metadata.lastEdited}" />
															<c:if test="${lastEdited == null || lastEdited == ''}">
																<c:set var="lastEdited" value="${project.dateCreated}" />
															</c:if>
															<p><span style="font-weight:bold;">Last Updated:</span> <fmt:formatDate value="${lastEdited}" type="both" dateStyle="medium" timeStyle="short" /></p>
															<c:if test="${(project.metadata.lessonPlan != null && project.metadata.lessonPlan != '') ||
																(project.metadata.standards != null && project.metadata.standards != '')}">
																<div class="viewLesson"><a class="viewLesson" id="viewLesson_${project.id}" title="Review Teaching Tips and Content Standards for this project">Teaching Tips & Standards</a></div>
																<div class="lessonPlan" id="lessonPlan_${project.id}" title="Teaching Tips & Content Standards">
																	<div class="panelHeader">${project.name} (ID: ${project.id})
																		<span style="float:right;"><a class="printLesson" id="printLesson_${project.id}">Print</a></span>
																	</div>
																	<c:if test="${project.metadata.lessonPlan != null && project.metadata.lessonPlan != ''}">
																		<div class="basicInfo sectionContent">
																			<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
																			<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}">Grades ${project.metadata.gradeRange} | </c:if>
																			<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}">Duration: ${project.metadata.totalTime} | </c:if>
																			<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
																			<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;">Tech Requirements:</span> ${project.metadata.techDetailsString}</p></c:if>
																		</div>
																		<div class="sectionHead">Teaching Tips</div>
																		<div class="lessonHelp">(Outlines technical or classroom requirements for the project's activities, 
																			common misconceptions/mistakes students may encounter, as well as suggestions for maximizing the project's effectiveness and student learning.)
																		</div><!-- TODO: remove this, convert to global info/help rollover popup -->
																		<div class="sectionContent">${project.metadata.lessonPlan}</div>
																	</c:if>
																	<c:if test="${project.metadata.standards != null && project.metadata.standards != ''}">
																		<div class="sectionHead">Learning Goals and Standards</div>
																		<div class="lessonHelp">(Outlines the curriculum standards covered by the project, the
					            											project's overall learning goals, and the goals of each activity in the project.)
																		</div><!-- TODO: remove this, convert to global info/help rollover popup -->
																		<div class="sectionContent">${project.metadata.standards}</div>
																	</c:if>
																</div>
														</c:if>
														</div>
													</div>
												</div>
												<div style="clear:both;"></div>
												<div class="detailsLinks">
													<div style="float:right; text-align:right">
														<a id="detailsToggle_${project.id}" class="detailsToggle">Details +</a>
													</div>
													<div style="clear:both;"></div>
												</div>
											</div>
										</div>
									</td>
									<td style="display:none;">${project.metadata.subject}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="footer.jsp"%>
</div>

</body>

</html>
</html>

