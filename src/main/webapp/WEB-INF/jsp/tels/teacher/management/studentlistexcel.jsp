<%-- Set the content type header with the JSP directive --%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="include.jsp"%>
                                                                                                                   
<%-- Set the content disposition header --%>

<% response.setHeader("Content-Disposition", "attachment; filename=WISE4-student-list.xls"); %>



<table>
	<tr>
		<th>WISE Period Name</th>
		<th>WISE Group ID</th>
		<th>WISE Student ID</th>
		<th>Student Username</th>		
		<th>Student Name</th>
	</tr>
	
	<c:forEach var="viewmystudentsperiod" varStatus="periodStatus" items="${viewmystudentsallperiods}">
	<c:choose>
		<c:when test="${fn:length(viewmystudentsperiod.period.members) == 0}">
		</c:when>
		<c:otherwise>
            <c:forEach var="mem" items="${viewmystudentsperiod.grouplessStudents}">
			         <tr><td>${mem.id}</td><td>${mem.sdsUser.sdsObjectId}</td><td>N/A</td><td>N/A</td><td>${mem.userDetails.firstname} ${mem.userDetails.lastname}</td><td>${mem.userDetails.username}</td></tr>
	        </c:forEach>
            <c:forEach var="workgroupInPeriod" varStatus="workgroupVarStatus" items="${viewmystudentsperiod.workgroups}" >
			      <c:forEach var="workgroupMember" items="${workgroupInPeriod.members}">
			      
			        <li class="workgrouplist" id="li_${workgroupMember.id}_${workgroupInPeriod.id}">
			        <tr><td>${workgroupInPeriod.period.name}</td><td>${workgroupInPeriod.id}</td><td>${workgroupMember.id}</td><td>${workgroupMember.userDetails.username}</td><td>${workgroupMember.userDetails.firstname} ${workgroupMember.userDetails.lastname}</td></tr>
			      </c:forEach>
            </c:forEach>
		</c:otherwise>
	</c:choose>
    </c:forEach>
</table>