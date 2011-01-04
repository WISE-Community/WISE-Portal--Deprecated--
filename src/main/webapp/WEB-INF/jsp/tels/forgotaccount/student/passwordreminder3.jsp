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

<title>Password Reminder Step 3</title>
</head>

<body>

<div id="centeredDiv">
    	
<%@ include file="headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h1 id="lostTitleBar" class="blueText"><spring:message code="forgot.student.passremind.2"/></h1>


<div id="studentpasswordremindersuggestion"> 
	<ul>
		<li class="forgotPasswordInstructionText reminder_highlight"><spring:message code="forgot.student.passremind.9"/></li>
		<li class="forgotPasswordInstructionText"><spring:message code="forgot.student.passremind.10"/></li>
		<li class="forgotPasswordInstructionText2"><spring:message code="forgot.student.passremind.11"/></li>
	</ul>
	
	<form id="submittedAccountPasswords" method="post" commandName="reminderParameters" autocomplete='off'>
		<table id="submittedAccountPasswordTable">
		<tr>
			<td><label id="passwordform" for="send_passwords"><spring:message code="lostpassword.student.new-password" /></label></td>
			<td><input type="password" name="newPassword" id="newPassword" size="25" tabindex="1" /></td>
				<!-- 			Special script pulls focus onto immediately preceding Input field-->
 				<script type="text/javascript">document.getElementById('newPassword').focus();
				</script>
			</tr>
		<tr>
			<td><label id="passwordform2" for="answer"><spring:message code="lostpassword.student.verify-password" /></label></td>
			<td><input id="verifyPassword" name="verifyPassword" type="password" size="25" tabindex="2" /></td>
		</tr>
		<tr>
			<td></td>
			<td>		
				<div id="finalPasswordReminderButtons">
				<input type="submit" name="_finish" value="SUBMIT" /> 
				</div>
			</td>
		</tr>
		</table>		
	</form>

</div>

<div id="errorMessageFormat">
		<!-- Support for Spring errors object -->
		<spring:bind path="reminderParameters.*">
		  <c:forEach var="error" items="${status.errorMessages}">
		    <b>
		      <br /><c:out value="${error}"/>
		    </b>
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
