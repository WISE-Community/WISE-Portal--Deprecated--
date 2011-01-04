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

<!-- $Id: setupRun3.jsp 357 2007-05-03 00:49:48Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
	
<script src="./javascript/tels/general.js" type="text/javascript"></script>
<script src="./javascript/tels/prototype.js" type="text/javascript"></script>
<script src="./javascript/tels/scriptaculous.js" type="text/javascript"></script>
<script src="./javascript/tels/AC_ActiveX.js" type="text/javascript"></script>
<script src="./javascript/tels/AC_RunActiveContent.js"
	type="text/javascript"></script>

<title><spring:message code="wise.overview" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain_nousername.jsp"%>

<p class="alignCenter"><object width="700" height="500"> <embed
		src="./flash/tels/WISE_Slideshow.swf" width="700" height="500" /> </object></p>
		
<div id="overviewMessage" class="alignCenter"><spring:message code="wise.cannot-see-movie" />
	<a href="http://www.macromedia.com/go/getflashplayer"> <spring:message
	code="wise.install-flash" /></a>
</div>
 
<div class="alignCenter"><a href="index.html"> <img id="return"
	src="<spring:theme code="return_to_homepage" />"
	onmouseover="swapImage('return', '<spring:theme code="return_to_homepage_roll" />');"
	onmouseout="swapImage('return', '<spring:theme code="return_to_homepage" />');" />
</a></div>

</div>  <!-- end of #centered div--> 

</body>
</html>