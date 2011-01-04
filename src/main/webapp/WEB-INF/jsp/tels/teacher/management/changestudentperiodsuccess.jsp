<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"
    type="text/css" />
    
<title><spring:message code="application.title" /></title>
<script type='text/javascript'>
function refreshParent(){
	if(window.opener){
		window.opener.location.reload();
		self.close();
	};
};
</script>

</head>

<body onload='refreshParent()'>

<div style="text-align:center;">   <!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<h2><spring:message code="teacher.manage.changeperiod.6"/></h2>

<div><a href="#" onclick="javascript:window.close()"><spring:message code="teacher.manage.changeworkgroup.5"/></div>

</div>

</body>
</html>