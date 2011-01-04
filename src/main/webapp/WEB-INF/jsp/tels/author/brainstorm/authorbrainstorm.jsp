<%@ include file="../../include.jsp"%>
<html>
<head>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/connection/connection.js"></script>


<script type="text/javascript">
var displaynameindex=0;
function hide(divId) {
    var sampleDiv = document.getElementById(divId);
    var d = document.getElementById('samplediv');
    d.removeChild(sampleDiv);    
};

function updatePromptPreview() {
   var promptPreviewElement = this.document.getElementById("promptPreview");
   var promptTextAreaElement = this.document.getElementById("promptTextArea");
   promptPreviewElement.innerHTML = promptTextAreaElement.value;
};

function createAttribute(doc, node, type, val){
	var attribute = doc.createAttribute(type);
	attribute.nodeValue = val;
	node.setAttributeNode(attribute);
};

function createElement(doc, type, attrArgs){
	var newElement = doc.createElement(type);
	if(attrArgs!=null){
		for(var option in attrArgs){
			createAttribute(doc, newElement, option, attrArgs[option]);
		};
	};
	return newElement;
};

function deletepreparedanswer(brainstormId, preparedAnswerId, preparedAnswerIndex) {
	var URL='editpreparedanswer.html';
	var data='brainstormId=' + brainstormId + '&action=delete&preparedAnswerId=' + preparedAnswerId;
	var callback = 
	{
		success:function(o)
		    {	   
	       hide(preparedAnswerIndex);
		    },
		failure:function(o){alert('failed to delete specified prepared response. please contact WISE staff');}
	};
YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);

};

function showsamplediv(brainstormId) {
	// first add a preparedanswer
	var URL='editpreparedanswer.html';
	var data='brainstormId=' + brainstormId + '&action=add';
	var callback = 
		{
			success:function(o)
			    {	   
	           var preparedAnswerIndex = (o.responseText);
	           var sampleDivElement = document.getElementById("samplediv");
			   var newElement = createElement(document, "div", {id:preparedAnswerIndex});
			   newElement.innerHTML="Prepared Response #"+ (Number(preparedAnswerIndex)+1) +"<br/>Name to display this post as:<br/><input id=\"preparedAnswers[" + preparedAnswerIndex + "].displayname\" type=\"text\" value=\"\" name=\"preparedAnswers[" + preparedAnswerIndex + "].displayname\" /><br/>Post:<br/><textarea id=\"preparedAnswers[" + preparedAnswerIndex + "].body\" rows=\"5\" cols=\"90\" name=\"preparedAnswers[" + preparedAnswerIndex + "].body\" ></textarea>"

				   //document.createElement("div");
			   //var attribute = document.createAttribute("id");
			   //attribute.nodeValue=displaynameindex;
			   //newElement.setAttribute(attribute);
			   //sampleDivElement.innerHTML += "<div id='"+ displaynameindex + "'>displayname: <input maxlength=\"25\" size=\"25\"></input><br/>Post:<br/><textarea rows=\"3\" cols=\"90\" ></textarea><a href=\"#\" onclick=\"javascript:hide('" + displaynameindex + "')\">delete</a><br/></div>";
			   sampleDivElement.appendChild(newElement);
			    },
			failure:function(o){alert('failed to add a new sample response. please contact WISE staff');}
		};
	YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
}

	var choices = [];
	
	function addChoice(){
		var text = document.getElementById("choiceText").value;
		if(text=="" || text==null){
			displayChoiceError("The choice field cannot be blank.");
		} else {
			document.getElementById("error").innerHTML = "";
			var index = document.getElementsByName('radioChoice').length;
			createChoiceDisplay(index, text, 'radioChoice');
			createChoiceDisplay(index, text, 'previewRadioChoice');
			document.getElementById("choiceText").value = "";
		};
	};
	
	function createChoicesDisplay(){
		for(x=0;x<choices.length;x++){
			createChoiceDisplay(x, choices[x], 'radioChoice');
			createChoiceDisplay(x, choices[x], 'previewRadioChoice');
		};
	};
	
	function createChoiceDisplay(index, item, name){
			var choicediv = createElement(document, 'div', {id: name + index});
			var choiceradio = createElement(document, 'input', {id: 'radio_' + index, type: 'radio', name: name, value: item});
			var choicetext;
			
			if(name=='radioChoice'){
				choicetext = document.createTextNode('Choice ' + (index + 1) + ': ' + item);
				var choicelink = createElement(document, 'a', {href: '#createChoices', onclick: 'removeChoice(' + index + ')'});
				var linktext = document.createTextNode(' remove');
			} else {
				choicetext = document.createTextNode(item);
			};
			
			choicediv.appendChild(choiceradio);
			choicediv.appendChild(choicetext);
			
			if(name=='radioChoice'){
				choicediv.appendChild(choicelink);
				choicelink.appendChild(linktext);
			};
			
			document.getElementById(name + "List").appendChild(choicediv);	
	};
	
	function removePreviousChoices(){
		var parent = document.getElementById('createChoices');
		parent.removeChild(document.getElementById('radioChoiceList'));
		parent.appendChild(createElement(document, 'div', {id: 'radioChoiceList'}));
		
		var parentDisplay = document.getElementById('previewChoices');
		parentDisplay.removeChild(document.getElementById('previewRadioChoiceList'));
		parentDisplay.appendChild(createElement(document, 'div', {id: 'previewRadioChoiceList'}));
	};
	
	function removeChoice(i){
		populateChoices();
		choices.splice(i, 1);
		removePreviousChoices();
		createChoicesDisplay();
	};
	
	function populateChoices(){
		choices = [];
		var choiceOpts = document.getElementsByName('radioChoice');
		for(x=0;x<choiceOpts.length;x++){
			choices.push(choiceOpts[x].value);
		};	
	};
	
	function displayChoiceError(error){
		document.getElementById("error").innerHTML = "<font color='8B0000'>" + error + "</font>";
	};
	
	function displayFormError(error){
		document.getElementById("formError").innerHTML = "<font color='8B0000'>" + error + "</font>";
	};

	function getChoicesXML(){
		var xmlChoices;
		populateChoices();
		for(x=0;x<choices.length;x++){
			if(x==0){
				xmlChoices = "<simpleChoice identifier=\"choice" + (x + 1) + "\">" + choices[x] + "</simpleChoice>"
			} else {
				xmlChoices = xmlChoices + "<simpleChoice identifier=\"choice" + (x + 1) + "\">" + choices[x] + "</simpleChoice>"
			};
		};
		return xmlChoices;
	};
	
	function Validate(){
		document.getElementById('error').innerHTML = "";
		document.getElementById('formError').innerHTML = "";

		var radioChoices = document.forms[0].radioChoice;
		if(radioChoices==null){
			displayFormError("You must create at least one choice for your question.");
			return false;
		};
		
		var found = false;
		if(radioChoices.length!=null){
			for(x=0;x<radioChoices.length;x++){
				if(radioChoices[x].checked == true){
					found = true;
					document.forms[0].correctChoice.value = 'choice' + (x + 1);
				}
			};
			if(!found){
				if(!warn()){
					return false;
				};
			};
		} else {
			if(radioChoices.checked!=true){
				if(!warn()){
					return false;
				};
			};
		};

		var text = document.getElementById('promptTextArea').value
		if(text == "" || text == null){
			displayFormError("The question field cannot be left blank.");
			return false;
		};		
		document.forms[0].choices.value = getChoicesXML();
		return true;
	};
	
	function warn(){
		return confirm("No choice has been selected as the 'correct' choice. Do you wish to continue?");
	};
</script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body>

<div id="centeredDiv">

<%@ include file="../../teacher/headerteacher.jsp"%> 

<div id="navigationSubHeader2">Q&A Authoring<span id="navigationSubHeader1">Management: My Project Runs</span></div>


<c:if test="${brainstorm.run != null}">

<div id="authorQuote">You unlock this door with the key of imagination.  
Beyond it is another dimension - a dimension of sound, a dimension of sight, a dimension of mind. 
You're moving into a land of both shadow and substance, of things and ideas. You've just crossed over into...the Authoring Zone.</div>

<div>
	<table id="authorInfoTable">
	<tr>
		<th>Project Title</th>
		<td style="color:#3333FF;">[Need Project Title here]</td>
	</tr>
	<tr>
		<th>Project ID</th>
		<td style="color:#3333FF;">[Need Project ID here]</td>
	</tr>
	<tr>
		<th>Step Type</th>
		<td style="color:#3333FF;">[Need Step Type being authored here]</td>
	</tr>
	<tr>
		<th>Step Location</th>
		<td style="color:#3333FF;">[Need Activity/Step Location here. Ex: "Activity 1, Step 3"]</td>
	</tr>
	</table>
</div>

</c:if>

<form:form method="post" action="authorbrainstorm.html?brainstormId=${brainstorm.id}" commandName="brainstorm" onsubmit="return Validate()" id="brainstormform" autocomplete='off'>

<div class="authorSectionHeader">Gating Options for Q&amp;A Step</div>


	  <div class="authorSectionHeader2" style="color:#FF0000;" >Starting the Q&amp;A Discussion:</div>
	  
	  <!--  
	  
	  <div class="authorOptionsBlock" style="color:#FF0000;"  >	  
      	<b>Open:</b> the Q&amp;A discussion step is available at all times. <br/>
      	<b>Start Manually:</b> the Q&amp;A is activated manually by the teacher<br/>
      	<b>Start on Date:</b>  the Q&amp;A activates automatically on a date set by the teacher.<br/>
      </div>
      	-->
      
      <div class="authorSectionHeader2">Initial Student Response:</div>
      <div class="authorOptionsBlock" >
      	<form:radiobutton path="gated" value="true" /><b>Gated:</b> the student must submit a Response before seeing Responses from other students.<br/>
      	<form:radiobutton path="gated" value="false" /><b>Open:</b> the student can see Responses from other students immediately.<br/>
      </div>
      
<div class="authorSectionHeader">Display Options</div>
       <div class="authorSectionHeader2">When responses are submitted by students, how should they be labeled?</div>
       <div class="authorOptionsBlock">
      		<c:forEach items="${displayNameOptions}" var="displayNameOption">
      		<form:radiobutton path="displayNameOption" value="${displayNameOption}" />${displayNameOption}<br/>      
      		</c:forEach>
      </div>
   

<div class="authorSectionHeader">Grouping Options</div>

       <div style="color:#FF0000;" class="authorSectionHeader2">Select a choice:</div>
       
       <div style="color:#FF0000;" class="authorOptionsBlock" >
      		<b>One Group per period:</b> students in a class period participate in a single group discussion.<br/>
      		<b>Multiple Groups per period:</b> students in a class period work in smaller discussion groups.<br/>
      	</div>	
      		<div style="color:#FF0000;" id="subgroupSelectionBox">
      			<div style="margin:0px;font-size:.8em;font-weight:bold;">Number of groups in each class period: 
      					<span style="color:#3333FF;">
      					<select name="subgroups" id="subgroups" tabindex="1">
      					<option value="">select an option</option>
      					<option value="2">2 Groups per period</option>
      					<option value="3">3 Groups per period</option>
      					<option value="4">4 Groups per period</option>
      					<option value="5">5 Groups per period</option>
      					<option value="6">6 Groups per period</option>
      					<option value="7">7 Groups per period</option>
      					<option value="8">8 Groups per period</option>
      					</select>
      					</span>
      			</div>
      			<div style="color:#FF0000;" style="color:#3333FF;" class="authorOptionsBlock">
      			Need Table Here listing "Group 1" "Group 2" etc up to the number of selected groups.  <br/>
      			The Author should be able to customize these default group names if desired.</div>
      			
      			<div id="subgroupNotice1">
      				Note: as students register for the project run they will be randomly assigned to discussion groups.  
      				The classroom teacher can manually adjust these grouping assignments before (or during) the project run.
      			</div>
      		</div>

<div class="authorSectionHeader">Content for Q&amp;A Step</div>

  <div>
      <div class="authorSectionHeader2">Question</div>
      <div class="authorOptionsBlock">Type the question you want students to see in the box below.  Use HTML formatting to control the look and feel.</div>
      <div style="margin:0 0 0 25px;">
      	<form:textarea onkeyup="javascript:updatePromptPreview()" rows="10" cols="110" path="question.prompt" id="promptTextArea" ></form:textarea>
      	<form:errors path="question.prompt" />
      </div>
      <a name="createChoices"></a>
      <c:if test="${brainstorm.questiontype == 'SINGLE_CHOICE'}">
      	<form:hidden id="correctChoice" path="question.correctChoice"/>
      	<form:hidden id="choices" path="question.newChoices"/>
      	Edit choices here. If there is one that you wish to indicate as correct, make sure that you indicate it here.
      	<div id="createChoices">
    		<textarea rows="2" cols="50" id="choiceText"></textarea><input type="button" value="Add Choice" onclick="addChoice()"/>
	    	<div id="error"></div>
		    <div id="radioChoiceList">
		    	<c:set var="choiceCount" value="0"/>
		    	<c:forEach var="key" varStatus="choiceStatus" items="${keys}">
		    		<c:if test="${brainstorm.question.correctChoice==key}">
		    			<input type="radio" name="radioChoice" id="${key}" value="${choices[key]}" CHECKED>Choice ${choiceCount + 1}: ${choices[key]} </input><a href="#createChoices" onclick="removeChoice('${choiceCount}')">remove</a>
		    		</c:if>
		    		<c:if test="${brainstorm.question.correctChoice!=key}">
		    			<input type="radio" name="radioChoice" id="${key}" value="${choices[key]}">Choice ${choiceCount + 1}: ${choices[key]} </input><a href="#createChoices" onclick="removeChoice('${choiceCount}')">remove</a>
		    		</c:if>
					<br>
					<c:set var="choiceCount" value="${choiceCount + 1}"/>
				</c:forEach>
		    </div>
	    </div>
      </c:if>	
   </div>


<br/>
<!--  NOTE: don't make the below into anchor or button, as it forces a database query -->

    <div class="authorSectionHeader2">Question Preview </div>
    <div class="authorOptionsBlock">Your question will appear to students as follows:</div>
	<div id="promptPreview">${brainstorm.question.prompt}</div>
	<br>
	<div id="previewChoices">
		<div id="previewRadioChoiceList">
			<c:if test="${brainstorm.questiontype == 'SINGLE_CHOICE' }">
				<c:forEach var="key" varStatus="choiceStatus" items="${keys}">
					<input type="radio" name="previewRadioChoice" id="${key}"> ${choices[key]}<br>
				</c:forEach>
			</c:if>
		</div>
	</div>

	<br/>

	<div style="color:#FF0000;" class="authorSectionHeader2">Starter Question</div>
	<div style="color:#FF0000;" class="authorOptionsBlock2" style="font-size:.7em;">If you want to provide a Starter Sentence (a prompt) to the student type it below:</div>
	<div style="margin:0 0 0 25px;"><textarea rows="2" cols="110" ></textarea></div>
    
    <div style="color:#FF0000;" id="subgroupBox2">
    	<div><b>Starter Sentence Style:</b></div>
    	<div id="subgroupBox2bullets">
    		<b>Link:</b> A link called "Show me a Starter Sentence" is displayed to student.  When the link is clicked the starter sentence appears in the Response Field.<br/>
      		<b>Auto:</b> The starter sentence is automatically displayed in the Response Box (student can edit/overwrite this starter sentence).<br/>
    	</div>
    </div>
    
    <br/>
    <div style="color:#FF0000;" class="authorSectionHeader2">Response Box Size</div>
	<div style="color:#FF0000;" class="authorOptionsBlock">Size of student response box: 
      					<span style="color:#3333FF;">
      					<select name="responseboxsize" id="responseboxsize=" tabindex="1">
      					<option value="3">3 rows</option>
      					<option selected="selected" value="6">6 rows</option>
      					<option value="9">9 rows</option>
      					<option value="12">12 rows</option>
      					</select>
      					</span>
      </div>

	<br/>
	<div style="color:#FF0000;" class="authorSectionHeader2">Final Teacher Response</div>
	<div style="color:#FF0000;" class="authorOptionsBlock2">The teacher can post this pre-written final answer at the conclusion of the Q&amp;A discussion.</div>
	<table id="prewrittenResponsesTable">
		<tr>
			<td><div style="margin:0 0 0 25px;"><textarea rows="3" cols="90" ></textarea></div><td>
			<td>
				<ul>
					<li><a href="#">Insert an Image</a><li>
				</ul>
			</td>
		</tr>
	</table>
    
    <br/><br/>
  	<div class="authorSectionHeader2">Prepared Responses</div>
	<div class="authorOptionsBlock2">These responses will be posted automatically when the run is set up that contains this Q&A step.</div>

	<div id="samplediv">

	<c:choose>
	    <c:when test="${fn:length(brainstorm.preparedAnswers) == 0}">
	       You do not have any sample student responses.
	    </c:when>
	    <c:otherwise>
           <c:forEach items="${brainstorm.preparedAnswers}" var="preparedAnswer" varStatus="vS">
                <div id="${vS.index}">
                Prepared Response #${vS.index+1} <input type="button" onclick="javascript:deletepreparedanswer(${brainstorm.id}, ${preparedAnswer.id}, ${vS.index});" value="delete" /><br/>
				Name to display this post as:<br/>
				<form:input path="preparedAnswers[${vS.index}].displayname" /><br/>
				Post:<br/>
				<form:textarea path="preparedAnswers[${vS.index}].body" rows="5" cols="90" /><br/><br/>				
				</div>
           </c:forEach>
	    </c:otherwise>
	</c:choose>
	
	</div>
		
	<br/>
	<div class="authorOptionsBlock2">
	    <input type="button" onclick="javascript:showsamplediv(${brainstorm.id});" value="Create Another Sample Student Response" />
	</div>
	
	
<div id="responseButtons">
	<input type="submit" name="save" value="Save All Changes" />
	<input type="reset" onclick="javascript:alert('please manually close this window')" name="cancel" value="Close without Saving" />
</div>
<div id="formError"></div>

</div>    <!-- end of centered div-->


</form:form>

</body>
</html>