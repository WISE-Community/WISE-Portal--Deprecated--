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

<!-- $Id: registerstudent.jsp 989 2007-08-30 01:15:54Z MattFish $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<script src="../javascript/tels/general.js" type="text/javascript" > </script>
<script src="../javascript/tels/jquery-1.4.2.min.js" type="text/javascript" > </script>
<script src="../javascript/tels/jquery-ui-1.8.9/js/jquery-ui-1.8.9.custom.min.js" type="text/javascript" > </script>
<link rel="stylesheet" type="text/css" href="../javascript/tels/jquery-ui-1.8.9/css/ui-lightness/jquery-ui-1.8.9.custom.css" />

<!-- Dependency -->
<!--  
<script src="http://yui.yahooapis.com/2.8.0r4/build/yahoo/yahoo-min.js"></script>
<script src="http://yui.yahooapis.com/2.8.0r4/build/event/event-min.js"></script>
<script src="http://yui.yahooapis.com/2.8.0r4/build/connection/connection_core-min.js"></script>
-->

<title><spring:message code="student.signup.title" /></title>
<script type="text/javascript">
function findPeriods() {
	  var successCallback = function(o) {
  			var periodSelect = document.getElementById("runCode_part2");
			periodSelect.innerHTML = "";
			// o.responseText can be either "not found" (when runcode doesn't point to an existing run
		  	// or "1,2,3,4,5,...", a comma-separated values of period names
		  	var responseText = o;
		  	if (responseText == "not found" || responseText.length < 2) {
		  		alert("The Access Code is invalid. Please talk with your teacher");
		  	} else {
			  	var op = document.createElement('option');
			  	op.appendChild(document.createTextNode("Select your class period..."));
			  	op.value = 'none';
  				periodSelect.appendChild(op);
			  	
			  	var periodsArr = responseText.split(",");
		  		for (var i=0; i < periodsArr.length; i++) {
			  		var periodName = periodsArr[i];
			  		if (periodName != "") {
			  			var op = document.createElement('option');
					  	op.appendChild(document.createTextNode(periodName));
					  	op.value = periodName;
		  				periodSelect.appendChild(op);
			  		}
		  		}
		  		periodSelect.disabled = false;
		  		document.getElementById("createAccountLink").onclick = checkForExistingAccountsAndCreateAccount;
		  	}
		  };
		  var failureCallback = function(o) {
			  alert('failure');
		  };
	var runcode = document.getElementById("runCode_part1").value;
	if (runcode != null && runcode != "") {
		$.ajax({
			url:"/webapp/runinfo.html?runcode=" + runcode,
			success:successCallback,
			error:failureCallback
		});
	} else {
		alert("Please enter an access code. Get this from your teacher.");
	}
}

/**
 * Check if there is an account with matching first name, last name,
 * birth month, and birth day already. If there are matching accounts
 * we will ask the student whether one of these existing accounts is
 * theirs to try to reduce duplicate accounts. If none of these accounts
 * is theirs they have the option of creating the new account. If
 * there are no matching accounts we will create the new account.
 */
function checkForExistingAccountsAndCreateAccount() {
	if(checkForExistingAccounts()) {
		//accounts exist, ask student if these accounts are theirs

		//get the JSON array of existing accounts
		var existingAccountsString = $('#existingAccounts').html();

		//create a JSON array object
		var existingAccountsArray = JSON.parse(existingAccountsString);

		//the message to display at the top of the popup
		var existingAccountsHtml = "<p><spring:message code='student.registerstudent.23'/></p>";

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
		existingAccountsHtml += "<a id='createBrandNewAccountButton' onclick='createAccount()' class='createAccountButton'><spring:message code='student.registerstudent.24'/></a>";

		//add the html to the div
		$('#existingAccountsDialog').html(existingAccountsHtml);

		//display the popup
		$('#existingAccountsDialog').dialog({title: "<spring:message code='student.registerstudent.25'/>",width:500, height:500});
	} else {
		//account does not exist, create the account
		createAccount();
	}
}

/**
 * Make a sync request for any existing teacher accounts with the same
 * first name and last name
 */
function checkForExistingAccounts() {
	//get the first name, last name, birth month, and birth day from the form
	var firstName = $('#firstname').val();
	var lastName = $('#lastname').val();
	var birthMonth = $('#birthmonth').val();
	var birthDay = $('#birthdate').val();

	var data = {
		accountType:'student',
		firstName:firstName,
		lastName:lastName,
		birthMonth:birthMonth,
		birthDay:birthDay
	};

	//make the request for matching accounts
	$.ajax({
		url:'../checkforexistingaccount.html',
		data:data,
		success:function(response) {
			if(response != null) {
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

function createAccount() {
	var runcode = document.getElementById("runCode_part1").value;
	var period = document.getElementById("runCode_part2").value;
	var firstname = document.getElementById("firstname").value;
	var lastname = document.getElementById("lastname").value;
	
	if(!/^[a-zA-Z]*$/.test(firstname)) {
		//first name contains characters that are not letters
		alert('First Name can only contain letters');
	} else if(!/^[a-zA-Z]*$/.test(lastname)) {
		//last name contains characters that are not letters
		alert('Last Name can only contain letters');
	} else if (runcode == null || runcode == "") {
		alert('Please enter project code');		
			var periodSelect = document.getElementById("runCode_part2");
			periodSelect.innerHTML = "";
	  		periodSelect.disabled = true;
	} else if ((period != null && period == "none") || period == null || period == "") {
		alert('Please click SHOW CLASS PERIODS. Then select a period from the menu.');
	} else if (runcode != null && period != null && period != "none") {
		var projectCode = document.getElementById("projectCode");
		projectCode.value = runcode + "-" + period;
		document.getElementById("studentRegForm").submit();		
	} else {
		alert('Invalid project code. Please talk to your teacher');
	}
}


function setup() {
	var runcode= document.getElementById('runCode_part1').value;
	if (runcode != null && runcode != "") {
		findPeriods();
	}
}
</script>
</head>

<body>

<div id="centeredDiv">

<%@ include file="header.jsp"%>

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

<form:form id="studentRegForm" commandName="studentAccountForm" method="post" action="registerstudent.html" autocomplete='off'>
  
  <dl>
  	<dt><label for="studentFirstName"><spring:message code="student.registerstudent.4"/></label></dt>	    
  	  	<dd><form:input path="userDetails.firstname" id="firstname" size="25" maxlength="25" tabindex="1"/>
	    <form:errors path="userDetails.firstname" />
    	<span class="hint">Use only letters for your first name.  No hyphens, apostrophes, or other punctuation.<span class="hint-pointer"></span></span> 
   		</dd>

<!--This unusually placed script gets the cursor into the First Name field immediately on page load  (MattFish)-->
<script type="text/javascript">
document.getElementById('firstname').focus();
</script>

  	<dt><label for="studentLastName">Last Name:</label></dt>
	<dd><form:input path="userDetails.lastname" id="lastname" size="25" maxlength="25" tabindex="2"/>
	    <form:errors path="userDetails.lastname" />
    	<span class="hint">Use only letters for your last name.  No hyphens, apostrophes, or other punctuation.<span class="hint-pointer"></span></span> 
   		</dd>
            
  	<dt><label for="studentGender"><spring:message code="student.registerstudent.8"/></label></dt>
	<dd><form:select path="userDetails.gender" id="gender" tabindex="3">       
          <c:forEach items="${genders}" var="genderchoice">
            <form:option value="${genderchoice}">
            	<spring:message code="genders.${genderchoice}" />
            </form:option>
          </c:forEach>
      	</form:select> 
        <span class="hint">Select a choice.<span class="hint-pointer"></span></span> 
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
<!--      		<form:errors path="userDetails.password"/> -->
      		<span class="hint">Your password can have up to 18 letters or numbers. Create a password that you can remember!<span class="hint-pointer"></span></span> 
            </dd>

	  <dt><label for="studentPasswordRepeat">Type Password Again:</label></dt>
	  <dd><form:password path="repeatedPassword" id="repeatedPassword" size="25" maxlength="25" tabindex="7"/> 
            <form:errors path="repeatedPassword" />      	  
	        <span class="hint">Type your password in again.<span class="hint-pointer"></span></span>
            </dd>
      
	  <dt><label for="reminderQuestion">Security Question:</label></dt>
	  <dd><form:select path="userDetails.accountQuestion" id="accountQuestion" tabindex="8" >  
            <form:errors path="userDetails.accountQuestion" />
        	<c:forEach items="${accountQuestions}" var="questionchoice">
            <form:option value="${questionchoice}">
            	<spring:message code="accountquestions.${questionchoice}"/>
             </form:option>
          </c:forEach>
        </form:select>
        
         <span class="hint">Select a question from the list then answer it below.<br/><br/>
			If you forget your password, WISE will ask you this Security question so you can reset your password.<span class="hint-pointer"></span></span>
		</dd>

	  <dt><label for="reminderAnswer" id="reminderAnswer">Answer for Security Q:</label></dt>
	  <dd><form:input path="userDetails.accountAnswer" id="accountAnswer" size="25" maxlength="25" tabindex="9"/>
	      <span class="hint">Answer the Security question here.<span class="hint-pointer"></span></span>			
          </dd>

<dt><label for="runCode_part1" id="runCode_part1_label">Access Code:</label></dt>
	  <dd><form:input path="runCode_part1" id="runCode_part1" size="25" maxlength="25" tabindex="10"/>
       	  <form:errors path="runCode_part1" />
          <span class="hint">Get this code from your teacher and enter it.  Then click the <i>Show Class Periods</i> button and select your class period.<span class="hint-pointer"></span></span></dd>

		<dt><label for="runCode_part1" id="runCode_part1_label"></label></dt>
	  <dd ><a onclick="findPeriods();" class="periodLink">Show Class Periods</a></dd>


      <dt><label for="runCode_part2" id="runCode_part2_label">Class Period:</label></dt>
	  <dd><form:select path="runCode_part2" id="runCode_part2" tabindex="11" disabled="true">
	  							   </form:select>
       	  <form:errors path="runCode_part2" />
          <span class="hint">Select your period from the list.<span class="hint-pointer"></span></span></dd>
      
	  <form:hidden path="projectCode" id="projectCode"/>
               
	 </dl>
      
      
  
	<div id="regButtonsStudent">
 				
	    <a id="createAccountLink" onclick="checkForExistingAccountsAndCreateAccount()"><spring:message code="student.registerstudent.26"/></a>
	    <a href="../index.html"><spring:message code="student.registerstudent.27"/></a>	

		</div>  
 
 </form:form>

<div id="existingAccounts" style="display:none"></div>
<div id="existingAccountsDialog" style="display:none"></div>
</div>

</div>  <!-- /* End of the CenteredDiv */-->

</body>

</html>




