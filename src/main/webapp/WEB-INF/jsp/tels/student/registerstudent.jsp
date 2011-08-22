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
<%@ page buffer="64kb" %>
<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="student.registerstudent.1"/></div>
				<div class="infoContentBox">
					<div><spring:message code="student.registerstudent.2"/> <spring:message code="student.registerstudent.3"/></div>
      
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
					  		<td><label for="studentFirstName"><spring:message code="student.registerstudent.4"/></label></td>	    
					  	  	<td><form:input path="userDetails.firstname" id="firstname" size="25" maxlength="25" tabindex="1"/>
							    <form:errors path="userDetails.firstname" />
						    	<span class="hint"><spring:message code="student.registerstudent.5"/><span class="hint-pointer"></span></span> 
					   		</td>
					   	</tr>
					
					  	<tr>
					  		<td><label for="studentLastName"><spring:message code="student.registerstudent.6"/></label></td>
							<td><form:input path="userDetails.lastname" id="lastname" size="25" maxlength="25" tabindex="2"/>
							    <form:errors path="userDetails.lastname" />
						    	<span class="hint"><spring:message code="student.registerstudent.7"/><span class="hint-pointer"></span></span> 
						   	</td>
						</tr>
					            
					  	<tr>
					  		<td><label for="studentGender"><spring:message code="student.registerstudent.8"/></label></td>
							<td><form:select path="userDetails.gender" id="gender" tabindex="3">       
						          <c:forEach items="${genders}" var="genderchoice">
						            <form:option value="${genderchoice}">
						            	<spring:message code="genders.${genderchoice}" />
						            </form:option>
						          </c:forEach>
						      	</form:select> 
						        <span class="hint"><spring:message code="student.registerstudent.9"/><span class="hint-pointer"></span></span> 
					    	</td>
					    </tr>
					            
					    <tr>
					    	<td><label for="studentBirthMonth"><spring:message code="student.registerstudent.10"/></label></td>
							<td><form:select path="birthmonth" id="birthmonth" tabindex="4">
								<form:errors path="birthmonth" />
								<c:forEach var="month" begin="1" end="12" step="1">
									<form:option value="${month}">
										<spring:message code="birthmonths.${month}" />
									</form:option>
								</c:forEach>
							    </form:select>
						        <span class="hint"><spring:message code="student.registerstudent.11"/><span class="hint-pointer"></span></span> 
					    	</td>
					    </tr>
					        
						<tr>
							<td><label for="studentBirthDate"><spring:message code="student.registerstudent.12"/></label></td>
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
					 		<td><label for="studentPassword"><spring:message code="student.registerstudent.13"/></label></td>
					  		<td><form:password path="userDetails.password" id="password" size="25" maxlength="25" tabindex="6"/>
								<!-- <form:errors path="userDetails.password"/> -->
					      		<span class="hint"><spring:message code="student.registerstudent.14"/><span class="hint-pointer"></span></span> 
				            </td>
				        </tr>
				
					    <tr>
					    	<td><label for="studentPasswordRepeat"><spring:message code="student.registerstudent.15"/></label></td>
						  	<td><form:password path="repeatedPassword" id="repeatedPassword" size="25" maxlength="25" tabindex="7"/> 
					            <form:errors path="repeatedPassword" />      	  
						        <span class="hint"><spring:message code="student.registerstudent.16"/><span class="hint-pointer"></span></span>
				            </td>
				        </tr>
				      
					  	<tr>
					  		<td><label for="reminderQuestion"><spring:message code="student.registerstudent.17"/></label></td>
					  		<td><form:select path="userDetails.accountQuestion" id="accountQuestion" tabindex="8" >  
					            <form:errors path="userDetails.accountQuestion" />
						        	<c:forEach items="${accountQuestions}" var="questionchoice">
							            <form:option value="${questionchoice}">
							            	<spring:message code="accountquestions.${questionchoice}"/>
							            </form:option>
							        </c:forEach>
						        </form:select>
						         <span class="hint"><spring:message code="student.registerstudent.18"/><span class="hint-pointer"></span></span>
							</td>
						</tr>
				
					  	<tr>
					  		<td><label for="reminderAnswer" id="reminderAnswer"><spring:message code="student.registerstudent.19"/></label></td>
							<td><form:input path="userDetails.accountAnswer" id="accountAnswer" size="25" maxlength="25" tabindex="9"/>
								<span class="hint"><spring:message code="student.registerstudent.20"/><span class="hint-pointer"></span></span>			
						    </td>
						</tr>
				
						<tr>
							<td><label for="runCode_part1" id="runCode_part1_label"><spring:message code="student.registerstudent.21"/></label></td>
							<td><form:input path="runCode_part1" id="runCode_part1" size="25" maxlength="25" tabindex="10"/>
						       	  <form:errors path="runCode_part1" />
						          <span class="hint"><spring:message code="student.registerstudent.22"/><span class="hint-pointer"></span></span>
						    </td>
						</tr>
						
						<tr>
							<td><label for="runCode_part1" id="runCode_part1_label"></label></td>
					  		<td><a style="font-weight:1.1em;" onclick="findPeriods();"><spring:message code="student.registerstudent.28"/></a></td>
					  	</tr>
				
				      	<tr>
				      		<td><label for="runCode_part2" id="runCode_part2_label"><spring:message code="student.registerstudent.29"/></label></td>
					  		<td><form:select path="runCode_part2" id="runCode_part2" tabindex="11" disabled="true"></form:select>
					       	  <form:errors path="runCode_part2" />
					          <span class="hint"><spring:message code="student.registerstudent.30"/><span class="hint-pointer"></span></span>
					        </td>
					    </tr>
				      
					  <form:hidden path="projectCode" id="projectCode"/>
				               
					</table>
					      
					      
				  	<div style="margin-top:1em;">
				 	  	<a style="margin-bottom:1em;" class="wisebutton" onclick="checkForExistingAccountsAndCreateAccount()"><spring:message code="student.registerstudent.26"/></a>
				 	  	<a href="/webapp/index.html"><spring:message code="student.registerstudent.27"/></a>
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




