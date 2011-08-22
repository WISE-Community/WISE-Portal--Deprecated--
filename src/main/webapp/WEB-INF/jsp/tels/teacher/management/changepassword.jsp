<%@ include file="../include.jsp" %> 

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

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html>

<html lang="en">
<head>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

<title><spring:message code="teacher.manage.account.1"/></title>
</head>

<body>

<div id="pageWrapper">

	<%@ include file="../headerteacher.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
		
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="teacher.manage.account.3"/></div>
				<div class="infoContentBox">
	
					<div class="errorMsgNoBg">
						<!-- Support for Spring errors object -->
						<spring:bind path="changeStudentPasswordParameters.*">
					  		<c:forEach var="error" items="${status.errorMessages}">
					   			 <p><c:out value="${error}"/></p>
					   		</c:forEach>
						</spring:bind>
					</div>
	
					<div>
						<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
						<table style="margin:0 auto;">
							<tr>
							<td><label for="changestudentpassword"><spring:message code="changepassword.password1" /></label></td>
					      	<td><form:password path="passwd1" /></td>
							</tr>
							<tr>
							<td><label for="changestudentpassword"><spring:message code="changepassword.password2" /></label></td>
							<td><form:password path="passwd2" /></td>
							</tr>
						</table>
								
					    <div><input type="submit" value="<spring:message code="wise.save-changes"/>"/></div>
						<div><a href="updatemyaccount.html"><spring:message code="navigate.cancel"/></a></div>
					
						</form:form>
					 	
				 	</div>
 				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->
	
	<%@ include file="../../footer.jsp"%>
</div>
	
</body>
</html>