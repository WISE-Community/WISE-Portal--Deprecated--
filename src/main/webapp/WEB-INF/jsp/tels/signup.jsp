<%@ include file="include.jsp"%>

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
  
<title><spring:message code="signup.title" /></title>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage"><spring:message code="wise"/></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="signup.1"/></div>
				<div class="infoContentBox">
					<h4><spring:message code="signup.2"/></h4>
					<div><a href="/webapp/student/registerstudent.html" class="wisebutton" title="<spring:message code="signup.3"/>"><spring:message code="signup.3"/></a></div>
					<div><a href="/webapp/teacher/registerteacher.html" class="wisebutton" title="<spring:message code="signup.4"/>"><spring:message code="signup.4"/></a></div>
					<div style="margin-top:1em;"><spring:message code="register.which-account" /></div>
					<div class="instructions"><spring:message code="register.student-account-desc" /></div>
					<div class="instructions"><spring:message code="register.teacher-account-desc" /></div>
				</div>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
	</div>
</div>
   
</body>
</html>


