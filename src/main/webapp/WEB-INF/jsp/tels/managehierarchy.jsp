<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html lang="en">
<head>

<script type="text/javascript" src="./javascript/tels/hierarchy.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/connection/connection.js"></script>

<script>
	var nodeManager = new NodeManager('${xmlNodes}', '${users}');
	var nodedataManager = new NodedataManager('${xmlNodedata}');
</script>
</head>
<body onload='nodeManager.createTopLevel()'>
<div>
<h3>Manage Hierarchy</h3>

Select an already created hierarchy as listed below or choose 'create new' to create a new hierarchy.
<input type="button" value="Create New Hierarchy" onclick="javascript:nodeManager.createNew()"/>
<table id="selectTable"></table>

</div>
</body>
</html>