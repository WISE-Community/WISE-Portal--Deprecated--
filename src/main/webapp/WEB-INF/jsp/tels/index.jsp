<%@ include file="include.jsp"%>

<!-- $Id$ -->
<!--
  * Copyright (c) 2006 Encore Research Group, University of Toronto
  * 
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
  * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->

<!-- $Id$ -->

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset=utf-8"/>
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />

<!--<script src="./javascript/tels/killautocomplete.js" type="text/javascript"></script>-->

<script src="./javascript/tels/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="./javascript/tels/general.js" type="text/javascript"></script>
<!--<script src="./javascript/tels/prototype.js" type="text/javascript"></script>-->
<!--<script src="./javascript/tels/effects.js" type="text/javascript"></script>-->
<!--<script src="./javascript/tels/scriptaculous.js" type="text/javascript"></script>-->
<script src="./javascript/tels/rotator.js" type="text/javascript"></script>
<!--<script src="./javascript/tels/rotatorT.js" type="text/javascript"></script>-->

<script type="text/javascript">
	// bind welcome text links to swap message function
	$(document).ready(function(){
		$('.welcomeLink').click(function(){
			var index = $('.welcomeLink').index($(this));
			swapWelcomeMsg(index);
		});
		
		//focus cursor into the First Name field on page ready  
		document.getElementById('j_username').focus();
	});
</script>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" />

<title><spring:message code="application.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="./javascript/tels/iefixes.js"></script>
<![endif]-->

<!--[if lt IE 8]>
<link href="<spring:theme code="ie7homestyles"/>" rel="stylesheet" type="text/css" />
<![endif]-->

<!--The next two conditional statements fix problems with the Display:Block navigation elements in older IE Browsers (MattFish)-->

<!--[if IE 5]>
<style type="text/css">
#welcomeTextLinks a {
float: left;
clear: both;
width: 100%;
}
</style>
<![endif]-->


</head>

<body>

<div id="centeredDiv" class="homePageMask"> 

	<%@ include file="headermain.jsp"%>
	
	<div id="contentTop">
		<div id="boxWelcome" class="panelColor1 panel">
			<div class="header"><spring:message code="welcometowise" /></div>
		
			<div id="parastyleTable">
		
				<ul id="welcomeTextLinks">
						<li><a class="welcomeLink"><spring:message code="whatiswise" /></a></li>
						<li><a class="welcomeLink"><spring:message code="curriculumbased" /></a></li>
						<li><a class="welcomeLink"><spring:message code="inquiryprojects" /></a></li>
						<li><a class="welcomeLink"><spring:message code="studentengagement" /></a></li>
						<li><a class="welcomeLink"><spring:message code="interactivemodels" /></a></li>
						<li><a class="welcomeLink"><spring:message code="onlinegrading" /></a></li>
						<li><a class="welcomeLink"><spring:message code="freeandopensource" /></a></li>
				</ul>
			
				<p class="smallText"><spring:message code="clickabovefordetails" /></p>
		
			</div>
			
			<div id="welcomeBulletContainer">
				<div class="welcomeBullet" style="">
					<div class="welcomeBulletHeader"><spring:message code="whatiswiseheader" /></div>
					<p><spring:message code="whatiswisebullet" /></p><br/>
					<p><spring:message code="whatiswisebullet2" htmlEscape="yes" /></p>
				</div>
				
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="curriculumbasedheader" /></div>
					<p><spring:message code="curriculumbasedbullet" /></p>
				</div>
		
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="inquiryprojectsheader" /></div>
					<p><spring:message code="inquiryprojectsbullet" /></p>
				</div>
		
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="studentengagementheader" /></div>
					<p><spring:message code="studentengagementbullet" /></p>
				</div>
		
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="interactivemodelsheader" /></div>
					<p><spring:message code="interactivemodelsbullet" /></p>
				</div>
		
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="teachertoolsheader" /></div>
					<p><spring:message code="teachertoolsbullet" /></p>
				</div>
		
				<div class="welcomeBullet" style="display: none;">
					<div class="welcomeBulletHeader"><spring:message code="freeandopensourceheader" /></div>
					<p><spring:message code="freeandopensourcebullet" /></p>
				</div>
			</div>
		
			<ul id="welcomeButtons">
				<li><a href="signup.html" title="<spring:message code="createaccounttitle"/>"
						onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Create Account Button','','./themes/tels/default/images/CreateWiseAccountRoll.png',1)">
					<img src="./themes/tels/default/images/CreateWiseAccount.png" width="145" height="33"
						alt="<spring:message code="createnewwiseaccount"/>" class="imgNoBorder" id="create-account" /></a></li>
				<li><a href="previewprojectlist.html" title="<spring:message code="instantpreviewtitle"/>"
						onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Preview of WISE Button','','./themes/tels/default/images/PreviewProjectRoll.png',1)">
					<img src="./themes/tels/default/images/PreviewProject.png" width="145" height="33"
						alt="<spring:message code="instantpreview"/>" class="imgNoBorder" id="preview-wise" /></a></li>
				<li><a href="wiseoverview.html" title="<spring:message code="animatedoverviewtitle"/>"
						onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Overview of WISE button','','./themes/tels/default/images/AnimatedOverviewRoll.png',1)">
					<img src="./themes/tels/default/images/AnimatedOverview.png" width="145" height="33"
						alt="<spring:message code="animatedoverviewofwise"/>" class="imgNoBorder" id="wise-overview" /> </a></li>
				<li><a href="./contactwisegeneral.html" title="<spring:message code="contacttitle"/>" onmouseout="MM_swapImgRestore()"
						onmouseover="MM_swapImage('Contact Wise Button','','./themes/tels/default/images/ContactWiseRoll.png',1)">
					<img src="./themes/tels/default/images/ContactWise.png" width="145" height="33" alt="<spring:message code="contactwise"/>" class="imgNoBorder"
						id="contact" /></a></li>
				<li><a href="./check.html" title="<spring:message code="checkcompatibilitytitle"/>" onmouseout="MM_swapImgRestore()"
						onmouseover="MM_swapImage('checkCompatibilityButton','','./themes/tels/default/images/CheckCompatibilityButtonRoll.png',1)">
					<img src="./themes/tels/default/images/CheckCompatibilityButton.png" width="145" height="33" alt="<spring:message code="checkcompatibility"/>" class="imgNoBorder"
						id="checkCompatibilityButton" /></a></li>
			</ul>
		</div>
		<!--    End of Welcome Box-->
	
		<div id="signInHome">
			<div id="signInSub1" class="panelColor2 panel signinSub"><!--  SignIn Sub Box 1-->
				<div class="header"><spring:message code="signinheader" /></div>
	
				<form id="home" method="post" action="j_acegi_security_check" autocomplete="off">
					<div id="signinForm">
						<div>
							<label for="username"><spring:message code="username" /><input class="dataBoxStyle" type="text" name="j_username" id="j_username" size="18" maxlength="60" /></label>
						</div>
						<div>
							<label for="password"><spring:message code="password" /><input class="dataBoxStyle" type="password" name="j_password" id="j_password" size="18" maxlength="30" /></label>
						</div>
					</div>
		
					<div class="alignRight">
						<input type="image" id="signInButton" img src="./themes/tels/default/images/SignIn.png"	width="100" height="27"
							alt="Sign In Button" onmouseover="MM_swapImage('signInButton','','./themes/tels/default/images/SignInRoll.png',1)"
							onmouseout="MM_swapImgRestore()" onclick="Effect.toggle('waiting', 'appear')" />
					</div>
				</form>
	
				<ul id="signInLinkPosition">
					<li><a href="forgotaccount/selectaccounttype.html" id="forgotlink">Forgot your Username or Password?</a>
					</li>
					<li><a href="signup.html" id="joinlink"><spring:message code="createanewwiseaccount" /></a></li>
				</ul>
			</div>
	
			<div id="signInSub2" class="panelColor3 panel signinSub"><!--  Researcher/Developer Sub Box 2-->
				<div class="header"><spring:message code="researchdevelop1" /></div>
				<div id="researcherText">
					<p><spring:message code="researchdevelop2" />
					<a href="/webapp/pages/gettingstarted.html" target="_blank"><spring:message code="researchdevelopGettingStartedGuide" /></a>
					<spring:message code="researchdevelop3" /></p>
				</div>
			</div>
		</div>
	</div>
	<!--  End contentTop -->

	<div id="contentBottom">
		<div id="boxWiseInAction"  class="bottomPanel first">
			<div class="panelColor1 panel">
				<div class="header"><spring:message code="home.wiseinactionlabel" /></div>
	
				<div class="alignCenter"><img id="rotator" src="./themes/tels/default/images/wiseInAction/AirBag.jpg" height="228" /></div>
	
				<div id="actionNavTable" class="alignCenter">
					<img src="./themes/tels/default/images/wiseInAction/Arrow_Previous.png" class="dynamicImage" id="actionPrevTable"
						onmouseover="this.style.cursor='pointer';" onmousedown="this.style.cursor='pointer';"
						onmouseup="this.style.cursor='pointer';" onmouseout="this.style.cursor='default';"
						onclick="counter=proceedToPreviousImage(counter); changeText('actionImgLinkTable',counter);" />
	
				<a id="actionImgLinkTable">1&nbsp;<spring:message code="home.wiseinactioncounter" />&nbsp;10</a>
					<img id="actionNextTable" src="./themes/tels/default/images/wiseInAction/Arrow_Next.png"
						onmouseover="this.style.cursor='pointer';" onmousedown="this.style.cursor='pointer';"
						onmouseup="this.style.cursor='pointer';" onmouseout="this.style.cursor='default';"
						onclick="counter=proceedToNextImage(counter); changeText('actionImgLinkTable',counter);" />
				</div>
			</div>
		</div>
		<!--    End of boxWISEInAction  -->

		<div id="boxTestimonials"  class="bottomPanel">
			<div class="panelColor1 panel">
				<div class="header"><spring:message code="home.testimonialslabel" /></div>
				<div class="alignCenter"><img class="dataBoxStyle" id="rotatorT"
						src="./themes/tels/default/images/testimonial_1.png" height="228" /></div>
	
				<div id="testimonialsNavTable" class="alignCenter">
					<img id="test_prev" class="dynamicImage"
						src="./themes/tels/default/images/wiseInAction/Arrow_Previous.png" onmouseover="this.style.cursor='pointer';"
						onclick="counter_T=proceedToPreviousImage_T(counter_T); changeText_T('testimonialsImgLinkTable',counter_T);"
						onmousedown="this.style.cursor='pointer';" onmouseup="this.style.cursor='pointer';"
						onmouseout="this.style.cursor='default';" />
					<a id="testimonialsImgLinkTable">1 <spring:message code="home.testimonialscounter" /> 5</a>
					<img id="test_next" class="dynamicImage"
						src="./themes/tels/default/images/wiseInAction/Arrow_Next.png" onmouseover="this.style.cursor='pointer';"
						onmousedown="this.style.cursor='pointer';" onmouseup="this.style.cursor='pointer';"
						onmouseout="this.style.cursor='default';"
						onclick="counter_T=proceedToNextImage_T(counter_T); changeText_T('testimonialsImgLinkTable',counter_T);" />
				</div>
			</div>
		</div>
		<!--    End of boxTestimonials  -->

		<div id="boxLatestNews" class="bottomPanel last">
			<div class="panelColor1 panel">
				<div class="header"><spring:message code="home.latestnewslabel" /></div>
				<div id="newsContent">
					<div id="newsContentHeader">${newsItem.title}</div>${newsItem.news}
				</div>
	
				<div class="alignCenter">
					<p id="newsArchiveButton">
						<a href="./newsarchive.html" onmouseout="MM_swapImgRestore()"
							onmouseover="MM_swapImage('newsArchive','','./themes/tels/default/images/newsArchiveRoll.png',1)">
							<img class="imgNoBorder" src="./themes/tels/default/images/newsArchive.png" alt="Go to News Archive"
								width="93" height="23" id="newsArchive" />
						</a>
					</p>
				</div>
			</div>
		</div>
		<!--    End of boxLatestNews  -->
	</div>
	<!--  End of contentBottom -->

	<div id="contentFooter">
		<div id="footerLogos">
			<a href="http://www.nsf.gov" title="National Science Foundation" target="_blank">
				<img src="./themes/tels/default/images/NSF-Logo-50x50.png" width="50" height="50" alt="National Science Foundation" />
			</a>
			<a href="http://www.telscenter.org/confluence/display/SAIL/Home" title="SAIL Technology" target="_blank">
				<img src="./themes/tels/default/images/SAIL-Logo-Small.png" width="96" height="50" alt="SAIL Logo" />
			</a>
			<a href="http://www.telscenter.org/" title="TELS Consortium" target="_blank">
				<img src="./themes/tels/default/images/TELS-logo-sm.gif" width="70" height="50" alt="TELS Logo" />
			</a>
			<a href="index.html" title="WISE 4.0" target="_blank">
				<img src="./themes/tels/default/images/WISE-Logo-Small-1.png" alt="WISE 4.0 Logo" />
			</a>
		</div>
		<div id="footerText">
			<ul>
				<li class="first"><a href="signup.html"><spring:message code="footer.link1" /></a></li>
				<li class="footerNav2"><a href="./contactwisegeneral.html"><spring:message code="footer.link2" /></a></li>
				<li class="footerNav2"><a href="<c:url value="/j_spring_security_logout"/>"><spring:message code="footer.link3" /></a></li>
				<li class="footerNav2 last"><a href="credits.html"><spring:message code="footer.link4" /></a></li>
			</ul>

			<p><spring:message code="footer.legal1" /></p>
			<p><spring:message code="footer.legal2" /><a href="http://www.firefox.com" title="Firefox web site">Firefox</a>browser.</p>
			<p><spring:message code="footer.legal3" /></p>
		</div>
	</div>
	<!--    End of contentFooter -->

</div>
<!-- end of centeredDiv -->

</body>

</html>

