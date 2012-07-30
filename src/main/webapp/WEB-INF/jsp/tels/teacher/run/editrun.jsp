<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<title>Edit Run</title>

<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type='text/javascript'>
	var runUpdated = false;
	
	function updateRunTitle(runId){
		$('#msgDiv').html('');
		var val = $('#editRunTitleInput').val();
		val = escape(val);

		/* validate user entered value */
		if(!val || val==''){
			writeMessage('You must specify a value for the title of the run');
			return;
		}

		$.ajax({type:'POST', url:'updaterun.html', data:'command=updateTitle&runId=' + runId + '&title=' + val, error:updateFailure, success:updateTitleSuccess});
	}

	function updateRunPeriod(runId){
		$('#msgDiv').html('');
		var val=$.trim($('#editRunPeriodsInput').val());

		/* validate user entered value */
		if(!val || val==''){
			writeMessage('You must specify a value for the period');
			return;
		} else if (val != val.match( /[A-Za-z0-9 ]*/ )) {
			writeMessage('The period name must be alphanumeric.');
			return;
		} else if ($("#period_"+val+"").length > 0) {
			writeMessage('You already have a period with this name.');
			return;			
		}

		$.ajax({type:'POST', url:'updaterun.html', data:'command=addPeriod&runId=' + runId + '&name=' + val, error:updateFailure, success:updatePeriodSuccess});
	}

	function writeMessage(msg){
		$('#msgDiv').html(msg);
		setTimeout(function(){$('#msgDiv').html('')}, 10000);
	}

	function updateSuccess(){
		writeMessage('Successfully updated run settings!');
	}
	
	function updateTitleSuccess(){
		runUpdated = true;
		writeMessage('Successfully updated run title!');
	}

	function updateFailure(){
		writeMessage('Error contacting server to update run information, please try again.');
	}

	function updatePeriodSuccess(){
		runUpdated = true;
		var val = $('#editRunPeriodsInput').val();
		$('#existingPeriodsList').append('<li>Period Name: <span id="period_'+val+'">' + val + "</span></li>");
		writeMessage('Period successfully added to run!');
	}

	$(document).ready(function() {		
		$(".runInfoOption").bind("click", function() {
			$('#msgDiv').html('');
			var runId = $("#runId").html();
			var infoOptionName = this.id;
			var isEnabled = this.checked;

			$.ajax({type:'POST', url:'updaterun.html', data:'command='+infoOptionName+'&runId=' + runId + '&isEnabled=' + isEnabled, error:updateFailure, success:updateSuccess});
			
			if(infoOptionName == 'enableXMPP' && isEnabled == false) {
				//hide the Classroom Monitor link because the teacher has enabled xmpp
				$('#runId\\=' + runId + '\\&gradingType\\=monitor', window.parent.document).hide();
			} else if(infoOptionName == 'enableXMPP' && isEnabled == true) {
				//show the Classroom Monitor link because the teacher has disabled xmpp
				$('#runId\\=' + runId + '\\&gradingType\\=monitor', window.parent.document).show();
			}
		});
	});
</script>
</head>
<body style="background:#FFFFFF;">
<div class="dialogContent">
	<div id="runId" style="display:none;">${run.id}</div>
	<div id='msgDiv'></div>
	<div id="editRunTitleDiv" class="dialogSection">
		Run Title: <input id="editRunTitleInput" class="dialogTextInput" type="text" size="40" value="<c:out value='${run.name}' />"/><input type="button" value="Update Title" onclick="updateRunTitle('${run.id}')"/>
	</div>
	<div id='runInfo' class="dialogSection">
		<c:choose>
			<c:when test="${run.ideaManagerEnabled}">
				<input id='enableIdeaManager' class='runInfoOption' type="checkbox" checked="checked" ></input>Enable Idea Manager
			</c:when>
			<c:otherwise>
				<input id='enableIdeaManager' class='runInfoOption' type="checkbox" ></input>Enable Idea Manager
			</c:otherwise>
		</c:choose>
		<br/>
		<c:choose>
			<c:when test="${run.studentAssetUploaderEnabled}">
				<input id='enableStudentAssetUploader' class='runInfoOption' type="checkbox" checked="checked"></input>Enable Student File Uploader
			</c:when>
			<c:otherwise>
				<input id='enableStudentAssetUploader' class='runInfoOption' type="checkbox"></input>Enable Student File Uploader
			</c:otherwise>
		</c:choose>
		<br/>
		<c:choose>
			<c:when test="${run.XMPPEnabled}">
				<input id='enableXMPP' class='runInfoOption' type="checkbox" checked="checked"></input>Enable Real-Time Classroom
			</c:when>
			<c:otherwise>
				<input id='enableXMPP' class='runInfoOption' type="checkbox"></input>Enable Real-Time Classroom
			</c:otherwise>
		</c:choose>
	</div>
	<div class="sectionHead">Existing Class Periods</div>
	<div id="editRunPeriodsDiv" class="dialogSection">
		<div id="editRunPeriodsExistingPeriodsDiv">
			<ul id="existingPeriodsList">
				<c:forEach var="period" items="${run.periods}">
					<li>Period Name: <span id="period_${period.name}">${period.name}</span></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div class="sectionHead">Add a New Period:</div>
	<div class="dialogSection">
		<div id="editRunPeriodsAddPeriodDiv">
			<div>Enter period name (e.g. for period 4, enter ONLY 4): <input id="editRunPeriodsInput" class="dialogTextInput" type="text" size="10"/><input type="button" value="Add Period" onclick="updateRunPeriod('${run.id}')"/></div>
		</div>
		<div class="buffer"></div>
	</div>
</div>
</body>
</html>