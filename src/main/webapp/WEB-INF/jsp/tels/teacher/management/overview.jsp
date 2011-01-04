<%@ include file="../include.jsp" %>

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

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >

<html lang="en">
<head>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
 
<title><spring:message code="teacher.manage.overview.1"/></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../../javascript/tels/iefixes.js"></script>
<![endif]-->

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Overview<span id="navigationSubHeader1">management</span></div>

<div id="overviewContent"> 
	
	<table id="overview_choices" cellspacing="20">
		<tr>
			<td class="link"><a href="../run/myprojectruns.html">My Project Runs / Access Codes</a></td>
			<td class="description">View the Project Runs that you are currently using in your classroom and the student Access Code for each project run.</td></tr>
		<tr>
			<td class="link"><a href="../management/projectPickerManagement.html"><spring:message code="teacher.manage.overview.3"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.4"/></td></tr>
		<tr>
			<!-- href="../management/projectpickerclassmonitor.html"> -->
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.manage.overview.5A"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.5B"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.manage.overview.6A"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.6B"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.manage.overview.9"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.10"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.manage.overview.13"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.14"/></td></tr>
		<tr>
			<td class="link"><a href="updatemyaccount.html"><spring:message code="teacher.manage.overview.15"/></a></td>
			<td class="description"><spring:message code="teacher.manage.overview.16"/></td></tr>
	</table>
	
</div>

<p class="center"><spring:message code="teacher.manage.overview.17"/>&nbsp;<a href="#"><spring:message code="teacher.manage.overview.18"/></a>&nbsp;<spring:message code="teacher.manage.overview.19"/></p>

</div>    <!--End of CenteredDiv-->

</body>
</html>

