<%@ include file="include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html>
<head>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>

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

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />

<!--<script src="./javascript/tels/killautocomplete.js" type="text/javascript"></script>-->

<script src="<spring:theme code="jquerysource"/>" type="text/javascript"></script>
<script src="<spring:theme code="generalsource"/>" type="text/javascript"></script>
<!--<script src="./javascript/tels/prototype.js" type="text/javascript"></script>-->
<!--<script src="./javascript/tels/effects.js" type="text/javascript"></script>-->
<!--<script src="./javascript/tels/scriptaculous.js" type="text/javascript"></script>-->
<script src="<spring:theme code="rotatorsource"/>" type="text/javascript"></script>
<!--<script src="./javascript/tels/rotatorT.js" type="text/javascript"></script>-->

<script type="text/javascript">
	// bind welcome text links to swap message function
	$(document).ready(function(){
		$('.welcomeLink').click(function(){
			var index = $('.welcomeLink').index($(this));
			swapWelcomeMsg(index);
		});
		
		//focus cursor into the First Name field on page ready 
		if($('#j_username').length){
			$('#j_username').focus();
		}
	});
</script>

<link rel="shortcut icon" href="<spring:theme code="favicon"/>" />

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

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
		
		<div id="pageContent">
	
			<!--<div id="contentTop">
				 <div id="boxWelcome" class="panelColor1 panel">
					<div class="header"><spring:message code="welcometowise" /></div>
				
					<div id="parastyleTable">
				
						<ul id="welcomeTextLinks">
								<li><a class="welcomeLink active"><spring:message code="whatiswise" /></a></li>
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
						<li><a href="signup.html" class="wisebutton" title="<spring:message code="createaccounttitle"/>"><spring:message code="createaccountlink"/></a></li>
						<li><a href="previewprojectlist.html" class="wisebutton" title="<spring:message code="instantpreviewtitle"/>"><spring:message code="instantpreviewlink"/></a></li>
						<li><a href="wiseoverview.html" class="wisebutton" title="<spring:message code="animatedoverviewtitle"/>"><spring:message code="animatedoverviewlink"/></a></li>
						<li><a href="./contactwisegeneral.html" class="wisebutton" title="<spring:message code="contacttitle"/>"><spring:message code="contactlink"/></a></li>
						<li><a href="./check.html" class="wisebutton" title="<spring:message code="checkcompatibilitytitle"/>"><spring:message code="checkcompatibilitylink"/></a></li>
					</ul>
				</div>  -->
				<!--    End of Welcome Box-->
			
				<!-- <div id="signInHome">
					<div id="signInSub1" class="panelColor2 panel signinSub">
						<div class="header"><spring:message code="signinheader" /></div>
			
						<form id="home" method="post" action="j_acegi_security_check" autocomplete="off">
							<div id="signinForm">
								<div>
									<label for="username"><spring:message code="username" /><input class="dataBoxStyle" type="text" name="j_username" id="j_username" size="18" maxlength="60" /></label>
								</div>
								<div>
									<label for="password"><spring:message code="password" /><input class="dataBoxStyle" type="password" name="j_password" id="j_password" size="18" maxlength="30" /></label>
								</div>
								<input type="submit" id="signInButton" name="signInButton" class="wisebutton smallbutton" value="<spring:message code="signinbutton"/>"></input>
							</div>
						</form>
			
						<ul id="signInLinkPosition">
							<li><a href="forgotaccount/selectaccounttype.html" id="forgotlink"><spring:message code="forgotaccountinfo" /></a></li>
							<li><a href="signup.html" id="joinlink"><spring:message code="createanewwiseaccount" /></a></li>
						</ul>
					</div>
			
					<div id="signInSub2" class="panelColor3 panel signinSub">
						<div class="header"><spring:message code="researchdevelop1" /></div>
						<div id="researcherText">
							<p><spring:message code="researchdevelop2" />
							<a href="/webapp/pages/gettingstarted.html" target="_blank"><spring:message code="researchdevelopGettingStartedGuide" /></a>
							<spring:message code="researchdevelop3" /></p>
						</div>
					</div>
				</div>
			</div> -->
			<!--  End contentTop -->

			<!-- <div id="contentBottom">
				<div id="boxWiseInAction"  class="bottomPanel first">
					<div class="panelColor1 panel">
						<div class="header"><spring:message code="home.wiseinactionlabel" /></div>
			
						<div class="alignCenter"><img id="rotator" src="./themes/tels/default/images/wiseInAction/AirBag.jpg" style="height:228px;" /></div>
			
						<div id="actionNavTable" class="alignCenter">
							<img src="./themes/tels/default/images/wiseInAction/Arrow_Previous.png" class="dynamicImage" id="actionPrevTable"
								onmouseover="this.style.cursor='pointer';" onmousedown="this.style.cursor='pointer';"
								onmouseup="this.style.cursor='pointer';" onmouseout="this.style.cursor='default';"
								onclick="counter=proceedToPreviousImage(counter); changeText('actionImgLinkTable',counter);" />
			
						<span id="actionImgLinkTable">1&nbsp;<spring:message code="home.wiseinactioncounter" />&nbsp;10</span>
							<img id="actionNextTable" src="./themes/tels/default/images/wiseInAction/Arrow_Next.png"
								onmouseover="this.style.cursor='pointer';" onmousedown="this.style.cursor='pointer';"
								onmouseup="this.style.cursor='pointer';" onmouseout="this.style.cursor='default';"
								onclick="counter=proceedToNextImage(counter); changeText('actionImgLinkTable',counter);" />
						</div>
					</div>
				</div> -->
				<!--    End of boxWISEInAction  -->
		
				<!-- <div id="boxTestimonials"  class="bottomPanel">
					<div class="panelColor1 panel">
						<div class="header"><spring:message code="home.testimonialslabel" /></div>
						<div class="alignCenter"><img class="dataBoxStyle" id="rotatorT"
								src="./themes/tels/default/images/testimonial_1.png" style="height:226px;" /></div>
			
						<div id="testimonialsNavTable" class="alignCenter">
							<img id="test_prev" class="dynamicImage"
								src="./themes/tels/default/images/wiseInAction/Arrow_Previous.png" onmouseover="this.style.cursor='pointer';"
								onclick="counter_T=proceedToPreviousImage_T(counter_T); changeText_T('testimonialsImgLinkTable',counter_T);"
								onmousedown="this.style.cursor='pointer';" onmouseup="this.style.cursor='pointer';"
								onmouseout="this.style.cursor='default';" />
							<span id="testimonialsImgLinkTable">1 <spring:message code="home.testimonialscounter" /> 5</span>
							<img id="test_next" class="dynamicImage"
								src="./themes/tels/default/images/wiseInAction/Arrow_Next.png" onmouseover="this.style.cursor='pointer';"
								onmousedown="this.style.cursor='pointer';" onmouseup="this.style.cursor='pointer';"
								onmouseout="this.style.cursor='default';"
								onclick="counter_T=proceedToNextImage_T(counter_T); changeText_T('testimonialsImgLinkTable',counter_T);" />
						</div>
					</div>
				</div> -->
				<!--    End of boxTestimonials  -->
		
				<!-- <div id="boxLatestNews" class="bottomPanel last">
					<div class="panelColor1 panel">
						<div class="header"><spring:message code="home.latestnewslabel" /></div>
						<div id="newsContent">
							<div id="newsContentHeader">${newsItem.title}</div>${newsItem.news}
						</div>
			
						<div class="alignCenter">
							<a id="newsArchive" href="./newsarchive.html" class="wisebutton minibutton" title="<spring:message code="home.newsarchive"/>"><spring:message code="home.newsarchive"/></a>
						</div>
					</div>
				</div> -->
				<!--    End of boxLatestNews  
			</div>-->
			<!--  End of contentBottom -->
		</div>
	</div>
	
	<%@ include file="footer.jsp"%>

</div>
<!-- end of centeredDiv -->

</body>

</html>

