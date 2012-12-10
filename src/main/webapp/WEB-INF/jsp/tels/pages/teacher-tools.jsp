<%@ include file="../include.jsp"%>

<!DOCTYPE html>
<html>
<head>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" rel="stylesheet" type="text/css" />

<script src="<spring:theme code="jquerysource"/>" type="text/javascript"></script>
<script src="<spring:theme code="jqueryuisource"/>" type="text/javascript"></script>

<link rel="shortcut icon" href="<spring:theme code="favicon"/>" />

<title>WISE Learning Environment</title>

</head>

<body>

<div id="pageWrapper">

	<%@ include file="../headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="contentPanel">
			
				<div class="panelHeader">
					Teaching With WISE
				</div>
				
				<div class="panelContent">
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-teacher.png" alt="Teaching with WISE" />
						<div class="featureContent">
							<div class="featureContentHeader">WISE Teacher Tools</div>
							<p>To guide students through inquiry-based WISE curricula, teachers survey students' ideas on an individual or small group basis and periodically address the whole class about course content. WISE provides teachers with a suite of integrated tools for efficiently managing and promoting student learning with WISE. Teachers monitor students' real-time progress, provide immediate feedback on student work, and grade more efficiently using automated scoring systems. </p>
							<p>By more effectively facilitating classroom management tasks, teachers are free to focus on diverse students' learning needs by interacting with individual students and gaining insights about classroom learning as a whole.</p>
							<p>WISE provides a wide range of one-week long inquiry units that address key concepts consistent with California and national standards. WISE units can not only fit with teachers' excising curricula across science topics, but can also be specifically customized for classroom use.</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featureContentHeader">Highlighted Features</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/teacher-manage.png" alt="management" />
						<div class="featureContent">
							<p class="featureHeader">Managing, Pacing, & Engaging with Students</p>
							<ul>
								<li><span style="font-weight:bold;">Progress Monitor:</span> View student work online in real-time with the Classroom Monitor. The tool allows teachers to quickly assess the progress of each student group and determine whether individualized or class-wide interventions are necessary.</li>
								<li><span style="font-weight:bold;">Step Completion Display:</span> See the percentage of students who have completed particular steps and activities in WISE projects. This feature provides a quick and simple way of determining how the class is progressing through a project.</li>
								<li><span style="font-weight:bold;">Pause Screens:</span> Pause work on student computers simultaneously. This feature can be used to focus student attention on a particular activity for a class discussion or to control the pacing of student progress through a WISE project.</li>
								<li><span style="font-weight:bold;">Flag Student Work:</span> Select specific student responses to share, discuss, or review (anonymously) with the whole class. Carefully chosen student examples can serve as an effective basis for reviewing key ideas or generating criteria for evaluating work.</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/teacher-grading.png" alt="grading and feedback" />
						<div class="featureContent">
							<p class="featureHeader">Grading & Feedback</p>
							<ul>
								<li><span style="font-weight:bold;">Grade Student Work & Provide Feedback:</span> Easily view student work to submit scores and comments that students can review and reflect on. Teachers can grade student work by curriculum step or by student team. </li>
								<li><span style="font-weight:bold;">Pre-Made Comments:</span> Edit and use templates for commonly utilized feedback comments on student work. Teachers can creat pre-made comments to streamline the process of generating feedback for hundreds of student responses.</li>
								<li><span style="font-weight:bold;">Autoscoring Assessments:</span> Score student work using WISE's autoscoring algorithms. This new and developing feature will aim to assist teachers with quickly and accurately assessing student work on key curriculum steps.</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/teacher-customization.png" alt="customization" />
						<div class="featureContent">
							<p class="featureHeader">Customizing Curricula</p>
							<ul>
								<li><span style="font-weight:bold;">WISE Authoring Tool:</span> Create customized curriculum projects targeted to specific classroom contexts. The WISE authoring features allow for flexibility and creativity with designing curriculum pages and embedded assessments. Curriculum authors can tailor existing WISE projects for their specific needs and even create brand new projects on any topic they want.</li>
								<li><span style="font-weight:bold;">Sharing Projects:</span> Provide access to other WISE teachers. WISE users can share projects with other teachers who may want to run the projects in their classrooms and/or further customize them. By sharing projects, curriculum authors can collaboratively edit and refine WISE units.
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					
				</div>
			</div>
		
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="../footer.jsp"%>
</div>

</body>

</html>