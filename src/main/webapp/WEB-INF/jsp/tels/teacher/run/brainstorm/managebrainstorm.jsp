<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<title>Manage Brainstorm</title>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="../../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/yui/connection/connection.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/brainstorm.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/brainstormUtils.js"></script>

<script type="text/javascript">
	var sortOrder = 0;
	var sortCriteria = 0;
	var pageManager;
	var isTeacherWorkgroup = "${workgroup.teacherWorkgroup}";

		function changeInterval(brainstormId, interval){
		pageManager.setPollInterval(interval);
	};

	pageManager = new PageManager('${brainstorm.id}', '${workgroup.id}', sortCriteria, sortOrder, '${brainstorm.questiontype}');
</script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>
<body  style="background-color:#FFFFFF;" onload="javascript:hideallanswers('${brainstorm.id}', false);">

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<div id="navigationSubHeader2">Brainstorm Management<span id="navigationSubHeader1">management</span></div> 

<c:choose>
<c:when test="${not brainstorm.sessionStarted}">
<h3>This Q&A Discussion step is closed. Your students can't see or work on it yet.</h3>
</c:when>
<c:otherwise>
<h3>This Q&A Discussion step is active. Your students can see it and work on it.</h3>
</c:otherwise>
</c:choose>
<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
    <form:hidden path="id" />
    <ul>
      <li id="test">
          <form:radiobutton path="sessionStarted" onclick="javscript:this.form.submit();" value="true" /> ACTIVATE Q&A <span style="font-size:.7em;">(allow students to see the Q&A step)</span>
      </li>
      <li>
		  <form:radiobutton path="sessionStarted" onclick="javscript:this.form.submit();" value="false" /> DEACTIVATE Q&A  <span style="font-size:.7em;">(do not allow students to see the Q&A step)</span>
	  </li>
    </ul>
</form:form>
<c:if test="${brainstorm.questiontype=='SINGLE_CHOICE'}">
	<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
		<form:hidden path="id"/>
		<ul>
			<li id="instantPoll">
				<form:radiobutton path="instantPollActive" onclick="javascript:this.form.submit();" value="false"/> DEACTIVATE INSTANT POLL - students will not be allowed to respond to the prompt.
			</li>
			<li>
				<form:radiobutton path="instantPollActive" onclick="javascript:this.form.submit();" value="true"/> ACTIVATE INSTANT POLL - allows students to respond to the prompt
			</li>
		</ul>
	</form:form>
</c:if>
<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
    <form:hidden path="id" />
    <ul>
      <li id="test">
          <form:radiobutton path="gated" onclick="javscript:this.form.submit();" value="false" /> OPEN DISCUSSION <span style="font-size:.7em;">(student can immediately see other student responses)</span>
      </li>
      <li>
		  <form:radiobutton path="gated" onclick="javscript:this.form.submit();" value="true" /> GATED DISCUSSION  <span style="font-size:.7em;">(student must submit a response before they can see other student responses)</span>
	  </li>
    </ul>
</form:form>
<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
    <form:hidden path="id" />
    <ul>
      <li id="test">
          <form:radiobutton path="richTextEditorAllowed" onclick="javscript:this.form.submit();" value="true" /> ALLOW Students to use Rich Text Editor when posting
      </li>
      <li>
		  <form:radiobutton path="richTextEditorAllowed" onclick="javscript:this.form.submit();" value="false" /> DO NOT ALLOW Students to use Rich Text Editor when posting
	  </li>
    </ul>
</form:form>
<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
    <form:hidden path="id" />
    <ul>
      <li id="test">
          <form:radiobutton path="displayNameOption" onclick="javscript:this.form.submit();" value="USERNAME_ONLY" /> USERNAME ONLY
      </li>
      <li>
		  <form:radiobutton path="displayNameOption" onclick="javscript:this.form.submit();" value="ANONYMOUS_ONLY" /> ANONYMOUS ONLY
	  </li>
      <li>
		  <form:radiobutton path="displayNameOption" onclick="javscript:this.form.submit();" value="USERNAME_OR_ANONYMOUS" /> USERNAME OR ANONYMOUS
	  </li>	  
    </ul>
</form:form>
<c:if test="${brainstorm.questiontype=='SINGLE_CHOICE'}">
	<form:form method="post" action="managebrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" id="brainstormform" autocomplete='off'>
		<form:hidden path="id"/>
		<ul>
			<li id="test">
				<form:radiobutton path="pollEnded" onclick="javascript:this.form.submit();" value="true"/>ALLOW STUDENTS to see results, graphs and charts regarding this poll.
			</li>
			<li>
				<form:radiobutton path="pollEnded" onclick="javascript:this.form.submit();" value="false"/>DO NOT ALLOW STUDENTS to see results, graphs and charts regarding this poll.
			</li>
		</ul>
	</form:form>
</c:if>
<div id="pollingInterval">
		Select the interval for polling to find new Q&amp;A responses.
		<br>
		<input type="radio" name="pollingRadio" value="15000" onclick="javascript:changeInterval(${brainstorm.id}, 15000);">15 seconds</input><br>
		<input type="radio" name="pollingRadio" value="30000" onclick="javascript:changeInterval(${brainstorm.id}, 30000);">30 seconds</input><br>
		<input type="radio" name="pollingRadio" value="45000" onclick="javascript:changeInterval(${brainstorm.id}, 45000);">45 seconds</input><br>
		<input type="radio" name="pollingRadio" value="60000" onclick="javascript:changeInterval(${brainstorm.id}, 60000);" CHECKED>60 seconds</input><br>
	</div>
	<br>
${fn:length(brainstorm.workgroupsThatRequestHelp)} students have requested HELP for this Q&A Discussion step:
<br />
students that requested help: <br/>
<c:forEach var='wg' items='${brainstorm.workgroupsThatRequestHelp}'>
  ${wg.sdsWorkgroup.name} <br/>
</c:forEach>
<br/>

<div id="teacherControlPanel">



<div id="stepTypeTitleBar">Q&amp;A DISCUSSION</div>

<div id="sectionBox">

	<div id="sectionBoxHeader">
		<a id="hideLink" href="#" onclick="toggle_visibility('sectionBoxMain1');">click to hide/show</a>
		<p>Question for <span style="color:#FF0000">PERIOD 1</span>&nbsp;<span style="color:#FF0000; font-size:.8em;">(12 students)</span></p>
	</div>
	
	<div id="sectionBoxMain1">
				
		<div id="column1">
			<p>Question:</p>
		</div>
		
		<div id="column2">
			<div id="questionContent" name="questionPrompt">${brainstorm.question.prompt}</div>
			<c:if test="${brainstorm.questiontype=='SINGLE_CHOICE'}">
				<div id="choiceList">
					<c:forEach var="key" varStatus="keyStatus" items="${keys}">
						<input type="radio" name="listChoiceRadio" disabled="true" id="listChoice${key}">${choices[key]}</input><br>
					</c:forEach>
				</div>
			</c:if>
			<div id="instructions1">To answer this Q&amp;A discussion question, click the <b>Create A New Response</b> button below.</div>
		</div>
	
		<div id="column3"><div id="graph"></div></div>
	
	</div>
	
</div>  <!--end of Section Box-->
		
		
<div id="sectionBox">

	<div id="sectionBoxHeader">
		<a id="hideLink" href="#" onclick="toggle_visibility('sectionBoxMain2');">click to hide/show</a>
		<p id="numOfPosts">Student Responses (${fn:length(brainstorm.answers)} responses)
			<span id="createResponse"><input type="button" value="Create A Response" onclick="responsePopUp(${workgroup.id}, ${brainstorm.id})"></input></span>
		</p>
	</div>
	
	
<div id="sectionBoxMain2">

	<!-- CONDITIONAL ON WHETHER STUDENTS CAN SEE OTHER STUDENTS' POSTS OR NOT -->
	<div id="0" name="answer">
		
		<div id="responseLinks">
			<ul>
				<li><a href="#" onclick="sortBy('time')">Sort By Time</a></li>
				<li><a href="#" onclick="sortBy('help')">Sort By Helpfulness</a></li>
				<li><a href="#" onclick="toggle_visibility_by_name('revisionrow')">Hide/Show Revisions</a></li>
				<li><a href="#" onclick="toggle_visibility_by_name('comments')">Hide/Show Comments</a></li>
			</ul>
		</div>
		


	
</div>  <!--end of Section Box-->
	
	
<div id="responseTableBody">

</div>
<div id="cannotSeeMessage">

</div>

</div>   <!--end of Discussion Section Box-->

<div id="blankBottomBar">
</div>

<div id="teacherBottomBar">
		<table>
			<tr>
				<td class="col1"><div id="createResponse"><input id="createResponseButton" type="button" value="Create A New Response" onclick="responsePopUp(${workgroup.id}, ${brainstorm.id})"></input></div></td>
				<td class="col2" id="showLatest"><input id="showLatestButtonTeacher" type="button" value="Update Display" onclick="refreshResponses()"/></td>
				<td class="col3"><div id="numNewResponses"><i>Show [x] new postings</i></div></td>	
		        <td>
				       	<dl>
							<dt>Requests for Help:</dt>
							<dd><b>${fn:length(brainstorm.workgroupsThatRequestHelp)}</b></dd>
							<dt>Requestors:</dt>
							<dd><b><c:forEach var='wg' items='${brainstorm.workgroupsThatRequestHelp}'>
									  ${wg.sdsWorkgroup.name} </b> 
									  <br/>
									</c:forEach>
							</dd>
						</dl>
				</td>
		
			</tr>
		</table>
</div>

</div>        <!--end of Centered Div-->

</div>
</div>

</body>
</html>


