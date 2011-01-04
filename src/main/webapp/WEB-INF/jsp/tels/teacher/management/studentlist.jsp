<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="teachermanagementstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="viewmystudentsstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /><link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

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

<%@ include file="../headerteacher.jsp"%>

<div id="L3Label"><spring:message code="teacher.manage.viewstudents.21"/></div> 

<table id="projectTitleBox" border=0>
	<tr>
		<th>${run.name}</th>
		<td>(Project ID: ${project_id})</td>
	</tr>
</table>

<div id="studentPrintableListBox">

	<c:forEach var="period" varStatus="periodStatus" items="${periods}">
	  <div id="studentListPeriod">Period: ${period.name}</div>
		  <ul id="studentListNames">  
		    <c:forEach var="student" varStatus="studentStatus" items="${period.members}">
		      <li>
		        ${student.userDetails.firstname} ${student.userDetails.lastname}        
		      </li>
		    </c:forEach>      
		  </ul>
		</c:forEach>
</div>

<div id="returnToTopLink"><a href="projectPickerManagement.html">Return to <em>Management/Student Progress</em></a></div>

</div>

</body>

</html>