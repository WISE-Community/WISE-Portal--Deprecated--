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

<title><spring:message code="student.enterprojectcode.1"/></title>

</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="student.enterprojectcode.2"/></div>
				<div class="infoContentBox">
					<div><spring:message code="searchforstudentusername.7"/>:</div>
	  				<div>
	  					<table width="100%" style="border-collapse:separate;border-spacing:10px">
							<tr>
								<td align="right" width="50%"><spring:message code="signup.firstname"/></td>
								<td align="left" width="50%"><input type="text" size=25 value="${firstName}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="signup.lastname"/></td>
								<td align="left" width="50%"><input type="text" size=25 value="${lastName}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="searchforstudentusername.2"/></td>
								<td align="left" width="50%"><input type="text" size=5 value="${birthMonth}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="searchforstudentusername.3"/></td>
								<td align="left" width="50%"><input type="text" size=5 value="${birthDay}" disabled /></td>
							</tr>
						</table>
	  				</div>
	  				<div>
	  					<c:choose>
							<c:when test="${fn:length(users) == 0}">
								<div class="errorMsgNoBg"><p><spring:message code="searchforstudentusername.4"/></p></div>
								<div><a href="searchforstudentusername.html" title="WISE Home"><spring:message code="lostpassword.teacher.try-again"/></a></div>
							</c:when>
							<c:when test="${fn:length(users) == 1}">
								<div class="errorMsgNoBg"><p><spring:message code="searchforstudentusername.5"/></p></div>
							</c:when>
							<c:when test="${fn:length(users) > 1}">
								<div class="errorMsgNoBg"><p><spring:message code="searchforstudentusername.6"/></p></div>
							</c:when>
						</c:choose>
	  				</div>
					<div>
						<c:forEach var="user" items="${users}">
				    		<p><a href="/webapp/login.html?userName=${user.userDetails.username}">${user.userDetails.username}</a></p>
				  		</c:forEach>
					</div>
				</div>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>
