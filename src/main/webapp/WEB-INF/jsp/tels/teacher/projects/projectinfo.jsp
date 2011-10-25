 <%@ include file="../include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE HTML>
<html lang="en">
<head>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>


<title><spring:message code="teacher.pro.projinfo.1"/></title>

<script type="text/javascript">
	$(document).ready(function(){
		// load project thumbnails		
		loadProjectThumbnails();
		
		$('#viewLesson_' + ${project.id}).click(function(){
			$('#lessonPlan_' + ${project.id}).slideToggle();
		});
	});
	
	// load thumbnails for each project by looking for curriculum_folder/assets/project_thumb.png (makes a ajax GET request)
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
</script>

</head>

<body style="background:#FFFFFF;">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="projectSummary">
	<div class="projectInfoDisplay">
		<div class="panelHeader">${project.name} (ID: ${project.id})
			<span style="float:right;"><a href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank"><img class="icon" alt="preview" src="/webapp/themes/tels/default/images/icons/teal/screen.png" /><span>Preview</span></a></span>
		</div>
		<div class="projectThumb" thumbUrl="${projectThumbPath}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
		<div class="summaryInfo">
			<div class="basicInfo">
				<c:if test="${project.metadata.subject != null && project.metadata.subject != ''}">${project.metadata.subject} | </c:if>
				<c:if test="${project.metadata.gradeRange != null && project.metadata.gradeRange != ''}">Grades ${project.metadata.gradeRange} | </c:if>
				<c:if test="${project.metadata.totalTime != null && project.metadata.totalTime != ''}">Duration: ${project.metadata.totalTime} | </c:if>
				<c:if test="${project.metadata.language != null && project.metadata.language != ''}">${project.metadata.language}</c:if>
				<div style="float:right;">Created: <fmt:formatDate value="${project.dateCreated}" type="date" dateStyle="medium" /></div>
			</div>
			<div id="summaryText_${project.id}" class="summaryText">
				<span style="font-weight:bold;">Summary:</span> ${project.metadata.summary}
			</div>
			<div class="details" id="details_${project.id}">
				<c:if test="${project.metadata.keywords != null && project.metadata.keywords != ''}"><p><span style="font-weight:bold;">Tags:</span> ${project.metadata.keywords}</p></c:if>
				<c:if test="${project.metadata.techDetailsString != null && project.metadata.techDetailsString != ''}"><p><span style="font-weight:bold;">Tech Requirements:</span> ${project.metadata.techDetailsString}</p></c:if>
				<c:if test="${project.metadata.compTime != null && project.metadata.compTime != ''}"><p><span style="font-weight:bold;">Computer Time:</span> ${project.metadata.compTime}</p></c:if>
				<p><span style="font-weight:bold;">Questions/Comments:</span> <a href="/webapp/contactwiseproject.html?projectId=${project.id}" target="_blank">Contact WISE</a></p>
				<c:if test="${project.metadata.author != null && project.metadata.author != ''}"><p><span style="font-weight:bold;">Contributors:</span> ${project.metadata.author}</p></c:if>
				<c:set var="lastEdited" value="${project.metadata.lastEdited}" />
				<c:if test="${lastEdited == null || lastEdited == ''}">
					<c:set var="lastEdited" value="${project.dateCreated}" />
				</c:if>
				<p><span style="font-weight:bold;">Last Updated:</span> <fmt:formatDate value="${lastEdited}" type="both" dateStyle="medium" timeStyle="short" /></p>
				<c:if test="${project.parentProjectId != null}">
					<p><span style="font-weight:bold"><spring:message code="teacher.run.myprojectruns.40"/></span> ${project.parentProjectId}</p>
				</c:if>
				<c:if test="${(project.metadata.lessonPlan != null && project.metadata.lessonPlan != '') ||
					(project.metadata.standards != null && project.metadata.standards != '')}">
					<div class="viewLesson"><a class="viewLesson" id="viewLesson_${project.id}" title="Review Teaching Tips and Content Standards for this project">Teaching Tips & Standards</a></div>
					<div class="lessonPlan" style="display:none;" id="lessonPlan_${project.id}" title="Teaching Tips & Content Standards">
						<c:if test="${project.metadata.lessonPlan != null && project.metadata.lessonPlan != ''}">
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
</div>

</body>
</html>
