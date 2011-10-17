<%@ include file="../../include.jsp" %>

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html>

<html lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
 
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
  return confirm('<spring:message code="teacher.pro.custom.sharepro.18"/>');
}
</script>

</head>

<body style="background:#FFFFFF;">

<div class="dialogContent">		

	<div id="sharingSearchBoxHelp" class="dialogSection"><spring:message code="teacher.pro.custom.sharepro.12"/></div>
	
	<div id="sharingSearchSelect">
		<form:form method="post" commandName="addSharedTeacherParameters" autocomplete='off'>
			<spring:message code="teacher.pro.custom.sharepro.17"/> <form:input path="sharedOwnerUsername" id="sharedOwnerUsernameInput" onkeyup="populatePossibilities(this.value)" size="25"/>
			<input type="submit" value="<spring:message code="teacher.pro.custom.sharepro.13"/>"></input>
		</form:form>
		<ul id="matchedUsernames"></ul>
	</div>	
	
	<table id="sharedProjectPermissions">
	
		<tr>
			<th><spring:message code="teacher.pro.custom.sharepro.5"/></th>
			<th><spring:message code="teacher.pro.custom.sharepro.6"/></th> 
			<th><spring:message code="teacher.pro.custom.sharepro.16"/></th> 
		</tr>
		<tr>
			<c:choose>
				<c:when test="${fn:length(project.owners) == 0 }">
				</c:when>
				<c:otherwise>
					<c:forEach var="owner" items="${project.owners }">
						<td class="sharedUserName">${owner.userDetails.username}</td>
						<td><spring:message code="teacher.pro.custom.sharepro.7"/></td>
						<td></td>
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
									onclick="javscript:this.form.submit();" value="ROLE_READ_PROJECT" /><spring:message code="teacher.pro.custom.sharepro.8"/><br />
								<form:radiobutton path="permission"
									onclick="javscript:this.form.submit();" value="ROLE_WRITE_PROJECT" /><spring:message code="teacher.pro.custom.sharepro.9"/><br />
								<sec:authorize ifAllGranted="ROLE_USER">
								   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
									<form:radiobutton path="permission"
										onclick="javscript:this.form.submit();" value="ROLE_SHARE_PROJECT" /><spring:message code="teacher.pro.custom.sharepro.10"/><br />
									</sec:authorize>
								   <sec:authorize ifNotGranted="ROLE_ADMINISTRATOR">
										<sec:accesscontrollist domainObject="${project}" hasPermission="16">												
								        	<form:radiobutton path="permission"
									    	    onclick="javscript:this.form.submit();" value="ROLE_SHARE_PROJECT" /><spring:message code="teacher.pro.custom.sharepro.10"/><br />								
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
						</td>
								
						</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	
	</table> 
</div>

<c:if test="${not empty message}">
<script type="text/javascript">
 alert("${message}");
</script>
</c:if>

</body>
</html>

