<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<%@ include file="adminhead.jsp" %>

</head>
<body>
<%@ include file="adminheader.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="centeredDiv">


scenarios
${TULL}
<br/>
<table width="100%">
<tr>
<td>${MODEL.name}</td><td>ID: ${MODEL.id}</td>
</table>
number of scenarios: ${fn:length(SCENARIOS)}
<table>
<c:forEach var="scen" items="${SCENARIOS}">
				<tr>
					<td>${scen.name} </td>
				</tr>
			</c:forEach>
			</table>




</div>
</body>