<%@ include file="../../include.jsp" %> 

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

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >

<html lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="teacherrunstylesheet" />" media="screen" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="../../.././javascript/tels/general.js"></script>
 
<title><spring:message code="teacher.run.shareprojectrun.1"/></title>

<script type="text/javascript">
//extend Array prototype
Array.prototype.contains = function(obj) {
	  var i = this.length;
	  while (i--) {
	    if (this[i] === obj) {
	      return true;
	    }
	  }
	  return false;
}

var teacherUsernamesString = "${teacher_usernames}";
var teacherUsernames = teacherUsernamesString.split(":");
teacherUsernames = teacherUsernames.sort();

// updates the search input box with the specified text
function updateInputBox(text) {
	document.getElementById("sharedOwnerUsernameInput").value=text;
}

function populatePossibilities(username) {
	var matchedUsernameUL = document.getElementById("matchedUsernames");
	matchedUsernameUL.innerHTML = "";
	if (username.length > 0) {
		var resultArray = findStringsContaining(username, teacherUsernames);
		for (k=0; k < resultArray.length; k++) {
			var matchedUsernameLI = document.createElement("li");
			matchedUsernameLI.innerHTML = "<a onclick='updateInputBox(\""+resultArray[k]+"\")'>" + resultArray[k] + "</a>";
			matchedUsernameUL.appendChild(matchedUsernameLI);
		}
	}
}


// returns an array of strings that contain what
function findStringsContaining(what, all_array) {
	var resultArray = new Array();
	for (i=0; i < all_array.length; i++) {
		if (all_array[i].toLowerCase().indexOf(what.toLowerCase()) > -1) {
			resultArray.push(all_array[i]);
		}
	}	
	return resultArray;
}

//when remove user is clicked, confirm with user
function removeSharedUserClicked() {
  return confirm('Are you sure you want to remove this shared teacher?');
}
</script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Sharing a Project Run<span id="navigationSubHeader1">Management: My Project Runs</span></div>


<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE. -->

<h2 id="titleBar" class="headerText"><spring:message code="teacher.run.shareprojectrun.2"/></h2> 
				<c:out value="${message}" />

<div class="sharedprojectHeadline1"><spring:message code="teacher.run.shareprojectrun.3"/></div>
     
				        <table id="runTitleTable">
				      			<tr>
				      				<td class="runTitleTableHeader"><spring:message code="teacher.run.shareprojectrun.4"/></td>
				      				<td>${run.project.curnit.sdsCurnit.name}</td>
				      			</tr>
				      			<tr>
				      				<td class="runTitleTableHeader"><spring:message code="teacher.run.shareprojectrun.5"/></td>
				      				<td>${run.project.id}</td>
				      			</tr>
				      			<tr> 
				      				<td class="runTitleTableHeader"><spring:message code="teacher.run.shareprojectrun.6"/></td>
				      				<td>UC Berkeley library project</td>
				      			</tr>
				      			<tr>
				      				<td class="runTitleTableHeader"><spring:message code="teacher.run.shareprojectrun.7"/></td>
				      				<td><fmt:formatDate value="${run.starttime}" type="date" dateStyle="short" /></td>
				      			</tr>
						</table>
				
<div class="sharedprojectHeadline1"><spring:message code="teacher.run.shareprojectrun.8"/></div>			

<table id="sharedProjectPermissions">

	<tr>
		<th><spring:message code="teacher.run.shareprojectrun.9"/></th>
		<th><spring:message code="teacher.run.shareprojectrun.10"/>L</th> 
		<th><spring:message code="teacher.run.shareprojectrun.11"/></th>
	</tr>
	<!--  display owners of the run -->
	<c:choose>
		<c:when test="${fn:length(run.owners) == 0}">
		</c:when>
		<c:otherwise>
			<c:forEach var="owner" items="${run.owners}">
				<tr>
				    <td>${owner.userDetails.firstname} ${owner.userDetails.lastname}</td>
					<td><spring:message code="teacher.run.shareprojectrun.12"/></td>
					<td><spring:message code="teacher.run.shareprojectrun.13"/></td>
			    </tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	<!--  display shared owners of the run -->
	<c:forEach var="sharedowner" items="${run.sharedowners}">        
		    <tr>
		        <td>${sharedowner.userDetails.username}</td>
			    <td align="left">
			    	<form:form method="post" id="${sharedowner.userDetails.username}" commandName="${sharedowner.userDetails.username}" autocomplete='off'>
            			<form:hidden path="sharedOwnerUsername" />
			        	<form:radiobutton path="permission" onclick="javscript:this.form.submit();" value="ROLE_RUN_READ" /><spring:message code="teacher.run.shareprojectrun.14"/><br />
			    	    <form:radiobutton path="permission" onclick="javscript:this.form.submit();" value="ROLE_RUN_GRADE" /><spring:message code="teacher.run.shareprojectrun.15"/>
			    	</form:form>			        
				</td>
				<td><form:form method="post" id="${sharedowner.userDetails.username}" commandName="${sharedowner.userDetails.username}" autocomplete='off'>
            		<form:hidden path="sharedOwnerUsername" />
            		<input type="hidden" name="removeUserFromRun" value="true"></input>
					<input type="submit" value="Remove this User" onclick="return removeSharedUserClicked();"></input>
			    	</form:form>			        
				    <!-- <a href='#' onclick="alert('Remove Shared Teacher is not yet implemented.');"><spring:message code="teacher.run.shareprojectrun.16"/></a> -->
				</td>
			</tr>
	</c:forEach>
	
	<tr>
		<td id="sharingSearchBox" colspan=3>
			<div id="sharingSearchBoxHelp">
			<p>To share this project with another person type in part of their name below.</p>
			<p>Click the matching Username from the search results, then click <i>Save</i>.</p> 
			</div>
			    <form:form method="post" commandName="addSharedTeacherParameters" autocomplete='off'>
					<form:input path="sharedOwnerUsername" id="sharedOwnerUsernameInput" onkeyup="populatePossibilities(this.value)" size="30"/>
				    <input type="submit" value="Save" />
				</form:form>
				<ul id="matchedUsernames">
				</ul>
		</td>
	</tr>

</table> 

<h5><a href="../run/myprojectruns.html"><spring:message code="teacher.run.shareprojectrun.18"/>&nbsp;<em><spring:message code="teacher.run.shareprojectrun.19"/></em></a></h5>

</div>
</div>

</body>
</html>

