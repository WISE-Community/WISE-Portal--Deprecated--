<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script src="../javascript/tels/general.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/prototype.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/effects.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/scriptaculous.js" 		type="text/javascript"> </script>
<script src="../javascript/tels/rotator.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/rotatorT.js" 			type="text/javascript"> </script>

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>

</head>

<body>

<%@ include file="adminheader.jsp"%>
<h5 style="color:#0000CC;"><a href="index.html">Return to Main Menu</a></h5>
<br>

<!-- Support for Spring errors object -->
<div id="regErrorMessages">
	<spring:bind path="lookupParameters.*">
		<c:forEach var="error" items="${status.errorMessages}">
			<b><br /><c:out value="${error}"/></b>
		</c:forEach>
	</spring:bind>
</div>

<form:form method="post" action="lookupstudent.html" commandName="lookupParameters" id="lookupStudent" autocomplete='off'>
	<form:label path="lookupField">Search for all students by  </form:label>
	<form:select path="lookupField" id="lookupField">
		<c:forEach var="field" items="${fields }">
			<form:option value="${field}">${field }</form:option>
		</c:forEach>
	</form:select>
	
	<form:label path="lookupCriteria">  that  </form:label>
	<form:select path="lookupCriteria" id="lookupCriteria">
		<form:option value="like">CONTAINS</form:option>
		<form:option value="=">MATCHES</form:option>
	</form:select>
	
	<form:input path="lookupData" id="lookupData"/>
	
	<input type="image" id="save" src="../<spring:theme code="register_save" />" 
    	onmouseover="swapSaveImage('save',1)"onmouseout="swapSaveImage('save',0)"   />
</form:form>

</body>
</html>