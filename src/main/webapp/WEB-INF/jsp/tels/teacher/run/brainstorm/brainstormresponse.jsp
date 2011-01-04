<%@ include file="include.jsp"%>
<!-- 
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="../../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/yui/connection/connection.js"></script>
<script type="text/javascript" src="../../.././javascript/tels/brainstorm.js"></script>


<script type="text/javascript">

function validateOptions(){	
	var options = document.getElementsByName('postName');
	for(x=0;x<options.length;x++){
		if(options[x].checked){
			return options[x].value;
		};
	};
	return false;
};

function validate(){
	var optionsPassed = validateOptions();
	var questiontype = '${brainstorm.questiontype}';
	if(!optionsPassed){
		alert("Please select one of the posting options (either Anonymous or with Team member names).");
		return false;
	};
	
	if(questiontype == 'OPEN_RESPONSE'){
		return validateOpenResponse();
	} else if(questiontype == 'SINGLE_CHOICE'){
		return validateSingleChoice();
	};
	return false;
};

function validateOpenResponse(){
	var responseText = document.getElementById('editor').value;
	if(responseText == null || responseText == ""){
		alert("Please enter a response before submitting.");
		return false;
	} else {
		return true;
	};
};

function validateSingleChoice(){
	var choices = document.getElementsByName('radioChoice');
	for(x=0;x<choices.length;x++){
		if(choices[x].checked){
			return choices[x].value;
		};
	};
	alert("Please select a choice before submitting.");
	return false;
};

function submit(){
	if(validate()){
		post();
	};
};

function post(){
	var URL='postresponse.html';
	var text;
	if('${brainstorm.questiontype}' == 'OPEN_RESPONSE'){
		text = document.getElementById('editor').value;
	}else if('${brainstorm.questiontype}' == 'SINGLE_CHOICE'){
		text = validateSingleChoice();
	};
	var data='option=' + validateOptions() + '&text=' + text + '&workgroupId=${workgroup.id}&brainstormId=${brainstorm.id}';
	var callback = {
		success:function(o){
			var xmlDoc = o.responseXML;
			if(xmlDoc==null){
				callback.failure(o);
			};
			var answerElements = xmlDoc.getElementsByTagName("answer");
			var answer = new Answer(answerElements[0]);
			var pageManager = window.opener.pageManager;			
			pageManager.addAnswer(answer);
			//self.close();
		},
		failure:function(o){
			alert('failed to update to server');
			//self.close();
		}
	};
	YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
};

</script>
</head>

<body>

<%@page import="org.telscenter.sail.webapp.domain.brainstorm.DisplayNameOption" %>
<% pageContext.setAttribute("username_only", DisplayNameOption.USERNAME_ONLY); %>
<% pageContext.setAttribute("anonymous_only", DisplayNameOption.ANONYMOUS_ONLY); %>
<% pageContext.setAttribute("username_or_anonymous", DisplayNameOption.USERNAME_OR_ANONYMOUS); %>

<div id="createResponseWindow">

	<div id="head">Create A Response</div>
	
	<div id="interior">
	
		<div id="owner" style="color:FF0000;">Period X: Group Y <span class="numberStudents">(# students)</span></div>
	
		<div id="question">
			<b>Question:</b>
			<span id="questionBox">${brainstorm.question.prompt}</span>
		</div>
	
		<c:if test="${brainstorm.questiontype=='OPEN_RESPONSE'}">
	    	<b>Response:</b><br>
			<textarea id="editor" name="editor" rows="20" cols="75" ></textarea>
		</c:if>
		<c:if test="${brainstorm.questiontype=='SINGLE_CHOICE'}">
			<div id="choiceList">
			<b>Choices:</b><br>
				<c:forEach var="key" varStatus="choiceStatus" items="${keys}">
					<input type="radio" name="radioChoice" id="choice${key}" value="${key}"/> ${choices[key]} <br>
				</c:forEach>
			</div>
		</c:if>
	
		<div id="selectPostType">
        	<c:if test="${brainstorm.displayNameOption == username_only}">  <!-- must NOT be anonymous -->
           	<c:out value="Your response will be displayed with your names" />
           	<input type="hidden" name="postName" value="1" checked="checked" />
        	</c:if>
        	<c:if test="${brainstorm.displayNameOption == anonymous_only}"> <!--  must be anonymous -->
           		<c:out value="Your response will be displayed anonymously" />
           		<input type="hidden" name="postName" value="0" checked="checked"/>
        	</c:if>
        	<c:if test="${brainstorm.displayNameOption == username_or_anonymous}">  <!--  student can choose displayname -->
		  
		  		<div>How would you like your response labeled?</div>
		  			<label for="radioAnon"><input type="radio" name="postName" id="radioAnon" value="0"/>Label anonymously as: "Anonymous"</label><br/>
		    		<label for="radioTeam"><input type="radio" name="postName" id="radioTeam" value="1" checked="checked"/>Label with student names: 
					<c:forEach var="student" varStatus="studentStatus" items="${workgroup.members}">
						${student.userDetails.firstname} ${student.userDetails.lastname}
						<c:if test="${studentStatus.last=='false'}">, </c:if>
					</c:forEach>
		    		</label>
   	      		</div>
        	</c:if>
			
			<div id="inputButtons">
				<input id="buh-bye" type="button" value="CANCEL" onclick="self.close()"/>
				<div onclick="setTimeout('self.close()', 1000);">
				    <input id="submitResponse" type="button" value="POST RESPONSE" onclick="submit()"/>
				</div>
			</div>
	
		</div>
		
	</div>

</body>
</html>