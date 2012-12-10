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
				<div class="panelHeader"><spring:message code='admin.index.title'/></div>
				<div class="panelContent">

					<div class="sectionHead" style="padding-top:0;"><spring:message code='admin.index.usermanagement'/></div>
					<div class="sectionContent"> 
						<h5><spring:message code='admin.index.usermanagement.list'/>: <a href="account/manageusers.html?userType=teacher"><spring:message code='admin.index.usermanagement.allteachers'/></a> | 
								  <a href="account/manageusers.html?userType=student"><spring:message code='admin.index.usermanagement.allstudents'/></a> 
								   <sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR">
								   |
								  <a href="account/manageusers.html?onlyShowLoggedInUser=true"><spring:message code='admin.index.usermanagement.allcurrentlyloggedinusers'/></a> |
								  <a href="account/manageusers.html?onlyShowUsersWhoLoggedInToday=true"><spring:message code='admin.index.usermanagement.alluserswhologgedintoday'/></a>
						   	 	  </sec:authorize>
								  
						</h5>
						<h5><spring:message code='admin.index.usermanagement.find'/>: <a href="account/lookupteacher.html"><spring:message code='admin.index.usermanagement.teacher'/></a> | <a href="account/lookupstudent.html"><spring:message code='admin.index.usermanagement.student'/></a></h5>
						<h5><a href="account/enabledisableuser.html"><spring:message code='admin.index.usermanagement.enabledisableuser'/></a></h5>
					</div>
						
					<div class="sectionHead"><spring:message code='admin.index.projectrunmanagement'/></div>
					<div class="sectionContent">
						<h5><spring:message code='admin.index.projectrunmanagement.listrunsrun'/> (<a href="run/runstats.html?command=today"><spring:message code='admin.index.projectrunmanagement.today'/></a> | <a href="run/runstats.html?command=week"><spring:message code='admin.index.projectrunmanagement.thisweek'/></a> | <a href="run/runstats.html?command=month"><spring:message code='admin.index.projectrunmanagement.thismonth'/></a>) | <a href="run/runstats.html?command=activity"><spring:message code='admin.index.projectrunmanagement.runsbyactivity'/></a></h5>
					
						<h5><spring:message code='admin.index.projectrunmanagement.manageprojectruns'/>: <a href="run/manageallprojectruns.html?q=current"><spring:message code='admin.index.projectrunmanagement.current'/></a> | 
												 <a href="run/manageallprojectruns.html?q=archived"><spring:message code='admin.index.projectrunmanagement.archived'/></a>
												 </h5>
						<h5><spring:message code='admin.index.projectrunmanagement.findprojectrunsby'/> 
							<a href="run/findprojectrunsbyteacher.html"><spring:message code='admin.index.usermanagement.teacher'/></a> | <a href='run/findprojectrunsbyprojectid.html'><spring:message code='admin.index.projectrunmanagement.projectid'/></a> | <a href='run/findprojectrunsbyrunid.html'><spring:message code='admin.index.projectrunmanagement.runid'/></a>
						</h5>
					</div>
					
					
					<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR">
						<div class="sectionHead"><spring:message code='admin.index.projectmanagement'/></div>
						<div class="sectionContent">
							    <spring:message code='admin.index.projectmanagement.byprojectid'/>: <form action="project/manageallprojects.html" method="GET" style="display:inline"><input type="text" name="projectId" size="5"></input><input type="Submit" value="Go"></input></form><br/>
							<h5><a href="project/manageallprojects.html"><spring:message code='admin.index.projectmanagement.allprojects'/></a></h5>
							<h5><a href="project/uploadproject.html"><spring:message code='admin.index.projectmanagement.importproject'/></a></h5>
							<h5><a href="project/currentlyAuthoredProjects.html"><spring:message code='admin.index.projectmanagement.viewcurrentauthors'/></a></h5>
						</div>
					</sec:authorize>
					
					<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR">
						<div class="sectionHead"><spring:message code='admin.index.newsmanagement'/></div>
						<div class="sectionContent">
							<h5><a href="news/managenewsitems.html"><spring:message code='admin.index.newsmanagement.workwithnewsitems'/></a></h5>
						</div>
					
						<div class="sectionHead"><spring:message code='admin.index.portalmanagement'/></div>
						<div class="sectionContent">
							<h5><a href="portal/manageportal.html"><spring:message code='admin.index.portalmanagement.configure'/></a></h5>
						</div>
						
						<!--  
						<div class="sectionHead">External Project Service (Beta)</div>
						<div class="sectionContent">
							<h5><a href="project/viewprojectcommunicators.html">Manage All External ProjectCommunicators (connect to other portals)</a></h5>	   
							<h5><a href="project/getallexternalprojects.html">Get all External Projects (connect to other portals)</a></h5>
						</div>
						-->
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