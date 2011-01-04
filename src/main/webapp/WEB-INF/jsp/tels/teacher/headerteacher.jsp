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

<!-- $Id: header.jsp 368 2007-05-05 01:41:18Z archana $ -->

<div id="bannerArea2">

	<div id="betaTag"><img src="/webapp/themes/tels/default/images/WISE-Logo-betatag.png" alt="Beta graphic" border="0" /></div>

    <div id="wiseLogo"><a href="/webapp/index.html" 
    	onmouseout="MM_swapImgRestore()" 
    	onmouseover="MM_swapImage('WISE Medium Logo','','/webapp/themes/tels/default/images/WISE-Logo-Medium-Roll-1.png',1)">
    	<img src="/webapp/themes/tels/default/images/WISE-Logo-Medium-1.png" alt="WISE Logo" border="0" id="WISE Medium Logo" /></a>
    </div>
    
    <div style="display:none;" id="teacherBannerLabel"><a href="#" 
    	onmouseout="MM_swapImgRestore()" 
    	onmouseover="MM_swapImage('Teacher Dashboard Label','','/webapp/themes/tels/default/images/Teacher-Dashboard-Label.png',1)">
    	<img src="/webapp/themes/tels/default/images/Teacher-Dashboard-Label.png" alt="Teacher Dashboard Label" width="169" height="11" border="0" id="Teacher Dashboard Label" /></a>
   </div>

    <div id="teacherInterfaceHeader">teacher dashboard</div>
	
<div id="menuContainer">

<ul class="sf-menu">
			
			<li class="current level1">
					<a href="/webapp/teacher/index.html" >Home</a>
			</li>

		<li class="level1"><a href="#">Projects</a>
		<ul>
				<li><a href="/webapp/teacher/projects/customized/index.html">View My Projects<br/><span style="font-size:90%;">(Custom, Shared, & Bookmarked)</span></a></li>
				<li><a href="/webapp/author/authorproject.html">Launch Authoring Tool</a></li>
				<li><a href="/webapp/teacher/projects/telsprojectlibrary.html">Browse TELS Projects</a></li>
				<!--  
				<li><a href="" style="color:#999;">Browse VISUAL Projects</a></li>
				-->
				<!--  
				<li><a href="/webapp/teacher/projects/projectlibrary.html">Search the Project Library</a></li>
				-->
				<li><a href="/webapp/teacher/projects/index.html">Overview</a></li>
		</ul>
		</li>

		<li class="level1"><a href="#">Management</a>
	    <ul>
            <li><a href="/webapp/teacher/run/myprojectruns.html">My Project Runs & Access Codes</a></li>
			<li><a href="/webapp/teacher/management/projectPickerManagement.html">Manage Students</a></li>
            <!--  
            <li><a href="/webapp/message.html?action=index">View & Send Messages</a></li>
			<li><a href="" style="color:#999;">View Student RealTime Progress Monitor</a></li>
            <li><a href="" style="color:#999;">Print/Export Student Work</a></li>
            <li><a href="" style="color:#999;">Manage Extra Teachers</a></li>
            -->
            <li><a href="/webapp/teacher/management/updatemyaccount.html">Update My Account</a></li>
            <li><a href="/webapp/teacher/management/overview.html">Overview</a></li>
        </ul>
		</li>

		<li class="level1"><a href="#">Help</a> 
		<ul>	
			<li><a href="/webapp/pages/gettingstarted.html" target="_blank">Quickstart Guide for Teachers</a></li>
			<li><a href="/webapp/pages/teacherfaq.html" target="_blank">Frequently Asked Questions</a></li>
			<!--  
            <li><a href="#" style="color:#999;">Search the Help Guide</a></li>
            -->
            <li><a href="/webapp/contactwisegeneral.html">Contact WISE Staff</a></li>
            <li><a href="/webapp/teacher/help/overview.html">Overview</a></li>
		</ul>
		</li>
		</ul>

</div>

	<div id="usernameSignOutBoxTeacher">
		<div id="usernameBannerTeacher"><sec:authentication property="principal.username" /> </div>
		<div id="signOutBannerTeacher">
		  <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
	   	    <span id="signOutBannerHome"><a href="/webapp/admin/index.html"><spring:message code="header.admin"/></a></span>
	 	  </sec:authorize>
 	      <sec:authorize ifAllGranted="ROLE_RESEARCHER">
	   	    <span id="signOutBannerHome"><a href="/webapp/admin/index.html"><spring:message code="header.researcher"/></a></span>
	 	  </sec:authorize>
		  <a href="<c:url value="/j_spring_security_logout"/>"><spring:message code="log.out"/></a>
		</div> 
	</div>

 
</div> <!-- End of bannerArea   Note that NavigationMainProjects and usernameSignoutBox are position ABSOLUTE to bannerArea (which is set Relative) -->

    

