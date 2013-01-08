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

<!-- $Id: login.jsp 341 2007-04-26 22:58:44Z hiroki $ -->
<!DOCTYPE HTML>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />    
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="forgotaccount.student.passwordreminder4.passwordReminderStep4"/></title>
</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="<spring:message code="wiseHomepage"/>"><spring:message code="wise"/></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="forgotaccount.student.passwordreminder4.studentLostUsernamePassword"/></div>
				<div class="infoContentBox">
					<div><spring:message code="forgotaccount.student.passwordreminder4.yourUsernameIsStill"/>&nbsp;<span style="font-weight:bold;">${username}.</span></div>
					<div class="errorMsgNoBg"><p><spring:message code="forgotaccount.student.passwordreminder4.yourPasswordHasBeenChanged"/></p></div>
					<div><spring:message code="forgotaccount.student.passwordreminder4.clickOnButtonToSignIn"/></div>
				</div>
				<a href="/webapp/login.html" class="wisebutton" style="margin-top:.25em;"><spring:message code="forgotaccount.student.passwordreminder4.signIn"/></a>
			</div>
		</div>
	</div>
</div>
</body>
</html>
