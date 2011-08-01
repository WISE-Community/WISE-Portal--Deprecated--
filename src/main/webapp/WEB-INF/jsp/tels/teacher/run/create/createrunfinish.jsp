<%@ include file="../../../include.jsp"%>

<!-- $Id: setuprunconfirm.jsp 2647 2010-01-08 22:46:32Z supersciencefish $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="setuprun.confirmation.title" /></title>

<script type="text/javascript" src="/webapp/javascript/pas/utils.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/rotator.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/general.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/effects.js"></script>

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

				<div id="setUpRunBoxConfirm">
					<div id="stepNumber" class="sectionHead"><spring:message code="teacher.run.setup.48"/></div>
					<div class="sectionContent">
	
						<h5><spring:message code="teacher.run.setup.49"/>&nbsp;<a href="/webapp/teacher/management/classroomruns.html">My Classroom Runs</a>&nbsp;<spring:message code="teacher.run.setup.51"/></h5>
		
						<table id="projectRunConfirmTable" border="1" cellpadding="5" cellspacing="0" >
							<tr>
								<td style="width:14%;"><spring:message code="setuprun.confirmation.run.title" /></td>
								<td style="width:40%;"><strong><c:out value="${run.project.name}" /></strong></td>
								<td class="instructions" style="width:46%;"></td>
							</tr>
							<tr>
								<td style="width:14%;">Project ID:</td>
								<td style="width:40%;"><strong><c:out value="${run.project.id}" /></strong></td>
								<td class="instructions"  style="width:46%;">Every source project has a unique ID number.</td>
							</tr>
							<tr>
								<td><spring:message code="setuprun.confirmation.run.createdtime" /></td>
								<td><strong><c:out value="${run.starttime}" /></strong></td>
								<td class="instructions" ></td>
							</tr>
							<tr>
								<td>Project Run ID:</td>
								<td><strong><c:out value="${run.id}" /></strong></td>
								<td class="instructions" >Each of your project runs also has a unique ID number.</td>
							</tr>
							<tr>
								<td>Access Code:</td>
								<td>
							    	<strong><c:out value="${run.runcode}" /></strong>
							    	&nbsp;<spring:message code="setuprun.confirmation.run.projectcodes.foryourstudentsinperiod" />
									<c:forEach var="period" items="${run.periods}">
							    		<c:out value="${period.name}" /><c:out value="," />
							  		</c:forEach>
							    	<br />
							    </td>
							    <td class="instructions" >
							    	Each Project Run has an individual Access Code that you give to your students.<br/><br/>
							    	Note: Students will manually specify their class period after entering this Access Code.<br/><br/>
							    </td>
							</tr>
						</table>
					</div>
				</div>
				<div id="gotoMyRunsButton" class="center">
					<a href="/webapp/teacher/management/classroomruns.html"  	
						onmouseout="MM_swapImgRestore()" 
						onmouseover="MM_swapImage('projectRuns','','../../themes/tels/default/images/teacher/Go-to-My-Proj-Runs-Roll.png',1)">
						<img src="../../themes/tels/default/images/teacher/Go-to-My-Proj-Runs.png" alt="My Project Runs" id="projectRuns" /> </a>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->

	<%@ include file="../../../footer.jsp"%>
</div>

</body>

</html>