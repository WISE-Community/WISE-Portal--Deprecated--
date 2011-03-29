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

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../.././javascript/tels/general.js"></script>
 
<title><spring:message code="teacher.pro.custom.sharepro.1"/></title>
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

// when remove user is clicked, confirm with user
function removeSharedUserClicked() {
  return confirm('Are you sure you want to remove this shared teacher?');
}
</script>

<!--USED TO SHOW/HIDE A DIV ELEMENT-->
<script type="text/javascript">

	function toggleProjectSummaryCurrent(){
		var searchDiv = document.getElementById('toggleProjectSummaryCurrent');
		if(searchDiv.style.display=='none'){
			searchDiv.style.display = 'block';
		} else {
			searchDiv.style.display = 'none';
		};
	};
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

<body>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<div id="navigationSubHeader2">Sharing a Project<span id="navigationSubHeader1">projects</span></div> 

<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE. -->

<h2 id="titleBar" class="headerText"><spring:message code="teacher.pro.custom.sharepro.2"/></h2> 

<div class="sharedprojectHeadline1"><spring:message code="teacher.pro.custom.sharepro.3"/></div>

<table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCell" colspan="3">
									<a href="projectinfo.html?projectId=${project.id}">${project.name}</a>
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
								<th id="title1" style="width:90px;">Project Family</th>
								<th id="title2" style="width:292px;" >Subject(s)</th>
								<th id="title3" style="width:100px;">Grades</th>
								<th id="title4" style="width:110px;">Total Time (hrs)</th>
								<th id="title5" style="width:110px;">Computer Time (hrs)</th>
								<th id="title6" style="width:92px;">Language</th>
								<th id="title7" style="width:90px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">[English]</td> 
								<td class="dataCell">${usageMap[project.id]} runs</td>
					
							</tr>
							<tr id="row4">  
								<td colspan="8">
									<a id="hideShowLink" href="#" onclick="toggleProjectSummaryCurrent()">Hide/Show project details</a>
									<div id="toggleAllCurrent">
									<div id="toggleProjectSummaryCurrent" style="display:none;">
										<table id="detailsTable">
											<tr>
												<th>Created On:</th>
												<td class="keywords">${project.dateCreated }</td>
											</tr>
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">[List of comma-separated keywords go here]</td>
											</tr>
					<tr>
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											<tr>
												<th>Tech Needs:</th>
												<td>[Tech Requirements go here]</td>
											</tr>
										</table>
									</div>
									</div>
								</td>
							</tr>
						</table>
				
<div class="sharedprojectHeadline1"><spring:message code="teacher.pro.custom.sharepro.4"/></div>			

<table id="sharedProjectPermissions">

	<tr>
		<th><spring:message code="teacher.pro.custom.sharepro.5"/></th>
		<th><spring:message code="teacher.pro.custom.sharepro.6"/></th> 
		<th>Actions</th> 
	</tr>
	<tr>
		<c:choose>
			<c:when test="${fn:length(project.owners) == 0 }">
			</c:when>
			<c:otherwise>
				<c:forEach var="owner" items="${project.owners }">
					<td class="sharedUserName">${owner.userDetails.username}</td>
					<td><spring:message code="teacher.pro.custom.sharepro.7"/></td>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tr>
	
	<c:choose>
		<c:when test="${fn:length(project.sharedowners) == 0}">
		</c:when>
		<c:otherwise>
			<c:forEach var="sharedowner" items="${project.sharedowners}">
					<tr>
						<td>${sharedowner.userDetails.username}</td>
						<td align="left">		
						<form:form method="post" id="${sharedowner.userDetails.username}"
							commandName="${sharedowner.userDetails.username}" autocomplete='off'>
							<form:hidden path="sharedOwnerUsername" />
						
							<form:radiobutton path="permission"
								onclick="javscript:this.form.submit();" value="ROLE_READ_PROJECT" />Can Run the project<br />
							<form:radiobutton path="permission"
								onclick="javscript:this.form.submit();" value="ROLE_WRITE_PROJECT" />Can Run + Edit the project<br />
							<sec:authorize ifAllGranted="ROLE_USER">
							   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
								<form:radiobutton path="permission"
									onclick="javscript:this.form.submit();" value="ROLE_SHARE_PROJECT" />Can Run + Edit + Share the project<br />
								</sec:authorize>
							   <sec:authorize ifNotGranted="ROLE_ADMINISTRATOR">
									<sec:accesscontrollist domainObject="${project}" hasPermission="16">												
							        	<form:radiobutton path="permission"
								    	    onclick="javscript:this.form.submit();" value="ROLE_SHARE_PROJECT" />Can Run + Edit + Share the project<br />								
									</sec:accesscontrollist>					
								</sec:authorize>							
					    	</sec:authorize>
					    </form:form>					    									
						</td>
						<td>
							<form:form method="post" id="${sharedowner.userDetails.username}" commandName="${sharedowner.userDetails.username}" autocomplete='off'>
            					<form:hidden path="sharedOwnerUsername" />
            					<input type="hidden" name="removeUserFromProject" value="true"></input>
								<input type="submit" value="Remove this User" onclick="return removeSharedUserClicked();"></input>
			    			</form:form>	
			    	<!--  
						<a href='#'
							onclick="alert('Remove Shared Teacher is not yet implemented.');"><spring:message
							code="teacher.run.shareprojectrun.16" /></a>
							-->
					</td>
							
					</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	<tr>
		<td id="sharingSearchBox" colspan=3>
			<div id="sharingSearchBoxHelp"><spring:message code="teacher.pro.custom.sharepro.12"/></div>
				<form:form method="post" commandName="addSharedTeacherParameters" autocomplete='off'>
					<form:input path="sharedOwnerUsername" id="sharedOwnerUsernameInput" onkeyup="populatePossibilities(this.value)" size="25"/>
					<input type="submit" value="<spring:message code="teacher.pro.custom.sharepro.13"/>"></input>
				</form:form>
				<ul id="matchedUsernames">
				</ul>
		</td>
	</tr>

</table> 

<h5><a href="../customized/index.html#actionsCurrent"><spring:message code="teacher.pro.custom.sharepro.14"/><em>My Projects</em></a></h5>

</div>
</div>
<c:if test="${not empty message}">
<script type="text/javascript">
 alert("${message}");
</script>
</c:if>

</body>
</html>

