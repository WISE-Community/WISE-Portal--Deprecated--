<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	
<title><spring:message code="application.title" /></title>

<%@ include file="styles.jsp"%>

<script type="text/javascript" src=".././javascript/tels/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src=".././javascript/tels/jquery-ui-1.8.9/js/jquery-ui-1.8.9.custom.min.js"></script>
<script type="text/javascript" src=".././javascript/tels/jquerycookie.js"></script>
<script type="text/javascript" src=".././javascript/tels/browserdetect.js"></script>
<script type="text/javascript" src=".././javascript/tels/checkCompatibility.js"></script>
<script src=".././javascript/tels/general.js" type="text/javascript" > </script>


<style>
.yui-panel-container select {
              _visibility: inherit;
}
</style>

<script type="text/javascript">
// only alert user about browser comptibility issue once.
if ($.cookie("hasBeenAlertedBrowserCompatibility") != "true") {
	alertBrowserCompatibility();
}
$.cookie("hasBeenAlertedBrowserCompatibility","true");    

$(document).ready(function() {
	$("#addprojectLink").bind("click", function() {
		var addProjectDialogHtml = '<div style="display:none" id="addProjectDialog">'+
		'<iframe id="addProjectFrame" src="addproject.html" width="100%" height="100%" FRAMEBORDER="0" allowTransparency="false" scrolling="no"> </iframe>'+			
		'</div>';
		if ($("#addProjectDialog").length == 0) {
			$("#centeredDiv").append(addProjectDialogHtml);	
		}
		$("#addProjectDialog").dialog({
			position:["center","top"],
			modal:true,
			resizeable:true,
			width:550,
			height:400,
		});
	})
});
</script>

<script language="JavaScript">
	function popup(URL) {
  	window.open(URL, 'SelectTeam', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=850,height=600,left = 570,top = 300');}
  	
  	function invalidateLink(linkID) {
  	   window.location= document.getElementById(linkID).href;
  	   document.getElementById(linkID).href="#";
  	   document.getElementById(linkID).style.backgroundColor='#000066';
  	   document.getElementById(linkID).style.color='#666666';
  	}
</script>

<script>

	function init() {
	    //create logger
	  //  var myContainer = document.body.appendChild(document.createElement("div")); 
	//	var myLogReader = new YAHOO.widget.LogReader(myContainer);
	 
   		var tabView = new YAHOO.widget.TabView('tabSystem');

		function runObject(id){
				this.runId=id;
		}
	
		var oRun =new runObject(null);
		
   	//add new announcements dialog ----------------------------------

    // Define various event handlers for Dialog
	var handleCancel = function() {
		this.cancel();
	};
    
    var checkNewAnnouncements = function(dialog){
    	var newAnnouncement = false;
    	var announcementHTML = "";
    	<c:forEach var="runInfo" items="${current_run_list}">
    		<c:forEach var="announcement" items="${runInfo.run.announcements}">
    			<c:if test="${user.userDetails.lastLoginTime < announcement.timestamp || user.userDetails.lastLoginTime == null}">
    				newAnnouncement = true;
    				announcementHTML = announcementHTML + "<tr><td align='center'><h3>${announcement.title} (posted on:" + "${announcement.timestamp})</h3>" + "${announcement.announcement}<br><br></td></tr>";
   			</c:if>
    		</c:forEach>
    	</c:forEach>
    	
    	if(newAnnouncement){
    		document.href="viewannouncements.html";
    	};
    };
    
    //YAHOO.util.Event.onDOMReady(getNewAnnouncements(newAnnouncementsDialog));
    //checkNewAnnouncements();
    
    	//Change Period or Team PopUp dialog ----------------------------------

    // Define various event handlers for Dialog

	var handleCancel = function() {
		this.cancel();
		document.getElementById('changePeriodTeamFrame').src=' ';
		//reload the page
		//window.location.reload();
	};

	// Instantiate the Dialog
	var changePeriodTeamDialog = new YAHOO.widget.Dialog("changePeriodTeamDialog", 
		{ width : "700px",
		//  height : "70%",
		  fixedcenter : true,
		  visible : false, 
		  iframe : true,
		  //ie7 modal problem
		  //modal:false,
		  constraintoviewport : true,
		  effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25},
		  buttons : [ 
					  {text:"Close", handler:handleCancel,isDefault:true } ]
		 } );
	
	
    changePeriodTeamDialog.render();
    
    var btns2 = YAHOO.util.Dom.getElementsByClassName("changePeriodTeamLink", "a");
         
    YAHOO.util.Event.on(btns2, "click", function(e, panel) {
                	YAHOO.log('RUNG id ' + this.id);
                	document.getElementById('changePeriodTeamFrame').src='changeperiodteam.html' 
                	changePeriodTeamDialog.show();
    }, changePeriodTeamDialog);
    
    
    
     //change password dialog  -----------------
      
    var handleClosePassword = function() {
		this.cancel();
		document.getElementById('changePasswordFrame').src=' ';
		//reload the page
		//window.location.reload();
	};
	
	// Instantiate the Dialog
	var changePasswordDialog = new YAHOO.widget.Dialog("changePasswordDialog", 
		{ width : "700px",
		  // height : "300px",
		  fixedcenter : true,
		  visible : false, 
		  iframe : true,
		  //ie7 modal problem
		  //modal:false,
		  constraintoviewport : true,
		  effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25},
		  buttons : [ 
					  { text:"Close", handler:handleClosePassword,isDefault:true } ]
		 } );
	
	
	// Render the Dialog
	changePasswordDialog.render();

    
    var btns2 = YAHOO.util.Dom.getElementsByClassName("changepasswordLink", "a");
				
	YAHOO.log('btns2 ' + btns2);
         
    YAHOO.util.Event.on(btns2, "click", function(e, panel) {
                	YAHOO.log('RUNG id ' + this.id);                	
                	document.getElementById('changePasswordFrame').src='changestudentpassword.html';
                	changePasswordDialog.show();
    }, changePasswordDialog);
    
    //run Project dialog -----------------------
    
    var handleCloseRun = function() {
		this.cancel();
		document.getElementById('runProjectFrame').src=' ';
		//reload the page
		//window.location.reload();
	};
	
	// Instantiate the Dialog
	var runProjectDialog = new YAHOO.widget.Dialog("runProjectDialog", 
		{ width : "700px",
		//  height : "70%",
		  fixedcenter : true,
		  visible : false, 
		  iframe : true,
		  //ie7 modal problem
		  //modal:false,
		  constraintoviewport : true,
		  effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25},
		  buttons : [ 
					  { text:"Close", handler:handleCloseRun,isDefault:true } ]
		 } );
	
	// Render the Dialog
	runProjectDialog.render();

    
    var btns2 = YAHOO.util.Dom.getElementsByClassName("runProjectLink", "a");
				
	YAHOO.log('btns2 ' + btns2);
         
    YAHOO.util.Event.on(btns2, "click", function(e, panel) {
                	YAHOO.log('RUNG id ' + this.id);
                	document.getElementById('runProjectFrame').src='selectteam.html?runId=' + this.id;
                	runProjectDialog.show();
    }, runProjectDialog);

}

YAHOO.util.Event.onDOMReady(init);
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

<script src=".././javascript/tels/classAnim.js" type="text/javascript" > </script>
<script>  YAHOO.util.Event.onAvailable("TestClassAnim", function(){ var anim = new 
		  YAHOO.mozmonkey.ClassAnim("TestClassAnim"); var start = 0; 
		  YAHOO.util.Event.addListener("TestClassAnim", "mouseover", function(){ anim.addClass("classAnimHover"); }); 
		  YAHOO.util.Event.addListener("TestClassAnim", "mouseout", function(){ anim.removeClass("classAnimHover"); }); 
		  YAHOO.util.Event.addListener("TestClassAnim", "click", function(){ if(start == 0){ start = 1; anim.addClass("classAnim2"); } else{ start = 0; anim.removeClass("classAnim2"); } }); 
		  }); 
		  </script>

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="studenthomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="../themes/tels/default/images/favicon_panda.ico">

</head>

<body class="yui-skin-sam">

<div id="centeredDiv">

<%@ include file="./studentHeader.jsp"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*" %>

<div id="columnButtons">

<dl id="list1" >
	<dt id="studentUsername"><sec:authentication property="principal.firstname" /> <sec:authentication property="principal.lastname" /></dt>
	<dd></dd>
	<dt id="studentWelcome">
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
	</dt>
	<dd></dd>
</dl>

<div style="text-align:center;"><img src="../themes/tels/default/images/student/Panda.jpg" width="220"  alt="WISE 3 Panda" /></div>

<div id="accountOptions"><spring:message code="wise.account-options" /></div>

<div id="optionButtons">
	<ul>
	<li>
		<a href="#"
		onmouseover="swapImage('studentaddproject','../<spring:theme code="student_add_project_roll" />');"
		onmouseout="swapImage('studentaddproject','../<spring:theme code="student_add_project" />');"
		class="addprojectLink" id="addprojectLink"> <img id="studentaddproject"
		src="../<spring:theme code="student_add_project" />" /> </a>
	</li>
		
	<!-- note: to make the change to student password into AJAX, type in class="changepasswordLink" -->	
	
	<li><a href="#"
        onclick=""	
		onmouseover="swapImage('studentopenjournal','../<spring:theme code="student_open_journal_roll" />');"
		onmouseout="swapImage('studentopenjournal','../<spring:theme code="student_open_journal" />');"	>
		<img id="studentopenjournal" src="../<spring:theme code="student_open_journal" />"
		style="border: 0px;" /> </a></li>
		
	<li><a href="#"
        onclick="javascript:popup640('changestudentpassword.html');"	
		onmouseover="swapImage('studentchangepwd','../<spring:theme code="student_change_password_roll" />');"
		onmouseout="swapImage('studentchangepwd','../<spring:theme code="student_change_password" />');"
		> <img
		id="studentchangepwd"
		src="../<spring:theme code="student_change_password" />"
		style="border: 0px;" /> </a></li>
		
	<li><a href="<c:url value="/j_spring_security_logout"/>"
		onmouseover="swapImage('studentsignout','../<spring:theme code="student_sign_out_roll" />');"
		onmouseout="swapImage('studentsignout','../<spring:theme code="student_sign_out" />');"> 
		<img id="studentsignout" src="../<spring:theme code="student_sign_out" />"
		style="border: 0px;" /> </a></li>
				
	<li style="display:none;"><a href="#"
		onmouseover="swapImage('studentchangelang','../<spring:theme code="student_change_lang_roll" />');"
		onmouseout="swapImage('studentchangelang','../<spring:theme code="student_change_lang" />');"
		onclick="javascript:alert('This page is not available yet')"> <img
		id="studentchangelang"
		src="../<spring:theme code="student_change_lang" />"
		style="border: 0px;" /> </a></li>

	</ul>
</div>

<div class="separator"></div>

<dl id="list2">
	<dt><spring:message code="student.index.6"/></dt>
	<dd>
	<c:choose>
		<c:when test="${user.userDetails.lastLoginTime == null}">
			<spring:message code="student.index.7"/>
		</c:when>
		<c:otherwise>
			<fmt:formatDate value="${user.userDetails.lastLoginTime}" 
				type="both" dateStyle="short" timeStyle="short" />
		</c:otherwise>
	</c:choose>
		
	</dd>
	<dt><spring:message code="student.index.5"/></dt>
	<dd><fmt:formatDate value="${current_date}" type="both" dateStyle="short" timeStyle="short" /></dd>
	
	<dt class="listTitle2"><spring:message code="student.index.8"/></dt>
	<dd id="numberOfLogins">${user.userDetails.numberOfLogins}</dd>
	<dt class="listTitle2"><spring:message code="student.index.9"/></dt> 
	<dd id="language"><spring:message code="student.index.10"/></dd>
</dl>

<div class="separator"></div>

<div style="text-align:center;margin-top:5px"><img src="../themes/tels/default/images/WISE-Logo-Small-1.png" alt="WISE Small Logo" /></div>

<div id="displayAsEnglish">WISE &amp; Amanda the Panda <br/>All rights reserved. &#169; 1998-2010</div>

<div style="display:none;" id="displayAsEnglish"><a href="#"><spring:message code="student.index.12"/></a></div>

</div>   <!--end of columnButtons, floated to left-->


<div id="columnProjects">

	<div id="columnLabel"><spring:message code="student.index.13"/></div>
	
	<div id="tabSystem" class="yui-navset">
	    <ul style="font-size:.8em;" class="yui-nav">
	        <li style="margin:0 .4em 0 0px;" class="selected"><a href="#currentRuns"><em><spring:message code="student.index.14"/></em></a></li>
	        <li><a href="#archivedRuns"><em><spring:message code="student.index.15"/></em></a></li>
	    </ul>            
	    <div class="yui-content" style="background-color:#FFFFFF;">
			<div id="currentRuns">
				<c:choose>
				<c:when test="${fn:length(current_run_list) > 0}" >
				
				<c:forEach var="studentRunInfo"  items="${current_run_list}">
						
						<table id="currentRunTable" >
				
							<tr id="projectMainRow">
								<td class="studentTableLeftHeaderCurrent"><spring:message code="student.index.16"/></td>
								<td>
									<div id="studentTitleText">${studentRunInfo.run.name}</div></td>
								<td rowspan="5" style="width:30%; padding:2px;">
									  	<ul id="studentActionList">   
											
											<c:choose>
												<c:when test="${studentRunInfo.workgroup == null}">
													<li class="startProject"><a href='startproject.html?runId=${studentRunInfo.run.id}' id='${studentRunInfo.run.id}' ><spring:message code="student.index.17"/></a></li>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when
															test="${fn:length(studentRunInfo.workgroup.members) == 1}">
															<li class="startProject"><a href="startproject.html?runId=${studentRunInfo.run.id}" 
																id='${studentRunInfo.run.id}' onclick="javascript:invalidateLink('${studentRunInfo.run.id}');"><spring:message code="student.index.17"/></a></li>
														</c:when>
														<c:otherwise>
															<li class="startProject"><a href='teamsignin.html?runId=${studentRunInfo.run.id}';  
																id='${studentRunInfo.run.id}' class=""><spring:message code="student.index.17"/></a></li>
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
											<!--  
											<li><a href="${studentRunInfo.workgroup.workPDFUrl}"><spring:message code="student.index.18"/></a></li>
											<li style="display:none;"><a style="letter-spacing:0px;" href="javascript:popup('changeperiodteam.html');"><spring:message code="student.index.19"/></a></li>
											-->
											<li><a href="viewannouncements.html?runId=${studentRunInfo.run.id}">View Announcements</a></li>
											<li><a href="../contactwiseproject.html?projectId=${studentRunInfo.run.project.id}&runId=${studentRunInfo.run.id}"><spring:message code="student.index.20"/></a></li>
									 	</ul>
							 	</td>
							</tr>
							<tr>
								<td id="secondaryRowTightFormat" class="studentTableLeftHeaderCurrent">Access Code</td>
								<td id="secondaryRowTightFormat" >${studentRunInfo.run.runcode}-${studentRunInfo.group.name}</td>
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
				<div id="firstUseBox">
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
				</div>
			</div>
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
															<a
																href='teamsignin.html?runId=${studentRunInfo.run.id}'
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
</div>   <!--end of columnProjects, floated to left-->
 
 
 <!-- BEGIN DEFINITION OF FRAMES USED FOR AJAX  -->
  
<!-- this creates the change period team iframe -->
<div id="changePeriodTeamDialog">
<div class="hd"><spring:message code="student.index.45"/>/div>
<div class="bd">

<iframe id="changePeriodTeamFrame" src="" width="100%" FRAMEBORDER="0"
	allowTransparency="false" scrolling="no"> </iframe>
	
</div>
</div>


<!-- creates change password -->
<div id="changePasswordDialog">
<div class="hd"><spring:message code="student.index.46"/></div>
<div class="bd">


<iframe id="changePasswordFrame" src=" " width="100%" height="250px" FRAMEBORDER="0"
	allowTransparency="false" scrolling="no"> </iframe>
	
</div>
</div>

<!-- this creates the select team dialog with iframe -->
<div id="runProjectDialog">
<div class="hd"><spring:message code="student.index.47"/></div>
<div class="bd" align="left">

<iframe id="runProjectFrame" src=" " width="100%" height="400px" FRAMEBORDER="0"
	allowTransparency="false" scrolling="no"> </iframe>
	
</div>
</div>

</div>
</div>
</body>
</html>

 
