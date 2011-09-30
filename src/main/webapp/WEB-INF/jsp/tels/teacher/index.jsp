<%@ include file="./include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE HTML>
<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<!--
  * Copyright (c) 2006 Encore Research Group, University of Toronto
  * 
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
  * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="browserdetectsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="checkcompatibilitysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="utilssource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    // only alert user about browser comptibility issue once.
    if ($.cookie("hasBeenAlertedBrowserCompatibility") != "true") {
    	alertBrowserCompatibility();
    }
	$.cookie("hasBeenAlertedBrowserCompatibility","true");
	
	// set unread message count and last login time in session (used in page headers)
	$.cookie("unreadMessages","<c:out value="${fn:length(unreadMessages)}" />", {path:"/"});
	
</script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="teacher.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

<script type='text/javascript'>
var isTeacherIndex = true; //global var used by spawned pages (i.e. archive run)
</script>

</head>

        <!-- Page-specific script TODO: Make text translatable -->

        <script type="text/javascript">
            /**
             * Asynchronously updates the run with the given id on the server and 
             * displays the appropriate reponse when completed.
             */
            function extendReminder(id){
            	var runLI = $('#extendReminder_' + id);
            	runLIhtml('Updating run on server...');
            	
            	$.ajax({
					type: 'post',
					url: '/webapp/teacher/run/manage/extendremindertime.html?runId=' + id,
					success: function(request){
						runLIhtml('<span style="color: #24DD24;">You will be reminded to archive project run ' + id + ' again in 30 days.</span>');
					},
					error: function(request,error){
						runLI.innerHTML = '<span style="color: #DD2424;">Unable to update project run ' + id + ' on server.</span>';
					}
            	});
            };
			
            /**
            * Asynchronously archives a run
            **/
            function archiveRun(runId){
				var runLI = $('#extendReminder_' + runId);
				runLI.html('Archiving run on server...');
				
				$.ajax({
					type: 'post',
					url: '/webapp/teacher/run/manage/archiveRun.html?runId=' + runId,
					success: function(request){
						/* update message on teacher index page announcements section */
						runLI.html('<span style="color:#24DD24;">Project run ' + runId + ' has been archived.</span>');

						/* remove archived run from quick runs list */
						var child = window.frames['dynamicFrame'].document.getElementById('runTitleRow_' + runId);
						child.parentNode.removeChild(child);
					},
					error: function(request,error){
						/* set failure message */
						runLIhtml('<span style="color:#992244;">Unable to archive project run! Refresh this page and try again.</span>');
					}
				});
            };

            /**
             * Asynchronously archives a message
             **/
            function archiveMessage(messageId, sender) {
				var messageDiv = $('#message_' + messageId);
				messageDiv.html('Archiving message...');
				
				$.ajax({
					type: 'post',
					url: '/webapp/message.html?action=archive&messageId='+messageId,
					success: function(request){
						/* update message on teacher index page announcements section */
						messageDiv.remove();
						$("#message_confirm_div_" + messageId).html('<span style="color: #24DD24;">Message from ' + sender + ' has been archived.</span>');
						/* update count of new message in message count div */
						var messageCountDiv = $("#newMessageCount");
						var messages = $("#messageDiv");
						if (messages.length == 1) {
							messageCountDiv.html("You have " + messages.length + " new message.");
						} else {
							messageCountDiv.html("You have " + messages.length + " new messages.");
						}
					},
					error: function(request,error){
						/* set failure message */
						messageDiv.html('<span style="color: #992244;">Unable to archive message! Refresh this page and try again.</span>');
					}
				});
            }
        </script>
    
<body>

<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="sidebar sidebarLeft">
				<div class="sidePanel">
					<div class="panelHeader"><spring:message code="teacher.index.1" /></div>
					
					<div class="panelContent">
				
						<table id="teacherQuickLinks">
							<tr>
								<td><a href="/webapp/pages/gettingstarted.html" target="_blank"><spring:message code="menu.quickstart"/></a></td>
							</tr>
							<tr>
								<td><a href="/webapp/teacher/management/library.html"><spring:message code="menu.library"/></a></td>
							</tr>
							<tr>
								<td><a href="/webapp/teacher/management/classroomruns.html"><spring:message code="menu.runs"/></a></td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class='sidePanel'>
					<div class="panelHeader"><spring:message code="teacher.index.1A" /></div>
					
					<div class="panelContent">
			
						<table id="teacherMessageTable">
							<tr>
								<td>
								<div class="highlight welcomeMsg">
									<c:set var="current_date" value="<%= new java.util.Date() %>" />
									<c:choose>
										<c:when test="${(current_date.hours>=4) && (current_date.hours<5)}">
												<spring:message code="teacher.index.7A" />
										</c:when>
										<c:when test="${(current_date.hours>=5) && (current_date.hours<6)}">
												<spring:message code="teacher.index.7C" />
										</c:when>
										<c:when test="${(current_date.hours>=6) && (current_date.hours<6.5)}">
												"Each morning we are born again.  What we do today is what matters most."  (Guatama Siddharta)
										</c:when>
										<c:when test="${(current_date.hours>=6.5) && (current_date.hours<7)}">
												<spring:message code="teacher.index.7D" />
										</c:when>
										<c:when test="${(current_date.hours>=7) && (current_date.hours<9)}">
												<spring:message code="teacher.index.7B" />
										</c:when>
										<c:when test="${(current_date.hours>=9) && (current_date.hours<10)}">
												<spring:message code="teacher.index.7E" />
										</c:when>
										<c:when test="${(current_date.hours>=10) && (current_date.hours<11)}">
												<spring:message code="teacher.index.7F" />
										</c:when>
										<c:when test="${(current_date.hours>=11) && (current_date.hours<11.5)}">
												<spring:message code="teacher.index.7G" />
										</c:when>
										<c:when test="${(current_date.hours>=11.5) && (current_date.hours<12)}">
												"Time flies like an arrow.  Fruit flies like a banana."  (Groucho Marx)
										</c:when>
										<c:when test="${(current_date.hours>=12) && (current_date.hours<15)}">
												<spring:message code="teacher.index.8A" />
										</c:when>
										<c:when test="${(current_date.hours>=15) && (current_date.hours<18)}">
												<spring:message code="teacher.index.8B" />
										</c:when>
										<c:when test="${(current_date.hours>=18) && (current_date.hours<22)}">
												<spring:message code="teacher.index.8C" />
										</c:when>
										<c:when test="${(current_date.hours>=22) && (current_date.hours<23)}">
												<spring:message code="teacher.index.9A" />
										</c:when>
										<c:when test="${(current_date.hours>=23) && (current_date.hours<24)}">
												<spring:message code="teacher.index.9B" />
										</c:when>
										<c:otherwise>
												<spring:message code="teacher.index.9C" />
										</c:otherwise>
									</c:choose>
								</div>
								<!-- <div class="messageContainer">
									<c:choose>
										<c:when test="${fn:length(unreadMessages) == 1}">
											<div id="newMessageCount"><spring:message code="teacher.index.50" />  <c:out value="${fn:length(unreadMessages)}" /> <spring:message code="teacher.index.50B" /></div>
										</c:when>
										<c:otherwise>
											<div id="newMessageCount"><spring:message code="teacher.index.50" />  <c:out value="${fn:length(unreadMessages)}" /> <spring:message code="teacher.index.50A" /></div>
										</c:otherwise>
									</c:choose>
									<c:if test="${fn:length(unreadMessages) > 0}">
										<c:forEach var="message" items="${unreadMessages}">
										    <div class="messageDiv" id="message_${message.id}">
										    <table class='messageDisplayTable'>
											<tr><th>Date:</th><td><fmt:formatDate value="${message.date}" type="both" dateStyle="short" timeStyle="short" /></td></tr>
											<tr><th>From:</th><td><c:out value="${message.sender.userDetails.username}"/></td></tr>
											<tr><th>Subject:</th><td><c:out value="${message.subject}"/></td></tr>
											<tr><td colspan='2' class='messageBody'><c:out value="${message.body}" /></td></tr>
											<tr><td colspan='2'>
												<a class="messageArchiveLink" onclick="archiveMessage('${message.id}', '${message.sender.userDetails.username}');"><spring:message code="teacher.index.51" /></a> | 
												<a class="messageReplyLink" href="/webapp/message.html?action=index"><spring:message code="teacher.index.51A" /></a></td></tr>
											</table>
											<div class="msgConfirm" id="message_confirm_div_${message.id}"></div>
											</div>
										</c:forEach>
									</c:if> 
									
									<div class="msgLink">
										<a href="/webapp/message.html?action=index"><spring:message code="teacher.index.52" /></a>
									</div> 
								</div> -->
								<ul class="reminders">
									<c:forEach var="run" items="${current_run_list1}">
										<sec:accesscontrollist domainObject="${run}" hasPermission="16">
											<c:if test='${(run.archiveReminderTime.time - current_date.time) < 0}'>
												<li id='extendReminder_${run.id}'><spring:message code="teacher.index.46" /> <span style="font-weight:bold;">${run.name} (${run.id})</span> <spring:message code="teacher.index.47" />
													<fmt:formatDate value="${run.starttime}" type="date" dateStyle="medium" timeStyle="short" />.
													 <spring:message code="teacher.index.48" />  [<a class="runArchiveLink"
															onclick="archiveRun('${run.id}')"><spring:message code="teacher.index.49" /></a> / <a class="runArchiveLink" onclick='extendReminder("${run.id}")'><spring:message code="teacher.index.49A" /></a>]</li>
											</c:if>
										</sec:accesscontrollist>
									</c:forEach>
								</ul>
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<!--  
						<div class="panelStyleCommunity">
								<div id="headerTeacherHome">Community Tools</div>
								<ul>
										<li>Launch your <a href="#" class="lineThrough">Community Overview</a></li>
										<li>Launch <a href="#" class="lineThrough">MyShared Projects Forum</a></li>
										<li>Launch <a href="#" class="lineThrough">SharedWithMe Forum</a></li>
										<li>Launch <a href="#" class="lineThrough">Mentor Forum</a></li>
										<li>Launch <a href="#" class="lineThrough">Professional Development Forum</a></li>
								</ul>
						</div>
				-->
				
			</div>
			
			<div class="contentPanel contentRight">
				<div class="panelHeader">
					<spring:message code="teacher.index.22" />
					<span class="pageTitle"><spring:message code="header.location.teacher"/></span>
				</div>
				
				<div class="panelContent">
					<!-- <iframe id="dynamicFrame" name="dynamicFrame" src="run/projectruntabs.html"	style="overflow: auto; width: 100%; 
					display: none; margin-top: 5px;"></iframe> -->
					<%@ include file="run/recentactivity.jsp"%>
				</div>
					
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="../footer.jsp"%>
</div>

</body>

</html>









