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

<title>Password Reminder Step 2</title>
</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="forgot.student.passremind.2"/></div>
				<div class="infoContentBox">
					<div><spring:message code="forgot.student.passremind.6"/></div>
					<div><spring:message code="forgot.student.passremind.7"/>, ${username}. <spring:message code="forgot.student.passremind.8"/></div>
					<form id="submittedAccountAnswer" method="post" commandName="reminderParameters" autocomplete='off'>
						<div>Question: <spring:message code="accountquestions.${accountQuestion}"/></div>
						<div class="forgotPasswordInstructionText3">
							<label for="send_accountanswer">Answer:</label>
							<input type="text" name="submittedAccountAnswer" id="submittedAnswer"  class="dataBoxStyle"
						  			style="width: 250px;" tabindex="1" />
						  	
				 			<script type="text/javascript">document.getElementById('submittedAnswer').focus();
				 			</script>
						  	
						  	<input style="margin-left:20px; text-align:center;width:55px;" type="submit" name="_target2" value="<spring:message code="navigate.next" />">
						</div>
					</form>

					<div class="errorMsgNoBg">
							<!-- Support for Spring errors object -->
							<spring:bind path="reminderParameters.*">
							  <c:forEach var="error" items="${status.errorMessages}">
							    <p><c:out value="${error}"/></p>
							  </c:forEach>
							</spring:bind>
					</div>
				</div>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>
