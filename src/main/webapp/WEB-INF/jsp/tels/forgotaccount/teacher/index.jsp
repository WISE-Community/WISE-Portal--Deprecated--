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

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
			    
<title><spring:message code="forgotaccount.teacher.index.forgotUsernameOrPassword"/></title>
</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="<spring:message code="wiseHomepage" />"><spring:message code="wise" /></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="forgotaccount.teacher.index.lostUsernameOrPassword"/></div>
				<div class="infoContentBox">
	
					<form id="username" method="post" action="index.html" commandName="userDetails" autocomplete='off'>
						<!-- Support for Spring errors object -->
						<div class="errorMsgNoBg">
							<spring:bind path="userDetails.*">
							  <c:forEach var="error" items="${status.errorMessages}">
							      <p><c:out value="${error}"/></p>
							  </c:forEach>
							</spring:bind>
						</div>
						<div>
						 <h4><spring:message code="forgotaccount.teacher.index.rememberUsernameButForgotPassword"/></h4>
						 <div><spring:message code="forgotaccount.teacher.index.enterYourUsername"/><br/><spring:message code="forgotaccount.teacher.index.aLinkToChangePasswordWillBeSentToEmail"/></div>
				 		<div>
					 		<label for="send_username" /><spring:message code="forgotaccount.teacher.index.username" />:
							<input type="text" id="username" name="username" size="30" tabindex="1" />
							<input type="submit" name="sendpassword" id="sendpassword" value="<spring:message code="forgotaccount.teacher.index.changePassword"/>" />
						</div>
						 </div>
					
						<div><spring:message code="forgotaccount.teacher.index.or"/></div>
					
						<h4><spring:message code="forgotaccount.teacher.index.forgotYourUsername"/></h4>
						<div><spring:message code="forgotaccount.teacher.index.enterTheEmailAddressWhenRegistering"/> <br/> <spring:message code="forgotaccount.teacher.index.yourUsernameWillBeSentToEmail"/></div>
						<div>
							<label for="send_usernamepassword" /><spring:message code="forgotaccount.teacher.index.email" />:
							<input type="text" name="emailAddress" id="emailAddress" size="40" tabindex="2" />
							<input type="submit" name="sendemailAndPwd" id="sendEmailAndPwd" value="<spring:message code="forgotaccount.teacher.index.sendUsername"/>" />
						</div>
					
						<div><spring:message code="forgotaccount.teacher.index.ifYoureStillStuck"/><a href="/webapp/contact/contactwisegeneral.html"><spring:message code="forgotaccount.teacher.index.contactWISE"/></a></div>
					
					 </form>
				</div>
				<a href="/webapp/index.html" title="<spring:message code="wiseHome" />"><spring:message code="returnHome"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>



