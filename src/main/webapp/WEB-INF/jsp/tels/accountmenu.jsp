<script type="text/javascript" src="<spring:theme code="superfishsource"/>"></script>
<link rel="stylesheet" type="text/css" href="<spring:theme code="superfishstylesheet"/>" media="screen">

<script type="text/javascript">
	// initialise menu
	$(function(){
		$('ul.sf-menu').superfish({ });
	});
</script>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sec:authorize ifNotGranted="ROLE_USER">
	<div id="userInfoBlock">
		<form id="home" method="post" action="j_acegi_security_check" autocomplete="off">
			<div id="signinForm">
				<div>
					<label for="username"><spring:message code="username" /></label><input class="dataBoxStyle" type="text" name="j_username" id="j_username" size="18" maxlength="60" />
				</div>
				<div>
					<label for="password"><spring:message code="password" /></label><input class="dataBoxStyle" type="password" name="j_password" id="j_password" size="18" maxlength="30" />
				</div>
			</div>
			<div id="submitSignIn">
				<input type="submit" id="signInButton" name="signInButton" class="wisebutton smallbutton" value="<spring:message code="signinbutton"/>"></input>
				<div id="forgotLogin"><a href="forgotaccount/selectaccounttype.html"><spring:message code="forgotaccountinfo" /></a></div>
			</div>
		</form>
	</div>
	
	<div id="accountMenu" class="guest">
		<ul class="welcome-menu">
			<li><spring:message code="header.welcome"/> <spring:message code="header.signup1"/> <spring:message code="header.signup2"/> <spring:message code="header.signup3"/></li>
		</ul>
		<a href="signup.html" class="wisebutton signup" title="<spring:message code="createaccounttitle"/>"><spring:message code="createaccountlink"/></a>
	</div>
</sec:authorize>

<sec:authorize ifAllGranted="ROLE_USER">
	<div id="userInfoBlock" class="userInfo">
		<a id="signOut" class="wisebutton minibutton" href="<c:url value="/j_spring_security_logout"/>" title="<spring:message code="log.out"/>"><spring:message code="log.out"/></a>
		<div id="userName">
			<span>Welcome, <sec:authentication property="principal.firstname" /> <sec:authentication property="principal.lastname" />!</span>
		</div>
		<div>
			<spring:message code="teacher.index.4" />
			<c:choose>
				<c:when test="${user.userDetails.lastLoginTime == null}">
					<spring:message code="teacher.index.5" />
				</c:when>
				<c:otherwise>
					<fmt:formatDate value="${user.userDetails.lastLoginTime}" type="both" dateStyle="medium" timeStyle="short" />
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<a href="/webapp/teacher/management/updatemyaccount.html"><spring:message code="teacher.index.44" /></a>
			<a href="/webapp/message.html?action=index" ><spring:message code="menu.messages"/> (<c:out value="${fn:length(unreadMessages)}" />)</a>
		</div>
		<sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
			<a id="adminTools" class="wisebutton smallbutton-wide" href="/webapp/admin/index.html" ><spring:message code="menu.admin"/></a>
		</sec:authorize>
		<sec:authorize ifAllGranted="ROLE_RESEARCHER">
			<a id="researchTools" class="wisebutton smallbutton-wide" href="/webapp/researcher/index.html" ><spring:message code="menu.researcher"/></a>
		</sec:authorize>
	</div>
	
	<div id="accountMenu">
		<ul class="sf-menu">
			<sec:authorize ifNotGranted="ROLE_STUDENT">
				<!-- <li class="level1"><a href="/webapp/teacher/projects/index.html"><spring:message code="menu.projects"/></a>
					<ul>
						<li><a href="/webapp/teacher/projects/customized/index.html"><spring:message code="menu.myprojects"/><br/><span style="font-size:90%;"><spring:message code="menu.myprojects.sub"/></span></a></li>
						<li><a href="/webapp/teacher/projects/library/tels.html"><spring:message code="menu.library"/></a></li>
						<li><a href="/webapp/author/authorproject.html"><spring:message code="menu.authoring"/></a></li>
					</ul>
				</li>  -->
				<li class="level1 menu1"><a href="/webapp/teacher/help/overview.html"><spring:message code="menu.help"/></a> 
					<ul>	
						<li><a href="/webapp/pages/gettingstarted.html" target="_blank"><spring:message code="menu.quickstart"/></a></li>
						<li><a href="/webapp/pages/teacherfaq.html" target="_blank"><spring:message code="menu.faq"/></a></li>
						<!--  
			            <li><a href="#" style="color:#999;">Search the Help Guide</a></li>
			            -->
			            <li><a href="/webapp/contactwisegeneral.html"><spring:message code="menu.contact"/></a></li>
					</ul>
				</li>
				
				<li class="level1 menu2"><a href="/webapp/teacher/management/overview.html"><spring:message code="menu.management"/></a>
				    <ul>
			            <li><a href="#"><spring:message code="menu.setuprun"/></a></li>
			            <li><a href="/webapp/teacher/management/classroomruns.html"><spring:message code="menu.runs"/></a></li>
			            <li><a href="/webapp/teacher/management/library.html"><spring:message code="menu.library"/></a></li>
			            <li><a href="/webapp/teacher/management/projectPickerManagement.html"><spring:message code="menu.managestudents"/></a></li>
						<li><a href="/webapp/author/authorproject.html"><spring:message code="menu.authoring"/></a></li>
			        </ul>
					</li>
			
				<sec:authorize ifAllGranted="ROLE_STUDENT">
					<li class="level1 menu3"><a href="/webapp/student/index.html" ><spring:message code="menu.student"/></a></li>
				</sec:authorize>
				<sec:authorize ifAllGranted="ROLE_TEACHER">
					<li class="level1 menu3"><a href="/webapp/teacher/index.html" ><spring:message code="menu.teacher"/></a></li>
				</sec:authorize>
				
			</sec:authorize>
			<!-- <li class="level1 align-right usernameBanner <sec:authorize ifAllGranted="ROLE_STUDENT">student</sec:authorize>"><a><sec:authentication property="principal.username" /></a>
				<sec:authorize ifNotGranted="ROLE_STUDENT">
				<ul>
					<li><a href="/webapp/teacher/management/updatemyaccount.html" ><spring:message code="menu.myaccount"/></a></li>
					<li><a href="/webapp/message.html?action=index" ><spring:message code="menu.messages"/></a></li>
				</ul>
				</sec:authorize>
			</li>  
			
			<li class="level1 signOutBanner"><a href="<c:url value="/j_spring_security_logout"/>"><spring:message code="log.out"/></a></li> -->
   	</ul>
   </div>
</sec:authorize>