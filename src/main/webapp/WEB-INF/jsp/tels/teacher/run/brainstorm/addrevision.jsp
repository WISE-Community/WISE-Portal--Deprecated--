<%@ include file="include.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

function validate(){
	
	if('${type}'=='OPEN_RESPONSE'){
		var responseText = document.getElementById('editor').value;
	
		if(responseText == null || responseText == ""){
			alert("Please enter a response before submitting.");
			return false;
		} else {
			return true;
		};
	} else if('${type}'=='SINGLE_CHOICE'){
		var choices = document.getElementsByName('radioChoice');
		for(x=0;x<choices.length;x++){
			if(choices[x].checked){
				return choices[x].value;
			};
		};
		alert("Please select a choice before submitting.");
		return false;
	};
};

function submit(){
	if(validate()){
		post();
	};
};

function post(){
	var URL='postrevision.html';
	var text;
	if('${type}'=='OPEN_RESPONSE'){
		text = escape(document.getElementById('editor').value);
	} else if('${type}'=='SINGLE_CHOICE'){
		text = validate();
	}
	var data='text=' + text + '&workgroupId=${workgroup.id}&answerId=${answer.id}';
	var callback = {
		success:function(o){
			var xmlDoc = o.responseXML;
			if(xmlDoc==null){
				callback.failure(o);
			};
			var revision = new Revision(xmlDoc);
			var pageManager = window.opener.pageManager;
			pageManager.addRevision(revision, ${answer.id});
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

	<div id="head">Revise Your Response</div>

	<div id="interior">

			<div id="answer">
				<div name="head" id="owner">
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

				</div>
				<br/>
				<div name="body">
				    <div><b>Current Response:</b>
					    <span id="postedDate">
							posted 
							<c:forEach var="revision" varStatus="revisionStatus" items="${answer.revisions}">
								<c:if test="${revisionStatus.last=='true'}">
									<fmt:formatDate value="${revision.timestamp}" type="time" timeStyle="short" />
									<fmt:formatDate value="${revision.timestamp}" type="date" dateStyle="medium" />	
									<div id="currentResponseBox">
										<c:if test="${type=='OPEN_RESPONSE'}">
											${revision.body}
										</c:if>
										<c:if test="${type=='SINGLE_CHOICE'}">
											<c:set var="latestRevision" value="${revision}"/>
											${choicemap[revision.body]}
										</c:if>
									</div>
								</c:if>
							</c:forEach>
						</span>
					<div>
				</div>		
			</div>
			<br/>
			
			<div id="comment">
				<b>Revised Response:</b><br/>
				<c:if test="${type=='OPEN_RESPONSE'}">
					<textarea id="editor" name="editor" cols="45" rows="8"><c:forEach var="revision" varStatus="revisionStatus" items="${answer.revisions}"><c:if test="${revisionStatus.last=='true'}">${revision.body}</c:if></c:forEach></textarea>
				</c:if>
				<c:if test="${type=='SINGLE_CHOICE'}">
					<c:forEach var="key" varStatus="choiceStatus" items="${keys}">
						<c:choose>
							<c:when test="${key==latestRevision.body}">
								<input type="radio" name="radioChoice" id="choice${key}" value="${key}" CHECKED/> ${choicemap[key]} <br>
							</c:when>
							<c:otherwise>
								<input type="radio" name="radioChoice" id="choice${key}" value="${key}"/> ${choicemap[key]} <br>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</div>
			
			<div id="inputButtons">
				<input id="buh-bye" type="button" value="CANCEL" onclick="self.close()"/>
				<input id="submitResponse" type="button" value="SUBMIT RESPONSE" onclick="submit()"/>
			</div>
	</div>
	
</div>

</body>
</html>