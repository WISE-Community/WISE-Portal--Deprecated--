<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryprintelement.js"/>"></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="teacher.manage.library.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

<script type='text/javascript'>
var isTeacherIndex = true; //global var used by spawned pages (i.e. archive run)
</script>

</head>
    
<body>
<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
			
				<div class="panelHeader">WISE Project Library</div>
				
				<div class="panelContent">
					<div class="featureContentHeader">Earth Science</div>
					<table class="projectTable">
						<tbody>
						<c:choose>
							<c:when test="${fn:length(esProjects) > 0}">
								<c:forEach var="project" items="${esProjects}">
									<tr class="projectRow" id="projectRow_${project.id}">
										<td>
											<c:set var="projectClass" value="projectBox" />
											<div class="${projectClass}" id="projectBox_${project.id}">
												<table class="projectOverviewTable">
													<tr>
														<td colspan="4" style="max-width: 310px;">
															<c:set var="bookmarked" value="false" />
															<a class="projectTitle" id="project_${project.id}">${project.name}</a>
															<span>(ID: ${project.id})</span>
														</td>
														<td colspan="1" style="text-align:right;">
															<ul class="actions">
																<li><a style="font-weight:bold;" href="<c:url value="/previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>" target="_blank">Preview</a></li>
															</ul>
														</td>
													</tr>
													
													<tr>
														<td colspan="5" class="projectSummary">
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
																	<c:if test="${project.metadata.contact != null && project.metadata.contact != ''}"><p><span style="font-weight:bold;">Contact Info:</span> ${project.metadata.contact}</p></c:if>
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
														</td>
													</tr>
													<tr class="detailsLinks">
														<td colspan="5">
															<div style="float:right; text-align:right">
																<a id="detailsToggle_${project.id}" class="detailsToggle">Details +</a>
															</div>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
						</tbody>
					</table>
				</div>
					
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="footer.jsp"%>
</div>

</body>

</html>