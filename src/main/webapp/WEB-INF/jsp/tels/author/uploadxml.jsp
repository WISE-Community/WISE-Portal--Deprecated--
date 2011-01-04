<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />


    
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>
<script type="text/javascript" src=".././javascript/tels/general.js"></script>
    
<title>Edit Project Page</title>

<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
</head>
<body>

<form:form method="post" action="uploadxml.html?projectId=${projectId}" commandName="xmlFileUpload" id="uploadProject" enctype="multipart/form-data" autocomplete='off'>
	<label for="xmlFile">xml file</label><br/>
	<input type="file" name="file" id="xmlFile"/>
    <br/><br/>
    
    <input type="submit" value="Save" />
    <a href="authorrooloproject.html?projectId=${projectId}"><input type="button" value="Cancel"></input></a>
</form:form>
</body>
</html>