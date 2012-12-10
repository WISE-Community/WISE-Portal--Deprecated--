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
					WISE Features
				</div>
				
				<div class="panelContent">
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-vle.png" alt="WISE Virtual Learning Envirnment" />
						<div class="featureContent">
							<div class="featureContentHeader">The WISE Virtual Learning Environment</div>
							<p>WISE is a powerful online platform for designing, developing, and implementing science inquiry activities. Since 1997, WISE has served a growing community of more than 15,000 science teachers, researchers, and curriculum designers, as well as over 100,000 K-12 students around the world.</p>
							<p>WISE provides a simple user interface, cognitive hints, embedded reflection notes and assessments, and online discussions, as well as software tools for activities such as drawing, concept mapping, diagramming, and graphing. WISE can also incorporate interactive simulations and models built in a variety of modern web technologies. WISE projects promote student self-monitoring through collaborative reflection activities and teacher feedback.</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featureContentHeader">Project Features & Tools</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/vle-prompts.png" alt="prompts" />
						<div class="featureContent">
							<p class="featureHeader">Reading & Writing Prompts</p>
							<ul>
								<li><span style="font-weight:bold;">Predict, Observe, Explain, Reflect:</span> The POER pattern guides students' interpretation of text. Students write and justify predictions, describe observations of data collected, and use evidence to explain changes to their predictions.</li>
								<li><span style="font-weight:bold;">Critique & Feedback:</span> Students develop criteria to evaluate divergent claims in terms style, purpose, and sources of evidence. Based on these criteria, they write critical responses to the work of their peers.</li>
								<li><span style="font-weight:bold;">Science Narratives:</span> Students write coherent narratives that require them to select key events, and to attend to their order and coherence.</li>
								<li><span style="font-weight:bold;">Challenge Questions:</span> Students evaluate the quality of different scientific explanations and are automatically redirected to relevant activities to improve their understanding.</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/vle-argumentation.png" alt="argumentation" />
						<div class="featureContent">
							<p class="featureHeader">Argument Organizers & Explanation Generation Tools</p>
							<ul>
								<li><span style="font-weight:bold;">Idea Manager:</span> A graphic organizer that guides evaluation of evidence in terms of content, source, and connection to claims. The Idea Basket provides a persistent space for students to collect and sort multimedia information. The Explanation Builder provides an organizing space that scaffolds argument formulation using evidence in their Idea Basket.</li>
								<li><span style="font-weight:bold;">WISE Draw & Flipbook Animator:</span> Students create drawings, take snapshots to create animation frames, and play back their flipbook-style animations. In doing so, students are guided to translate their arguments into different representational forms.</li>
								<li><span style="font-weight:bold;">MySystem:</span> A diagramming tool to visualize sequences of events, and guide the writing of verbal narratives. Translating between different representational forms helps students recognize both the abstract structure of narrative, as well as the key content details.</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/vle-activities.png" alt="activity structures" />
						<div class="featureContent">
							<p class="featureHeader">Activity Templates</p>
							<ul>
								<li><span style="font-weight:bold;">Inquiry & Role-Play:</span> WISE projects investigate personally meaningful driving questions. Students take on roles of scientists to investigate compelling phenomena, helping students to view science as accessible, which can enhance their motivation to achieve.</li>
								<li><span style="font-weight:bold;">Peer Critique & Feedback:</span> Students are anonymously assigned work from their peers to analyze and critique. Practice generating criteria and giving feedback on other's work helps develop critical evaluation skills, as well as collaborative knowledge building.</li>
								<li><span style="font-weight:bold;">Debate, Brainstorm, Discussion:</span> Students share written explanations and feedback with their peers. They are encouraged to elaborate and build upon one another's ideas.</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/vle-simulations.png" alt="simulations" />
						<div class="featureContent">
							<p class="featureHeader">Rich Media & Interactive Simulations</p>
							<ul>
								<li><span style="font-weight:bold;">Virtual Experiments:</span> Similar to the activities of professional scientists, students plan and conduct experiments and gather data to support their claims. Prompts and graphic organizers scaffold students' interactions with rich simulations and models of complex scientific phenomena.</li>
								<li><span style="font-weight:bold;">Multimedia Texts:</span> Curriculum designers can customize and embed media-rich artifacts relevant to the target content in each project (e.g. animations, images, diagrams, graphs, videos, external webpages, and narrative text). Supported by scaffolding tools, students gain fluency in abstracting information from various representational forms.</li>
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