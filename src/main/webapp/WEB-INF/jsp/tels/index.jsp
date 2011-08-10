<%@ include file="include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html>
<head>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jqueryjscrollpane.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="nivoslider.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="nivoslider-wise.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="tinycarousel.css"/>" rel="stylesheet" type="text/css" />

<script src="<spring:theme code="jquerysource"/>" type="text/javascript"></script>
<script src="<spring:theme code="jqueryuisource"/>" type="text/javascript"></script>
<script src="<spring:theme code="jquerymousewheel.js"/>" type="text/javascript"></script>
<!-- <script src="<spring:theme code="mwheelintent.js"/>" type="text/javascript"></script>  -->
<script src="<spring:theme code="jqueryjscrollpane.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="nivoslider.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="easyaccordion.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="tinycarousel.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="generalsource"/>" type="text/javascript"></script>

<script type="text/javascript">
	// bind welcome text links to swap message function
	$(document).ready(function(){
		
		//focus cursor into the First Name field on page ready 
		if($('#j_username').length){
			$('#j_username').focus();
		}
		
		$('#newsContent').jScrollPane();
		
		$('.tinycarousel').tinycarousel({ axis: 'y', pager: true, duration:500 });
		
		loadProjectThumbnails();
	});
	
	$(window).load(function() {
		
		// initiate showcase slider
		$('#showcaseSlider').nivoSlider({
			effect:'sliceDownRight',
			animSpeed:500,
			pauseTime:10000,
			prevText: '>',
	        nextText: '<',
	        directionNav: false,
	        beforeChange: function(){
	        	$('#about .panelHead span').fadeOut('slow');
	        },
	        afterChange: function(){
	        	var active = $('#showcaseSlider').data('nivo:vars').currentSlide;
	        	$('#about .panelHead span').text($('#showcaseSlider > img').eq(active).attr('alt'));
	        	$('#about .panelHead span').fadeIn('fast');
	        }
		});
		
		// set random opening slide for project showcase
		var numSlides = $('#projectShowcase dt').length;
		var start = Math.floor(Math.random()*numSlides);
		$('#projectShowcase dt').eq(start).addClass('activea');
		
		// initiate project showcase accordion
		$('#project-showcase').easyAccordion({ 
		   autoStart: false,
		   slideNum: false	
		});
	});
	
	// load thumbnails for each project by looking for curriculum_folder/assets/project_thumb.png (makes a ajax GET request)
	// If found (returns 200 status), it will replace the default image with the fetched image.
	// If not found (returns 400 status), it will do nothing, and the default image will be used.
	function loadProjectThumbnails() {		
		$(".projectThumb").each(
			function() {
				var thumbUrl = $(this).attr("thumbUrl");
				// check if thumbUrl exists
				$.ajax({
					url:thumbUrl,
					context:this,
					statusCode: {
						200:function() {
				  		    // found, use it
							$(this).html("<img src='"+$(this).attr("thumbUrl")+"' alt='thumb'></img>");
						},
						404:function() {
						    // not found, leave alone
							//$(this).html("<img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></img>");
						}
					}
				});
			});
	};
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

</head>

<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
	
	<div id="page">
		
		<div id="pageContent">
		
			<div class="showcase">
				<div id="about">
					<div class="panelHead"><span><spring:message code="whatiswiseheader" /></span></div>
					<div class="slider-wrapper theme-wise">
   				 		<div class="ribbon"></div>
						<div id="showcaseSlider">
						    <img src="/webapp/themes/tels/default/images/home/whatiswise.png" alt="<spring:message code="whatiswiseheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/curriculumbased.png" alt="<spring:message code="curriculumbasedheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/inquiry.png" alt="<spring:message code="inquiryprojectsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/engagement.png" alt="<spring:message code="studentengagementheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/interactive.png" alt="<spring:message code="interactivemodelsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/teachertools.png" alt="<spring:message code="teachertoolsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/opensource.png" alt="<spring:message code="freeandopensourceheader" />" />
						</div>
					</div>
				</div>
				<div id="news">
					<div class="panelHead"><spring:message code="home.latestnewslabel" /><a class="panelLink" title="News Archive">more news +</a></div>
					<div id="newsContent">
						<c:forEach var="newsItem" items="${newsItems}">
							<p class="newsTitle">${newsItem.title}<span class="newsDate"><fmt:formatDate value="${newsItem.date}" type="date" dateStyle="medium" /></span></p>
							<p class="newsSnippet">${newsItem.news}</p>
						</c:forEach>
					</div>
					<div id="socialLinks">
						<a href="http://www.facebook.com/pages/WISE-4/150541171679054" title="Find us on Facebook"><img src="/webapp/themes/tels/default/images/home/facebook.png" alt="facebook" /></a>
						<a href="" title="Follow us on Twitter" ><img src="/webapp/themes/tels/default/images/home/twitter.png" alt="twitter" /></a>
					</div>
				</div>
			</div>
			
			<div class="showcase">
				<div id="projectHeader" class="feature"><span class="featureContent">WISE Projects</span><a class="projectsLink" href="/webapp/previewprojectlist.html" title="WISE Project Library">Browse WISE Curricula +</a></div>
				<div id="features">
					<div id="featureHeader" class="feature"><span class="featureContent">WISE Features</span></div>
					<div id="featuresContent">
						<p><a href="/webapp/pages/learning-environment.html">Learning Environment +</a></p>
						<p><a href="/webapp/pages/teacher-tools.html">Teacher Tools +</a></p>
						<p><a href="/webapp/pages/gettingstarted.html">Getting Started +</a></p>
						<p id="checkCompatibility"><a href="/webapp/check.html">Check Compatibility +</a></p>
					</div>
				</div>
				<div id="projectShowcase">
					<div id="project-showcase">
						<dl>
							<dt>Earth Science</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${esProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${esProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>Life Science</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${lsProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${lsProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>Physical Science</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${psProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${psProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>Biology</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${bioProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${bioProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>Chemistry</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${chemProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${chemProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>Physics</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${physProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a href="">More Details +</a><a href="">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${physProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
					   </dl>
					  </div>
				</div>
				<div style="clear:both;"></div>
			</div>
			
			<div class="showcase">
				<a id="wiseAdvantage" href="" class="panelSection">
					<div class="panelHead"><span>The WISE Advantage</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-in-classroom.png" alt="WISE in Classroom" /></div>
				</a>
				<a id="wiseInAction" href="" class="panelSection">
					<div class="panelHead"><span>WISE In Action</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-teaching.png" alt="WISE Students & Teacher" /></div>
				</a>
				<a id="researchTech" href="" class="panelSection">
					<div class="panelHead"><span>Research & Technology</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-research.png" alt="WISE Research" /></div>
				</a>
				<div style="clear:both;"></div>
			</div>
			
			<div id="bottomLinks" class="showcase">
				<div id="telsLink"><a href="http://telscenter.org" target="_blank"><img src="/webapp/themes/tels/default/images/home/tels.png"/></a></div>
				<div id="telsLinkLabel">Powered by the TELS Community</div>
				<div id="openSourceHeader" class="feature">
					<span class="featureContent">WISE Open Source Partnerships</span>
				</div>
				<div id="openSourceContent">WISE software is free to use and open source. Visit <a href="http://wise4.org" target="_blank">http://wise4.org</a> to learn about partnership opportuniies.</div>
			</div>
	
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
	</div> <!-- End of page -->
	
	<%@ include file="footer.jsp"%>

</div>
</body>

</html>

