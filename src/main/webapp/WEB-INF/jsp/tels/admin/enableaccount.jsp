<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="./javascript/tels/rotator.js"></script>
    
<title><spring:message code="application.title" /></title>
</head>

<body style="background-color:transparent;">

<div id="centeredDiv" style="background-color:transparent;">

		<div id="current_status">${username}'s current account status: ${current_enable_status}</div><br/>

		Change ${username}'s account status to:
		<form:form method="post" action="enableaccount.html" id="enableaccount" autocomplete='off' commandName="enableAccountParameters"> 	
			<input type="hidden" name="username" value="${username}" />
			<form:select path="doEnable">
			   <form:option value="false">Disabled</form:option>
			   <form:option value="true">Enabled</form:option>
			</form:select>
			<br/>
			<input type="submit" value="Save" />
		</form:form>
		<input type="button" onclick="window.close()" value="Cancel"/>
		

</div>
</body>
</html>