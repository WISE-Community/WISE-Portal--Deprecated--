<%@ include file="../../../include.jsp"%>
<html>
<head>
<title>Create Open Response Brainstorm</title>
</head>
<body>
Create Open Response Brainstorm
<br>
<form:form method="post" action="createopenresponsebrainstorm.html" commandName="createOpenResponseBrainstormParameters" id="createbrainstormForm" autocomplete='off'>

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
    
    <input type="submit" name="save" value="Create Brainstorm" />
</form:form>
</body>
</html>