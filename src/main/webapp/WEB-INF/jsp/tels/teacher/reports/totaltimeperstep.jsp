<%@ include file="../../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
<title>Total time spent per step graph</title>
<head></head>

<body>

<c:choose>
	<c:when test="${fn:length(workgroups)>1}">
		Average time (in minutes) spent per step for the students:
	</c:when>
	<c:otherwise>
		Total time (in minutes) spent per step for Team with members:
	</c:otherwise>
</c:choose>
<c:forEach var="workgroup" varStatus="workgroupStatus" items="${workgroups}">
	<c:forEach var="student" varStatus="studentStatus" items="${workgroup.members}">
		${student.userDetails.firstname} ${student.userDetails.lastname}
		<c:if test="${studentStatus.last=='false'}"> & </c:if>
	</c:forEach>
	<c:if test="${workgroupStatus.last=='false'}"> & </c:if>
</c:forEach>

<br><br>
<img src="${url}"/>

</body>
</html>