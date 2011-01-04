<%@ include file="./include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
    
<script type="text/javascript" src=".././javascript/tels/general.js"></script>    
</head>
<body>
<div>
	<div>
		<h3>
			<c:if test="${preview=='true'}">
				Preview
			</c:if>
			${run.name}<br>
			Workgroup Id: ${workgroup.id}
		</h3>
	</div>
	<div>
		${elo.xml}<br>
		${elo.content.xml}
	</div>
</div>
</body>
</html>