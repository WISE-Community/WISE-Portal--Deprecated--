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

<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src=".././javascript/tels/general.js"></script>    
    
<!-- Dependency -->
<script src="http://yui.yahooapis.com/2.8.0r4/build/yahoo/yahoo-min.js"></script>
<!-- Used for Custom Events and event listener bindings -->
<script src="http://yui.yahooapis.com/2.8.0r4/build/event/event-min.js"></script>
<script src="http://yui.yahooapis.com/2.8.0r4/build/connection/connection_core-min.js"></script>

    
<title><spring:message code="application.title" /></title>

<script type="text/javascript">
function findPeriods() {
	var callback =
		{
		  success: function(o) {
  			var periodSelect = document.getElementById("runCode_part2");
			periodSelect.innerHTML = "";
			// o.responseText can be either "not found" (when runcode doesn't point to an existing run
		  	// or "1,2,3,4,5,...", a comma-separated values of period names
		  	var responseText = o.responseText;
		  	if (responseText == "not found" || responseText.length < 2) {
		  		alert("The Access Code is invalid. Please ask your teacher for help.");
		  	} else {
  				var op = document.createElement('option');
			  	op.appendChild(document.createTextNode("Select your class period..."));
			  	op.value = 'none';
  				periodSelect.appendChild(op);
  				
			  	var periodsArr = responseText.split(",");
		  		for (var i=0; i < periodsArr.length; i++) {
			  		var periodName = periodsArr[i];
			  		if (periodName != "") {
			  			var op = document.createElement('option');
					  	op.appendChild(document.createTextNode(periodName));
					  	op.value = periodName;
		  				periodSelect.appendChild(op);
			  		}
		  		}
		  		periodSelect.disabled = false;
		  	}
		  },
		  failure: function(o) {
			  alert('failure');
		  },
		  argument: []
		}
	var runcode = document.getElementById("runCode_part1").value;
	if (runcode != null && runcode != "") {
		var transaction = YAHOO.util.Connect.asyncRequest('GET', "/webapp/runinfo.html?runcode=" + runcode, callback, null); 
	}
}

function save() {
	var runcode = document.getElementById("runCode_part1").value;
	var period = document.getElementById("runCode_part2").value;

	if (period != null && period == "none") {
		alert('Please select a period.');
	} else if (runcode != null && period != null && period != "none") {
		var projectCode = document.getElementById("projectcode");
		projectCode.value = runcode + "-" + period;
		document.getElementById("addproject").submit();		
	} else {
		alert('invalid project code. Please talk to your teacher');
	}
}


function setup() {
	var runcode= document.getElementById('runCode_part1').value;
	if (runcode != null && runcode != "") {
		findPeriods();
	}
}
</script>

</head>

<body onload="setup();" style="background-color:transparent;">
<!-- Support for Spring errors object -->
<spring:bind path="addProjectParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <div id="errorMessageFormat">
      	<c:out value="${error}"/>
    </div>
  </c:forEach>
</spring:bind>

<div id="centeredDiv" style="background-color:transparent;">

<div id="popUpWindow1">

<form:form method="post" action="addproject.html" commandName="addProjectParameters" id="addproject" autocomplete='off'>

  <div>
      <label for="runCode_part1" id="runCode_part1_label">Access Code:</label>
	  <form:input onblur="findPeriods();" path="runCode_part1" id="runCode_part1" size="25" maxlength="25" tabindex="1"/>

			<!--This unusually placed script gets the cursor into the First Name field immediately on page load.  
				It must appear immediately after the Input field in question  (MattFish)
				<script type="text/javascript">
				document.getElementById('runCode_part1').focus();
				</script>-->

	  <a href="#" onclick="findPeriods();" class="viewPeriodsLink">CLICK TO SHOW PERIODS (after entering access code)</a>
	 
      <label for="runCode_part2" id="runCode_part2_label">Period:</label>
	  <form:select path="runCode_part2" id="runCode_part2" tabindex="2" disabled="true"></form:select>
      
      <form:hidden path="projectcode" id="projectcode"/>
     
      <div id="addButtonContainer"><a id="addButton" onclick="save();">Add Project</a></div>
     <!--  
   	 <input id="addProjectButton" onclick="save()" type="image" src="../<spring:theme code="student_add_this_project" />" 
    	onmouseover="swapImage('addProjectButton','../<spring:theme code="student_add_this_project_roll" />');" 
    	onmouseout="swapImage('addProjectButton','../<spring:theme code="student_add_this_project"/>');" />
   -->
   </div>
</form:form>

</div>
</div>
</body>
</html>
