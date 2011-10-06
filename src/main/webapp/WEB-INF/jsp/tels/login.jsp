
<%@ include file="include.jsp"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>

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

<!-- $Id$ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta name="description" content="login for portal"/>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />

<style type="text/css" media="screen">
  .inplaceeditor-saving {background: url(<spring:theme code="wait"/>) bottom right no-repeat; }
</style>

<link rel="shortcut icon" href="<spring:theme code="favicon"/>" />

<title>Sign In to WISE4</title>

</head>

<body onload="document.getElementById('j_username').focus();">

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			
			<div id="boxTableSignInFailedLogin" class="loginPanel">
				<a id="name" href="/webapp/" title="WISE Homepage">WISE</a>
				<div style="padding:134px 60px 0;">
					<form id="home" method="post" action="j_acegi_security_check" autocomplete="off">
						<div id="signinForm">
							<div>
								<label for="username"><spring:message code="login.failed11"/><input class="dataBoxStyle" type="text" name="j_username" id="j_username" size="18" maxlength="60" <c:if test="${userName != ''}">value="${userName}"</c:if> /></label>
							</div>
							<div>
								<label for="password"><spring:message code="login.failed12"/><input class="dataBoxStyle" type="password" name="j_password" id="j_password" size="18" maxlength="30" /></label>
							</div>
							<c:if test="${requireCaptcha && reCaptchaPublicKey != null && reCaptchaPrivateKey != null}">
								<%
									//get the captcha public and private key so we can make the captcha
									String reCaptchaPublicKey = (String) request.getAttribute("reCaptchaPublicKey");
									String reCaptchaPrivateKey = (String) request.getAttribute("reCaptchaPrivateKey");
									
									//create the captcha factory
									ReCaptcha c = ReCaptchaFactory.newReCaptcha(reCaptchaPublicKey, reCaptchaPrivateKey, false);
									
									//make the html that will display the captcha
									String reCaptchaHtml = c.createRecaptchaHtml(null, null);
									
									//output the instructions for the captcha
									out.print("<p>Enter the correct password above and then type the characters in the image below.</p>");
									
									//output the captcha html to the page
									out.print(reCaptchaHtml);
								%>
							</c:if>
				        
							<input type='hidden' value='${redirect}' name='redirect'/>
						</div>
						<div class="alignRight" style="float: right; margin: 16px 10px;">
							<input type="submit" id="signInButton" name="signInButton" class="wisebutton smallbutton" value="<spring:message code="signinbutton"/>"></input>
						</div>
						<div style="clear:both;"></div>
					</form>
			    	<div id="forgotLogin">   
				        <ul id="signInLinkPosition"> <!-- TODO: make these open in top window -->
				       		<li><a href="forgotaccount/selectaccounttype.html" class="forgotlink"><spring:message code="login.failed13"/></a>  </li>
				       		<li><a href="signup.html" class="joinlink"><spring:message code="login.failed14"/></a></li>
				       		<li><a href="/webapp/index.html" class="joinlink"><spring:message code="login.failed15"/></a></li>
				        </ul>
			 		</div>
			 	</div>               
			</div>   <!--    End of boxTableSignIn  x-->     
 
			<div class="errorMsg">
				<c:if test="${failed}">
				  <p><spring:message code="login.failed" /></p>
				</c:if>
			</div>          
		
		</div>

	</div>
</div>

</body>
</html>
