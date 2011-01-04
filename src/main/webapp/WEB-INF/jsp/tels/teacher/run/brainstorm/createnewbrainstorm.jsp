
<html>
<head>
<script type="text/javascript">

	function submit(){
		
		var type = document.getElementById('type').options[document.getElementById('type').selectedIndex].value;
		
		document.getElementById('error').innerHTML = "";
		
		if(type=='OPEN_RESPONSE'){
			window.location.href='createopenresponsebrainstorm.html?projectId=${projectId}&runId=${runId}';
		}else if(type=='SINGLE_CHOICE'){
			window.location.href='createsinglechoicebrainstorm.html?projectId=${projectId}&runId=${runId}';
		}else if(type=='MULTI_CHOICE') {
			displayError("<font color='8B0000'>MultiChoice functionality not yet implemented</font>");
		}else {
			displayError("<font color='8B0000'>Before proceeding, one of the Question types must be selected.</font>");
		};
	};
	
	function displayError(error){
		document.getElementById('error').innerHTML = error;
	};
</script>
</head>
<body>

Please select the type of question you would like to create.
<select id="type">
	<option value="OPEN_RESPONSE">Open Response</option>
	<option value="SINGLE_CHOICE">Multiple Choice/Single Response</option>
	<option value="MULTI_CHOICE">Multiple Choice/Multiple Response</option>
</select>

<input type="button" value="SUBMIT" onclick='submit()'/><input type="button" value="CANCEL" onclick='self.close()'/>

<div id="error"></div>

</body>
</html>