<%@ include file="include.jsp"%>

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

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body class="yui-skin-sam">
<div id="wait"></div> 

<script type="text/javascript">

	function topiframeOnLoad() {
		var getGradingConfigUrl = "${getGradingConfigUrl}";
		window.frames["topifrm"].load(getGradingConfigUrl);
	}
	
</script>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Grade Student Work<span id="navigationSubHeader1">grading</span></div> 

<div id="gradeStepSelectionArea">

<!--  BEGIN: for projects that have curnitmap -->
<c:if test="${fn:length(curnitMap) > 0}">
<div>
		<table id="selectedProjectTable">
				<tr>
						<td class="header1">Project Run:</td>
						<td class="header2"><div id="selectAnotherLink"><a href="projectPickerGrading.html?gradeByType=step">Change Run</a></div></td>
						<td><div id="gradeStepSelectedProject"><c:out value="${run.name}" default="Name of Selected Project Goes Here"></c:out>
							<span class="runIdtag">(Project Run ID: ${runId})</span></div></td>
				</tr>
		</table>


</div>
</c:if>
<!--  END: for projects that have curnitmap -->

<!--  BEGIN: for LD-inspired Projects that don't have curnitmap -->
<c:if test="${fn:length(getGradeByStepUrl) > 0}">
		<div>
		
		<table id="selectedProjectTable">
				<tr>
						<td><div id="gradeStepSelectedProject"><c:out value="${run.name}" default="Name of Selected Project Goes Here"></c:out>
								<span class="runIdtag">(Project Run ID: ${runId})</span></div></td>
						<td class="header2"><div id="selectAnotherLink"><a href="projectPickerGrading.html?gradeByType=step">Select Another Run</a></div></td>
				</tr>
		</table>

				<iframe id="topifrm" src="${getGradeByStepUrl}?loadScriptsIndividually" name="topifrm" scrolling="auto" width="100%"
				height="100%" frameborder="0">Sorry, you cannot view this web page because your browser doesn't support iframes.</iframe>

		</div>
</c:if>

<!--  END: for LD-inspired Projects that don't have curnitmap -->


<div>      <!--End of gradeStepSelectionArea -->

</div>      <!--End of Centered Div-->

</div>
</div>
</body>

</html>
