<%@ include file="include.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Student Brainstorm</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/connection/connection.js"></script>
<script type="text/javascript" src="../.././javascript/tels/brainstorm.js"></script>
<script type="text/javascript" src="../.././javascript/tels/brainstormUtils.js"></script>

<script type="text/javascript">
	var sortCriteria = 0;   // 0=sortbytime, 1=sortbyhelpfulness
	var sortOrder = 0;       // 0=decreasing, 1=increasing
	var pageManager;
	var isTeacherWorkgroup = ${workgroup.teacherWorkgroup};

	pageManager = new PageManager('${brainstorm.id}', '${workgroup.id}', sortCriteria, sortOrder, '${brainstorm.questiontype}');
</script>

</head>

<body style="background-color:#FFFFFF;" onload="javascript:hideallanswers('${brainstorm.id}', '${cannotseeresponses}');">

<div id="stepTypeTitleBar">STUDENT BRAINSTORM</div>

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
		</p>
	</div>
	
	
<div id="sectionBoxMain2">

	<!-- CONDITIONAL ON WHETHER STUDENTS CAN SEE OTHER STUDENTS' POSTS OR NOT -->
	<div id="0" name="answer">
		
		<div id="responseLinks">
		    <div id="sortRadioButtons">
		        <b>Sort by:</b>
		        <input type="radio" name="sortGroup1" onclick="sortBy('0','0');" checked="checked"/>Newest Posts
		        <input type="radio" name="sortGroup1" onclick="sortBy('0','1');"/>Oldest Posts
		        <input type="radio" name="sortGroup1" onclick="sortBy('1','1');"/>Most Helpful Posts
		        <input type="radio" name="sortGroup1" onclick="sortBy('1','0');"/>Least Helpful Posts
			</div>
			<div id="filterTeacherSelectedAnswers"><b>Filter Responses:</b>
		        <input type="radio" name="sortGroup2" onclick="filter(false);" checked="checked"/>Show All Posts
		        <input type="radio" name="sortGroup2" onclick="filter(true);"/>Only Show Posts That Teacher Chose
			</div>
			<ul>
				<li><a href="#" onclick="toggle_visibility_by_name('revisionrow')">Hide/Show Revisions</a></li>
				<li><a href="#" onclick="toggle_visibility_by_name('comments')">Hide/Show Comments</a></li>
			</ul>
		</div>
		
<div id="responseTableBody">
</div>

</div>  <!--end of Section Box-->
	
<div id="cannotSeeMessage"></div>

<div id="studentBottomBar">
		<table>
			<tr>
				<td class="col1"><div id="createResponse"><input id="createResponseButton" type="button" value="Create A New Response" onclick="responsePopUp(${workgroup.id}, ${brainstorm.id})"></input></div></td>
				<td class="col2" id="showLatest"><input id="showLatestButton" type="button" value="Update Display" onclick="refreshResponses()"/></td>
				<td class="col3"><div id="numNewResponses"><i>Show [x] new postings<i></div></td>
				<td colspan="2"><c:set var="thisworkgrouprequestedhelp" value="false" />
					<c:forEach var="workgroupThatRequestedHelp" varStatus="wtrh" items="${brainstorm.workgroupsThatRequestHelp}">
		    			<c:if test="${workgroupThatRequestedHelp == workgroup}">
		        			<c:set var="thisworkgrouprequestedhelp" value="true" />
						</c:if>
					</c:forEach>
					<c:choose>
		    			<c:when test="${thisworkgrouprequestedhelp == true}">
		    				<input id="requesthelp_${workgroup.id}_${brainstorm.id}" checked="checked" type="checkbox" value="helpful" onclick="javascript:requestHelp('${workgroup.id}', '${brainstorm.id}')">Request Discussion Help from Teacher</input>
		    			</c:when>
		    			<c:otherwise>
		        			<input id="requesthelp_${workgroup.id}_${brainstorm.id}" type="checkbox" value="helpful" onclick="javascript:requestHelp('${workgroup.id}', '${brainstorm.id}')">Request Discussion Help from Teacher</input>
		    			</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>

		</div>
		

</div>  <!--end of Centered Div -->
<div id="blankBottomBar">
</div>
	
</div>  <!--end of Section Box-->
        <div id="cannotSeeMessage"></div>    
        <div id="responseTableBody"></div>    

</body>
</html>
