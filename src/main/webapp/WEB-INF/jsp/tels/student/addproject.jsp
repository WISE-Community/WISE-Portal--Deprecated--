<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>   
    
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
		alert('Invalid access code. Please talk to your teacher');
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

<body style="background:#FFFFFF" onload="setup();">
<div class="dialogContent">
	<div class="dialogSection">
		<div class="sectionHead">Instructions</div>
		<ol id="addProjectInstructions">
			<li>Enter the Access Code your teacher gave you</li>
			<li>Press TAB on your keyboard or click 'Show Periods'</li>
			<li>Select your class period, then click 'Add Project'</li>
		</ol>
		
		<div class="dialogSection formSection" id="addProjectForm">
		
			<!-- Support for Spring errors object -->
			<div class="errorMsgNoBg">
				<spring:bind path="addProjectParameters.*">
				  <c:forEach var="error" items="${status.errorMessages}">
				    <p><c:out value="${error}"/></p>
				  </c:forEach>
				</spring:bind>
			</div>
			<form:form method="post" commandName="addProjectParameters" id="addproject" autocomplete='off'>
			<div>
		    	<label for="runCode_part1" id="runCode_part1_label">Access Code:</label>
				<form:input onblur="findPeriods();" path="runCode_part1" id="runCode_part1" size="25" maxlength="25" tabindex="1"/>
			</div>
			<div>
				<a onclick="findPeriods();">SHOW PERIODS (after entering access code)</a>
			</div>
			<div>
				<label for="runCode_part2" id="runCode_part2_label">Choose Period:</label>
				<form:select path="runCode_part2" id="runCode_part2" tabindex="2" disabled="true"></form:select>
			</div>
		      
		      <form:hidden path="projectcode" id="projectcode"/>
		     
		    <div><input type="submit" onclick="save();" value="Add Project" /></div>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>
