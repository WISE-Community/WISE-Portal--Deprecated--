<script type="text/javascript" src="<spring:theme code="superfishsource"/>"></script>
<link rel="stylesheet" type="text/css" href="<spring:theme code="superfishstylesheet"/>" media="screen">

<script type="text/javascript">
	// initialise menu
	$(function(){
	    $('ul.sf-menu').superfish({
	    	autoArrows:  false
	    });
	});
</script>

<div id="bannerArea1" class="banner">
	<a href="/webapp/index.html">
       <img src="<spring:theme code="wiselogo"/>" alt="WISE Logo" border="0" id="wise-logo" />
     </a>
	
	<sec:authorize ifAllGranted="ROLE_USER">
		<div id="accountMenu">
			<ul class="sf-menu">
			
				<sec:authorize ifAllGranted="ROLE_STUDENT">
					<!-- <li class="level1"><a href="student/index.html" ><spring:message code="menu.student"/></a></li>  -->
				</sec:authorize>
				<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
					<li class="level1"><a href="admin/index.html" ><spring:message code="menu.admin"/></a></li>
				</sec:authorize>
				<sec:authorize ifAllGranted="ROLE_RESEARCHER">
					<li class="level1"><a href="researcher/index.html" ><spring:message code="menu.researcher"/></a></li>
				</sec:authorize>
				<sec:authorize ifAllGranted="ROLE_TEACHER">
					<li class="level1"><a href="teacher/index.html" ><spring:message code="menu.teacher"/></a></li>
				</sec:authorize>
				<sec:authorize ifNotGranted="ROLE_STUDENT">
					<li class="level1"><a href="/webapp/teacher/projects/index.html"><spring:message code="menu.projects"/></a>
						<ul>
							<li><a href="/webapp/teacher/projects/customized/index.html"><spring:message code="menu.myprojects"/><br/><span style="font-size:90%;"><spring:message code="menu.myprojects.sub"/></span></a></li>
							<li><a href="/webapp/teacher/projects/projectlibrary.html"><spring:message code="menu.library"/></a></li>
							<li><a href="/webapp/author/authorproject.html"><spring:message code="menu.authoring"/></a></li>
							<!-- <li><a href="/webapp/teacher/projects/telsprojectlibrary.html">Browse TELS Projects</a></li>  -->
							<!--  
							<li><a href="" style="color:#999;">Browse VISUAL Projects</a></li>
							-->  
						</ul>
					</li>
					<li class="level1"><a href="/webapp/teacher/management/overview.html"><spring:message code="menu.management"/></a>
					    <ul>
				            <li><a href="/webapp/teacher/run/myprojectruns.html"><spring:message code="menu.runs"/></a></li>
							<li><a href="/webapp/teacher/management/projectPickerManagement.html"><spring:message code="menu.managestudents"/></a></li>
				            <!--  
				            <li><a href="/webapp/message.html?action=index">View & Send Messages</a></li>
							<li><a href="" style="color:#999;">View Student RealTime Progress Monitor</a></li>
				            <li><a href="" style="color:#999;">Print/Export Student Work</a></li>
				            <li><a href="" style="color:#999;">Manage Extra Teachers</a></li>
				            -->
				        </ul>
						</li>
				
						<li class="level1"><a href="/webapp/teacher/help/overview.html"><spring:message code="menu.help"/></a> 
						<ul>	
							<li><a href="/webapp/pages/gettingstarted.html" target="_blank"><spring:message code="menu.quickstart"/></a></li>
							<li><a href="/webapp/pages/teacherfaq.html" target="_blank"><spring:message code="menu.faq"/></a></li>
							<!--  
				            <li><a href="#" style="color:#999;">Search the Help Guide</a></li>
				            -->
				            <li><a href="/webapp/contactwisegeneral.html"><spring:message code="menu.contact"/></a></li>
						</ul>
						</li>
				</sec:authorize>
				<li class="level1 align-right usernameBanner <sec:authorize ifAllGranted="ROLE_STUDENT">student</sec:authorize>"><a><sec:authentication property="principal.username" /></a>
					<sec:authorize ifNotGranted="ROLE_STUDENT">
					<ul>
						<li><a href="/webapp/teacher/management/updatemyaccount.html" ><spring:message code="menu.myaccount"/></a></li>
						<li><a href="/webapp/message.html?action=index" ><spring:message code="menu.messages"/></a></li>
					</ul>
					</sec:authorize>
				</li>
				
				<li class="level1 signOutBanner"><a href="<c:url value="/j_spring_security_logout"/>"><spring:message code="log.out"/></a></li>
     		</ul>
     	</div>
     </sec:authorize>
     <sec:authorize ifNotGranted="ROLE_USER">
	     <div class="welcomeBox welcome">
	   	   <div class="welcome"><span><spring:message code="header.welcome"/></span></div>
	   	   <div class="signup"><spring:message code="header.signup1"/><a href="signup.html"><spring:message code="header.signup2"/></a><spring:message code="header.signup3"/></div>
	 	 </div>
 	</sec:authorize>
 	
 	<div class="locationName"><span><spring:message code="header.location.student"/></span></div>
 		
</div>