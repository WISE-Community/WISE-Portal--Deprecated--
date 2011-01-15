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
<script type="text/javascript" src="./javascript/tels/checkCompatibility.js" defer="defer"></script>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

<style type="text/css">
body{
text-align:left;
}
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

hr 
{
border:thin solid;
}

h3
{
margin-bottom:15px;
}

h4
{
margin-top:10px;
margin-bottom:10px;
}
</style>
</head>

<body onload='checkCompatibility(${specificRequirements})'>

<%@ include file="headermain_nousername.jsp"%>

<a href="#compatibility">Browser Compatibility Check</a><br/>
<a href="#firewall">Network Compatibility Check (Firewall/Proxy)</a><br/>
<a href="#browser">Browser Recommendation</a><br/>
<a href="#system">Computer System Requirements to run WISE4 projects</a><br/><br/>
	<div>
		<h3><a name="compatibility"></a>Browser Compatibility Check</h3>
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
		<hr/>			
		<h3 id='contentFilter'><a name="firewall"></a>Network Compatibility Check (Firewall/Proxy)</h3>
		<div>You should not be behind firewall/proxy if possible when running WISE projects.  Parts or all of the WISE may not load 
		     depending on your school's firewall settings. This section checks if you are
			 restricted from accessing certain resources on the WISE server. 
			 If you see any X's below, WISE may not function properly. Please talk to your server administrator.</div><br/>
		<div id='contentFilterMessageSwf'>
			<span>Can Retrieve Flash objects (.swf):</span><span id='contentFilterSwfRequirementSatisfied'>checking...</span><br/><br/>
			<span>Can Retrieve Java archives (.jar):</span><span id='contentFilterJarRequirementSatisfied'>checking...</span>
		</div>
		
	<br/>
	<hr/>	
	<h3><a name="browser"></a>Browser Recommendation</h3>
	<div>Use this section to choose which browser to use to run WISE</div>
	<table>
			<tr>
				<th>Browser,version,OS</th>
				<th>Known Issues</th>
				<th>Recommendation Level</th>
			</tr>
			<tr>
				<td>Firefox 3.5/3.6 on OSX and Windows</td>
				<td>none</td>
				<td>Strongly Recommended</td>
			</tr>
			<tr>
				<td>Chrome on OSX and OSX and Windows</td>
				<td>none</td>
				<td>Recommended</td>
			</tr>
			<tr>
				<td>Safari 4.0+ on OSX</td>
				<td>none</td>
				<td>Recommended</td>
			</tr>
			<tr>
				<td>IE 7,8 on Windows</td>
				<td>Drawing and MySystem steps do not work, some usability issues in student+teacher pages</td>
				<td>Least Recommended</td>
			</tr>
			<tr>
				<td colspan="3">Other browsers are not yet recommended</td>
			</tr>
	</table>


	<hr/>
		
	<h3><a name="system"></a>Computer System Requirements to run WISE4 projects</h3>
 
<h4>Fully supported configuration</h4> 
 
<table class='confluenceTable'><tbody> 
<tr> 
<td class='confluenceTd'>Operating system</td> 
<td class='confluenceTd'>OS X &gt;=10.5 or Windows XP/2k, Vista, 7</td> 
</tr> 
<tr> 
<td class='confluenceTd'>RAM</td> 
<td class='confluenceTd'>512MB or more</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Java</td> 
<td class='confluenceTd'>1.5.0 or later</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Flash</td> 
<td class='confluenceTd'>10.0 or later</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Firewall</td> 
<td class='confluenceTd'>no firewall</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Proxy</td> 
<td class='confluenceTd'>no proxy</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Execution</td> 
<td class='confluenceTd'>User have permissions to run (<a href="http://javatechniques.com/blog/launching-java-webstart-from-the-command-line" rel="nofollow">javaws</a>)</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Storage</td> 
<td class='confluenceTd'>Users can write to system disk</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Peristence</td> 
<td class='confluenceTd'>Writes to disk persist all week</td> 
</tr> 
</tbody></table> 
 
<h4>Partially supported configuration</h4> 
 
<table class='confluenceTable'><tbody> 
<tr> 
<td class='confluenceTd'>Operating system</td> 
<td class='confluenceTd'>OS X &gt;=10.4 or Windows XP,Vista, 7</td> 
</tr> 
<tr> 
<td class='confluenceTd'>RAM</td> 
<td class='confluenceTd'>256MB or more</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Java</td> 
<td class='confluenceTd'>1.5.0 or later</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Flash</td> 
<td class='confluenceTd'>10.0 or later</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Firewall</td> 
<td class='confluenceTd'>no firewall</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Proxy</td> 
<td class='confluenceTd'>some proxies okay</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Execution</td> 
<td class='confluenceTd'>User have permissions to run javaws</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Storage</td> 
<td class='confluenceTd'>Users can write to system disk</td> 
</tr> 
<tr> 
<td class='confluenceTd'>Peristence</td> 
<td class='confluenceTd'>without persistence, downloads take place each session</td> 
</tr> 
</tbody></table> 
 
<h4>Unsupported configuration</h4> 
 
<p>Any configuration that doesn't meet the criteria above.</p> 	

</div>   <!-- end of centered div-->
<br/>
<hr/>
<a href="pages/schoolIT.html">Resource for school technicians</a>
</body>
</html>


