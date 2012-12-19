<%@ include file="../include.jsp"%>
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

<!-- $Id$ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<title><spring:message code="application.title" /></title>

<style>
/* hides the close button on the loading modal dialog so students can't close it
.ui-dialog-titlebar-close {
  visibility: hidden;
}
</style>

<script type="text/javascript">

    /**
     * Called when the student clicks on the "absent today" link
     */
    function teammateAbsent(teammateAbsentIndex) {
        //clear the username from the form
		document.getElementById("username" + teammateAbsentIndex).value = "";
    }
    
    $(document).ready(function() {
    	$("#runproject").click(function() {
    	// show a loading dialog while the form is being submitted.
    	if ($("#loadingDialog").length == 0) {
    		var loadingDialog = $("<div>").attr("id","loadingDialog").attr("title", "Loading...").html("Loading...Please wait");
    		$(document).append(loadingDialog);
    		loadingDialog.dialog({
                height: 140,
                modal: true,
                draggable: false
            });
    	}
    })
    });
</script>

</head>

<body style="background-color:#333333;">
<c:if test="${closeokay}">
<c:out value="hi" />
</c:if>
<!--  <h1>Team Sign In</h1> -->

<div id="teamSelect" class="teamMargin2">
	<div id="teamSelectHeader"><span style="color:#0000CC;"><sec:authentication property="principal.username" /></span> <spring:message code="student.teamsignin.1"/></div>
	<div id="teamSelectHeader"><spring:message code="student.teamsignin.2"/></div>
	
	<c:set var="runId" value='<%= request.getParameter("runId") %>' />
	<form:form method="post" action="teamsignin.html?runId=${runId}" commandName="teamSignInForm" id="teamSignInForm" autocomplete='off'>
			<table id="multiUserSignIn" border="0" cellspacing="0" cellpadding="2">
		  		<tr id="multiUserSeparatorRow">
					<td colspan=3"></td>
				</tr>
				<tr>
		  			<td><label for="username1"><spring:message code="student.teamsignin.3"/></label></td>
		     		<td><form:input disabled="true" path="username1" id="username1" /></td>
		     		<td id="teamSignMessages"><spring:message code="student.teamsignin.4"/></td>
				</tr>
				<tr id="multiUserSeparatorRow">
					<td colspan=3"></td>
				</tr>
		  		<tr>
		  		<c:forEach var="teammate_index" begin="2" end="${maxWorkgroupSize}" step="1">
		    		<td><label for="username${teammate_index}"><spring:message code="student.teamsignin.5"/> ${teammate_index}:</label></td>
		        	<td><form:input path="username${teammate_index}" id="username${teammate_index}"/></td>
		        	<td class="errorMsgStyle"><form:errors path="username${teammate_index}" /></td>
		        </tr>
				<tr>
		 			<td><label for="password${teammate_index}"><spring:message code="student.teamsignin.6"/></label></td>
		        	<td><form:password path="password${teammate_index}" id="password${teammate_index}"/></td>
		        	<td class="errorMsgStyle"><form:errors path="password${teammate_index}" /></td>
		        </tr>
		        <tr class="multiUserAbsentRow">
		        	<td><a href="#" onclick="teammateAbsent(${teammate_index})"><spring:message code="student.teamsignin.7"/></a></td>
		        	<td></td>
		        	<td></td>
		        </tr>
				<tr id="multiUserSeparatorRow">
					<td colspan=3"></td>
				</tr>
		  </c:forEach>
			</table>
			
	<div><a href="../forgotaccount/student/passwordreminder.html" id="forgotlink"><spring:message code="student.teamsignin.8"/></a>  </div>
	
	 <div id="finalRunProjectButton" onclick="setTimeout('self.close()', 15000);">
 	    <input type="submit" class="wisebutton" name="_finish" value="Run Project" id="runproject" />
	</div>
					
	</form:form>

</div>

</body>
</html>
