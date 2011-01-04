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
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
 
<title><spring:message code="teacher.grading.overview.1"/></title>

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

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Overview<span id="navigationSubHeader1">grading</span></div>
 
<div id="overviewContent"> 

	<table id="overview_choices" cellspacing="20">
		<tr>
		    <td class="link"><a href="./projectPickerGrading.html?gradeByType=step"><spring:message code="teacher.grading.overview.3"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.4"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999" href="./projectPickerGrading.html?gradeByType=group"><spring:message code="teacher.grading.overview.5"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.6"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="./projectPickerGrading.html?gradeByType=value"><spring:message code="teacher.grading.overview.7"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.8"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.grading.overview.9"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.10"/></td></tr>
		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.grading.overview.11"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.12"/></td></tr>

		<tr>
			<td class="link"><a style="color:#999999;" href="#"><spring:message code="teacher.grading.overview.13"/></a></td>
			<td class="description"><spring:message code="teacher.grading.overview.14"/></td></tr>
	</table>
	
</div>

</div>
</div>    <!--End of CenteredDiv-->

</body>
</html>

