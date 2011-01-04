<%@ include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html lang="en">
<title>Progress Monitor Meanings</title>
<head>
<%@ include file="../grading/styles.jsp"%>
</head>
<body>
<div align="left">
	<h2>Progress Monitor Meanings</h2>
	<a name="currentlocation"></a>
		<h3>Current Location</h3>
		<p>The current location displays the last Activity number and Step number - e.g. A4, Step 7 - 
		that this team has completed work for. There is a percentage number of total
		steps that this team has completed as well as a visual representation of this percentage.</p>
		<input type="button" value="Close" onclick="self.close()"/>
	<a name="flaggeditems"></a>
		<h3>Flagged Items</h3>
		<p>Flagged Items contains a variety of items that a teacher may want to take a closer at,
		including: skipped steps, skipped activities, and scant responses to 
		the questions.</p>
		<h4>Skipped Steps</h4>
		<p>Skipped Steps indicate the Activity number and Step number - e.g. A1, Step 3 (skipped) - of steps that
		teams have not completed though they have completed later steps.</p>
		<h4>Skipped Activities</h4>
		<p>Skipped activities are indicated by Activity number - e.g. A3 (all skipped) - when no steps for that activity
		have been completed though steps for later activities have been completed.</p>
		<h4>Scant Responses</h4>
		<p>Scant responses include Activity number and Step number - e.g. A7, Step 3 (scant) - and are flagged 
		because the team's response to the activity may be a bit short given the difficulty of the 
		activity</p>
		<input type="button" value="Close" onclick="self.close()"/>
	<a name="rawscore"></a>
		<h3>Raw Score</h3>
		<p>Raw score shows a percentage and a ratio of total score received so far for
		all work graded so far over total possible points for this run.</p>
		<input type="button" value="Close" onclick="self.close()"/>
	<a name="teachergraded"></a>
		<h3>Teacher-graded Score</h3>
		<p>Teacher-graded score indicates a percentage and a ratio of total points awarded
		by the teacher so far over total points possible of the steps that the teacher
		has graded.</p>
		<input type="button" value="Close" onclick="self.close()"/>
	<a name="autograded"></a>
		<h3>Auto-graded Score</h3>
		<p>Auto-graded score displays a percentage and a ratio of total points awarded so far by
		the auto-grading system over the total points possible for the activities that have been
		graded. <b>Note:</b> this has <i>not</i> yet been implemented and is not reflected in any
		of the scoring.</p>
		<input type="button" value="Close" onclick="self.close()"/>
</div>
</body>
</html>