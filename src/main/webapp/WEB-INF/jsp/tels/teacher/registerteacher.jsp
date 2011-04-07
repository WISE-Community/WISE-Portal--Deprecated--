<%@ include file="include.jsp"%>

   
    <!-- $Id: header.jsp 368 2007-05-05 01:41:18Z mattfish $ -->
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script src="../javascript/tels/general.js" type="text/javascript" ></script>  
<script src="../javascript/tels/jquery-1.4.2.min.js" type="text/javascript" > </script>
<script src="../javascript/tels/jquery-ui-1.8.9/js/jquery-ui-1.8.9.custom.min.js" type="text/javascript" > </script>
<link rel="stylesheet" type="text/css" href="../javascript/tels/jquery-ui-1.8.9/css/ui-lightness/jquery-ui-1.8.9.custom.css" />

<script type="text/javascript">
			function checkIfLegalAcknowledged (form, id) {
			if(form.getElementById(id).checked==true){
			}else{
			}
			}
</script>


<script type="text/javascript">
 
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

/**
 * Check if there is an account with matching first name and
 * last name already. If there are matching accounts we will 
 * ask the teacher whether one of these existing accounts is
 * theirs to try to reduce duplicate accounts. If none of these accounts
 * is theirs they have the option of creating the new account. If
 * there are no matching accounts we will create the new account.
 */
function checkForExistingAccountsAndCreateAccount() {
	if(checkForExistingAccounts()) {
		//accounts exist, ask teacher if these accounts are theirs

		//get the JSON array of existing accounts
		var existingAccountsString = $('#existingAccounts').html();

		//create a JSON array object
		var existingAccountsArray = JSON.parse(existingAccountsString);

		//the message to display at the top of the popup
		var existingAccountsHtml = "<p><spring:message code='teacher.registerteacher.31'/></p>";

		//loop through all the existing accounts
		for(var x=0; x<existingAccountsArray.length; x++) {
			//get a user name
			var userName = existingAccountsArray[x];
			
			if(existingAccountsHtml != "") {
				//add line breaks between user names
				existingAccountsHtml += "<br><br>";
			}

			//make the user name a link to the login page that will pre-populate the user name field
			existingAccountsHtml += "<a href='../login.html?userName=" + userName + "'>";
			existingAccountsHtml += userName;
			existingAccountsHtml += "</a>";
		}

		existingAccountsHtml += "<br><br><p>------------------------------------------------------------</p><br>";

		//add the button that will create a brand new account if none of the existing accounts belongs to the user
		existingAccountsHtml += "<a id='createBrandNewAccountButton' onclick='createAccount()' class='createAccountButton'><spring:message code='teacher.registerteacher.32'/></a>";

		//add the html to the div
		$('#existingAccountsDialog').html(existingAccountsHtml);

		//display the popup
		$('#existingAccountsDialog').dialog({title: "<spring:message code='teacher.registerteacher.33'/>", width:500, height:500});
	} else {
		//we did not find any accounts that have matching fields so we will create a new account
		createAccount();
	}
}

/**
 * Make a sync request for any existing teacher accounts with the same
 * first name and last name
 */
function checkForExistingAccounts() {
	//get the first name and last name from the form
	var firstName = $('#teacherFirstName').val();
	var lastName = $('#teacherLastName').val();

	var data = {
		accountType:'teacher',
		firstName:firstName,
		lastName:lastName
	};

	//make the request for matching accounts
	$.ajax({
		url:'../checkforexistingaccount.html',
		data:data,
		success:function(response) {
			if(response != null) {
				//set the response into a hidden div so we can access it later
				$('#existingAccounts').html(response);
			}
		},
		async:false
	});

	var existingAccounts = false;
	
	if($('#existingAccounts').html() != '' && $('#existingAccounts').html() != '[]') {
		//there are existing accounts that match
		existingAccounts = true;
	}

	return existingAccounts;
}

/**
 * Submit the form to create the account
 */
function createAccount() {
	$('#teacherRegForm').submit();
}

/**
 * Toggle show/hide of the curriculum box
 */
function showSubjects() {
	$('#curriculumSubjectsBox').toggle();
}

</script>

<title><spring:message code="teacher.signup.title" /></title>

</head>

<body>

<div id="centeredDiv">

<%@ include file="headermain.jsp"%>

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h1 id="registrationTitle" class="blueText"><spring:message code="teacher.registerteacher.1"/></h1>
     
<div id="subtitleTeacherReg"><spring:message code="teacher.registerteacher.2"/> <br/> <spring:message code="teacher.registerteacher.3"/></div>

<!-- Support for Spring errors object -->
<div id="regErrorMessages">
	<spring:bind path="teacherAccountForm.*">
  <c:forEach var="error" items="${status.errorMessages}">
    <b>
      <br /><c:out value="${error}"/>
    </b>
  </c:forEach>
</spring:bind>
</div>

<form:form method="post" action="registerteacher.html" commandName="teacherAccountForm" id="teacherRegForm" autocomplete='off'>  
  <dl>
  
  	<dt><label for="firstname" id="firstname1"><spring:message code="signup.firstname" /></label></dt>
    <dd><form:input path="userDetails.firstname" id="teacherFirstName" size="25" maxlength="25" tabindex="1"/><span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
        
	<!--This unusually placed script gets the cursor into the First Name field immediately on page load.  
	It must appear immediately after the Input field in question  (MattFish)-->
	<script type="text/javascript">
	document.getElementById('teacherFirstName').focus();
	</script>
       
  	<dt><label for="lastname" id="lastname1"><spring:message code="signup.lastname"/></label></dt>
	<dd><form:input path="userDetails.lastname" id="teacherLastName" size="25" maxlength="25" tabindex="2"/> <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>

    <dt><label for="emailAddress" id="emailAddress1"><spring:message code="signup.emailAddress" /></label></dt>
	<dd><form:input path="userDetails.emailAddress" id="teacherEmail" size="25" maxlength="40" tabindex="3"/> <span class="hint"><spring:message code="teacher.registerteacher.5"/> <span class="hint-pointer"></span></span></dd>
            
     <dt><label for="city" id="city1"><spring:message code="signup.city" /></label> </dt>
	<dd><form:input path="userDetails.city" id="teacherCity" size="25" maxlength="50" tabindex="4"/>
    <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span>  </dd>
           
    <dt><label for="state" id="state1" ><spring:message code="signup.state" /></label> </dt>
	<dd><form:input path="userDetails.state" id="teacherState" size="25" maxlength="50" tabindex="5"/>
    	<span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span>  
    	<div id="autocomplete_choices_state" class="autocomplete" ></div>
    </dd>
                
    <dt><label for="country" id="country1"><spring:message code="signup.country" /></label></dt>
	<dd><form:input path="userDetails.country" id="teacherCountry" size="25" maxlength="50" tabindex="6"/> 
    <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> 
    <div id="autocomplete_choices_country" class="autocomplete" ></div>
    </dd>
            
    <dt>    <label for="schoolname" id="schoolname1"><spring:message code="signup.schoolname" /></label></dt>
	<dd><form:input path="userDetails.schoolname" id="teacherSchool" size="25" maxlength="50" tabindex="7"/>      <span class="hint"><spring:message code="teacher.registerteacher.4"/><span class="hint-pointer"></span></span> </dd>
    
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
    
    <a onclick="showSubjects()" style="cursor:pointer;color:blue;text-decoration:underline"><spring:message code="teacher.registerteacher.6"/></a> 
   
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
     <div>&nbsp;</div>
     <dt id="layoutForLegal"><label for="legalAcknowledged" id="legalAcknowledged1"><spring:message code="signup.legalAcknowledged" /></label></dt>
	 <dd id="termsOfUse">
	     <form:checkbox path="legalAcknowledged" id="legalAcknowledged"/> 
     <spring:message code="teacher.registerteacher.25"/>&nbsp;<a href="termsofuse.html" onClick="return popupSpecial(this, 'terms')"><spring:message code="teacher.registerteacher.26"/></a>
     </dd>
      <div>&nbsp;</div> 
      <dt><label for="password" id="password1"><spring:message code="signup.password" /></label>
</dt>
	  <dd><form:password path="userDetails.password" id="password" size="25" maxlength="20" tabindex="11"/> <span class="hint"><spring:message code="teacher.registerteacher.27"/><span class="hint-pointer"></span></span> </dd>

	  <dt><label for="repeatedPassword" id="repeatedPassword2"><spring:message code="signup.password.verify" /></label></dt>
	  <dd><form:password path="repeatedPassword" id="repeatedPassword" size="25" maxlength="20" tabindex="12"/>  <span class="hint"><spring:message code="teacher.registerteacher.28"/><span class="hint-pointer"></span></span></dd>
      
      <dt><label for="howDidYouHearAboutUs" id="howDidYouHearAboutUs2"><spring:message code="teacher.registerteacher.36"/></label></dt>
	  <dd><form:input path="userDetails.howDidYouHearAboutUs" id="howDidYouHearAboutUs" size="25" maxlength="120" tabindex="13"/>  <span class="hint"><spring:message code="teacher.registerteacher.37"/><span class="hint-pointer"></span></span></dd>
      
      <div>&nbsp;</div> 
      </dl>
               
 	  <div id="regButtons">
 	  	<a id="createAccountLink" class="createAccountButton" onclick="checkForExistingAccountsAndCreateAccount()"><spring:message code="teacher.registerteacher.34"/></a>
 	  	<a class="createAccountButton" href="../index.html"><spring:message code="teacher.registerteacher.35"/></a>
	  </div>
           
</form:form>

</div> 

<div id="existingAccounts" style="display:none"></div>
<div id="existingAccountsDialog" style="display:none"></div>

</div>   <!--End of the CenteredDiv -->

</body>
</html>

