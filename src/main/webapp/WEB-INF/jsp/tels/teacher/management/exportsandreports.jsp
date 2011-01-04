<%@ include file="include.jsp"%>
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

<!-- $Id: index.jsp 888 2007-08-06 23:47:19Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachermanagementstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
  
<script type="text/javascript" src="../javascript/general.js"></script> 

<title><spring:message code="teacher.manage.exportreport.1"/></title>

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
<%@ include file="../headerteacher.jsp"%>
<br />

<div id="overviewContent">
<h3><spring:message code="teacher.manage.exportreport.2"/></h3>
<table>
<tr> 
<td><spring:message code="teacher.manage.exportreport.3"/></td>
<td><spring:message code="teacher.manage.exportreport.4"/></td>
</tr>
<tr> 
<td><spring:message code="teacher.manage.exportreport.5"/></td>
<td><spring:message code="teacher.manage.exportreport.6"/></td>
</tr>
<tr> 
<td><spring:message code="teacher.manage.exportreport.7"/></td>
<td><spring:message code="teacher.manage.exportreport.8"/></td>
</tr>
</table>
<h3><spring:message code="teacher.manage.exportreport.9"/></h3>
<table>
<tr>
<td><spring:message code="teacher.manage.exportreport.10"/></td>
<td><spring:message code="teacher.manage.exportreport.11"/></td>
</tr>
<tr>
<td><spring:message code="teacher.manage.exportreport.12"/></td>
<td><spring:message code="teacher.manage.exportreport.13"/></td>
</tr>
<tr>
<td><spring:message code="teacher.manage.exportreport.14"/></td>
<td><spring:message code="teacher.manage.exportreport.15"/></td>
</tr>
</table>

</div>

</body>
</html>
