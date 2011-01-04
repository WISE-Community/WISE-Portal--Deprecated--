<%@ include file="./include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script src="../javascript/tels/general.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/prototype.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/effects.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/scriptaculous.js" 		type="text/javascript"> </script>
<script src="../javascript/tels/rotator.js" 			type="text/javascript"> </script>
<script src="../javascript/tels/rotatorT.js" 			type="text/javascript"> </script>

    
<title><spring:message code="application.title" /></title>

<script type="text/javascript" src="./javascript/pas/utils.js"></script> 
<script type="text/javascript" src="./javascript/tels/general.js"></script>

<script type='text/javascript' src='/webapp/dwr/interface/ChangePasswordParametersValidatorJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
</head>

<body>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="centeredDiv">

	<%@ include file="headermain_nousername.jsp"%>
		 
	<div id="archiveHeader">News Archives</div>
	
	<c:choose>
		<c:when test="${fn:length(all_news) > 0}">
			
			<table id="newsArchivePage">
				<tr>
					<th>Title</th>
					<th>Date</th>
					<th>News</th>
				</tr>
			
			<c:forEach var="news" items="${all_news}">
				<tr>
					<td class="col1">${news.title}</td>
					<td class="col2"><fmt:formatDate value="${news.date}" type="both" dateStyle="short" timeStyle="short" /></td>
					<td class="col3">${news.news}</td>
				</tr>
			</c:forEach>   
			</table>
		
		</c:when>
		<c:otherwise>
			<h5>No News Items found</h5>
		</c:otherwise>
	</c:choose>
	
	<br/>
	
	<div style="text-align:center;"><a href="index.html"> <img id="return"
	src="<spring:theme code="return_to_homepage" />"
	onmouseover="swapImage('return', '<spring:theme code="return_to_homepage_roll" />');"
	onmouseout="swapImage('return', '<spring:theme code="return_to_homepage" />');" /></a></div>
	
</div>

</body>
</html>


