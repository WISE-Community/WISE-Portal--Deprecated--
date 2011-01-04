<%@ include file="include.jsp"%>
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

<!-- $Id: setupRun1.jsp 357 2007-05-03 00:49:48Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script src="./javascript/tels/general.js" type="text/javascript" ></script>
<script src="./javascript/tels/effects.js" type="text/javascript" ></script>
<script src="./javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="./javascript/tels/scriptaculous.js" type="text/javascript" ></script>

<title><spring:message code="teacher.setup-project-run-step-one" /></title>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
    /* initialise plugins */
    jQuery(function(){
    	jQuery('ul.sf-menu').superfish();
    });
    
	/* USED TO SHOW/HIDE A DIV ELEMENT */
	function toggleProjectSummaryCurrent(){
		var searchDiv = document.getElementById('toggleProjectSummaryCurrent');
		if(searchDiv.style.display=='none'){
			searchDiv.style.display = 'block';
		} else {
			searchDiv.style.display = 'none';
		};
	};

	/* checks the cleaning variables and determines what on this page is displayed */
	window.onload = function(){
		if('${forceCleaning}'==='true'){
			/* show the cleaning div */
			document.getElementById('cleaningDiv').style.display = 'block';
			if('${isAllowedToClean}'==='true'){
				document.getElementById('cleaningAllowedDiv').style.display = 'block';
				enableCleaning();
			} else {
				document.getElementById('notAllowedButCleaningNeededDiv').style.display = 'block';
			};
		} else {
			enableRunCreation();
		};
	};

	/* enables the parts of this page needed to create a run */
	function enableRunCreation(){
		/* hide the cleaning divs */
		document.getElementById('cleaningDiv').style.display = 'none';
		document.getElementById('cleaningAllowedDiv').style.display = 'none';
		document.getElementById('notAllowedButCleaningNeededDiv').style.display = 'none';

		/* show the centered div, next and cancel buttons */
		document.getElementById('setUpRunBox').style.display = 'block';
		document.getElementById('prevButt').style.display = 'inline';
		document.getElementById('nextButt').style.display = 'inline';
	};

	/* launches the cleaning for this project */
	function runCleaning(allowed){
		document.getElementById('notAllowedButCleaningNeededDiv').style.display = 'none';
		var cleaning = document.getElementById('cleaningAllowedDiv');
		cleaning.style.display = 'block';

		cleaning.innerHTML = "<iframe name='cleaningFrm' id='cleaningFrm' scrolling='auto' width='100%' height='100%' frameborder='0'></iframe>";
		document.getElementById('cleaningFrm').src = '../../author/authorproject.html?command=launchAuthoring&param1=cleanProject&projectId=${project.id}';
		window.frames['cleaningFrm'].isOwner = allowed;
	};

	/* displays the html to run cleaing for this project */
	function enableCleaning(){
		var cleaning = document.getElementById('cleaningDisplayDiv');
		cleaning.innerHTML = 'We have detected that the project has not been cleaned since it was last edited.<br/>' +
			'Before setting up a run the project must be cleaned. To continue <a onclick="runCleaning(\'true\')"><font color="blue">Clean the Project</font></a> ' +
			'For any problems detected during cleaning, you will be prompted to resolve them, otherwise, run setup will continue normally';
	};

	/* processes the results an allows the appropriate action based on the results */
	function processCleaningResults(results){
		var cleaning = document.getElementById('cleaningAllowedDiv');
		var html = '<div id="cleaningDisplayDiv" class="cleaner"></div>';
		
		cleaning.innerHTML = html;

		var displayHtml = '<b>Cleaning Results: </b><br/><table><tbody><tr><td></td><td># Problems Detected</td><td># Problems Resolved</td></tr>' +
		'<tr><td>Severe:</td><td>' + results.severe.detected + '</td><td>' + results.severe.resolved + '</td></tr>' +
		'<tr><td>Warning:</td><td>' + results.warning.detected + '</td><td>' + results.warning.resolved + '</td></tr>' +
		'<tr><td>Notifications:</td><td>' + results.notification.detected + '</td><td>' + results.notification.resolved + '</td></tr></tbody></table><br/><br/>'
	
		/* determine appropriate display based on results */
		if('${isAllowedToClean}'==='true'){
			/* if any severe problems detected equals resolved then we can proceed */
			if(results.severe.detected==results.severe.resolved){
				displayHtml += 'The cleaning process was completed and any severe problems were resolved. Continue to ' +
					'<a onclick="enableRunCreation()"><font color="blue">Set up a Run</font></a>.';
			/* otherwise, they need to re-run cleaning to continue */
			} else {
				displayHtml += 'The cleaning process was completed but not all severe problems were resolved. These must be resolved before ' +
					'continuing to set up a run.<br/><br/>' +
					'<a onclick="runCleaning(\'true\')"><font color="blue">Re-Run Cleaning</font></a>';
			};
		/* non-owner but severe detected, needs to contact run owner */
		} else if(results.severe.detected>0){
			displayHtml += 'Severe problems were detected. Run set up cannot continue. <a onclick="sendCleanMessage()"><font color="blue">' +
					'Send a message</font></a> to the owner(s) of the project and system administrator requesting cleaning of the project. ' +
					'NOTE: The owner(s) will be made aware of your username so that they may respond when the project is cleaned. If your ' +
					'email address for this account is valid, an email will be generated and sent to that address as well.';
		/* non-owner but no severe detected, can continue to set up run */
		} else {
			displayHtml += 'No severe problems detected, continue to <a onclick="enableRunCreation()"><font color="blue">Set up a Run</font></a>.';
		};

		/* display the html */
		document.getElementById('cleaningDisplayDiv').innerHTML = displayHtml;
	};

	/**
	 * Sends a cleaning message to the owners of the project
	 */
	function sendCleanMessage(){
		/*
		if('${project.metadata}' && '${project.metadata.title}'){
			var projectName = '${project.metadata.title}';
		} else {
			var projectName = '${project.name}';
		};
		*/

		var projectName = '<c:out value="${project.name}" />';
		
		var body = 'Hello, I am ${currentUsername} and would like to request a cleaning for the project ' + projectName +
				' with project ID ${project.id} so that I may set up a run with this project. Thank you.';
		var postData = 'recipient=${projectOwners}&subject=Request for project cleaning&body=' + body;
		var callback = {
				success:function(o){
					if(o.responseText != null && o.responseText == 'success'){
						var msg = '<font color="green">Message was sent to the project owner(s).</font>';
					} else {
						var msg = '<font color="red">Error sending message to the owner(s)! Please contact a wise administrator.</font>';
					};
					
					document.getElementById('cleaningDisplayDiv').innerHTML = msg;
				},
				failure:function(o){
					document.getElementById('cleaningDisplayDiv').innerHTML = '<font color="red">Error sending message to the owner(s)! Please contact a wise administrator.</font>';
				},
				scope:this
		};

		YAHOO.util.Connect.asyncRequest('POST', '/webapp/message.html?action=compose', callback, postData);
	};

</script>

</head>

<body>

<!-- Support for Spring errors object -->
<spring:bind path="runParameters.project">
  <c:forEach var="error" items="${status.errorMessages}">
    <c:choose>
      <c:when test="${fn:length(error) > 0}" >
        <script type="text/javascript">
            alert("${error}");
        </script>
      </c:when>
    </c:choose>
  </c:forEach>
</spring:bind>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="navigationSubHeader2">Project Run Setup<span id="navigationSubHeader1">projects</span></div> 

<h1 id="titleBarSetUpRun" class="blueText"><spring:message code="teacher.setup-project-classroom-run" /></h1>
     	    	    
<div id="setUpRunBox" style='display:none;'>

<div id="stepNumber"><spring:message code="teacher.run.setup.1"/><span class="blueText">&nbsp;<spring:message code="teacher.run.setup.2"/></span></div>

<h5><spring:message code="teacher.run.setup.3"/>&nbsp;<em><spring:message code="teacher.run.setup.4"/></em>&nbsp;<spring:message code="teacher.run.setup.5"/><br/><spring:message code="teacher.run.setup.6"/></h5>

<h5><spring:message code="teacher.run.setup.7"/>&nbsp;<em>[Library/Customized]</em>&nbsp;<spring:message code="teacher.run.setup.8"/></h5>

<table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCell" colspan="3">
									<a href="../projects/projectinfo.html?projectId=${project.id}">${project.name}</a>
									<c:if test="${fn:length(project.sharedowners) > 0}">
										<div id="sharedNamesContainer">
											This project is shared with:
											<div id="sharedNames">
												<c:forEach var="sharedowner" items="${project.sharedowners}">
												  <c:out value="${sharedowner.userDetails.firstname}"/>
												  <c:out value="${sharedowner.userDetails.lastname}"/>
												  <c:out value=",  "/>
												</c:forEach>
												</c:if>
											</div>
										</div>
							</td>
							<td class="actions" colspan="6"> 
									<ul>
									</ul>
							</tr>
					<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title2" style="width:90px;">Project Family</th>
								<th id="title3" style="width:280px;" >Subject</th>
								<th id="title4" style="width:70px;">Grade Level</th>
								<th id="title5" style="width:105px;">Total Hours</th>
								<th id="title6" style="width:110px;">Computer Hours</th>
								<th id="title7" style="width:72px;">Language</th>
								<th id="title8" style="width:82px;">Tech Needs</th>
								<th id="title9" style="width:60px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">[English]</td> 
								<td class="dataCell">[Flash, Java]</td> 
								<td class="dataCell">${usageMap[project.id]}</td>
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}" style="display:none;">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">[List of comma-separated keywords go here]</td>
											</tr>

											<tr>
												<th>Tech Details:</th>
												<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<tr> 
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											<tr>
												<th>Contact Info:</th>
												<td>[Name and Email goes here]</td>
											</tr>
										</table>
									</div>									
								</td>
							</tr>
						</table>
			
<h5><spring:message code="teacher.run.setup.9"/>&nbsp;<em><spring:message code="teacher.run.setup.10"/></em>&nbsp;<spring:message code="teacher.run.setup.11"/></h5>

</div> <!-- /* End setUpRunBox */-->


<div id='cleaningDiv' style='display:none;'>
	<div id='notAllowedButCleaningNeededDiv' style='display:none;' class='cleaner'>
		We detected that this project needs to be cleaned before a run can be set up with it. You can run the cleaning process to ensure that
		the run you are setting up will run properly. However, you are not the owner nor are you a shared owner of the project. If any severe
		problems are detected, you will need to contact the owner or shared owner to resolve the problem before setting up a run. If there are no
		severe errors, you can continue to set up a run. <a onclick='runCleaning("false")'><font color="blue">Clean the Project</font></a>
	</div>
	<div id='cleaningAllowedDiv' style='display:none;'>
		<div id='cleaningDisplayDiv' class='cleaner'></div>
	</div>
</div>

<!-- 
FOR MON:
BEFORE MOVING ON TO THE FINAL PAGE, MAKE REQUEST TO COPY PROJECT SYNCHRONOUSLY. IF SUCCESS, MOVE ON. ELSE, FAIL.
 -->

<div align="center">
<form method="post" align="center">
<input type="submit" name="_target0" disabled value="<spring:message code="navigate.back" /> " style="display:none;" id='prevButt'/>
<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel" />" />
<input type="submit" name="_target1" value="<spring:message code="navigate.next" />" style="display:none;" id='nextButt'/>
</form>

</div>  <!-- /* End of the CenteredDiv */-->

</body>
</html>