<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<title>Edit Run</title>

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/jquery-1.4.1.min.js"></script>
<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type='text/javascript'>
	function updateRunTitle(runId){
		var val = $('#editRunTitleInput').val();
		val = escape(val);

		/* validate user entered value */
		if(!val || val==''){
			writeMessage('You must specify a value for the title of the run');
			return;
		}

		$.ajax({type:'POST', url:'updaterun.html', data:'command=updateTitle&runId=' + runId + '&title=' + val, error:updateFailure, success:updateSuccess});
	}

	function updateRunPeriod(runId){
		var val=$('#editRunPeriodsInput').val();

		/* validate user entered value */
		if(!val || val==''){
			writeMessage('You must specify a value for the period');
			return;
		}

		$.ajax({type:'POST', url:'updaterun.html', data:'command=addPeriod&runId=' + runId + '&name=' + val, error:updateFailure, success:updatePeriodSuccess});
	}

	function writeMessage(msg){
		$('#errorMsgDiv').html(msg);
		setTimeout(function(){$('#errorMsgDiv').html('')}, 10000);
	}

	function updateSuccess(){
		writeMessage('Successfully updated on server!');
	}

	function updateFailure(){
		writeMessage('Error contacting server to update run information, please try again.');
	}

	function updatePeriodSuccess(){
		var val = $('#editRunPeriodsInput').val();

		$('#existingPeriodsList').append('<li>Period Name: ' + val);
		writeMessage('Period successfully added to run!');
	}

	$(document).ready(function() {		
		$(".runInfoOption").bind("click", function() {
			var runId = $("#runId").html();
			var infoOptionName = this.id;
			var isEnabled = this.checked;

			$.ajax({type:'POST', url:'updaterun.html', data:'command='+infoOptionName+'&runId=' + runId + '&isEnabled=' + isEnabled, error:updateFailure, success:updateSuccess});
		});
	});
</script>
</head>
<body>
<div id="mainDiv">
	<div id="editRunHeadDiv" class="editRunBlock">Edit Run (Run ID: <span id='runId'>${run.id}</span>)</div>
	<div id='errorMsgDiv'></div>
	<div id="editRunTitleDiv" class="editRunBlock">
		Run Title: <input id="editRunTitleInput" type="text" size="50" value="<c:out value='${run.name}' />"/><input type="button" value="update title" onclick="updateRunTitle('${run.id}')"/>
	</div>
	<div id='runInfo' style='margin-top:20px; margin-bottom:20px'>
		<c:choose>
			<c:when test="${run.ideaManagerEnabled}">
				<input id='enableIdeaManager' class='runInfoOption' type="checkbox" checked="checked" ></input>Enable Idea Manager<br/>
			</c:when>
			<c:otherwise>
				<input id='enableIdeaManager' class='runInfoOption' type="checkbox" ></input>Enable Idea Manager<br/>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${run.studentAssetUploaderEnabled}">
				<input id='enableStudentAssetUploader' class='runInfoOption' type="checkbox" checked="checked"></input>Enable Student File Uploader
			</c:when>
			<c:otherwise>
				<input id='enableStudentAssetUploader' class='runInfoOption' type="checkbox"></input>Enable Student File Uploader
			</c:otherwise>
		</c:choose>
	</div>
	<div id="editRunPeriodsDiv" class="editRunBlock">
		<div id="editRunPeriodsHeadDiv">Periods:</div>
		<div id="editRunPeriodsExistingPeriodsDiv">
			Existing Periods:
			<ul id="existingPeriodsList">
				<c:forEach var="period" items="${run.periods}">
					<li>Period Name: ${period.name}</li>
				</c:forEach>
			</ul>
		</div>
		<div id="editRunPeriodsAddPeriodDiv">
			<div>Add a new period:</div>
			<div>Enter period name (ex: for period 4, enter ONLY 4): <input id="editRunPeriodsInput" type="text" size="10"/><input type="button" value="add period" onclick="updateRunPeriod('${run.id}')"/></div>
		</div>
		<div class="buffer"></div>
	</div>
</div>
</body>
</html>