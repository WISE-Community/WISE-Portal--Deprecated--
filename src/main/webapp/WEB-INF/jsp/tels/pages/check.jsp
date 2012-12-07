<%@ include file="../include.jsp"%>

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="utilssource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="browserdetectsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="checkcompatibilitysource"/>"></script>
<script type="text/javascript" src="./javascript/tels/deployJava.js"></script>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  
<title><spring:message code="checkcompatibility.title" /></title>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

</head>

<body onload='checkCompatibility(${specificRequirements})'>

<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">WISE4 System Check</div>
				<div class="panelContent">

					<div class="sectionHead" style="padding-top:0;">Browser Compatibility Check</div>
					<div class="sectionContent"> 
						<div><table>
							<tr>
								<th>Resource</th>
								<th>Status</th>
								<th>Required Version</th>
								<th>Your Version</th>
								<th>Requirement Satisfied</th>
								<th>Additional Info</th>
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
						</table></div>
						<noscript>
						<div>Browser Compatibility Check Result: You can not run WISE4</div>
						<div class='checkCompatibilityWarning'>Warning: you must enable Javascript in order to run Wise 4, please click the "How to enable Javascript" link to find out how to enable Javascript.</div></noscript>
						<div id='compatibilityCheckResult' style="font-weight:bold;"></div>
						<div id='compatibilityCheckMessages'></div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">Network Compatibility Check (Firewall/Proxy)</div>
					<div class="sectionContent"> 
						<div>You should not be behind firewall/proxy if possible when running WISE projects.  Parts or all of the WISE may not load 
		     depending on your school's firewall settings. This section checks if you are
			 restricted from accessing certain resources on the WISE server. 
			 If you see any X's below, WISE may not function properly. Please talk to your school technician.</div>
						<div id='contentFilterMessageSwf'>
							<span>Can Retrieve Flash objects (.swf):</span><span id='contentFilterSwfRequirementSatisfied'>checking...</span><br/><br/>
							<span>Can Retrieve Java archives (.jar):</span><span id='contentFilterJarRequirementSatisfied'>checking...</span>
						</div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">Browser Recommendation</div>
					<div class="sectionContent"> 
						<div>Use this section to choose which browser to use to run WISE.</div>
						<div><table>
							<tr>
								<th>Browser, Version, Operating System</th>
								<th>Known Issues</th>
								<th>Recommendation Level</th>
							</tr>
							<tr>
								<td>Firefox 3.5/3.6 or higher on OSX and Windows</td>
								<td>none</td>
								<td>Strongly Recommended</td>
							</tr>
							<tr>
								<td>Chrome 10 or higher on OSX and Windows</td>
								<td>none</td>
								<td>Recommended</td>
							</tr>
							<tr>
								<td>Safari 4.0 or higher on OSX</td>
								<td>none</td>
								<td>Recommended</td>
							</tr>
							<tr>
								<td>IE 7,8,9 on Windows</td>
								<td>Drawing and MySystem steps do not work, some usability issues in student+teacher pages</td>
								<td>Least Recommended</td>
							</tr>
							<tr>
								<td colspan="3">Other browsers are not yet recommended</td>
							</tr>
						</table></div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">Computer System Requirements</div>
					<div class="sectionContent"> 
						<div>Fully supported configuration:</div>
						<div>
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
								<td class='confluenceTd'>1.6.0 or later</td> 
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
								</tbody>
							</table>
						</div>
						<div style="margin-top:1em;">Partially supported configuration:</div>
						<div>
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
						</div>
						<div style="margin-top:1em;"><a href="./schoolIT.html">Resource for school technicians</a></div>
					</div>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->
	
	<%@ include file="../footer.jsp"%>
</div>

</body>
</html>


