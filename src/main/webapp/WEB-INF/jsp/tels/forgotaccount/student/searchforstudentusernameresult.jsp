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

<title><spring:message code="forgotaccount.student.searchforstudentusernameresult.searchForUsernameViaProjectCode"/></title>

</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="<spring:message code="wiseHomepage" />"><spring:message code="wise" /></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="forgotaccount.student.searchforstudentusernameresult.studentLostUsernamePassword"/></div>
				<div class="infoContentBox">
					<div><spring:message code="forgotaccount.student.searchforstudentusernameresult.searchResultsFor"/>:</div>
	  				<div>
	  					<table width="100%" style="border-collapse:separate;border-spacing:10px">
							<tr>
								<td align="right" width="50%"><spring:message code="forgotaccount.student.searchforstudentusernameresult.firstName"/>:</td>
								<td align="left" width="50%"><input type="text" size=25 value="${firstName}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="forgotaccount.student.searchforstudentusernameresult.lastName"/>:</td>
								<td align="left" width="50%"><input type="text" size=25 value="${lastName}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="forgotaccount.student.searchforstudentusernameresult.birthMonth"/>:</td>
								<td align="left" width="50%"><input type="text" size=5 value="${birthMonth}" disabled /></td>
							</tr>
							<tr>
								<td align="right" width="50%"><spring:message code="forgotaccount.student.searchforstudentusernameresult.birthDay"/>:</td>
								<td align="left" width="50%"><input type="text" size=5 value="${birthDay}" disabled /></td>
							</tr>
						</table>
	  				</div>
	  				<div>
	  					<c:choose>
							<c:when test="${fn:length(users) == 0}">
								<div class="errorMsgNoBg"><p><spring:message code="forgotaccount.student.searchforstudentusernameresult.noMatchesFound"/></p></div>
								<div><a href="searchforstudentusername.html" title="<spring:message code="wiseHome" />"><spring:message code="forgotaccount.student.searchforstudentusernameresult.tryAgain"/></a></div>
							</c:when>
							<c:when test="${fn:length(users) == 1}">
								<div class="errorMsgNoBg"><p><spring:message code="forgotaccount.student.searchforstudentusernameresult.foundMatch"/></p></div>
							</c:when>
							<c:when test="${fn:length(users) > 1}">
								<div class="errorMsgNoBg"><p><spring:message code="forgotaccount.student.searchforstudentusernameresult.foundMatches"/></p></div>
							</c:when>
						</c:choose>
	  				</div>
					<div>
						<c:forEach var="user" items="${users}">
				    		<p><a href="/webapp/login.html?userName=${user.userDetails.username}">${user.userDetails.username}</a></p>
				  		</c:forEach>
					</div>
				</div>
				<a href="/webapp/index.html" title="<spring:message code="wiseHome" />"><spring:message code="returnHome"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>
