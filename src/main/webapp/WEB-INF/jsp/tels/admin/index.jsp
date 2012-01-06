<%@ include file="../include.jsp"%>

<!-- $Id: index.jsp 3200 2011-07-26 23:13:40Z geoffreykwan $ -->

<!DOCTYPE HTML>
<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<!-- <script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>  -->
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

    
<title><spring:message code="application.title" /></title>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

	//set unread message count and last login time in session (used in page headers)
	//if(!$.cookie("unreadMessages")){
		//$.cookie("unreadMessages","<c:out value="${fn:length(unreadMessages)}" />");
	//}
	
	//if(!$.cookie("lastLoginTime")){
		<c:choose>
			<c:when test="${userDetails.lastLoginTime == null}">
				var lastLogin = "<spring:message code="teacher.index.5" />";
			</c:when>
			<c:otherwise>
				var lastLogin = "<fmt:formatDate value="${userDetails.lastLoginTime}" type="both" dateStyle="medium" timeStyle="short" />";
			</c:otherwise>
		</c:choose>
		//$.cookie("lastLoginTime",lastLogin);
	//}
</script>

</head>
    
<body>
<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">WISE Administrator Tools</div>
				<div class="panelContent">

					<div class="sectionHead" style="padding-top:0;">User Management</div>
					<div class="sectionContent"> 
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
						
					<div class="sectionHead">Project Run Management</div>
					<div class="sectionContent">
						<h5>List Runs run (<a href="runstats.html?command=today">today</a> | <a href="runstats.html?command=week">this week</a> | <a href="runstats.html?command=month">this month</a>) | <a href="runstats.html?command=activity">runs by activity</a></h5>
					
						<h5>Manage Project Runs: <a href="manageallprojectruns.html?q=current">Current</a> | 
												 <a href="manageallprojectruns.html?q=archived">Archived</a>
												 </h5>
						<h5>Find Project Runs by 
							<a href="findprojectrunsbyteacher.html">Teacher</a> | <a href='findprojectrunsbyprojectid.html'>Project Id</a> | <a href='findprojectrunsbyrunid.html'>Run Id</a>
						</h5>
					</div>
					
					
					<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
						<div class="sectionHead">Project Management</div>
						<div class="sectionContent">
							    Manage Project By Project ID: <form action="manageallprojects.html" method="GET" style="display:inline"><input type="text" name="projectId" size="5"></input><input type="Submit" value="Go"></input></form><br/>
							<h5><a href="manageallprojects.html">Manage All Projects</a></h5>
							<h5><a href="project/uploadproject.html">Import A Project</a></h5>
						</div>
					</sec:authorize>
					
					<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
						<div class="sectionHead">News Management</div>
						<div class="sectionContent">
							<h5><a href="managenewsitems.html">Work with News Items</a></h5>
						</div>
					
						<div class="sectionHead">Portal Management</div>
						<div class="sectionContent">
							<h5><a href="portal/manageportal.html">Configure Portal Settings</a></h5>
						</div>
						
						<div class="sectionHead">External Project Service (Beta)</div>
						<div class="sectionContent">
							<h5><a href="project/viewprojectcommunicators.html">Manage All External ProjectCommunicators (connect to other portals)</a></h5>	   
							<h5><a href="project/getallexternalprojects.html">Get all External Projects (connect to other portals)</a></h5>
						</div>
					</sec:authorize>
				
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->
	
	<%@ include file="../footer.jsp"%>
</div>
	
</body>
</html>