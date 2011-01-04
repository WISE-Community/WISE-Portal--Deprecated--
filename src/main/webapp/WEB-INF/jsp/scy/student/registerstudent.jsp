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

<!-- $Id: registerstudent.jsp 989 2007-08-30 01:15:54Z MattFish $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<script src=".././javascript/tels/general.js" type="text/javascript" > </script>
<script src=".././javascript/tels/effects.js" type="text/javascript" > </script>
<script src=".././javascript/tels/scriptaculous.js" type="text/javascript" ></script>

<title><spring:message code="student.signup.title" /></title>

</head>

<body>

<div id="centeredDiv">

<%@ include file="../header.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug).  Oh how I hate IE-->

<h1 id="registrationTitle" class="blueText"><spring:message code="student.registerstudent.1"/></h1>

<div id="subtitleStudentReg"><spring:message code="student.registerstudent.2"/> <br/><spring:message code="student.registerstudent.3"/></div>
      
<!-- Support for Spring errors object -->
<div id="regErrorMessages">
<spring:bind path="studentAccountForm.*">
  <c:forEach var="error" items="${status.errorMessages}">
        <br /><c:out value="${error}"/>
    </c:forEach>
</spring:bind>
</div>

<form:form id="studentRegForm" commandName="studentAccountForm" method="post" action="registerstudent.html">
  
  <dl>
  	<dt><label for="studentFirstName"><spring:message code="student.registerstudent.4"/></label></dt>	    
  	  	<dd><form:input path="userDetails.firstname" id="firstname" size="25" maxlength="25" tabindex="1"/>
	    <form:errors path="userDetails.firstname" />
    	<span class="hint"><spring:message code="student.registerstudent.5"/><span class="hint-pointer"></span></span> 
   		</dd>

<!--This unusually placed script gets the cursor into the First Name field immediately on page load  (MattFish)-->
<script type="text/javascript">
document.getElementById('firstname').focus();
</script>

  	<dt><label for="studentLastName">Last Name:</label></dt>
	<dd><form:input path="userDetails.lastname" id="lastname" size="25" maxlength="25" tabindex="2"/>
	    <form:errors path="userDetails.lastname" />
    	<span class="hint"><spring:message code="student.registerstudent.7"/><span class="hint-pointer"></span></span> 
   		</dd>
            
  	<dt><label for="studentGender"><spring:message code="student.registerstudent.8"/></label></dt>
	<dd><form:select path="userDetails.gender" id="gender" tabindex="3">       
          <c:forEach items="${genders}" var="genderchoice">
            <form:option value="${genderchoice}">
            	<spring:message code="genders.${genderchoice}" />
            </form:option>
          </c:forEach>
      	</form:select> 
        <span class="hint"><spring:message code="student.registerstudent.9"/><span class="hint-pointer"></span></span> 
    	</dd>
            
    <dt><label for="studentBirthMonth"><spring:message code="student.registerstudent.10"/></label></dt>
	<dd><form:select path="birthmonth" id="birthmonth" tabindex="4">
		<form:errors path="birthmonth" />
		<c:forEach var="month" begin="1" end="12" step="1">
			<form:option value="${month}">
				<spring:message code="birthmonths.${month}" />
			</form:option>
		</c:forEach>
	    </form:select>
        <span class="hint"><spring:message code="student.registerstudent.11"/><span class="hint-pointer"></span></span> 
    	</dd>
        
	  <dt><label for="studentBirthDate"><spring:message code="student.registerstudent.12"/></label></dt>
	  <dd><form:select path="birthdate" id="birthdate" tabindex="5">
	      <form:errors path="birthdate" />
			 <c:forEach var="date" begin="1" end="31" step="1">
				  <form:option value="${date}">
				  		<spring:message code="birthdates.${date}" />
			  	  </form:option>
		  </c:forEach>
	    </form:select> 	
         </dd>
                   
	  <dt><label for="studentPassword">Type a Password:</label></dt>
	  <dd><form:password path="userDetails.password" id="password" size="25" maxlength="25" tabindex="6"/>
      		<form:errors path="userDetails.password"/> 
      		<span class="hint">Your password can contain from 4 to 18 letters or numbers. Try to create a password that you can remember!<span class="hint-pointer"></span></span> 
            </dd>

	  <dt><label for="studentPasswordRepeat">Type Password Again:</label></dt>
	  <dd><form:password path="repeatedPassword" id="repeatedPassword" size="25" maxlength="25" tabindex="7"/> 
            <form:errors path="repeatedPassword" />      	  
	        <span class="hint">Type your password in again.<span class="hint-pointer"></span></span>
            </dd>
      
	  <dt><label for="reminderQuestion">My Reminder Question:</label></dt>
	  <dd><form:select path="userDetails.accountQuestion" id="accountQuestion" tabindex="8" >  
            <form:errors path="userDetails.accountQuestion" />
        	<c:forEach items="${accountQuestions}" var="questionchoice">
            <form:option value="${questionchoice}">
            	<spring:message code="accountquestions.${questionchoice}"/>
             </form:option>
          </c:forEach>
        </form:select>
        
         <span class="hint">If you forget your password, WISE will ask you this Reminder question as an alternative way to sign in.  
			You can select any question from the list.<span class="hint-pointer"></span></span>
		</dd>

	  <dt><label for="reminderAnswer" id="reminderAnswer">My Reminder Answer:</label></dt>
	  <dd><form:input path="userDetails.accountAnswer" id="accountAnswer" size="25" maxlength="25" tabindex="9"/>
	      <span class="hint">Answer your reminder questions here.<span class="hint-pointer"></span></span>			
          </dd>
      
      <dt><label for="projectCode" id="projectCode1">Access Code:</label></dt>
	  <dd><form:input path="projectCode" id="projectCode" size="25" maxlength="25" tabindex="10"/>
       	  <form:errors path="projectCode" />
          <span class="hint">Ask your teacher for the access code.<span class="hint-pointer"></span></span></dd>

    </dl>
               
 	  <div id="regButtons">
 	    <input type="image" id="save" src="../themes/tels/default/images/CreateAccount.png" 
    onmouseover="swapImage('save','../themes/tels/default/images/CreateAccountRoll.png')" 
    onmouseout="swapImage('save','../themes/tels/default/images/CreateAccount.png')"
    />
    <a href="../index.html"><input type="image" id="cancel" src="../<spring:theme code="register_cancel" />" 
    onmouseover="swapImage('cancel','../<spring:theme code="register_cancel_roll" />')" 
    onmouseout="swapImage('cancel','../<spring:theme code="register_cancel" />')"
    /> </a>	  </div>
 
 </form:form>
 
</div>

</div>  <!-- /* End of the CenteredDiv */-->

</body>

</html>




