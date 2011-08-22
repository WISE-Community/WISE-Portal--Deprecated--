<%@ include file="../../../include.jsp"%>

<!DOCTYPE html >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<script src="/webapp/javascript/tels/effects.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/scriptaculous.js" type="text/javascript" ></script>

<title><spring:message code="teacher.setup-project-run-step-two" /></title>

</head>

<body>

<div id="pageWrapper">

	<%@ include file="../../../headermain.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">
					<spring:message code="teacher.setup-project-classroom-run" />
					<span class="pageTitle"><spring:message code="header.location.teacher.management"/></span>
				</div>
				<form:form method="post" commandName="runParameters" autocomplete='off'>
					<div class="panelContent">
						<div id="setUpRunBox">
							<div id="stepNumber" class="sectionHead"><spring:message code="teacher.run.setup.12"/>&nbsp;<spring:message code="teacher.run.setup.13"/></div>
							<div class="sectionContent">
	
								<h5><spring:message code="teacher.run.setup.14"/></h5>
								<h5><spring:message code="teacher.run.setup.15a"/></h5>
								<h5><spring:message code="teacher.run.setup.15b"/></h5>
	
								<c:choose>
									<c:when test="${fn:length(existingRunList) == 0}">
								      <h5 style="font-weight:bold;"><spring:message code="teacher.run.setup.16"/></h5>
									</c:when>
									<c:otherwise>
										<div id="setupProjectTableContainer">
											<table  id="setupProjectTable">
												<thead>
													<tr>
														<th><spring:message code="teacher.run.setup.17"/></th>
														<th><spring:message code="teacher.run.setup.18"/></th>
														<th><spring:message code="teacher.run.setup.19"/></th>
														<th><spring:message code="teacher.run.setup.20"/></th>
														<th><spring:message code="teacher.run.setup.21"/></th>
													</tr>
												</thead>
											    <c:forEach var="run" items="${existingRunList}">
												    <tr>
												     <td class="center">
												     
												     <!-- CHECKBOXES -->
													    <div class="runcheckboxes">
													       <form:checkbox path="runIdsToArchive" value="${run.id}" /><br/> 
													    </div>
													 <!-- END CHECKBOXES -->
											    <!--end of SetUpRunBox -->
												     </td>
													        <td><strong>${run.project.name}</strong></td>
													        <td>${run.id}</td>
													        <td>${run.starttime.month + 1}/${run.starttime.date}/${run.starttime.year + 1900}</td>
													        <td>${run.endtime}</td>
												     </tr>
												</c:forEach>
											</table>
										</div>
										<h5><spring:message code="teacher.run.setup.22"/>&nbsp;<em><spring:message code="teacher.run.setup.23"/></em>&nbsp;<spring:message code="teacher.run.setup.24"/></h5>
									</c:otherwise>
									
								</c:choose>
							
							</div>
						</div> <!-- /* End setUpRunBox */-->
						<div class="center">
							<input type="submit" name="_target0" value="<spring:message code="navigate.back" />" />
							<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel" />" />
							<input type="submit" name="_target2" value="<spring:message code="navigate.next" />" />
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->

	<%@ include file="../../../footer.jsp"%>
</div>

</body>
</html>