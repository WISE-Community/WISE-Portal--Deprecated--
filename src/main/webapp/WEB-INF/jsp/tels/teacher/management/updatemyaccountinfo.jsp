<%@ include file="../include.jsp"%>

   
    <!-- $Id$ -->
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

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
  
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script src="../.././javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="../.././javascript/tels/scriptaculous.js" type="text/javascript" ></script>
<script src="../.././javascript/effects.js" type="text/javascript" ></script>

<script type="text/javascript">
function checkIfLegalAcknowledged (form, id) {
	if(form.getElementById(id).checked==true){
	} else{
	}
}
</script>

<title><spring:message code="teacher.signup.title" /></title>

</head>

<body>

<div id="pageWrapper">

	<%@ include file="../headerteacher.jsp"%>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="infoContent">
				<div class="panelHeader">Update My Account Information</div>
				<div class="infoContentBox">
					<div><spring:message code="teacher.registerteacher.29"/> <spring:message code="teacher.registerteacher.30"/></div>

					<!-- Support for Spring errors object -->
					<div id="errorMsgNoBg">
						<spring:bind path="teacherAccountForm.*">
						  <c:forEach var="error" items="${status.errorMessages}">
						    <p><c:out value="${error}"/></p>
						  </c:forEach>
						</spring:bind>
					</div>
					
					<div>
						<form:form method="post" action="updatemyaccountinfo.html" commandName="teacherAccountForm" id="teacherRegForm" autocomplete='off'>  
						  <dl>
						  
						  	<dt><label for="firstname" id="firstname1"><spring:message code="signup.firstname" /></label></dt>
						    <dd><form:input disabled="true" path="userDetails.firstname" id="teacherFirstName" size="25" maxlength="25" tabindex="1"/><span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
						        
							<!--This unusually placed script gets the cursor into the First Name field immediately on page load.  
							It must appear immediately after the Input field in question  (MattFish)-->
							<script type="text/javascript">
							document.getElementById('teacherFirstName').focus();
							</script>
						       
						  	<dt><label for="lastname" id="lastname1"><spring:message code="signup.lastname"/></label></dt>
							<dd><form:input disabled="true" path="userDetails.lastname" id="teacherLastName" size="25" maxlength="25" tabindex="2"/> <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
						    
						    <dt><label for="displayname" id="displayname"><spring:message code="signup.displayname"/></label></dt>
						    <dd><form:input path="userDetails.displayname" id="teacherDisplayName" size="25" maxlength="40" tabindex="3"/><br/><span style="font-size:.7em;">(Name as it will appear to students)</span></dd>
						   
						            
						    <dt><label for="emailAddress" id="emailAddress1"><spring:message code="signup.emailAddress" /></label></dt>
							<dd><form:input path="userDetails.emailAddress" id="teacherEmail" size="25" maxlength="40" tabindex="4"/> <span class="hint"><spring:message code="teacher.registerteacher.5"/> <span class="hint-pointer"></span></span></dd>
						            
						    <dt><label for="city" id="city1"><spring:message code="signup.city" /></label> </dt>
							<dd><form:input path="userDetails.city" id="teacherCity" size="25" maxlength="25" tabindex="5"/>
						    <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span>  </dd>
						           
						    <dt><label for="state" id="state1" ><spring:message code="signup.state" /></label> </dt>
							<dd><form:input path="userDetails.state" id="teacherState" size="25" maxlength="25" tabindex="6"/>
						    	<span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span>  
						    </dd>
						                
						    <dt><label for="country" id="country1"><spring:message code="signup.country" /></label></dt>
							<dd><form:input path="userDetails.country" id="teacherCountry" size="25" maxlength="25" tabindex="7"/> 
						    <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> 
						    </dd>
						            
						    <dt>    <label for="schoolname" id="schoolname1"><spring:message code="signup.schoolname" /></label></dt>
							<dd><form:input path="userDetails.schoolname" id="teacherSchool" size="25" maxlength="25" tabindex="8"/>      <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
						    
						    <dt><label for="schoollevel" id="schoollevel1"><spring:message code="signup.schoollevel" /></label> </dt>
							<dd> 
						    		<form:select path="userDetails.schoollevel" id="schoollevel" onfocus="Effect.toggle('showSchoolLevelInfo','appear');" onblur="Effect.toggle('showSchoolLevelInfo','appear');">           
						    		<c:forEach items="${schoollevels}" var="schoollevel">
						            <form:option value="${schoollevel}"><spring:message code="signup.schoollevels.${schoollevel}" /></form:option>
						          </c:forEach>
						        </form:select>
						        <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
						                 
						    <dt><label for="curriculumsubjects" id="curriculumsubjects1"><spring:message code="signup.curriculumsubjects" /></label> 
						</dt>
							<dd>
						     
						    <a href="javascript:Effect.toggle('curriculumSubjectsBox','appear')"><spring:message code="teacher.registerteacher.6"/></a> 
						   
						   	<div id="curriculumSubjectsBox" style="display:none;"> 
						          	<p><strong><spring:message code="teacher.registerteacher.7"/></strong></p>
								  <p><spring:message code="teacher.registerteacher.8"/></p>
								  
						          <table id="textCurriculumBox">
						          <tr>
						          <td class="width166"><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects1" value="Biology"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.9"/></td>
						          <td class="width122"><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects2" value="APBiology"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.10"/></td>
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects3" value="EnvironmentalScience"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.11"/></td>
								  <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects4" value="Chemistry"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.12"/></td>
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects5" value="APChemistry"/><input type="hidden"  value="on"/><spring:message code="teacher.registerteacher.13"/></td>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects6" value="Astronomy"/><input type="hidden"  value="on"/><spring:message code="teacher.registerteacher.14"/></td>
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects7" value="Physics"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.15"/></td>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects8" value="APPhysics"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.16"/></td>
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects9" value="Anatomy"/><input type="hidden"  value="on"/><spring:message code="teacher.registerteacher.17"/></td>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects10" value="EarthScience"/><input type="hidden"  value="on"/><spring:message code="teacher.registerteacher.18"/></td>
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects11" value="Biotechnology"/><input type="hidden"  value="on"/><spring:message code="teacher.registerteacher.19"/></td>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects12" value="Geology"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.20"/></td>
								  </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects14" value="AdvancedIntScience"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.21"/></td>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects13" value="IntegratedScience"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.22"/></td>
						
						          </tr>
						          <tr>
						          <td><form:checkbox path="userDetails.curriculumsubjects" id="userDetails.curriculumsubjects15" value="Other"/><input type="hidden" value="on"/><spring:message code="teacher.registerteacher.23"/></td>
						          <td></td>
						          </tr>
						          </table>
						          
								 <p><spring:message code="teacher.registerteacher.24"/></p>
						     </div>
						    </dd>
						    
							<div style="display:none">
						     
						     <dt id="layoutForLegal"><label for="legalAcknowledged" id="legalAcknowledged1"><spring:message code="signup.legalAcknowledged" /></label></dt>     
							 <dd id="termsOfUse">
							     <form:checkbox disabled="true" path="legalAcknowledged" id="legalAcknowledged" /> 	 
						     <spring:message code="teacher.registerteacher.25"/>&nbsp;<a href="termsofuse.html" onClick="return popupSpecial(this, 'terms')"><spring:message code="teacher.registerteacher.26"/></a>
						     </dd>
						      <div>&nbsp;</div> 
						      <dt><label for="password" id="password1"><spring:message code="signup.password" /></label></dt>
							  <dd><form:password disabled="true" path="userDetails.password" id="password" size="25" maxlength="25" tabindex="11" /><span class="hint"><spring:message code="teacher.registerteacher.27"/><span class="hint-pointer"></span></span> </dd>
						
							  <dt><label for="repeatedPassword" id="repeatedPassword2"><spring:message code="signup.password.verify" /></label></dt>
							  <dd><form:password disabled="true" path="repeatedPassword" id="repeatedPassword" size="25" maxlength="25" tabindex="12" />  <span class="hint"><spring:message code="teacher.registerteacher.28"/><span class="hint-pointer"></span></span></dd>
						      </div>
						       
						      </dl>
						      
						      <div><input type="submit" value="Save Changes"/></div>
							  <div><a href="updatemyaccount.html"><spring:message code="teacher.registerteacher.35"/></a></div>
						           
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

