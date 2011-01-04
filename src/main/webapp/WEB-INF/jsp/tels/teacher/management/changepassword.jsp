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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >

<html lang="en">
<head>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
 
<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

<title><spring:message code="teacher.manage.account.1"/></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Update My Account<span id="navigationSubHeader1">management</span></div>

 
<div id="overviewContent"> 

<div id="overviewHeader"><spring:message code="teacher.manage.account.3"/></div>
	
<div id="errorMessageFormat">
	<!-- Support for Spring errors object -->
	<spring:bind path="changeStudentPasswordParameters.*">
  		<c:forEach var="error" items="${status.errorMessages}">
   			 <br /><c:out value="${error}"/>
   		</c:forEach>
	</spring:bind>
</div>

<div id="popUpWindowTeacherPassword">

	<div id="teacherchangepasswordbox">
		<table cellpadding="8" border="1" style="margin:5px;">
			<tr>
			<form:form method="post" action="changestudentpassword.html" commandName="changeStudentPasswordParameters" id="changestudentpassword" autocomplete='off'>
			<td><label for="changestudentpassword"><spring:message code="changepassword.password1" /></label></td>
	      	<td><form:password path="passwd1" id="teacherchangePasswordField"/></td>
			</tr>
			<tr>
			<td><label for="changestudentpassword"><spring:message code="changepassword.password2" /></label></td>
			<td><form:password path="passwd2" id="teacherchangePasswordField"/></td>
			</tr>
		</table>
				
	    <div id="teacherPasswordButtons">
	    
			    <input type="image" id="teachersave" src="../../<spring:theme code="register_save" />" 
			    onmouseover="swapImage('teachersave','../../<spring:theme code="register_save_roll" />')" 
			    onmouseout="swapImage('teachersave','../../<spring:theme code="register_save" />')"/>
			    
			    <a href="updatemyaccount.html" >
			    <input type="image" id="teachercancel" src="../../<spring:theme code="register_cancel" />" 
			    onmouseover="swapImage('teachercancel','../../<spring:theme code="register_cancel_roll" />')" 
			    onmouseout="swapImage('teachercancel','../../<spring:theme code="register_cancel" />')"
			    /> </a>
	    </div>
	
		</form:form>
	 	
 	</div>
 	
</div>	<!--end of popUpWindowTeacherPassword div-->

</div>



</div>    <!--End of CenteredDiv-->

</body>
</html>





















