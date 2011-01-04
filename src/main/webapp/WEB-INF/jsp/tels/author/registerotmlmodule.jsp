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
<p>
   Please make sure you know what you're doing.  If you're unsure, ask a WISE staff.
</p>
<form:form method="post" action="registerotmlmodule.html" 
	commandName="otmlFile" id="registerotmlmoduleform" enctype="multipart/form-data" autocomplete='off'>

    <p>
    <label for="name">Module name:</label>
    <form:input path="name" id="name" /><form:errors path="name"/>
    </p>
    
    <p>
	<label for="otmlFile">Choose otml to upload: </label>
	<input type="file" name="file" id="otmlFile"/>
	</p>
    
    <input type="submit" value="Save" />
    <a href="../teacher/index.html"><input type="button" value="Cancel"></input></a>
</form:form>

</body>
</html>