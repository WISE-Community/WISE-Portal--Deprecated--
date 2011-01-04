<%@ include file="include.jsp"%>

<!-- $Id: header.jsp 368 2007-05-05 01:41:18Z mattfish $ -->

<div id="bannerArea1">

	<div id="betaTag"><img src="themes/tels/default/images/WISE-Logo-betatag.png" alt="WISE4 Beta graphic" border="0" /></div>

    <a href="index.html" onmouseout="MM_swapImgRestore()"
	      onmouseover="MM_swapImage('wise-logo','','themes/tels/default/images/WISE-Logo-Large-v4.png',1)">
       <img src="themes/tels/default/images/WISE-Logo-Large-v4.png" alt="WISE Large Logo" border="0" id="wise-logo" />
     </a>

   <div id="usernameSignOutBoxHome">
     <sec:authorize ifAllGranted="ROLE_USER">
	   <div id="usernameBannerHome"><sec:authentication property="principal.username" /></div>
	   <div class="signOutBannerHome"><a id="styleOverRideSafari1" href="<c:url value="/j_spring_security_logout"/>"><spring:message code="log.out"/></a></div>
	   <sec:authorize ifAllGranted="ROLE_STUDENT">
	   	   <div class="signOutBannerHome"><a href="student/index.html"><spring:message code="header.student"/></a></div>
	   </sec:authorize>
	   <sec:authorize ifAllGranted="ROLE_TEACHER">
	   	   <span class="signOutBannerHome"><a href="teacher/index.html"><spring:message code="header.teacher"/></a></span>
	   </sec:authorize>
	   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
	   	  <span class="signOutBannerHome"><a href="admin/index.html"><spring:message code="header.admin"/></a></span>
	 	</sec:authorize>
	   <sec:authorize ifAllGranted="ROLE_RESEARCHER">
	   	  <span class="signOutBannerHome"><a href="admin/index.html"><spring:message code="header.researcher"/></a></span>
	 	</sec:authorize>
     </sec:authorize>
  </div>
</div>