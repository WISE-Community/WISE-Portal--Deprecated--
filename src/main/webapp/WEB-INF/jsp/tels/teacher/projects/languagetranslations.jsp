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

<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="teacher.pro.translations.0"/>Language Translations</title>

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

<div id="navigationSubHeader2">Language Translations<span id="navigationSubHeader1">projects</span></div> 

<div id="overviewContent"> 

<div id="translations">
<h1><spring:message code="teacher.pro.translations.1"/></h1>

<p><spring:message code="teacher.pro.translations.2"/></p>

<p><b><spring:message code="teacher.pro.translations.3"/></b>&nbsp;<spring:message code="teacher.pro.translations.4"/></p>

<p><b><spring:message code="teacher.pro.translations.5"/></b>&nbsp;<spring:message code="teacher.pro.translations.6"/></p>

<p><b><spring:message code="teacher.pro.translations.7"/></b> <spring:message code="teacher.pro.translations.8"/></p>

<p><spring:message code="teacher.pro.translations.9"/></p>

<p align="center"><a href="/webapp/contactwisegeneral.html"><spring:message code="teacher.pro.translations.11"/></a></p>
</div>      <!--end of Translations div-->
</div>    <!--end of CenteredDiv div-->

</body>
</html>

