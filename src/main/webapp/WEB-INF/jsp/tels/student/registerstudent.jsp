<%@ include file="include.jsp"%>

<!-- $Id: registerstudent.jsp 989 2007-08-30 01:15:54Z MattFish $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="registerstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<title><spring:message code="student.registerstudent.studentRegistration" /></title>
<script type="text/javascript">
$(document).ready(function(){
	
	//focus cursor into the First Name field on page ready 
	if($('#firstname').length){
		$('#firstname').focus();
	}
});

function findPeriods() {
	  var successCallback = function(o) {
  			var periodSelect = document.getElementById("runCode_part2");
			periodSelect.innerHTML = "";
			// o.responseText can be either "not found" (when runcode doesn't point to an existing run
		  	// or "1,2,3,4,5,...", a comma-separated values of period names
		  	var responseText = o;
		  	if (responseText == "not found" || responseText.length < 2) {
		  		alert("<spring:message code='student.addproject.invalidAccessCode'/>");
		  	} else {
			  	var op = document.createElement('option');
			  	op.appendChild(document.createTextNode("<spring:message code='student.addproject.selectClassPeriod'/>"));
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
		  	}
		  };
		  var failureCallback = function(o) {
			  alert("<spring:message code='student.addproject.serverError' />");
		  };
	var runcode = document.getElementById("runCode_part1").value;
	if (runcode != null && runcode != "") {
		$.ajax({
			url:"/webapp/runinfo.html?runcode=" + runcode,
			dataType:"text",		
			success:successCallback,
			error:failureCallback
		});
	} else {
		alert("<spring:message code='student.addproject.enterAccessCode' />");
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

		//the message to display in the popup
		var existingAccountsHtml = "";
		
		existingAccountsHtml += "<h1 style='color:red;text-align:center'><spring:message code='warning_all_caps'/></h1>";
		
		if(existingAccountsArray.length > 1) {
			//message to display if we found multiple accounts
			existingAccountsHtml += "<p style='color:red'><spring:message code='student.registerstudent.accountsAlreadyExistWarning'/></p>";
		} else {
			//message to display if we found a single account
			existingAccountsHtml += "<p style='color:red'><spring:message code='student.registerstudent.accountAlreadyExistsWarning'/></p>";
		}
		
		existingAccountsHtml += "<br>";
		
		//loop through all the existing accounts
		for(var x=0; x<existingAccountsArray.length; x++) {
			//get a user name
			var userName = existingAccountsArray[x];

			//make the user name a link to the login page that will pre-populate the user name field
			existingAccountsHtml += "<a href='../login.html?userName=" + userName + "'>";
			existingAccountsHtml += userName;
			existingAccountsHtml += "</a>";
			
			existingAccountsHtml += "<br><br>";
		}

		existingAccountsHtml += "<p style='text-align:center'>------------------------------------------------------------</p><br>";

		existingAccountsHtml += "<p><spring:message code='student.registerstudent.forceCreateNewAccount'/></p>";
		
		//add the button that will create a brand new account if none of the existing accounts belongs to the user
		existingAccountsHtml += "<table style='width:100%'><tr><td style='width:100%' align='center'><a onclick='checkIfReallyWantToCreateAccount()' class='wisebutton'><spring:message code='student.registerstudent.createNewAccount'/></a></td</tr></table>";

		existingAccountsHtml += "<br>";
		
		//add the html to the div
		$('#existingAccountsDialog').html(existingAccountsHtml);

		//display the popup
		$('#existingAccountsDialog').dialog({title: "<spring:message code='student.registerstudent.accountAlreadyExists'/>",width:500, height:500});
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
		dataType:"text",
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

/**
 * Ask the student again if they are really sure they 
 * have never created an account before.
 */
function checkIfReallyWantToCreateAccount() {
	//ask the student again 
	var answer = confirm("<spring:message code='student.registerstudent.confirmNoPreviousAccount' />");
	
	if(answer) {
		//create the account if they answered 'OK'
		createAccount();
	}
}

function createAccount() {
	var runcode = document.getElementById("runCode_part1").value;
	var period = document.getElementById("runCode_part2").value;
	var firstname = document.getElementById("firstname").value;
	var lastname = document.getElementById("lastname").value;
	
	if(!/^[a-zA-Z]*$/.test(firstname)) {
		//first name contains characters that are not letters
		alert("<spring:message code='student.registerstudent.firstNameOnlyLetters' />");
	} else if(!/^[a-zA-Z]*$/.test(lastname)) {
		//last name contains characters that are not letters
		alert("<spring:message code='student.registerstudent.lastNameOnlyLetters' />");
	} else if (runcode == null || runcode == "") {
		alert("<spring:message code='student.addproject.enterAccessCode'/>");		
			var periodSelect = document.getElementById("runCode_part2");
			periodSelect.innerHTML = "";
	  		periodSelect.disabled = true;
	} else if ((period != null && period == "none") || period == null || period == "") {
		alert("<spring:message code='student.addproject.selectClassPeriod' />");
	} else if (runcode != null && period != null && period != "none") {
		var projectCode = document.getElementById("projectCode");
		projectCode.value = runcode + "-" + period;
		document.getElementById("studentRegForm").submit();		
	} else {
		alert("<spring:message code='student.addproject.invalidAccessCode' />");
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
<%@ page buffer="64kb" %>
<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage"><spring:message code="wise" /></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="student.registerstudent.studentRegistration"/></div>
				<div class="infoContentBox">
					<div><spring:message code="student.registerstudent.formInstructions"/></div>
      
					<!-- Support for Spring errors object -->
					<div class="errorMsgNoBg">
						<spring:bind path="studentAccountForm.*">
						  <c:forEach var="error" items="${status.errorMessages}">
						        <br /><c:out value="${error}"/>
						    </c:forEach>
						</spring:bind>
					</div>

					<form:form id="studentRegForm" commandName="studentAccountForm" method="post" action="registerstudent.html" autocomplete='off'>
					  
					  <table class="regTable">
					  	<tr>
					  		<td><label for="studentFirstName"><spring:message code="student.registerstudent.firstName"/></label></td>	    
					  	  	<td><form:input path="userDetails.firstname" id="firstname" size="25" maxlength="25" tabindex="1"/>
							    <form:errors path="userDetails.firstname" />
						    	<span class="hint"><spring:message code="student.registerstudent.firstNameOnlyLetters"/><span class="hint-pointer"></span></span> 
					   		</td>
					   	</tr>
					
					  	<tr>
					  		<td><label for="studentLastName"><spring:message code="student.registerstudent.lastName"/></label></td>
							<td><form:input path="userDetails.lastname" id="lastname" size="25" maxlength="25" tabindex="2"/>
							    <form:errors path="userDetails.lastname" />
						    	<span class="hint"><spring:message code="student.registerstudent.lastNameOnlyLetters"/><span class="hint-pointer"></span></span> 
						   	</td>
						</tr>
					            
					  	<tr>
					  		<td><label for="studentGender"><spring:message code="student.registerstudent.gender"/></label></td>
							<td><form:select path="userDetails.gender" id="gender" tabindex="3">       
						          <c:forEach items="${genders}" var="genderchoice">
						            <form:option value="${genderchoice}">
						            	<spring:message code="genders.${genderchoice}" />
						            </form:option>
						          </c:forEach>
						      	</form:select> 
						        <span class="hint"><spring:message code="student.registerstudent.genderSelectChoice"/><span class="hint-pointer"></span></span> 
					    	</td>
					    </tr>
					            
					    <tr>
					    	<td><label for="studentBirthMonth"><spring:message code="student.registerstudent.birthMonth"/></label></td>
							<td><form:select path="birthmonth" id="birthmonth" tabindex="4">
								<form:errors path="birthmonth" />
								<c:forEach var="month" begin="1" end="12" step="1">
									<form:option value="${month}">
										<spring:message code="birthmonths.${month}" />
									</form:option>
								</c:forEach>
							    </form:select>
						        <span class="hint"><spring:message code="student.registerstudent.birthDayHelp"/><span class="hint-pointer"></span></span> 
					    	</td>
					    </tr>
					        
						<tr>
							<td><label for="studentBirthDate"><spring:message code="student.registerstudent.birthDate"/></label></td>
					  		<td><form:select path="birthdate" id="birthdate" tabindex="5">
							    <form:errors path="birthdate" />
									<c:forEach var="date" begin="1" end="31" step="1">
										<form:option value="${date}">
											<spring:message code="birthdates.${date}" />
									  	</form:option>
									</c:forEach>
							 	</form:select>
							</td>
						</tr>
				                   
					 	<tr>
					 		<td><label for="studentPassword"><spring:message code="student.registerstudent.typePassword"/></label></td>
					  		<td><form:password path="userDetails.password" id="password" size="25" maxlength="25" tabindex="6"/>
								<!-- <form:errors path="userDetails.password"/> -->
					      		<span class="hint"><spring:message code="student.registerstudent.passwordHelp"/><span class="hint-pointer"></span></span> 
				            </td>
				        </tr>
				
					    <tr>
					    	<td><label for="studentPasswordRepeat"><spring:message code="student.registerstudent.verifyPassword"/></label></td>
						  	<td><form:password path="repeatedPassword" id="repeatedPassword" size="25" maxlength="25" tabindex="7"/> 
					            <form:errors path="repeatedPassword" />      	  
						        <span class="hint"><spring:message code="student.registerstudent.verifyPasswordHelp"/><span class="hint-pointer"></span></span>
				            </td>
				        </tr>
				      
					  	<tr>
					  		<td><label for="reminderQuestion"><spring:message code="student.registerstudent.securityQuestion"/></label></td>
					  		<td><form:select path="userDetails.accountQuestion" id="accountQuestion" tabindex="8" >  
					            <form:errors path="userDetails.accountQuestion" />
						        	<c:forEach items="${accountQuestions}" var="questionchoice">
							            <form:option value="${questionchoice}">
							            	<spring:message code="accountquestions.${questionchoice}"/>
							            </form:option>
							        </c:forEach>
						        </form:select>
						         <span class="hint"><spring:message code="student.registerstudent.securityQuestionHelp"/><span class="hint-pointer"></span></span>
							</td>
						</tr>
				
					  	<tr>
					  		<td><label for="reminderAnswer" id="reminderAnswer"><spring:message code="student.registerstudent.securityQuestionAnswer"/></label></td>
							<td><form:input path="userDetails.accountAnswer" id="accountAnswer" size="25" maxlength="25" tabindex="9"/>
								<span class="hint"><spring:message code="student.registerstudent.securityQuestionAnswerHelp"/><span class="hint-pointer"></span></span>			
						    </td>
						</tr>
				
						<tr>
							<td><label for="runCode_part1" id="runCode_part1_label"><spring:message code="student.registerstudent.accessCode"/></label></td>
							<td><form:input path="runCode_part1" id="runCode_part1" size="25" maxlength="25" tabindex="10"/>
						       	  <form:errors path="runCode_part1" />
						          <span class="hint"><spring:message code="student.registerstudent.accessCodeHelp"/><span class="hint-pointer"></span></span>
						    </td>
						</tr>
						
						<tr>
							<td><label for="runCode_part1" id="runCode_part1_label"></label></td>
					  		<td><a style="font-weight:1.1em;" onclick="findPeriods();"><spring:message code="student.registerstudent.showClassPeriods"/></a></td>
					  	</tr>
				
				      	<tr>
				      		<td><label for="runCode_part2" id="runCode_part2_label"><spring:message code="student.registerstudent.classPeriod"/></label></td>
					  		<td><form:select path="runCode_part2" id="runCode_part2" tabindex="11" disabled="true"></form:select>
					       	  <form:errors path="runCode_part2" />
					          <span class="hint"><spring:message code="student.registerstudent.selectPeriodHelp"/><span class="hint-pointer"></span></span>
					        </td>
					    </tr>
				      
					  <form:hidden path="projectCode" id="projectCode"/>
				               
					</table>
					      
					      
				  	<div style="margin-top:1em;">
				 	  	<a style="margin-bottom:1em;" class="wisebutton" onclick="checkForExistingAccountsAndCreateAccount()"><spring:message code="student.registerstudent.createAccount"/></a>
				 	  	<a href="/webapp/index.html"><spring:message code="cancel"/></a>
					 </div> 
					 
					 </form:form>

					<div id="existingAccounts" style="display:none"></div>
					<div id="existingAccountsDialog" style="display:none"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>

</html>




