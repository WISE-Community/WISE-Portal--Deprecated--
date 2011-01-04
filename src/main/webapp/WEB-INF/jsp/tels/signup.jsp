<%@ include file="include.jsp"%>

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
  
<title><spring:message code="signup.title" /></title>

<script type="text/javascript" src="./javascript/pas/utils.js"></script> 
<script type="text/javascript" src="./javascript/tels/general.js"></script>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain_nousername.jsp"%>

<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  Oh how I hate IE-->

<h1 id="registrationTitle" class="blueText"><spring:message code="signup.1"/></h1>

<div id="boxNewAccountReg">

<div id="questionPromptReg" class="center"><spring:message code="signup.2"/></div>

<div id="newAccountButtons">
<ul>
	<li>
	<a href="student/registerstudent.html" title="<spring:message code="signup.3"/>">
	<img id="createstudentacct" src="<spring:theme code="create_student_account" />" 
    onmouseover="swapImage('createstudentacct','<spring:theme code="create_student_account_rollover" />')" 
    onmouseout="swapImage('createstudentacct','<spring:theme code="create_student_account" />')"/></a>
	</li>
</ul>
<ul>
	<li><a href="teacher/registerteacher.html" title="<spring:message code="signup.4"/>"> 
	<img id="createteacheracct" src="<spring:theme code="create_teacher_account" />" 
    onmouseover="swapImage('createteacheracct','<spring:theme code="create_teacher_account_rollover" />')" 
    onmouseout="swapImage('createteacheracct','<spring:theme code="create_teacher_account" />')"/></a> 
	</li>

</ul>
</div>

</div>   <!--  end of boxNewAccountReg -->

<div id="newAccountDetails">
	<h4><em> <spring:message code="register.which-account" /></em> </h4>
	<ul>
		<li><spring:message code="register.student-account-desc" /></li>
		<li><spring:message code="register.teacher-account-desc" /></li>
	</ul>
</div>

	<div style="text-align:center;"><a href="index.html" title="<spring:message code="signup.5"/>"> <img id="return"
	src="<spring:theme code="return_to_homepage" />"
	onmouseover="swapImage('return', '<spring:theme code="return_to_homepage_roll" />');"
	onmouseout="swapImage('return', '<spring:theme code="return_to_homepage" />');" /></a></div>
	
</div>     <!-- end of IE center fix-->

</div>   <!-- end of centered div-->
   
</body>
</html>


