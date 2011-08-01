<%@ include file="include.jsp"%>

<!-- $Id: header.jsp 368 2007-05-05 01:41:18Z mattfish $ -->

<div id="bannerArea">
  <div>
    <a href="../../index.html" onmouseout="MM_swapImgRestore()"
	      onmouseover="MM_swapImage('WISE Main Logo','','../../themes/tels/default/images/WISE-Logo-Largev2.png',1)">
       <img src="../../themes/tels/default/images/WISE-Logo-Largev2.png" alt="WISE Large Logo" border="0" id="WISE Main Logo" />
     </a>
   </div>

   <div class="accountBox">
     <sec:authorize ifAllGranted="ROLE_USER">
	   <sec:authorize ifAllGranted="ROLE_STUDENT">
	   	   <div class="student"><a href="../../student/index.html"><spring:message code="header.student"/></a></div>
	   </sec:authorize>
	   <sec:authorize ifAllGranted="ROLE_TEACHER">
	   	   <div class="teacher"><a href="../../teacher/index.html"><spring:message code="header.teacher"/></a></div>
	   </sec:authorize>
	   <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
	   	  <div class="admin"><a href="../../admin/index.html"><spring:message code="header.admin"/></a></div>
	 	</sec:authorize>
	 	<sec:authorize ifAllGranted="ROLE_RESEARCHER">
	   	  <div class="admin"><a href="../../admin/index.html"><spring:message code="header.researcher"/></a></div>
	 	</sec:authorize>
	   <div class="usernameBanner"><span><sec:authentication property="principal.username" /></span></div>
	   <div class="signOutBanner"><a class="styleOverRideSafari1" href="<c:url value="/j_spring_security_logout"/>">(<spring:message code="log.out"/>)</a></div>
     </sec:authorize>


  </div>
  
  <br/>
</div>