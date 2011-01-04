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
 
<script type="text/javascript" src="/webapp/javascript/tels/prototype.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/scriptaculous.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/effects.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/controls.js"></script>

<%@ include file="./styles.jsp"%>

<link href="../../<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

</head>

<body class="yui-skin-sam" style="background-color:#CCCCCC;">

<script type="text/javascript">

	var locations = [];
	
	var scores = [];

	function absoluteScore(absolute){
		for(var i=0; i < locations.length; i++){
			injectScore(absolute, locations[i]);
		}
	}
	
	function percentageScore(percentage){
		for(var i=0; i < locations.length; i++){
			injectScore(Math.round(scores[i] * percentage), locations[i]);
		}
	}

	function score(){
		
		var error;
				
		var absolute = document.getElementById('absoluteScore').value;
		
		var percentage = document.getElementById('select-percentage').options[document.getElementById('select-percentage').selectedIndex].value;
		
		document.getElementById('error').innerHTML = "";
		
		error = checkForErrors(absolute, percentage);
		
		if(error == ""){
			if(absolute != ""){
				absoluteScore(absolute);
				self.close();
			} else if(percentage != ""){
				percentageScore(percentage);
				self.close();
			} else {
				document.getElementById('error').innerHTML = "<font color='8B0000'>Unable to batch score.</font>";
			}
		} else {
			document.getElementById('error').innerHTML = error;
		}
	}
	
	checkForErrors = function(absolute, percentage){

		var error = "";
		
		if(absolute == "" && percentage == ""){
			error = "<font color='8B0000'>Please enter an absolute score or a percentage score.</font>";
		}
		
		if(absolute != "" && percentage != ""){
			error = "<font color='8B0000'>Please enter EITHER an absolute score or a percentage score. You cannot run both at once.</font>";
		}
		
		return error;
	}
	
	function setLocation(location){
		locations[locations.length] = location;
	}
	
	function setScore(score){
		scores[scores.length] = score;
	}
	
	function injectScore(score, location){
		window.opener.document.getElementById(location).value = score;
	}
</script>


<div id="batchWindowBorder">

<div id="batchHeader">score as batch</div> 

<div id="currentDisplayCounter">Current grading display contains ${fn:length(steps)} gradable items.</div>

<div id="scoreValueArea">
<h5>Type an absolute score for these items: <input type="text" id="absoluteScore"/></h5>
<h6>OR</h6>
<h5>Select a percent score for these items:
<span id="percentage">
	<select id="select-percentage" name="precentage-select">
		<option value=""></option>
		<option value="1">100%</option>
		<option value=".95">95%</option>
		<option value=".9">90%</option>
		<option value=".85">85%</option>
		<option value=".8">80%</option>
		<option value=".75">75%</option>
		<option value=".7">70%</option>
		<option value=".65">65%</option>
	</select>
</span>
</h5>
</div>

<c:forEach var="step" items="${steps }">
	<c:set var="loc" value="teacher-score-${step.podUUID}_${workgroupId}"/>
	<c:set var="score" value="${step.possibleScore}"/>
	<script type="text/javascript">
		setLocation('${loc}');
		setScore('${score}');
	</script>
</c:forEach>

<div id="batchButtonArea">
	<input id="score" type="button" value="RUN BATCH SCORE" onclick="score()"/> <input id="forgetIt" type="button" value="CANCEL" onclick="self.close()"/>
</div>

<div id="error"></div>

</div>

</body>
</html>