<%@ include file="include.jsp" %>
<!--
  * Copyright (c) 2006 Encore Research Group, University of Toronto
  * 
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
  * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->

<!-- $Id: header.jsp 368 2007-05-05 01:41:18Z MattFish $ -->

<div id="bannerArea1">

    	<div id="wiseLogo"><a href="../index.html" 
    		onmouseout="MM_swapImgRestore()" 
    		onmouseover="MM_swapImage('WISE Medium Logo','','../themes/tels/default/images/WISE-Logo-Medium-Roll-1.png',1)">
    		<img src="../themes/tels/default/images/WISE-Logo-Medium-1.png" alt="WISE Logo" border="0" id="WISE Medium Logo" /> </a></div>
    		
    	    <div id="teacherInterfaceHeader">student home page</div>

<!---->
<!--		<div id="studentBannerLabel">-->
<!--    		<img src="../themes/tels/default/images/student/Student-Site-Label.png" width="104" height="11"-->
<!--       		alt="Student Dashboard Label" />-->
<!--       	</div>-->
          
       	<div id="usernameSignOutBoxStudent">
			<div id="usernameBannerStudent"><sec:authentication property="principal.username" /> </div>
			<div id="signOutBannerStudent"><a href="<c:url value="/j_spring_security_logout"/>"><spring:message code="log.out"/></a></div> 
		</div>
   
</div>