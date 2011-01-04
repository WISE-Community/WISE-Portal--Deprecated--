<%@ include file="../include.jsp"%>
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../javascript/tels/prototype.js" ></script>
<script type="text/javascript" src="../../javascript/tels/effects.js" ></script>
<script type="text/javascript" src="../../javascript/tels/scriptaculous.js" ></script>
<script type="text/javascript" src="../../javascript/tels/rotator.js" ></script>
<script type="text/javascript" src="../../javascript/tels/rotatorT.js" ></script>

<script type="text/javascript" src="../../javascript/tels/general.js"></script>
<script type="text/javascript" src="../../javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../../javascript/tels/yui/event/event.js"></script>
<script type="text/javascript" src="../../javascript/tels/yui/connection/connection.js"></script>

<script type="text/javascript"><!--
	
	function bookmark(pID){
		var checked = document.getElementById('check_' + pID).checked;
		var callback = {
			success:function(o){alert(o.responseText);},
			failure:function(o){alert('bookmark: failed update to server');}
		};
		YAHOO.util.Connect.asyncRequest('GET', 'bookmark.html?projectId=' + pID + '&checked=' + 
			checked, callback);
	};
	
	function bookmarked(){
		var bookmarked = false;
		<c:forEach var='project' items='${projectList}'>
			var bookmarked = false;
			<c:forEach var='bookmarker' items='${project.bookmarkers}'>
				<c:if test='${bookmarker.id==userId}'>
					bookmarked = true;
				</c:if>
			</c:forEach>
			if(bookmarked){
				document.getElementById('check_${project.id}').checked = true;
			};
		</c:forEach>
	};
	
	function copy(pID, type, name, filename, url, base){
		var yes = confirm("Copying a project may take some time. If you proceed, please" +
			" do not click the 'make copy' button again. A message will be displayed when" +
			" the copy has completed.");
		if(yes){
			if(type=='LD'){
				var callback = {
					success:function(o){
						var fullPath = o.responseText;
						var portalPath = fullPath.substring(base.length, fullPath.length) + '/' + filename;
						var callback = {
							success:function(o){
								alert('The LD project has been successfully copied with the name Copy of ' + name + '. The project can be found in the My Customized Projects section.');
							},
							failure:function(o){alert('Project files were copied but the project was not successfully registered in the portal.');},
							scope:this
						};

						YAHOO.util.Connect.asyncRequest('POST', "/webapp/author/authorproject.html", callback, 'command=createProject&param1=' + portalPath + '&param2=Copy of ' + name);
					},
					failure:function(o){alert('Could not copy project folder, aborting copy.');},
					scope:this
				};
				
				YAHOO.util.Connect.asyncRequest('POST', '/vlewrapper/vle/filemanager.html', callback, 'command=copyProject&param1=' + url + '&param2=' + base);
			} else {
				var callback = {
					success:function(o){alert(o.responseText);},
					failure:function(o){alert('copy: failed update to server');}
				};
				YAHOO.util.Connect.asyncRequest('GET', 'copyproject.html?projectId=' + pID, callback);
			};
		};
	};

--></script>

<link rel="shortcut icon" href="../.././themes/tels/default/images/favicon_panda.ico" />

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

<title><spring:message code="curnitlist.project.library" /></title>
</head>

<body>

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%> 

<div id="navigationSubHeader2">Search the Project Library<span id="navigationSubHeader1">projects</span></div> 
 
<div class="searchContainer">
	<div class="header">Browse by Topic</div>
	<div id='searchInstructions'>Select any topic for additional details.</div>

	<ul class="topicLinks"> 
			<li><a href="#" onclick="javascript:projectTopic1();">Life Science</a></li>
			<li><a href="#" onclick="javascript:projectTopic2();">Physical Science</a></li>
			<li><a href="#" onclick="javascript:projectTopic3();">Earth Science</a></li>
			<li><a href="#" onclick="javascript:projectTopic7();">GeneralScience Science</a></li>
			<li><a href="#" onclick="javascript:projectTopic4();">Biology</a></li>
			<li><a href="#" onclick="javascript:projectTopic5();">Chemistry</a></li>
			<li><a href="#" onclick="javascript:projectTopic6();">Physics</a></li>
	</ul>

	<ul class="topicLinks">
			<li><a href="#" onclick="javascript:projectTopic7();">TELS Projects</a></li>
			<li><a style="text-decoration:line-through;" href="#" onclick="">VISUAL Projects</a></li>
			<li><a style="text-decoration:line-through;" href="#" onclick="">Scientific Controversy</a></li>
			<li><a style="text-decoration:line-through;" href="#" onclick="">Earthquakes</a></li>
			<li><a style="text-decoration:line-through;" href="#" onclick="">Health</a></li>
	</ul>

	<div id="topicDisplayContainer">

		<div id="lifescience" style="display: none;">
			<div class="topicHeader">LIFE SCIENCE</div>
			<div class="topicImages">	
				<img src="../../themes/tels/default/images/teacher/topic_photo.jpg" height="100" alt="Photosynthesis graphic" />
				<img src="../../themes/tels/default/images/teacher/topic_mitosis.jpg" height="100" alt="Mitosis graphic" />
				<img src="../../themes/tels/default/images/teacher/topic_inheritance.jpg" height="100" alt="Inheritance graphic" />
			</div>
			<p>Life science projects for grades 6-8 currently include Photosynthesis, Mitosis & Cell Proceses, Simple Inheritance, and more.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>

		<div id="physicalscience" style="display: none;">
			<div class="topicHeader">PHYSICAL SCIENCE</div>
			<div class="topicImages">	
				<img src="../../themes/tels/default/images/teacher/topic_photo.jpg" height="100" alt="Photosynthesis graphic" />
				<img src="../../themes/tels/default/images/teacher/topic_mitosis.jpg" height="100" alt="Mitosis graphic" />
				<img src="../../themes/tels/default/images/teacher/topic_inheritance.jpg" height="100" alt="Inheritance graphic" />
			</div>
			<p>Life science projects for grades 6-8 currently include Motion and Velocity, Introductory Chemistry, Heat & Temperature, The Moon, and more.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>

		<div id="earthscience" style="display: none;">
			<div class="topicHeader">EARTH SCIENCE</div>
			<p>Images here.</p><br/>
			<p>Earth science projects for grades 6-8 currently include Plate Tectonics, Global Warming, Rock Cycle, Ocean Ecosystems, and more.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>

		<div id="biology" style="display: none;">
			<div class="topicHeader">BIOLOGY</div>
			<p>Images here.</p><br/>
			<p>Biology projects for grades 9-12 currently include X,Y, and Z.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>
		<div id="chemistry" style="display: none;">
			<div class="topicHeader">CHEMISTRY</div>
			<p>Images here.</p><br/>
			<p>Chemistry projects for grades 9-12 currently include X, Y, and Z.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>
		<div id="physics" style="display: none;">
			<div class="topicHeader">PHYSICS</div>
			<p>Images here.</p><br/>
			<p>Physics projects for grades 9-12 currently include A, B, C, and D.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>
		<div id="tels" style="display: none;">
			<div class="topicHeader">TELS: Technology Enhanced Learning in Science</div>
			<p>Images here.</p><br/>
			<p>The projects in this family have been developed for the Technology Enhanced Learning in Science Center. Since these projects include new technologies it is important to review a project on the computers the students will be using prior to an actual classroom run. Several additional projects are under development and will be added to this family in the near future.</p>
			<a href='' target='_blank'>Browse Topic</a>
		</div>
	</div>

</div>
	
<div class="searchContainer">
	<div class='header'>Search by Category</div>
	<div id='searchInstructions'>Refine your search by selecting one or more categories using the drop-down menus. Then click <i>Search By Category</i> to find matching projects.</div>
	<div id='projectOverviewSearchContainer'>
	
		<form:form commandName='searchProjectLibraryParameters' id='searchLibraryForm' method='post' action='projectlibrary.html' autocomplete='off'>
		<table id="projectOverviewTable">
			
				<tr id="row2">
						<th id="title1" style="width: 90px;">Project Family</th>
						<th id="title2" style="width: 222px;">Subject</th>
						<th id="title3" style="width: 100px;">Grade Level</th>
						<th id="title4" style="width: 110px;">Total Hours</th>
						<th id="title5" style="width: 110px;">Computer Hours</th>
						<th id="title6" style="width: 92px;">Language</th>
						<th id="title7" style="width: 120px;">Tech Requirements</th>
				</tr>
				<tr id="row3">
						<td class="dataCell">
							<select name="searchFamily">
							<option id='telsRadio' path='family' value='0'>TELS</option>
							<option id='uccpRadio' path='family' value='1'>VISUAL</option>
							<option id='allRadio' path='family' value='2'>UCCP</option>
							<option selected id='allRadio' path='family' value='-1'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchSubject">
							<option id='subjectLife' path='subject' value='subjectLife'>Life Science</option>
							<option id='subjectPhysical' path='subject' value='subjectPhysical'>Physical Science</option>
							<option id='subjectEarth' path='subject' value='subjectEarth'>Earth Science</option>
							<option id='subjectBiology' path='subject' value='subjectBiology'>Biology</option>
							<option id='subjectChemistry' path='subject' value='subjectChemistry'>Chemistry</option>
							<option id='subjectPhysics' path='subject' value='subjectPhysics'>Physics</option>
							<option selected id='subjectAll' path='subject' value='subjectAll'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchGrade">
							<option id='grade1' path='grade' value='grade1'>Grades 3-5</option>
							<option id='grade2' path='grade' value='grade2'>Grades 6-8</option>
							<option id='grade3' path='grade' value='grade3'>Grades 9-12</option>
							<option id='grade4' path='grade' value='grade4'>Grades 6-12</option>
							<option selected id='gradeAll' path='grade' value='gradeAll'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchTotalTime">
							<option id='total1' path='totalTime' value='total1'>2-3 hours</option>
							<option id='total2' path='totalTime' value='total2'>4-5 hours</option>
							<option id='total3' path='totalTime' value='total3'>6-7 hours</option>
							<option id='total4' path='totalTime' value='total4'>8-9 hours</option>
							<option id='total5' path='totalTime' value='total5'>10-11 hours</option>
							<option id='total6' path='totalTime' value='total6'>12+ hours</option>
							<option selected id='totalAll' path='totalTime' value='totalAll'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchTotalTime">
							<option id='computer1' path='computerTime' value='computer1'>2-3 hours</option>
							<option id='computer2' path='computerTime' value='computer2'>4-5 hours</option>
							<option id='computer3' path='computerTime' value='computer3'>6-7 hours</option>
							<option id='computer4' path='computerTime' value='computer4'>8-9 hours</option>
							<option id='computer5' path='computerTime' value='computer5'>10-11 hours</option>
							<option id='computer6' path='computerTime' value='computer6'>12+ hours</option>
							<option selected id='computerAll' path='computerTime' value='computerAll'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchLanguage">
							<option id='language1' path='language' value='language1'>English</option>
							<option id='language6' path='language' value='language6'>French</option>
							<option id='language4' path='language' value='language4'>German</option>
							<option id='language3' path='language' value='language3'>Hebrew</option>
							<option id='language2' path='language' value='language2'>Spanish</option>
							<option id='language5' path='language' value='language5'>U.K. English</option>
							<option selected id='languageAll' path='language' value='languageAll'>All</option>
							</select>
						</td>
						<td class="dataCell">
							<select name="searchTech">
							<option id='tech1' path='tech' value='tech1'>Browser</option>
							<option id='tech2' path='tech' value='tech2'>Browser + Flash</option>
							<option id='tech3' path='tech' value='tech3'>Browser + Flash + Java</option>
							<option selected id='techAll' path='tech' value='techAll'>All</option>
							</select>
						</td>

				</tr>
		</table>
		<div id="searchCategoryButton">
			<input type='submit' value='Search by Category'/>
		</div>
		</form:form>
		</div>
</div>

<div class="searchContainer">
	<div class="header">Search by Keyword</div>
	<div id='searchInstructions'>Type one or more words into the search field below. Then click <i>Search By Keyword</i> to find matching projects.</div>
	<form commandName='searchProjectLibraryParameters' id='searchLibraryForm' method='post' action='projectlibrary.html' autocomplete='off'>
		<div id='searchTypeDiv'>
						<b>Search should:</b>  
						<INPUT type="radio"  id='exactRadio' path='searchtype' value='matches'/>Match text exactly
						<INPUT type="radio"  id='containsRadio' path='searchtype' value='contains'/>Contain text
					</div>
		<div id="searchKeywordButton">
			<input type="text" size="45" value=""> 
			<input type="submit" value="Search by Keyword"><br>
		</div>

	</form>
</div>

<!--Old search form.  Commented out but left for reference.  (MF)-->
<!--<div>
	<form:form commandName='searchProjectLibraryParameters' id='searchLibraryForm' method='post' action='projectlibrary.html' autocomplete='off'>
	<table id='searchTable'>
		<thead></thead>
		<tbody>
			<tr>
				<td id='familyTD'>
					<div id='familyDiv'>
						Family: <br/>
						<form:radiobutton id='telsRadio' path='family' value='0'/> TELS<br/>
						<form:radiobutton id='uccpRadio' path='family' value='1'/> UCCP<br/>
						<form:radiobutton id='otherRadio' path='family' value='2'/> Other<br/>
						<form:radiobutton id='allRadio' path='family' value='-1'/> All<br/>
					</div>
				</td>
				<td id='currentTD'>
					<div id='currentDiv'>
						Project status: <br/>
						<form:radiobutton id='currentRadio' path='status' value='1'/> Current projects only<br/>
						<form:radiobutton id='endedRadio' path='status' value='0'/> Closed projects only<br/>
						<form:radiobutton id='bothRadio' path='status' value='-1'/> Both current and closed projects<br/>
					</div>
				</td>
				<td id='searchTypeTD'>
					<div id='searchTypeDiv'>
						Search should: 
						<form:radiobutton id='exactRadio' path='searchtype' value='matches'/> Match text exactly
						<form:radiobutton id='containsRadio' path='searchtype' value='contains'/> Contain text
					</div>
				</td>
			</tr>
			<tr>
				<td>
					Title: <form:input id='titleText' path='title'/>
				</td>
				<td>
					Author: <form:input id='authorText' path='author'/>
				</td>
				<td>
					Subject: <form:input id='subjectText' path='subject'/>
				</td>
			</tr>
			<tr>
				<td>
					Project Summary: <form:textarea id='summaryText' path='summary'></form:textarea>
				</td>
				<td>
					Grade Range: <form:input id='gradeRangeText' path='gradeRange'/>
				</td>
				<td>
					Contact: <form:input id='contactText' path='contact'/>
				</td>
			</tr>
			<tr>
				<td>
					Total time (in mins): <form:input id='totalTimeText' path='totalTime'/>
				</td>
				<td>
					Computer time (in mins): <form:input id='compTimeText' path='compTime'/>
				</td>
				<td>
					Technical Requirements: <form:textarea id='techReqsText' path='techReqs'></form:textarea>
				</td>
			</tr>
			<tr>
				<td><input type='submit' value='execute search'/></td>
			</tr>
		</tbody>
	</table>
	</form:form>
</div><br/><br/>

<c:forEach var="project" items="${projectList}">
		<c:choose>
			<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
				<c:set var="projectName" value="${project.metadata.title}"/>
			</c:when>
			<c:otherwise>
				<c:set var="projectName" value="${project.name}"/>
			</c:otherwise>
		</c:choose>

	<table id="libraryProjectTable">
		<tr>
			<th>project title</th>
			<th id="libraryProjectCol2">project id</th>
			<th id="libraryProjectCol3">project source</th>
			<th id="libraryProjectCol4">subjects/keywords</th>
			<th>grade range</th>
			<th>total</br>time</th>
			<th>computer</br>time</th>
			<th>usage</th>
			<th>actions</th>
		</tr>
		<tr id="libraryProjectTableR2">
			<td class="titleCell"><a href="projectinfo.html?projectId=${project.id}">${projectName}</a></td>
			<td class="dataCell">${project.id}</td>   
			<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
			<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
			<td class="dataCell">${project.metadata.gradeRange}</td>              
			<td class="dataCell">${project.metadata.totalTime}</td>              
			<td class="dataCell">${project.metadata.compTime}</td> 
			<td class="dataCell">${usageMap[project.id]} runs</td>
			<td class="dataCell" >
				<ul>
					<li class="list1"><span><input type="checkbox" id="check_${project.id}" onclick="javascript:bookmark('${project.id}')"/>Bookmark</span></li>
					<li class="list2"><c:if test="${project.projectType=='ROLOO'}"><a href="../vle/vle.html?runId=${project.previewRun.id}&summary=true">Project Summary</a></c:if></li>
					<li class="list3"><input type="button" onclick="copy('${project.id}','${project.projectType}','${projectName}','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" value="Make Copy"/></li>
				</ul>
			</td>
		</tr>
		<tr id="libraryProjectTableR3">  
			<td colspan="9">${project.metadata.summary}</td>
		</tr>
	</table>
	
</c:forEach>	
<script>bookmarked();</script>

--></div>
</body>
</html>
