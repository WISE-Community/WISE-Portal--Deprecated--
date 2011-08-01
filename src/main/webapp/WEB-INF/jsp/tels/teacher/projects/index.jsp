<%@ include file="../../include.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<title><spring:message code="teacher.pro.index.1"/></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

</head>

<body>

<%@ include file="../headerteacher.jsp"%>

<div id="page">
	<div class="pageContent">
		<div class="contentPanel">
			
			<div class="panelHeader"><spring:message code="teacher.pro.index.1"/></div>
			<div class="panelContent">
				
				<div class="sectionHead" style="padding-top:0;"><spring:message code="teacher.pro.index.2"/></div>
				<div class="sectionContent">
					<h5><a href="/webapp/teacher/projects/customized/index.html"><spring:message code="teacher.pro.index.8"/></a> - <spring:message code="teacher.pro.index.8A"/></h5>
					<h5><a href="/webapp/author/authorproject.html"><spring:message code="teacher.pro.index.9"/></a> - <spring:message code="teacher.pro.index.9A"/></h5>
					<h5><a href="/webapp/teacher/run/myprojectruns.html"><spring:message code="teacher.pro.index.7"/></a> - <spring:message code="teacher.pro.index.7A"/></h5>
				</div>
				
				<div class="sectionHead"><spring:message code="teacher.pro.index.3"/></div>
				<div class="sectionContent">
					<h5><a class="inactive"><spring:message code="teacher.pro.index.4"/></a> - <spring:message code="teacher.pro.index.4A"/></h5> <!-- href="/webapp/teacher/projects/library/index.html" -->
					<h5><a href="/webapp/teacher/projects/library/tels.html"><spring:message code="teacher.pro.index.5"/></a> - <spring:message code="teacher.pro.index.5A"/> <a href="http://telscenter.org" target="_blank"><spring:message code="teacher.pro.index.5B"/></a></h5>
					<h5><a class="inactive"><spring:message code="teacher.pro.index.6"/></a> - <spring:message code="teacher.pro.index.6A"/> <a href="http://telscenter.org/projects/visual" target="_blank"><spring:message code="teacher.pro.index.6B"/></a></h5> <!-- href="/webapp/teacher/projects/library/visual.html" -->
				</div>
				
				<div class="sectionContent" style="text-align:center; margin-top:1em;">
					<div class="ui-state-highlight ui-corner-all" style="margin:0 auto; display:inline-block;"> 
						<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
						<spring:message code="teacher.pro.index.10"/> &nbsp;<a href="languagetranslations.html"><spring:message code="teacher.pro.index.10A"/></a></p>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
</div>    <!--End of page-->

<%@ include file="../../footer.jsp"%>

</body>
</html>

