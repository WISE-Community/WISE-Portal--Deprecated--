<%@ include file="../../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script src="../../javascript/tels/general.js" 			type="text/javascript"> </script>
    
<title><spring:message code="application.title" /></title>

<script type='text/javascript'>
// update lookup criteria options based on lookup field chosen
function lookupFieldChanged() {
	var selectedLookupField = $("#lookupField option:selected").val();
	if (selectedLookupField == "ID") {
		$("#equalsCriteria").attr("selected","selected");
		$("#likeCriteria").hide();
	} else {
		$("#likeCriteria").show();		
	}
};
</script>
</head>

<body onload="document.getElementById('lookupData').focus();">


<div id="page">

<div id="pageContent">
<h5 style="color:#0000CC;"><a href="../index.html">Return to Main Menu</a></h5>

<!-- Support for Spring errors object -->
<div id="regErrorMessages">
	<spring:bind path="lookupParameters.*">
		<c:forEach var="error" items="${status.errorMessages}">
			<b><br /><c:out value="${error}"/></b>
		</c:forEach>
	</spring:bind>
</div>

<form:form method="post" action="lookupteacher.html" commandName="lookupParameters" id="lookupTeacher" autocomplete='off'>
	<form:label path="lookupField">Search for all teachers by  </form:label>
	<form:select path="lookupField" id="lookupField" onchange="lookupFieldChanged()">
		<c:forEach var="field" items="${fields }">
			<form:option value="${field}">${field }</form:option>
		</c:forEach>
	</form:select>
	
	<form:label path="lookupCriteria">  that  </form:label>
	<form:select path="lookupCriteria" id="lookupCriteria">
		<form:option id="likeCriteria" value="like">CONTAINS</form:option>
		<form:option id="equalsCriteria" value="=">MATCHES</form:option>
	</form:select>
	
	<form:input path="lookupData" id="lookupData"/>
	
	<input type="image" id="save" src="<spring:theme code="register_save" />" 
    	onmouseover="swapSaveImage('save',1)"onmouseout="swapSaveImage('save',0)"   />
</form:form>
</div>
</div>
</body>
</html>