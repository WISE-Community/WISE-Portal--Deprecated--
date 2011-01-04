<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="viewmystudentsstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /><link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>

<title><spring:message code="application.title" /></title>
</head>
<body>

<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->


<h1><spring:message code="teacher.manage.changeperiod.1"/></h1>
 
<div id="popUpWindowTeacherPeriod">
	
	<form:form method="post" action="changestudentperiod.html" commandName="changePeriodParameters" id="changestudentperiod" autocomplete='off'>
	
	<table id="studentInfoTable">
	<tr>
		<th><spring:message code="teacher.manage.changeperiod.2"/></th>
		<td>${changePeriodParameters.student.sdsUser.firstName} ${changePeriodParameters.student.sdsUser.lastName }</td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.changeperiod.3"/></th>
		<td>[Need Student Username here]</td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.changeperiod.4"/></th>
		<td>${changePeriodParameters.projectcode}</td>
	</tr>
	<tr>
		<th><spring:message code="teacher.manage.changeperiod.5"/></th>
		<td><form:select path="projectcodeTo" id="projectcodeTo">
			<c:forEach items="${changePeriodParameters.run.periods}" var="period">
				<form:option value="${period.name}">
					${period.name}
				</form:option>
			</c:forEach>
			</form:select>	
			<br/>
		</td> 
	</tr>
	</table>
	
	
    <div id="teacherPeriodButtons">
    
		    <input type="image" id="teachersave" src="../../<spring:theme code="register_save" />" 
		    onmouseover="swapImage('teachersave','../../<spring:theme code="register_save_roll" />')" 
		    onmouseout="swapImage('teachersave','../../<spring:theme code="register_save" />')"/>
		    
		    <input type='image' value='cancel' id='teachercancel' onclick='window.close()' src="../../<spring:theme code="register_cancel" />" 
		    onmouseover="swapImage('teachercancel','../../<spring:theme code="register_cancel_roll" />')"
		    onmouseout="swapImage('teachercancel','../../<spring:theme code="register_cancel" />')"></input>
    </div>
	</form:form>
 	</div>

</div>

</body>
</html>