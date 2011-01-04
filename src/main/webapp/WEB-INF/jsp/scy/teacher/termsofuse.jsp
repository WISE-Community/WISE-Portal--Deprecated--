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
 
<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="registerstylesheet" />" media="screen" rel="stylesheet"  type="text/css" />
  
  
<script src="../javascript/general.js"				type="text/javascript" ></script> 
<script src="./javascript/tels/effects.js" 			type="text/javascript"> </script>
<script src="./javascript/tels/prototype.js" 		type="text/javascript"> </script>
<script src="./javascript/tels/scriptaculous.js" 	type="text/javascript"> </script>

<script language="Javascript" type="text/javascript">

	agreeCheckbox = window.opener.document.forms[0].agree;
	function yay() {
	      agreeCheckbox.checked = true;
	      window.close();
	}
	function nay() {
	    agreeCheckbox.checked = false;
	    window.close();
	}
</script>

<title><spring:message code="teacher.termsofuse.1"/></title>
</head>

<body onload="MM_preloadImages('../images/teacher/Close-Window-Roll.png')">

<div>
  <h1 class="center"><spring:message code="teacher.termsofuse.2"/></h1>
</div>

<h5 class="center" id=""><spring:message code="teacher.termsofuse.3"/></h5>

<div id="useAgreement">

    <p><strong><spring:message code="teacher.termsofuse.4"/></strong></p>
      <p><spring:message code="teacher.termsofuse.5"/></p>
      <p><spring:message code="teacher.termsofuse.6"/></p> 
      <p><spring:message code="teacher.termsofuse.7"/></p>
      <p><spring:message code="teacher.termsofuse.8"/></p>
      <p><spring:message code="teacher.termsofuse.9"/></p>
      <p><spring:message code="teacher.termsofuse.10A"/>&nbsp;(<a href="./contactwisegeneral.html"><spring:message code="teacher.termsofuse.10B"/></a>)&nbsp;<spring:message code="teacher.termsofuse.10C"/></p>
      <p><spring:message code="teacher.termsofuse.11"/></p>      
      <p><spring:message code="teacher.termsofuse.12"/></p>
      <p><spring:message code="teacher.termsofuse.13"/></p>
      <p><spring:message code="teacher.termsofuse.14"/> &nbsp;<a href="mailto:mclinn@berkeley.edu">email</a> </p>
      <p><spring:message code="teacher.termsofuse.15"/> &nbsp;<a href="mailto:kbenemann@berkeley.edu">email</a> </p>
      
</div>

<div class="center" >
 		 <a href="#" onclick="self.close();return false;">
 		 <img src="../themes/tels/default/images/teacher/Close-Window.png" alt="Close Terms of Use" class="imgNoBorder" />
 		 </a> 
 </div> 
    


</body>
</html>




