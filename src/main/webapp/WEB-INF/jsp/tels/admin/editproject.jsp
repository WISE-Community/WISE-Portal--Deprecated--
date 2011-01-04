<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />


    
<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/effects.js"></script>
<script type="text/javascript" src=".././javascript/tels/general.js"></script>
    
<title>Edit Project Page</title>

<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
</head>
<body>
<%@ include file="adminheader.jsp"%>


<form:form method="post" action="editproject.html?projectId=${project.id}" 
	commandName="project" id="editproject" autocomplete='off'>
    <br/><br/>
	<b>Projecd Id:</b><form:label path="id"></form:label> ${project.id}<br/><br/>
	<label for="nameLabel">Project Name:</label><br/>
	<form:input path="name" id="name" size="50" maxlength="75"/>
    <br/><br/>
	<label for="iscurrentlabel">Is this project current or not current? (Current projects are eligible for creating new classroom runs)</label><br/>
    <form:select path="current" id="currentselect">           	
            <form:option value="true">current</form:option>
            <form:option value="false">not current</form:option>
    </form:select>
    <br/><br/>

	<label for="familytaglabel">Familytag (what type of project is this?)</label><br/>
	    <form:select path="familytag" id="familytagselect">           
    		<c:forEach items="${familytags}" var="familytag">
            <form:option value="${familytag}">${familytag}</form:option>
          </c:forEach>
        </form:select>
    <br/><br/>

	<label for="authorlabel">Author</label><br/>
	<form:input path="projectInfo.author" id="author" size="25" maxlength="25"/>
    <br/><br/>

	<label for="gradelevellabel">Grade level</label><br/>
	<form:input path="projectInfo.gradeLevel" id="gradeLevel" size="25" maxlength="25"/>
    <br/><br/>

	<label for="subjectlabel">Subject</label><br/>
	<form:input path="projectInfo.subject" id="subject" size="25" maxlength="25"/>
    <br/><br/>

	<label for="keywordlabel">Keywords</label><br/>
	<form:input path="projectInfo.keywords" id="keywords" size="25"/>
    <br/><br/>

	<label for="projectlifecyclelabel">Project Life Cycle</label><br/>
	<form:input path="projectInfo.projectLiveCycle" id="projectLiveCycle" size="25" maxlength="25"/>
    <br/><br/>

	<label for="commentlabel">Description (Project Description)</label><br/>
	<form:input path="projectInfo.description" id="description" size="50"/>
    <br/><br/>

	<label for="commentlabel">Comments (technical comments, will not be shown to public)</label><br/>
	<form:input path="projectInfo.comment" id="comment" size="50"/>
    <br/><br/>
    
    <input type="submit" value="Submit" />
    <a href="manageallprojects.html"><input type="button" value="Cancel"></input></a>
</form:form>
    <p>Note: If the project is current and is a TELS project, it will show up in the Instant Preview page and the
       Project Library page. Otherwise, it will not show up in either of those pages. This might change at a later time as more types of projects are defined in the portal.</p>


</body>
</html>