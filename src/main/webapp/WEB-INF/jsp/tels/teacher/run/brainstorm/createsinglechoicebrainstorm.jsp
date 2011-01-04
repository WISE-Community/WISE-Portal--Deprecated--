<%@ include file="../../../include.jsp"%>
<html>
<head>
<title>Create Mulitiple Choice/Single Response Brainstorm</title>

<script type="text/javascript">

	var choices = [];
	
	function addChoice(){
		var text = document.getElementById("choiceText").value;
		if(text=="" || text==null){
			displayChoiceError("The choice field cannot be blank.");
		} else {
			document.getElementById("error").innerHTML = "";
			var index = document.getElementsByName('radioChoice').length;
			createChoiceDisplay(index, text, 'radioChoice');
			document.getElementById("choiceText").value = "";
		};
	};
	
	function createChoicesDisplay(){
		for(x=0;x<choices.length;x++){
			createChoiceDisplay(x, choices[x], 'radioChoice');
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

		var text = document.getElementById('question').value
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
	
	function getChoicesXML(){
		var xmlChoices;
		populateChoices();
		for(x=0;x<choices.length;x++){
			if(x==0){
				xmlChoices = "<simpleChoice identifier=\"choice" + (x + 1) + "\">" + choices[x] + "</simpleChoice>";
			} else {
				xmlChoices = xmlChoices + "<simpleChoice identifier=\"choice" + (x + 1) + "\">" + choices[x] + "</simpleChoice>";
			};
		};
		return xmlChoices;
	};
</script>
</head>
<body>
Create Multiple Choice/Single Response Brainstorm
<br>
<form:form method="post" action="createsinglechoicebrainstorm.html" commandName="createSingleChoiceBrainstormParameters" onsubmit="return Validate()" id="createbrainstormForm" autocomplete='off'>

	<br>
    Options for Students:
    <br>

    Text Editor
   	<br>

	<form:radiobutton path="richTextEditorAllowed" value="true" />Students are allowed to use a Rich Text Editor.<br/>
    <form:radiobutton path="richTextEditorAllowed" value="false" />Students are NOT allowed to use a Rich Text Editor.<br/>
    <br>

	Gating Options:
	<br>
	<div id="gatingOptions">
		<form:radiobutton path="gated" value="true" /><b>Gated:</b> the student must submit a Response before seeing Responses from other students.<br/>
    	<form:radiobutton path="gated" value="false" /><b>Open:</b> the student can see Responses from other students immediately.<br/>
    </div>
    <br>
    
    Display Name Options:
    <br>
    <div id="displayNameOptions">
    	<c:forEach items="${displayNameOptions}" var="displayNameOption">
      		<form:radiobutton path="displayNameOption" value="${displayNameOption}" />${displayNameOption}<br/>      
      	</c:forEach>
    </div>
    <br>
    Question:
    <br>
    Enter the question here.
    <br>
    <form:textarea path="question" id="question"/>
    <br>
    
    <form:hidden id="choices" path="choices"/>
    <form:hidden id="correctChoice" path="correctChoice"/>
	Enter the Choices here. If there is a correct choice, make sure that you indicate it.
    <div id="createChoices">
    	<textarea rows="2" cols="50" id="choiceText"></textarea><input type="button" value="Add Choice" onclick="addChoice()"/>
	    <div id="error"></div>
	    <div id="radioChoiceList"></div>
    </div>
  
    
    <input type="submit" name="save" value="Create Brainstorm" />
    <div id="formError"></div>
</form:form>
</body>
</html>