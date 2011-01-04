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
	var responseText = document.getElementById('editor').value;
	if(!optionsPassed){
		alert("Please select one of the posting options (either Anonymous or with Team member names).");
		return false;
	} else if(responseText == null || responseText == ""){
		alert("Please enter a response before submitting.");
		return false;
	} else {
		return true;
	};
};

function submit(){
	if(validate()){
		post();
	};
};

function post(){
	var URL='postcomment.html';
	var data='option=' + validateOptions() + '&text=' + document.getElementById('editor').value + '&workgroupId=${workgroup.id}&answerId=${answer.id}';
	var callback = {
		success:function(o){
			var xmlDoc = o.responseXML;
			if(xmlDoc==null){
				callback.failure(o);
			};
			var commentElements = xmlDoc.getElementsByTagName("comment");			
			var comment = new Comment(commentElements[0]);
			var pageManager = window.opener.pageManager;
			pageManager.addComment(comment, ${answer.id});
			self.close();
		},
		failure:function(o){
				alert('failed to update to server'); 
				self.close();
		}
	};
	YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
};
</script>
</head>

<body>

<div id="createResponseWindow">

	<div id="head">Add a Comment</div>

	<div id="interior">
	
			<div id="answer">
				<div name="head" id=>
					<b>Selected Response:</b><br/>
					<div id="selectedResponseLabels">
						<c:choose>
							<c:when test="${answer.anonymous}">
			                	<i>Anonymous</i>
			                </c:when>
							<c:otherwise>
								<c:forEach var="student" varStatus="studentStatus" items="${answer.workgroup.members}">
									${student.userDetails.firstname} ${student.userDetails.lastname}
									<c:if test="${studentStatus.last=='false'}"> & </c:if>
								</c:forEach>
			            	</c:otherwise>
						</c:choose>
						<br>
						posted 
						<c:forEach var="revision" varStatus="revisionStatus" items="${answer.revisions}">
							<c:if test="${revisionStatus.last=='true'}">${revision.timestamp}</c:if>
						</c:forEach>
					</div>
				</div>
				<div name="body" id="selectedResponseText">
					<c:forEach var="revision" varStatus="revisionStatus" items="${answer.revisions}">
						<c:if test="${revisionStatus.last=='true'}">
							<c:if test="${type=='OPEN_RESPONSE'}">${revision.body}</c:if>
							<c:if test="${type=='SINGLE_CHOICE'}">${choicemap[revision.body]}</c:if>
						</c:if>
					</c:forEach>
				</div>		
			</div>
			<br/>
			<div id="comment">
				<b>Comment (type your comment here):</b><br/>
				<textarea id="editor" cols="45" rows="8"></textarea>
			</div>
		
			<div id="selectPostType">
				<div>How would you like your comment labeled?</div>
				<label for="radioAnon"><input type="radio" name="postName" id="radioAnon" value="0"/>Label anonymously as: "Anonymous"</label><br/>
				<label for="radioTeam"><input type="radio" name="postName" id="radioTeam" value="1" checked="checked"/>Label with student names: 
					<c:forEach var="student" varStatus="studentStatus" items="${workgroup.members}">
						${student.userDetails.firstname} ${student.userDetails.lastname}
						<c:if test="${studentStatus.last=='false'}">, </c:if>
					</c:forEach>
				</label>
			</div>
			
			<div id="inputButtons">
				<input id="buh-bye" type="button" value="CANCEL" onclick="self.close()"/>
				<input id="submitResponse" type="button" value="POST COMMENT" onclick="submit()"/>
			</div>
	</div>

</div>

</body>
</html>