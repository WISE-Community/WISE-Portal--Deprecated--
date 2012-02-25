<%@ include file="../include.jsp"%>
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

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
			    
<title><spring:message code="forgot.teacher.error.1"/></title>
</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader">Reset Your Password</div>
					<div class="infoContentBox">
						<c:if test="${displayForgotPasswordSelectAccountTypeLink == false && displayLoginLink == false}">
							<div>
								<form id="submittedAccountPasswords" method="post" commandName="reminderParameters" autocomplete='off'>
									<table id="submittedAccountPasswordTable" style="margin:0 auto;">
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
										<td colspan="2">
											<div id="finalPasswordReminderButtons">
											<input type="submit" name="_finish" value="SUBMIT" /> 
											</div>
										</td>
									</tr>
									</table>		
								</form>
							</div>
						</c:if>
					<div class="errorMsgNoBg">
						<!-- Support for Spring errors object -->
						<spring:bind path="reminderParameters.*">
						  <c:forEach var="error" items="${status.errorMessages}">
						    <b>
						      <p><c:out value="${error}"/></p>
						    </b>
						  </c:forEach>
						</spring:bind>
					</div>
					<c:if test="${displayForgotPasswordSelectAccountTypeLink == true}">
						<a id="forgotPasswordSelectAccountTypeLink" href="./selectaccounttype.html" title="">Forgot Username or Password?</a>
						<br>
						<br>
						<br>
						<br>
					</c:if>
					<c:if test="${displayLoginLink == true}">
						<div><spring:message code="error.sign-in" /></div>
						<br>
						<a href="/webapp/login.html" class="wisebutton" style="margin-top:.25em;"><spring:message code="login.submit"/></a>
						<br>
						<br>
						<br>
						<br>
					</c:if>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>



