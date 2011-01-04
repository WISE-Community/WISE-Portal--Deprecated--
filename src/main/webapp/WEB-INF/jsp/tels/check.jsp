<%@ include file="include.jsp"%>

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
  
<title><spring:message code="checkcompatibility.title" /></title>

<script type="text/javascript" src="./javascript/tels/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="./javascript/tels/utils.js"></script>
<script type="text/javascript" src="./javascript/tels/general.js"></script>
<script type="text/javascript" src="./javascript/tels/browserdetect.js"></script>
<script type="text/javascript" src="./javascript/tels/deployJava.js"></script>
<script type="text/javascript" src="./javascript/tels/checkCompatibility.js"></script>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

<style type="text/css">
table
{
border-spacing:2px;
}
table, td, th
{
border:1px solid black;
}

td, th
{
padding:2px;
}
</style>
</head>

<body onload='checkCompatibility(${specificRequirements})'>

<div id="centeredDiv">

<%@ include file="headermain_nousername.jsp"%>

	<div align='center'>
		<h3>Browser Compatibility Check</h3>
		<table>
			<tr>
				<td>Resource</td>
				<td>Status</td>
				<td>Required Version</td>
				<td>Your Version</td>
				<td>Requirement Satisfied</td>
				<td>Additional Info</td>
			</tr>
			<noscript>
				<tr>
				<td>Javascript</td>
				<td>Required</td>
				<td>Enabled</td>
				<td>Disabled</td>
				<td><img src='./themes/tels/default/images/error_16.gif' /></td>
				<td><a href='https://www.google.com/support/adsense/bin/answer.py?answer=12654'>How to enable Javascript</a></td>
				</tr>
			</noscript>
			<tr>
				<td id='javascriptResource'></td>
				<td id='javascriptStatus'></td>
				<td id='javascriptRequiredVersion'></td>
				<td id='javascriptYourVersion'></td>
				<td id='javascriptRequirementSatisfied'></td>
				<td id='javascriptAdditionalInfo'></td>
			</tr>
			<tr>
				<td id='browserResource'></td>
				<td id='browserStatus'></td>
				<td id='browserRequiredVersion'></td>
				<td id='browserYourVersion'></td>
				<td id='browserRequirementSatisfied'></td>
				<td id='browserAdditionalInfo'></td>
			</tr>
			<tr>
				<td id='quickTimeResource'></td>
				<td id='quickTimeStatus'></td>
				<td id='quickTimeRequiredVersion'></td>
				<td id='quickTimeYourVersion'></td>
				<td id='quickTimeRequirementSatisfied'></td>
				<td id='quickTimeAdditionalInfo'></td>
			</tr>
			<tr>
				<td id='flashResource'></td>
				<td id='flashStatus'></td>
				<td id='flashRequiredVersion'></td>
				<td id='flashYourVersion'></td>
				<td id='flashRequirementSatisfied'></td>
				<td id='flashAdditionalInfo'></td>
			</tr>
			<tr>
				<td id='javaResource'></td>
				<td id='javaStatus'></td>
				<td id='javaRequiredVersion'></td>
				<td id='javaYourVersion'></td>
				<td id='javaRequirementSatisfied'></td>
				<td id='javaAdditionalInfo'></td>
			</tr>
		</table>
		<noscript><br><b>Browser Compatibility Check Result: You can not run Wise 4</b><br><br><p class='checkCompatibilityWarning'>Warning: you must enable Javascript in order to run Wise 4, please click the "How to enable Javascript" link to find out how to enable Javascript.</p></noscript>
		<div id='compatibilityCheckResult'></div>
		<div id='compatibilityCheckMessages'></div>
		<br/>
		<h3 id='contentFilter'>Network Compatibility Check (Firewall/Proxy)</h3>
		<div>You should not be behind firewall/proxy if possible when running WISE projects.  Parts or all of the WISE may not load 
		     depending on your school's firewall settings. This section checks if you are
			 restricted from accessing certain resources on the WISE server. 
			 If you see any X's below, WISE may not function properly. Please talk to your server administrator.</div><br/>
		<div id='contentFilterMessageSwf'>
			<span>Can Retrieve Flash objects (.swf):</span><span id='contentFilterSwfRequirementSatisfied'>checking...</span><br/><br/>
			<span>Can Retrieve Java archives (.jar):</span><span id='contentFilterJarRequirementSatisfied'>checking...</span>
		</div>
	</div>

</div>   <!-- end of centered div-->

</body>
</html>


