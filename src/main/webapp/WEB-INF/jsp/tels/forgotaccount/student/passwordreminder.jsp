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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="studentforgotstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />    
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
   
<script type="text/javascript" src="../../javascript/tels/general.js"></script>	
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>	

<title><spring:message code="forgot.student.passremind.1"/></title>
</head>

<body>

<div id="centeredDiv">
    	
<%@ include file="headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h1 id="lostTitleBar" class="blueText"><spring:message code="forgot.student.passremind.2"/></h1>

<div id="studentpasswordremindersuggestion">
	<table style="border-collapse:separate;border-spacing:10px">
		<tr><td><div class="forgotPasswordInstructionText"><spring:message code="forgot.student.passremind.4"/></div></td></tr>
		<tr><td><div class="forgotPasswordInstructionText reminderHighlight"><spring:message code="forgot.student.passremind.5"/></div></td></tr>
		<tr><td>
				<div class="forgotPasswordInstructionText2">
					<form:form id="username" name="retrievepassword" method="post" commandName="reminderParameters" autocomplete='off'>
						<label style="font-weight:bold;" for="send_username"><spring:message code="login.username" /></label>
			  			<input class="dataBoxStyle" type="text" name="username" id="userName" size="20" tabindex="1" />
			 			
						<!-- 			Special script pulls focus onto immediately preceding Input field-->
			 			<script type="text/javascript">document.getElementById('userName').focus();
						</script> 
			
						<input style="margin-left:20px; text-align:center;width:55px;" type="submit" id="next" name="_target1" value="<spring:message code="navigate.next" />" />
					</form:form>
				</div>
			</td>
		</tr>
	</table>
	<div id="forgotUsernameReminder"><spring:message code="forgot.student.passremind.15"/></div>
	<br/>
	<a id="forgotUsernameLink" href="searchforstudentusername.html"><spring:message code="forgot.student.passremind.16"/></a>
</div>

<div id="errorMessageFormat">
<!-- Support for Spring errors object -->
<spring:bind path="reminderParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <br /><c:out value="${error}"/>
  </c:forEach>
</spring:bind>
</div>

<a href="../../index.html"> 
		<img id="return" src="../../<spring:theme code="return_to_homepage" />"
		onmouseover="swapImage('return', '../../<spring:theme code="return_to_homepage_roll" />');"
		onmouseout="swapImage('return', '../../<spring:theme code="return_to_homepage" />');" />
</a>

</div>
</div>

</body>
</html>
