<%@ include file="include.jsp"%>
<!-- 
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />  
<!--  
<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../.././javascript/tels/prototype.js"></script>
<script type="text/javascript" src="../.././javascript/tels/effects.js"></script>
-->

<link href="../../<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
.yui-skin-sam {	margin:0px;}
</style>
</head>

<body class="yui-skin-sam">
<div id="wait"></div> 

<script type="text/javascript">

	function topiframeOnLoad() {
	//var xmlString = "${xmlString}";
	var runId = "${runId}";
	var workgroupId = "${workgroup.id}";
	var contentUrl = "${contentUrl}";
	var userInfoUrl = "${userInfoUrl}";
	var getDataUrl = "${getDataUrl}";
	var contentBaseUrl = "${contentBaseUrl}";
	var getAnnotationsUrl = "${getAnnotationsUrl}";
	var postAnnotationsUrl = "${postAnnotationsUrl}";

	var getFlagsUrl = "${getFlagsUrl}";
	var postFlagsUrl = "${postFlagsUrl}";

	var projectName = "${projectName}";
	
	//alert(userInfoUrl);
	//var userInfoUrl = "http://localhost:8080/webapp/student/vle/studentdata.html?runId=${runId}&getUserInfo=true";
	//var userInfoUrl = "vle.html?runId=${runId}&getUserInfo=true";
	//window.frames["topifrm"].loadFromString(xmlString, runId, workgroupId);
	window.frames["topifrm"].load(contentUrl, userInfoUrl, getDataUrl, contentBaseUrl, getAnnotationsUrl, postAnnotationsUrl, runId, getFlagsUrl, postFlagsUrl, projectName);
}
	
	function foo() {
		//alert('foo!');
	}
	function foo2() {
		//alert('foo222!');
	}		
</script>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="gradeStepSelectionArea">

<!--  BEGIN: for projects that have curnitmap -->
<c:if test="${fn:length(curnitMap) > 0}">
<div>
		<table id="selectedProjectTable">
				<tr>
						<td class="header1">Project Run:</td>
						<td class="header2"><div id="selectAnotherLink"><a href="projectPickerGrading.html?gradeByType=step">Change Run</a></div></td>
						<td><div id="gradeStepSelectedProject"><c:out value="${run.name}" default="Name of Selected Project Goes Here  (ID xxxxx)"></c:out></div></td>
				</tr>
		</table>


</div>
</c:if>
<!--  END: for projects that have curnitmap -->

<!--  BEGIN: for LD-inspired Projects that don't have curnitmap -->
<c:if test="${fn:length(gradeByStepUrl) > 0}">
		<div>
		
		<table id="selectedProjectTable">
				<tr>
						<td><div id="gradeStepSelectedProject"><c:out value="${run.name}" default="Name of Selected Project Goes Here  (ID xxxxx)"></c:out></div></td>
						<td class="header2"><div id="selectAnotherLink"><a href="projectPickerGrading.html?gradeByType=step">Select Another Run</a></div></td>
				</tr>
		</table>

				<iframe id="topifrm" src="${gradeByStepUrl}?loadScriptsIndividually" onload="topiframeOnLoad();" name="topifrm" scrolling="auto" width="100%"
				height="10000px" frameborder="0">Sorry, you cannot view this web page because your browser doesn't support iframes.</iframe>

		<h3 style="display:none;">gradebystepurl: ${gradeByStepUrl}</h3>
		<h3 style="display:none;">contentUrl: ${contentUrl}</h3>
		</div>
</c:if>

<!--  END: for LD-inspired Projects that don't have curnitmap -->


<div>      <!--End of gradeStepSelectionArea -->

</div>      <!--End of Centered Div-->

</div>
</div>
</body>

</html>
