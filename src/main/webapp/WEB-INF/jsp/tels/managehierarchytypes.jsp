<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html lang="en">
<head>

<script type="text/javascript" src="./javascript/tels/hierarchy.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="./javascript/tels/yui/connection/connection.js"></script>

<script>
	var nodedataManager = new NodedataManager('${xmlNodedata}');
</script>
</head>
<body>

<div>
<h3>Create/Edit Hierarchy Types</h3>

Select the type below. Click on an item in the box to the right to edit, or type in the field to create a new object of the type selected.<br>
All Teachers and Students will automatically show up when creating hierarchies, so will not show up here.<br>

<select id='selectType' name='selectType' onchange='javascript:newOption()'>
	<option id='none' value='null'></option>
	<option id='district' value='district'>District</option>
	<option id='school' value='school'>School</option>
	<option id='period' value='period'>Period</option>
</select>
<br>

<div id='textInput' name='textInput'>
	<input type="text" id="text"/>
</div>
<div id='buttons'>
	<input type="button" value="create/save" onclick="javascript:submit()"/>
	<input type="button" value="clear" onclick="javascript:clearAll()"/>
</div>
<br>
<div id='typeList' name='typeList'>
<div id='list'></div>
</div>
<br>
<div id="error"></div>


</div>
</body>
</html>