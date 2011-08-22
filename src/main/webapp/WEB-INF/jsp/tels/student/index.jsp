<%@ include file="../include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title><spring:message code="application.title" /></title>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="superfishsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="browserdetectsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="checkcompatibilitysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="studenthomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
// only alert user about browser comptibility issue once.
if ($.cookie("hasBeenAlertedBrowserCompatibility") != "true") {
	alertBrowserCompatibility();
}
$.cookie("hasBeenAlertedBrowserCompatibility","true");    

$(document).ready(function() {
	// create add project dialog
	$("#addprojectLink").bind("click", function() {
		var addProjectDialogHtml = '<div style="display:none" id="addProjectDialog">'+
		'<iframe id="addProjectFrame" src="addproject.html" width="100%" height="99%" frameborder="0" allowTransparency="false"> </iframe>'+			
		'</div>';
		if ($("#addProjectDialog").length == 0) {
			$("#centeredDiv").append(addProjectDialogHtml);	
		}
		$("#addProjectDialog").dialog({
			position:["center","center"],
			modal:true,
			resizable:false,
			width:600,
			height:400,
			title: '<spring:message code="student.index.44"/>'
		});

	});

	// create change password dialog
	$("#changePasswordLink").bind("click", function() {
		var changePasswordDialogHtml = '<div style="display:none; overflow-y:hidden;" id="changePasswordDialog">'+
		'<iframe id="changePasswordFrame" src="changestudentpassword.html" width="100%" height="99%" allowTransparency="false"> </iframe>'+			
		'</div>';
		if ($("#changePasswordDialog").length == 0) {
			$("#centeredDiv").append(changePasswordDialogHtml);	
		}
		$("#changePasswordDialog").dialog({
			modal:true,
			resizable:false,
			width:600,
			height:300,
			title: 'Change Password',
			buttons: {
				'Close': function(){ $(this).dialog('destroy'); }
			}
		});

	});

	// make tabs for current/archived runs
    $("#tabSystem").tabs();		
});
</script>

<script type="text/javascript">
	function popup(URL) {
  	window.open(URL, 'SelectTeam', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=850,height=600,left = 570,top = 300');}
  	
  	function invalidateLink(linkID) {
  	   window.location= document.getElementById(linkID).href;
  	   document.getElementById(linkID).href="#";
  	   document.getElementById(linkID).style.backgroundColor='#000066';
  	   document.getElementById(linkID).style.color='#666666';
  	}
</script>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src=".././javascript/tels/iefixes.js"></script>
<![endif]-->

<!--[if IE 5]>
<style>
#studentActionList a:link, #studentActionList a:visited {
	float: left;
	clear: both;
	width: 100%;
	font-family: "Gill Sans", Helvetica, Arial, "Lucida Grande", "Lucida San Unicode";
			}
</style>
<![endif]-->

<!--[if lte IE 6]>
<style>
#studentActionList a:link, #studentActionList a:visited {
	height: 1%;
	font-family: "Gill Sans", Helvetica, Arial, "Lucida Grande", "Lucida San Unicode";
		}
</style>
<![endif]-->

<link rel="shortcut icon" href="../themes/tels/default/images/favicon_panda.ico" />

</head>

<body>

<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
	

			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			
			<%@page import="java.util.*" %>
	
			<div class="sidebar sidebarLeft">
				<div class="sidePanel">
					<div class="panelHeader"><spring:message code="student.index.welcome"/></div>
					<div class="panelContent">
						<div class="sideContent">
							<c:set var="current_date" value="<%= new java.util.Date() %>" />
							<c:choose>
						        <c:when test="${(current_date.hours>=3) && (current_date.hours<12)}" >
						            <spring:message code="student.index.2"/>
						        </c:when>
						        <c:when test="${(current_date.hours>=12) && (current_date.hours<18)}" >
									<spring:message code="student.index.3"/>
						        </c:when>
						        <c:otherwise>
									<spring:message code="student.index.4"/>
						        </c:otherwise>
						    </c:choose>
						</div>
					</div>
				</div>
				<div class="sidePanel">
					<div class="panelHeader"><spring:message code="wise.account-options" /></div>
					<div class="panelContent">
						<!-- <div style="text-align:center;"><img src="../themes/tels/default/images/student/Panda.jpg" width="220"  alt="WISE 3 Panda" /></div>  -->
				
						<div id="optionButtons" class="sideContent">
							<ul>
							<li>
								<a onmouseover="swapImage('studentaddproject','<spring:theme code="student_add_project_roll" />');"
								onmouseout="swapImage('studentaddproject','<spring:theme code="student_add_project" />');"
								class="addprojectLink" id="addprojectLink"> <img id="studentaddproject"
								src="<spring:theme code="student_add_project" />" /> </a>
							</li>
				<!-- 			
							<li><a href="#"
						        onclick=""	
								onmouseover="swapImage('studentopenjournal','<spring:theme code="student_open_journal_roll" />');"
								onmouseout="swapImage('studentopenjournal','<spring:theme code="student_open_journal" />');"	>
								<img id="studentopenjournal" src="<spring:theme code="student_open_journal" />"
								style="border: 0px;" /> </a></li>
				 -->				
							<li><a id="changePasswordLink" onmouseover="swapImage('studentchangepwd','<spring:theme code="student_change_password_roll" />');"
								onmouseout="swapImage('studentchangepwd','<spring:theme code="student_change_password" />');"
								> <img
								id="studentchangepwd"
								src="<spring:theme code="student_change_password" />"
								style="border: 0px;" /> </a></li>
								
							<li><a href="<c:url value="/j_spring_security_logout"/>"
								onmouseover="swapImage('studentsignout','<spring:theme code="student_sign_out_roll" />');"
								onmouseout="swapImage('studentsignout','<spring:theme code="student_sign_out" />');"> 
								<img id="studentsignout" src="<spring:theme code="student_sign_out" />"
								style="border: 0px;" /> </a></li>
										
							<!-- <li><a onmouseover="swapImage('studentchangelang','<spring:theme code="student_change_lang_roll" />');"
								onmouseout="swapImage('studentchangelang','<spring:theme code="student_change_lang" />');"
								onclick="javascript:alert('This page is not available yet')"> <img
								id="studentchangelang"
								src="<spring:theme code="student_change_lang" />"
								style="border: 0px;" /> </a></li> -->
						
							</ul>
						</div>
						<div class="sideContent">	
							<table id="list2">
								<tr>
									<td style="width:90px;"><spring:message code="student.index.6"/></td>
									<td>
									<c:choose>
										<c:when test="${user.userDetails.lastLoginTime == null}">
											<spring:message code="student.index.7"/>
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${user.userDetails.lastLoginTime}" 
												type="both" dateStyle="short" timeStyle="short" />
										</c:otherwise>
									</c:choose>
										
									</td>
								</tr>
								<tr>
									<td><spring:message code="student.index.5"/></td>
									<td><fmt:formatDate value="${current_date}" type="both" dateStyle="short" timeStyle="short" /></td>
								<tr>
									<td class="listTitle2"><spring:message code="student.index.8"/></td>
									<td id="numberOfLogins">${user.userDetails.numberOfLogins}</td>
								</tr>
								<tr>
									<td class="listTitle2"><spring:message code="student.index.9"/></td> 
									<td id="language"><spring:message code="student.index.10"/></td>
								</tr>
							</table>
						</div>
					
						<div class="sideContent">
						
							<div style="text-align:center;margin-top:5px"><img src="../themes/tels/default/images/WISE-Logo-Small-1.png" alt="WISE Small Logo" /></div>
						
							<div id="displayAsEnglish">WISE &amp; Amanda the Panda <br/>All rights reserved. &#169; 1998-2010</div>
						
							<div style="display:none;" id="displayAsEnglish"><a href="#"><spring:message code="student.index.12"/></a></div>
							
						</div>
					</div>
				</div>
			</div>
		
		<div class="contentPanel contentRight">
			<div class="panelHeader"><spring:message code="student.index.13"/></div>
			<div class="panelContent">
				<div id="tabSystem" class="panelTabs">
			   		<ul style='height:2em;'>   <!-- HT says: I don't know why but if I don't set height, the ul's height is much larger than it should be. -->
			        	<li><a href="#currentRuns"><spring:message code="student.index.14"/></a></li>
			        	<li><a href="#archivedRuns"><spring:message code="student.index.15"/></a></li>
			    	</ul>            
					<div id="currentRuns">
						<c:choose>
						<c:when test="${fn:length(current_run_list) > 0}" >
					
						<c:forEach var="studentRunInfo"  items="${current_run_list}">
							
							<table id="currentRunTable" >
					
								<tr id="projectMainRow">
									<td class="studentTableLeftHeaderCurrent"><spring:message code="student.index.16"/></td>
									<td>
										<div id="studentTitleText">${studentRunInfo.run.name}</div>
									</td>
									<td rowspan="5" style="width:30%; padding:2px;">
										<ul id="studentActionList">   
												
											<c:choose>
												<c:when test="${studentRunInfo.workgroup == null}">
													<li class="startProject"><a href='startproject.html?runId=${studentRunInfo.run.id}' class="wisebutton" id='${studentRunInfo.run.id}' ><spring:message code="student.index.17"/></a></li>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${fn:length(studentRunInfo.workgroup.members) == 1}">
															<li class="startProject"><a href="startproject.html?runId=${studentRunInfo.run.id}"
																id='${studentRunInfo.run.id}' class="wisebutton" onclick="javascript:invalidateLink('${studentRunInfo.run.id}');"><spring:message code="student.index.17"/></a></li>
														</c:when>
														<c:otherwise>
															<li class="startProject"><a href='teamsignin.html?runId=${studentRunInfo.run.id}' 
																id='${studentRunInfo.run.id}' class="wisebutton"><spring:message code="student.index.17"/></a></li>
														</c:otherwise>														
													</c:choose>
													<!--  
													<c:if test="${not empty studentRunInfo.run.brainstorms}" >
					            						<c:forEach var="brainstorm" items="${studentRunInfo.run.brainstorms}">
					                						<li><a href="brainstorm/studentbrainstorm.html?brainstormId=${brainstorm.id}">View Q&amp;A Discussion</a></li>
					            						</c:forEach>
					    							</c:if>	
					    							-->
												</c:otherwise>
											</c:choose>
											<!-- <li><a href="viewannouncements.html?runId=${studentRunInfo.run.id}" class="wisebutton medium">View Announcements</a></li> TODO: reinstate when announcements are re-enabled -->
											<li><a href="/webapp/contactwiseproject.html?projectId=${studentRunInfo.run.project.id}"><spring:message code="student.index.20"/></a></li>
										</ul>
								 	</td>
								</tr>
								<tr>
									<td id="secondaryRowTightFormat" class="studentTableLeftHeaderCurrent">Access Code</td>
									<td id="secondaryRowTightFormat" >${studentRunInfo.run.runcode}<!-- -${studentRunInfo.group.name} --></td>
							  	</tr>	
								<tr>
									<td id="secondaryRowTightFormat" class="studentTableLeftHeaderCurrent"><spring:message code="student.index.22"/></td>
									<td id="secondaryRowTightFormat" >
										<c:choose>
										<c:when test="${fn:length(studentRunInfo.run.owners) > 0}" >
											<c:forEach var="member" items="${studentRunInfo.run.owners}">
												${member.userDetails.displayname}
											</c:forEach>
										</c:when>
										<c:otherwise>
											<spring:message code="student.index.23"/>
										</c:otherwise>	
							      		</c:choose>
									</td>
									</tr>
								<tr>
									<td id="secondaryRowTightFormat" class="studentTableLeftHeaderCurrent"><spring:message code="student.index.24"/></td>
									<td id="secondaryRowTightFormat" >${studentRunInfo.group.name} <span id="periodMessage">(to change period or team ask your teacher for help)</span></td>
							  	
							  	</tr>
								<tr>
									<td id="secondaryRowTightFormat" class="studentTableLeftHeaderCurrent"><spring:message code="student.index.25"/></td>
									<td id="secondaryRowTightFormat" >
										<c:choose>
										<c:when test="${studentRunInfo.workgroup != null}" >
											<c:forEach var="member" varStatus="membersStatus" items="${studentRunInfo.workgroup.members}">
											${member.userDetails.username}
									 		   <c:if test="${membersStatus.last=='false'}">
						     					&
						    				</c:if> 
											</c:forEach>
										</c:when>
										<c:otherwise>
											<div class="teamNotRegisteredMessage"><spring:message code="student.index.26"/></div>  
										</c:otherwise>	
							      		</c:choose>
									</td>
								</tr>
							</table>	
						</c:forEach>
						</c:when>
						<c:otherwise>
							<spring:message code="student.index.27"/>			    
						</c:otherwise>
						</c:choose>
						<!-- <div id="firstUseBox">
							<div id="firstUseHeader"><spring:message code="student.index.28"/></div>
							<div id="instructionsArea">
								<h6><spring:message code="student.index.29"/></h6>
								<ol>
									<li><spring:message code="student.index.30A"/></li>
									<li><spring:message code="student.index.30C"/></li>
									<li><spring:message code="student.index.31"/></li>
									<li><spring:message code="student.index.32"/></li>
								</ol>
							</div>
						</div>  -->
					</div>  <!--  closes <div id='currentRuns'> -->
					<div id="archivedRuns">
						<div id="archivedAdvisory">NOTICE: Archived Project Runs can be run and viewed. But any changes you make to an Archived Project Run will not be saved. 
		If you want to save work to an archived project run, ask your teacher to change its status back to "Current Project Run".</div> 
		
						<c:choose>
						<c:when test="${fn:length(ended_run_list) > 0}" >
						<c:forEach var="studentRunInfo"  items="${ended_run_list}">
							<table id="currentRunTable" >
				
								<tr id="projectMainRow">
									<td class="studentTableLeftHeaderArchive"><spring:message code="student.index.35"/></td>
									<td id="studentCurrentTitleCell">
										<div id="studentTitleText">${studentRunInfo.run.name}</div></td>
									<td rowspan="5" style="width:27%; padding:2px;">
									  	<ul id="studentActionList">
											<li><c:choose>
												<c:when test="${studentRunInfo.workgroup == null}">
													<a href="#" id='${studentRunInfo.run.id}' class="runProjectLink"><spring:message code="student.index.36"/></a>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when
															test="${fn:length(studentRunInfo.workgroup.members) == 1}">
															<a href="${studentRunInfo.startProjectUrl}"
																id='${studentRunInfo.run.id}' class=""><spring:message code="student.index.36"/></a>
														</c:when>
														<c:otherwise>
															<a href='teamsignin.html?runId=${studentRunInfo.run.id}'
																id='${studentRunInfo.run.id}' class=""><spring:message code="student.index.36"/></a>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose></li>
										</ul>
								 	</td>
								</tr>	
								<tr>
									<td class="studentTableLeftHeaderArchive"><spring:message code="student.index.37"/></td>
									<td>
										<c:choose>
										<c:when test="${fn:length(studentRunInfo.run.owners) > 0}" >
											<c:forEach var="member" items="${studentRunInfo.run.owners}">	
												${member.userDetails.displayname}
											</c:forEach>
										</c:when>
										<c:otherwise>
											<spring:message code="student.index.38"/>			    
										</c:otherwise>	
							      		</c:choose>
									</td>
									</tr>
								<tr>
									<td class="studentTableLeftHeaderArchive"><spring:message code="student.index.39"/></td>
									<td>${studentRunInfo.group.name}</td>
							  	
							  	</tr>
								<tr>
									<td class="studentTableLeftHeaderArchive"><spring:message code="student.index.40"/></td>
									<td>
										<c:choose>
										<c:when test="${studentRunInfo.workgroup != null}" >
											<c:forEach var="member" varStatus="membersStatus" items="${studentRunInfo.workgroup.members}">
											${member.userDetails.username}
									 		   <c:if test="${membersStatus.last=='false'}">
						     					&
						    				</c:if> 
											</c:forEach>
										</c:when>
										<c:otherwise>
											<spring:message code="student.index.41"/>			    
										</c:otherwise>	
							      		</c:choose>
									</td>
								</tr>
								<tr>
									<td class="studentTableLeftHeaderArchive"><spring:message code="student.index.42"/></td>
									<td><fmt:formatDate value="${studentRunInfo.run.endtime}" type="date" dateStyle="short" /></td>
								</tr>
							</table>
						</c:forEach>
						</c:when>
						<c:otherwise>
								<spring:message code="student.index.43"/>	    
						</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="../footer.jsp"%>
</div>

</body>
</html>

 
