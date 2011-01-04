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

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="signup.title" /></title>
<script type="text/javascript" src="./javascript/pas/utils.js"></script>
<script type="text/javascript" src="./javascript/tels/rotator.js"></script>
</head>

<body>

<%@ include file="studentHeader.jsp"%>

<div style="position:relative;right:-380px;bottom:5px;">
<h2><spring:message code="student.registration" /></h2>
<h3><spring:message code="login.success" /></h3>
<h4><spring:message code="login.sign-in-message" /></h4>
</div>

<div id="verticalNavigation" style="position:relative;right:100px;bottom:50px">
<ul>
<li><spring:message code="login.username" />
<input name="username" value="${username}"/>
</li>
<li><spring:message code="login.password" />
<input name="password" type="password" value="<sec:authentication	property="principal.password" />" />
</li>
</ul>
</div>

<div id="spacing" style="position:relative;bottom:50px;" class="left">
<ul>
<li > <spring:message code="login.email-info-message" /></li>
<li> <spring:message code="login.remember" /></li>
<li> <spring:message code="login.username-tip" /></li>
</ul>
</div>


</body>
</html>
