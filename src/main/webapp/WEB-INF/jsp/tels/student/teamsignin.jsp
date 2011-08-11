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

<%@ include file="styles.jsp"%>

<title><spring:message code="application.title" /></title>


</head>

<body class="yui-skin-sam" style="background-color:#333333;">

<script type="text/javascript">

	//preload image if browser is not IE because animated gif will just freeze if user is using IE

	if(navigator.appName != "Microsoft Internet Explorer") {
		loadingImage = new Image();
		loadingImage.src = "/webapp/themes/tels/default/images/rel_interstitial_loading.gif";
	}
	
    YAHOO.namespace("example.container");

    function init() {

        if (!YAHOO.example.container.wait) {

            // Initialize the temporary Panel to display while waiting for external content to load

            YAHOO.example.container.wait = 
                    new YAHOO.widget.Panel("wait",  
                                                    { width: "240px", 
                                                      fixedcenter: true, 
                                                      close: false, 
                                                      draggable: false, 
                                                      zindex:4,
                                                      modal: true,
                                                      visible: false
                                                    } 
                                                );

            //YAHOO.example.container.wait.setHeader("Loading, please wait...");
            YAHOO.example.container.wait.setBody("<table><tr align='center'>Loading, please wait...</tr><tr align='center'><img src=/webapp/themes/tels/default/images/rel_interstitial_loading.gif /></tr><table>");
            YAHOO.example.container.wait.render(document.body);

        }

        // Define the callback object for Connection Manager that will set the body of our content area when the content has loaded



        var callback = {
            success : function(o) {
                //content.innerHTML = o.responseText;
                //content.style.visibility = "visible";
                YAHOO.example.container.wait.hide();
            },
            failure : function(o) {
                //content.innerHTML = o.responseText;
                //content.style.visibility = "visible";
                //content.innerHTML = "CONNECTION FAILED!";
                YAHOO.example.container.wait.hide();
            }
        }
    
        // Show the Panel
        YAHOO.example.container.wait.show();
        
        // Connect to our data source and load the data
        //var conn = YAHOO.util.Connect.asyncRequest("GET", "assets/somedata.php?r=" + new Date().getTime(), callback);
    }

    YAHOO.util.Event.on("runproject", "click", init);

    /**
     * Called when the student clicks on the "absent today" link
     */
    function teammateAbsent(teammateAbsentIndex) {
        //clear the username from the form
		document.getElementById("username" + teammateAbsentIndex).value = "";
    }
</script>

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
		  		<c:forEach var="teammate_index" begin="2" end="3" step="1">
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
			
	<div><a href="../forgotaccount/student/index.html" id="forgotlink"><spring:message code="student.teamsignin.8"/></a>  </div>
	
	 <div id="finalRunProjectButton" onclick="setTimeout('self.close()', 15000);">
 	    <input type="image" name=_finish" value="Run Project" id="runproject" src="../<spring:theme code="run_project" />" 
    		onmouseover="swapImage('runproject','../<spring:theme code="run_project_roll" />')" 
    		onmouseout="swapImage('runproject','../<spring:theme code="run_project" />')" />
	</div>
					
	</form:form>

</div>

</body>
</html>
