<%@ include file="./include.jsp"%>
<html>
<head>
<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title><spring:message code="gettingstarted.teacher-information-sheet" /></title>
</head>

<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader"><spring:message code="gettingstarted.teacher-information-sheet" /> <span style="float:right;"><a class="printLesson" onClick="window.print();return false"><spring:message code="print" /></a></span></div>
				<div class="panelContent">

					<div class="sectionHead" style="padding-top:0;"><spring:message code="gettingstarted.technical-requirements" /></div>
					<div class="sectionContent"> 
						<ol>
							<li><spring:message code="gettingstarted.internet-connection" /></li>
							<li><spring:message code="gettingstarted.updated-browser" />: <a href="http://www.firefox.com/" target="_blank">http://www.firefox.com/</a> 
								or Chrome: <a href="http://www.google.com/chrome/" target="_blank">http://www.google.com/chrome/</a></li>
							<li><spring:message code="gettingstarted.updated-adobe" />: <a href="http://get.adobe.com/flashplayer/" target="_blank">http://get.adobe.com/flashplayer/</a></li>
							<li><spring:message code="gettingstarted.updated-java" />: <a href="http://java.sun.com/getjava/download.html" target="_blank">http://java.sun.com/getjava/download.html</a></li>
							<li><spring:message code="gettingstarted.click-link-compatibility" />: <a href="/webapp/check.html" target="_blank"><spring:message code="gettingstarted.compatibility-test" /> </a></li>
						</ol>
					</div>
					
					<div class="sectionHead" style="padding-top:0;"><spring:message code="gettingstarted.registration" /></div>
					<div class="sectionContent">
						<ol>
							
							<li><spring:message code="gettingstarted.select-create-new" /> <a href="/webapp/signup.html">Sign Up</a></li>
							
							<li><spring:message code="gettingstarted.select-teacher-account" /></li>
							
							<li><spring:message code="gettingstarted.fill-in-form" /></li>
							
							<li><spring:message code="gettingstarted.username-note" /></li>
						
						</ol>
					</div>
					
					<div class="sectionHead"><spring:message code="gettingstarted.set-up-new-run" /></div>
					<div class="sectionContent">
						<ol>
							<li><a href="/webapp/login.html"><spring:message code="gettingstarted.log-in-new-account" /> </a> <spring:message code="gettingstarted.log-in-new-account2" /></li>
							
							<li><spring:message code="gettingstarted.select-browse-project" /> <a href="/webapp/teacher/management/library.html"><spring:message code="gettingstarted.select-browse-project2" /></a></li>
							
							<li><spring:message code="gettingstarted.select-preview" /></li>
							
							<li><spring:message code="gettingstarted.set-up-run-next" /></li>
							
							<li><spring:message code="gettingstarted.archive-projects-next" /></li>
							
							<li><spring:message code="gettingstarted.select-period-next" /></li>
							
							<li><spring:message code="gettingstarted.configure-run" /></li>
							
							<li><spring:message code="gettingstarted.recommend-preview" /></li>
							
							<li><spring:message code="gettingstarted.new-run-created" /> <a href="/webapp/teacher/management/classroomruns.html"><spring:message code="gettingstarted.new-run-created2" /></a></li>
							
							<li><spring:message code="gettingstarted.note-access-code" /></li>
						
						</ol>
					</div>

					<div class="sectionHead"><spring:message code="gettingstarted.set-up-test-student" /></div>
					<div class="sectionContent">
						<ol>
							<li><spring:message code="gettingstarted.recommend-test-student" /></li>
							
							<li><spring:message code="gettingstarted.click-wise-logo" /> <a href="/webapp/index.html"><spring:message code="gettingstarted.click-wise-logo2" /></a></li>
							
							<li><spring:message code="gettingstarted.click-create-account" /></li>
							
							<li><spring:message code="gettingstarted.fill-out-student-form" /></li>
							
							<li><spring:message code="gettingstarted.note-student-username" /></li>
							
							<li><spring:message code="gettingstarted.note-student-username2" /></li>
							
							<li><spring:message code="gettingstarted.note-student-username3" /></li>
							
							<li><spring:message code="gettingstarted.note-student-username4" /></li>
							
							<li><spring:message code="gettingstarted.after-login-student" /></li>
							
							<li><spring:message code="gettingstarted.student-explore-project" /></li>
							</ol>
					</div>

					<div class="sectionHead"><spring:message code="gettingstarted.faq" /></div>
					<div class="sectionContent">
						<h5><spring:message code="gettingstarted.faq-teacher" /> <a href="teacherfaq.html"><spring:message code="gettingstarted.faq-teacher2" /></a>.</h5>
					</div>
					
					<div class="sectionHead"><spring:message code="gettingstarted.additional-help-header" /></div>
					<div class="sectionContent">
						<h5><spring:message code="gettingstarted.additional-help-text" /> <a href="/webapp/contact/contactwisegeneral.html"><spring:message code="gettingstarted.additional-help-text2" /></a> <spring:message code="gettingstarted.additional-help-text3" /></h5>
					</div>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->
	
	<%@ include file="footer.jsp"%>
</div>


</body>

</html>
