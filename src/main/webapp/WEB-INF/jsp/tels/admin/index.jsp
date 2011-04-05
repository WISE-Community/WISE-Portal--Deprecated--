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

<script>
//alert('hi');
//alert(ChangePasswordParametersValidatorJS.test('hi'))
</script>

</head>

<body>

<div id="centeredDiv">

<%@ include file="adminheader.jsp"%>


<h2 style="color:#0000CC;margin-bottom:40px;">Welcome to the WISE Administrator Page</h2>


<div class="adminTitle">User Management</div>
	<div style="margin:0 0 0 25px;"> 
		<h5>List: <a href="manageusers.html?userType=teacher">All Teachers</a> | 
				  <a href="manageusers.html?userType=student">All Students</a> 
				   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
				   |
				  <a href="manageusers.html?onlyShowLoggedInUser=true">All Currently-Logged In Users</a> |
				  <a href="manageusers.html?onlyShowUsersWhoLoggedInToday=true">All Users Who Logged in Today</a>
		   	 	  </sec:authorize>
				  
		</h5>
		<h5>Find: <a href="lookupteacher.html">Teacher</a> | <a href="lookupstudent.html">Student</a></h5>
		<!-- <h5><a href="lookupuser.html">Look up User</a></h5>-->
	</div>
	
<div class="adminTitle">Project Run Management</div>
	<div style="margin:0 0 0 25px;">
		<h5>List Runs run (<a href="runstats.html?command=today">today</a> | <a href="runstats.html?command=week">this week</a> | <a href="runstats.html?command=month">this month</a>) | <a href="runstats.html?command=activity">runs by activity</a></h5>
	
		<h5>Manage Project Runs: <a href="manageallprojectruns.html?q=current">Current</a> | 
								 <a href="manageallprojectruns.html?q=archived">Archived</a>
								 </h5>
		<h5>Find Project Runs by 
			<a href="findprojectrunsbyteacher.html">Teacher</a> | <a href='findprojectrunsbyprojectid.html'>Project Id</a> | <a href='findprojectrunsbyrunid.html'>Run Id</a>
		</h5>
	</div>


	   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">

<div class="adminTitle">Project Management</div>
	<div style="margin:0 0 0 25px;">
		<h5><a href="manageallprojects.html">Manage All Projects</a></h5>
		<h5><a href="project/uploadproject.html">Import A Project</a></h5>
	</div>


	 	</sec:authorize>


<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
<div class="adminTitle">News Management</div>
	<div style="margin:0 0 0 25px;">
		<h5><a href="managenewsitems.html">Work with News Items</a></h5>
	</div>

<div class="adminTitle">Portal Management</div>
	<div style="margin:0 0 0 25px;">
		<h5><a href="portal/manageportal.html">Configure Portal Settings</a></h5>
	</div>

<div class="adminTitle">External Project Service (Beta)</div>
	<div style="margin:0 0 0 25px;">
		<h5><a href="project/viewprojectcommunicators.html">Manage All External ProjectCommunicators (connect to other portals)</a></h5>	   
		<h5><a href="project/getallexternalprojects.html">Get all External Projects (connect to other portals)</a></h5>
	</div>
</div>

</sec:authorize>
	
</body>
</html>