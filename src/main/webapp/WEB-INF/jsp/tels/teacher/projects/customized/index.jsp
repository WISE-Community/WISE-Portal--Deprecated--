<%@ include file="../../include.jsp"%>
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

<!-- $Id: projectlibrary.jsp 1850 2008-04-01 01:22:32Z mattf $ -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 

<%@ include file="../styles.jsp"%>

<!-- Source File --> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/menu/menu-min.js"></script> 

<link href="../../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<!-- Core + Skin CSS --> 
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.1/build/menu/assets/skins/sam/menu.css"> 
 
<!-- Dependencies -->  
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/yahoo-dom-event/yahoo-dom-event.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/container/container_core-min.js"></script> 
<script type="text/javascript" src="../../.././javascript/tels/yui/connection/connection.js"></script>

<script type="text/javascript" src="../../../javascript/tels/general.js"></script>

<title><spring:message code="teacher.pro.custom.index.1"/></title>
<script type="text/javascript">

    // un-bookmarks the specified project. pID=projectID of project to remove bookmark
	function unbookmark(pID){
		var callback = {
			success:function(o){
				alert(o.responseText);
				document.getElementById('bookmarked_' + pID).parentNode.removeChild(document.getElementById('bookmarked_' + pID));
			},
			failure:function(o){alert('failed update to server');}
		};
		YAHOO.util.Connect.asyncRequest('GET', '../bookmark.html?projectId=' + pID + '&checked=' + 
			false, callback);
	};
</script>

        <!-- Page-specific script -->

        <script type="text/javascript">

            /*
                 Initialize and render the MenuBar when its elements are ready 
                 to be scripted.
            */

            YAHOO.util.Event.onContentReady("customProjectActionsMenu", function () {

                /*
                     Instantiate a MenuBar:  The first argument passed to the 
                     constructor is the id of the element in the page 
                     representing the MenuBar; the second is an object literal 
                     of configuration properties.
                */

                var oMenuBar = new YAHOO.widget.MenuBar("customProjectActionsMenu", { 
                                                            autosubmenudisplay: true, 
                                                            hidedelay: 500, 
                                                            lazyload: true });

                /*
                     Define an array of object literals, each containing 
                     the data necessary to create a submenu.
                */
/*
                var aSubmenuData = [
                
                    {
                        id: "actionsCurrent", 
                        itemdata: [ 
                            { text: "<spring:message code="teacher.pro.custom.index.2"/>", url: "../../../author/authorproject.html?projectId=1" },
                            { text: "<spring:message code="teacher.pro.custom.index.3"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.4"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.5"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.6"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.7"/>",  url: "shareproject.html" },
                            { text: "<spring:message code="teacher.pro.custom.index.8"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.9"/>", url: "#" },
                            { text: "<spring:message code="teacher.pro.custom.index.10"/>", url: "#" },     
                        ]
                                      
                    },                   
                                             
                ];        
*/                   
                
                var ua = YAHOO.env.ua,
                    oAnim;  // Animation instance


                /*
                     "beforeshow" event handler for each submenu of the MenuBar
                     instance, used to setup certain style properties before
                     the menu is animated.
                */

                function onSubmenuBeforeShow(p_sType, p_sArgs) {

                    var oBody,
                        oElement,
                        oShadow,
                        oUL;
                

                    if (this.parent) {

                        oElement = this.element;

                        /*
                             Get a reference to the Menu's shadow element and 
                             set its "height" property to "0px" to syncronize 
                             it with the height of the Menu instance.
                        */

                        oShadow = oElement.lastChild;
                        oShadow.style.height = "0px";

                        
                        /*
                            Stop the Animation instance if it is currently 
                            animating a Menu.
                        */ 
                    
                        if (oAnim && oAnim.isAnimated()) {
                        
                            oAnim.stop();
                            oAnim = null;
                        
                        }


                        /*
                            Set the body element's "overflow" property to 
                            "hidden" to clip the display of its negatively 
                            positioned <ul> element.
                        */ 

                        oBody = this.body;


                        //  Check if the menu is a submenu of a submenu.

                        if (this.parent && 
                            !(this.parent instanceof YAHOO.widget.MenuBarItem)) {
                        

                            /*
                                There is a bug in gecko-based browsers where 
                                an element whose "position" property is set to 
                                "absolute" and "overflow" property is set to 
                                "hidden" will not render at the correct width when
                                its offsetParent's "position" property is also 
                                set to "absolute."  It is possible to work around 
                                this bug by specifying a value for the width 
                                property in addition to overflow.
                            */

                            if (ua.gecko) {
                            
                                oBody.style.width = oBody.clientWidth + "px";
                            
                            }
                            
                            
                            /*
                                Set a width on the submenu to prevent its 
                                width from growing when the animation 
                                is complete.
                            */
                            
                            if (ua.ie == 7) {

                                oElement.style.width = oElement.clientWidth + "px";

                            }
                        
                        }

    
                        oBody.style.overflow = "hidden";


                        /*
                            Set the <ul> element's "marginTop" property 
                            to a negative value so that the Menu's height
                            collapses.
                        */ 

                        oUL = oBody.getElementsByTagName("ul")[0];

                        oUL.style.marginTop = ("-" + oUL.offsetHeight + "px");
                    
                    }

                }


                /*
                    "tween" event handler for the Anim instance, used to 
                    synchronize the size and position of the Menu instance's 
                    shadow and iframe shim (if it exists) with its 
                    changing height.
                */

                function onTween(p_sType, p_aArgs, p_oShadow) {

                    if (this.cfg.getProperty("iframe")) {
                    
                        this.syncIframe();
                
                    }
                
                    if (p_oShadow) {
                
                        p_oShadow.style.height = this.element.offsetHeight + "px";
                    
                    }
                
                }


                /*
                    "complete" event handler for the Anim instance, used to 
                    remove style properties that were animated so that the 
                    Menu instance can be displayed at its final height.
                */

                function onAnimationComplete(p_sType, p_aArgs, p_oShadow) {

                    var oBody = this.body,
                        oUL = oBody.getElementsByTagName("ul")[0];

                    if (p_oShadow) {
                    
                        p_oShadow.style.height = this.element.offsetHeight + "px";
                    
                    }


                    oUL.style.marginTop = "";
                    oBody.style.overflow = "";
                    

                    //  Check if the menu is a submenu of a submenu.

                    if (this.parent && 
                        !(this.parent instanceof YAHOO.widget.MenuBarItem)) {


                        // Clear widths set by the "beforeshow" event handler

                        if (ua.gecko) {
                        
                            oBody.style.width = "";
                        
                        }
                        
                        if (ua.ie == 7) {

                            this.element.style.width = "";

                        }
                    
                    }
                    
                }


                /*
                     "show" event handler for each submenu of the MenuBar 
                     instance - used to kick off the animation of the 
                     <ul> element.
                */

                function onSubmenuShow(p_sType, p_sArgs) {

                    var oElement,
                        oShadow,
                        oUL;
                
                    if (this.parent) {

                        oElement = this.element;
                        oShadow = oElement.lastChild;
                        oUL = this.body.getElementsByTagName("ul")[0];
                    

                        /*
                             Animate the <ul> element's "marginTop" style 
                             property to a value of 0.
                        */

                        oAnim = new YAHOO.util.Anim(oUL, 
                            { marginTop: { to: 0 } },
                            .5, YAHOO.util.Easing.easeOut);


                        oAnim.onStart.subscribe(function () {
        
                            oShadow.style.height = "100%";
                        
                        });
    

                        oAnim.animate();

    
                        /*
                            Subscribe to the Anim instance's "tween" event for 
                            IE to syncronize the size and position of a 
                            submenu's shadow and iframe shim (if it exists)  
                            with its changing height.
                        */
    
                        if (YAHOO.env.ua.ie) {
                            
                            oShadow.style.height = oElement.offsetHeight + "px";


                            /*
                                Subscribe to the Anim instance's "tween"
                                event, passing a reference Menu's shadow 
                                element and making the scope of the event 
                                listener the Menu instance.
                            */

                            oAnim.onTween.subscribe(onTween, oShadow, this);
    
                        }
    

                        /*
                            Subscribe to the Anim instance's "complete" event,
                            passing a reference Menu's shadow element and making 
                            the scope of the event listener the Menu instance.
                        */
    
                        oAnim.onComplete.subscribe(onAnimationComplete, oShadow, this);
                    
                    }
                
                }


                /*
                     Subscribe to the "beforerender" event, adding a submenu 
                     to each of the items in the MenuBar instance.
                */

                oMenuBar.subscribe("beforeRender", function () {

                    if (this.getRoot() == this) {

                        this.getItem(0).cfg.setProperty("submenu", aSubmenuData[0]);
                        this.getItem(1).cfg.setProperty("submenu", aSubmenuData[1]);
                        this.getItem(2).cfg.setProperty("submenu", aSubmenuData[2]);
                        this.getItem(3).cfg.setProperty("submenu", aSubmenuData[3]);

                    }

                });


                /*
                     Subscribe to the "beforeShow" and "show" events for 
                     each submenu of the MenuBar instance.
                */
                
                oMenuBar.subscribe("beforeShow", onSubmenuBeforeShow);
                oMenuBar.subscribe("show", onSubmenuShow);


                /*
                     Call the "render" method with no arguments since the 
                     markup for this MenuBar instance is already exists in 
                     the page.
                */

                oMenuBar.render();         
            
            });

            
            function copy(pID, type, name, filename, url, base){
                var escapedName = escape(name);
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
        								alert('Successfully copied the project\n\n' + name + '\n\nThe copy can be found in the View My Projects section. If you are already on the View My Projects page, please refresh the page.');
        							},
        							failure:function(o){alert('Project files were copied but the project was not successfully registered in the portal.');},
        							scope:this
        						};

        						YAHOO.util.Connect.asyncRequest('POST', "/webapp/author/authorproject.html", callback, 'command=createProject&parentProjectId='+pID+'&param1=' + portalPath + '&param2=' + escapedName);
        					},
        					failure:function(o){alert('Could not copy project folder, aborting copy.');},
        					scope:this
        				};
        				
        				YAHOO.util.Connect.asyncRequest('POST', '/webapp/author/authorproject.html', callback, 'forward=filemanager&projectId=' + pID + '&command=copyProject&param1=' + url + '&param2=' + base);
        			} else {
        				var callback = {
        					success:function(o){alert(o.responseText);},
        					failure:function(o){alert('copy: failed update to server');}
        				};
        				YAHOO.util.Connect.asyncRequest('GET', 'copyproject.html?projectId=' + pID, callback);
        			};
        		};
        	};
        </script>

<script type="text/javascript">

	/**
	 * Toggles the summary div
	 * projectId: id of project whose summary div to toggle
	 */
	function toggleDetails(projectId){
		var searchDiv = document.getElementById('details_'+projectId);
		if(searchDiv.style.display=='none'){
			searchDiv.style.display = 'block';
		} else {
			searchDiv.style.display = 'none';
		};
	};
</script>

<script type="text/javascript">


function changePublic(id){
	var callback = {
		success:function(o){alert(o.responseText);},
		failure:function(o){alert('failed update of public access');}
	};

	YAHOO.util.Connect.asyncRequest('GET', 'public.html?projectId=' + id + '&checked=' + document.getElementById('public_'+id).checked, callback);
};

function minifyProject(id){
	var callback= {
			success:function(o){alert(o.responseText);},
			failure:function(o){alert('Unable to minify project file, please clean up any old node references and make sure that all node content is in valid JSON format.');},
			scope:this
	};

	YAHOO.util.Connect.asyncRequest('GET', '../minifyproject.html?projectId=' + id, callback);
};
</script>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href="../../../themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src="../../../javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="../../../javascript/tels/superfish.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    
</script>

</head>

<body class="yui-skin-sam" onload=''> 

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="navigationSubHeader2">My Projects<span id="navigationSubHeader1">projects</span></div> 


<!--<div id="projectInfoInstructions">Click any tab below for more information.</div>-->
<div id="projectInfoTabs" class="yui-navset">
    <ul class="yui-nav" >
        <li style="margin-left:4px;"><a href="#tab1"><em><spring:message code="teacher.pro.custom.index.12"/></em></a></li>
        <li style="margin-left:4px;"><a href="#tab2"><em><spring:message code="teacher.pro.custom.index.13"/></em></a></li>
        <li style="margin-left:4px;"><a href="#tab3"><em><spring:message code="teacher.pro.custom.index.tab.bookmark"/></em></a></li>
        <li style="margin-left:4px;"><a href="#tab4"><em><spring:message code="teacher.pro.custom.index.14"/></em></a></li>  
		<li style="margin-left:4px;"><a id="special" href="#tab5"><em>my project runs</em></a></li>        
    </ul>     
<div class="yui-content" style="background-color: #FFFFFF;">

<div id="tab1">

<table id="customProjectsButtons">
	<tr>
		<td><a href="/webapp/author/authorproject.html?command=launchAuthoring&param1=createProject">Create New Project<br/>using Author Tool</a></td>
		<c:if test="${fn:length(currentOwnedProjectsList) > 0}">
			<td><a href="#" onclick="toggleProjectSummaryAll()">Hide/Show All<br/> Project Details Below</a></td>
		</c:if>
		
	</tr>
</table>

	<c:choose>
		<c:when test="${fn:length(currentOwnedProjectsList) == 0}">
		   <h5>You currently do not own any projects.</h5>
		</c:when>
		<c:otherwise>
		    <div id="customProjectInstructions">You own the Custom projects listed below.</div>
			<c:forEach var="project" items="${currentOwnedProjectsList}">
				<c:set var="projectName" value="${projectNameMap[project.id]}" />
				<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
					<table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCell" colspan="3">
									<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
									<c:if test="${fn:length(project.sharedowners) > 0}">
										<div id="sharedNamesContainer">
											This project is shared with:
											<div id="sharedNames">
												<c:forEach var="sharedowner" items="${project.sharedowners}">
												  <c:out value="${sharedowner.userDetails.firstname}"/>
												  <c:out value="${sharedowner.userDetails.lastname}"/>
												  <c:out value=",  "/>
												</c:forEach>
											</div>
										</div>
									</c:if>
							</td>
							<td class="actions" colspan="8"> 
									<ul>
										<li><a href="<c:url value="../../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>">Preview</a></li>
										<li><a href="../projectinfo.html?projectId=${project.id}">Project Info</a></li>
										<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Project Run</a></li>
										<li><a href="../../../author/authorproject.html?projectId=${project.id}">Edit/Author</a></li>
										<li><a href="shareproject.html?projectId=${project.id}">Share</a>
										<li><a href="#" onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy</a></li>
										<li><a href="#" style="color:#666;">Archive</a>
										<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
									</ul>
							</tr>
								<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title2" style="width:90px;">Project Family</th>
								<th id="title3" style="width:280px;" >Subject</th>
								<th id="title4" style="width:70px;">Grade Level</th>
								<th id="title5" style="width:105px;">Total Hours</th>
								<th id="title6" style="width:110px;">Computer Hours</th>
								<th id="title7" style="width:72px;">Language</th>
								<th id="title9" style="width:60px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">${project.metadata.language}</td> 
								<td class="dataCell">${usageMap[project.id]}</td>
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">${project.metadata.keywords}</td>
											</tr>
											<tr>
												<th>Tech Details:</th>
													<td class="techdetails">${project.metadata.techDetailsString}</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<!--  
											<tr> 
												<th>Original Author:</th>
												<td>${project.metadata.author}</td>
											</tr>
											-->
											<tr>
												<th>Copy of Project ID:</th>
												<c:choose>
											  		<c:when test="${project.parentProjectId != null}">
											    		<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>${project.parentProjectId}</a></td>
											  		</c:when>
											  		<c:otherwise>
											    		<td>N/A</td>
											  		</c:otherwise>
											 	</c:choose>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>

	</c:forEach>
		</c:otherwise>
	</c:choose>


</div>
<!--	    End of Tab 1 content-->

<div id="tab2">  <!-- shared projects -->

<!--  
<table id="customProjectsButtons">
	<tr>
		<td><a href="#" onclick="toggleProjectSummaryAll()">Hide/Show All Project Details</a></td>
	</tr>
</table>
-->

<c:choose>
		<c:when test="${fn:length(currentSharedProjectsList) == 0}">
		<h5>No projects are currently being shared with you.</h5>
		</c:when>
		<c:otherwise>
<div id="customProjectInstructions">The projects below have been shared with you by another user.</div>

	<table id="projectOverviewTable">
							<c:forEach var="project" items="${currentSharedProjectsList}">
								<c:set var="projectName" value="${projectNameMap[project.id]}" />
								<c:set var="projectNameEscaped" value="${projectNameEscapedMap[project.id]}" />
								<tr id="row1">
								<td id="titleCell" colspan="3">
										<a href="../projectinfo.html?projectId=${project.id}"><c:out value="${projectName}" /></a>
										<c:if test="${fn:length(project.sharedowners) > 0}">
											<div id="sharedNamesContainerOwned">
												Project OWNER is:
												<div id="sharedNames">
													<c:forEach var="projectowner" items="${project.owners}">
						  							<c:out value="${projectowner.userDetails.firstname}" />
						  							<c:out value="${projectowner.userDetails.lastname}" />
					 								</c:forEach>
												</div>
											</div>
										</c:if>
	
								</td>
								<td class="actions" colspan="8"> 
										<ul>
	
	
											<li><a href="../../../previewproject.html?projectId=${project.id}">Preview Project</a></li>
											<li><a href="../projectinfo.html?projectId=${project.id}">Project Info</a></li>
											<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Project Run</a></li>
											<sec:accesscontrollist domainObject="${project}" hasPermission="2,16">	
												<li><a href="../../../author/authorproject.html?projectId=${project.id}">Edit/Author</a></li>
											</sec:accesscontrollist>		
											<li><a href="#" onclick="copy('${project.id}','${project.projectType}','<c:out value="${projectNameEscaped}" />','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy</a></li>
											<sec:accesscontrollist domainObject="${project}" hasPermission="16">												
												<li><a href="shareproject.html?projectId=${project.id}">Share</a></li>
											</sec:accesscontrollist>										
											<li><a href="#" style="color:#666;">Archive</a>
											<!-- input type='checkbox' id='public_${project.id}' onclick='changePublic("${project.id}")'/> Is Public</li>-->
										</ul>
								</tr>
									<tr id="row2">
									<th id="title1" style="width:60px;">Project ID</th>
									<th id="title2" style="width:90px;">Project Family</th>
									<th id="title3" style="width:280px;" >Subject</th>
									<th id="title4" style="width:70px;">Grade Level</th>
									<th id="title5" style="width:105px;">Total Hours</th>
									<th id="title6" style="width:110px;">Computer Hours</th>
									<th id="title7" style="width:72px;">Language</th>
									<th id="title9" style="width:60px;">Usage</th>
								</tr>
								<tr id="row3">
									<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
									<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
									<td class="dataCell">${project.metadata.gradeRange}</td>              
									<td class="dataCell">${project.metadata.totalTime}</td>              
									<td class="dataCell">${project.metadata.compTime}</td> 
									<td class="dataCell">${project.metadata.language}</td>
									<td class="dataCell">${usageMap[project.id]}</td>
								</tr>
								<tr id="row4">  
									<td colspan="9">
										<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
										<div id="details_${project.id}"> 
											<table id="detailsTable">
												<tr>
													<th>Summary:</th>
													<td class="summary">${project.metadata.summary}</td>
												</tr>
												<tr>
													<th>Keywords:</th>
													<td class="keywords">${project.metadata.keywords}</td>
												</tr>
	
												<tr>
													<th>Tech Details:</th>
													<td>${project.metadata.techDetailsString}</td>
												</tr>
												<tr>
													<th>Created On:</th>
													<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
												</tr>
												<!--  
												<tr> 
													<th>Original Author:</th>
													<td></td>
												</tr>
												-->
												<tr>
													<th>Contact Info:</th>
													<td>${project.metadata.contact}</td>
												</tr>
												<c:if test='${project.parentProjectId != null}'>
													<tr>
														<th>Copy of:</th>
														<td><a href='/webapp/teacher/projects/projectinfo.html?projectId=${project.parentProjectId}'>project ${project.parentProjectId}</a></td>
													</tr>
												</c:if>
											</table>
										</div>
									</td>
								</tr>
							</c:forEach>
	</table>

	</c:otherwise>
</c:choose>

</div>



<div id="tab3">  <!-- bookmarked projects -->

	<c:choose>
		<c:when test="${fn:length(bookmarkedProjectsList) == 0}">
		   <h5>You currently have not bookmarked any WISE library projects.</h5>
		</c:when>
		<c:otherwise>
		    <div id="customProjectInstructions">You have bookmarked the following WISE library projects:</div>
			<c:forEach var="project" items="${bookmarkedProjectsList}">
				<c:choose>
					<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
						<c:set var="projectName" value="${project.metadata.title}"/>
					</c:when>
					<c:otherwise>
						<c:set var="projectName" value="${project.name}"/>
					</c:otherwise>
				</c:choose>

			<table id="projectOverviewTable">
					<tr id="row1">
					<td id="titleCell" colspan="3"><a href="../projectinfo.html?projectId=${project.id}">${projectName}</a></td>
					<td class="actions" colspan="6"> 
							<ul>

								<li><a href="#" onclick="unbookmark(${project.id})">Unbookmark</a></li>
								<li><a href="<c:url value="../../../previewproject.html"><c:param name="projectId" value="${project.id}"/></c:url>">Preview</a></li>
								<li><a href="<c:url value="../../run/createRun.html"><c:param name="projectId" value="${project.id}"/></c:url>">Set up Project Run</a></li>
								<li><a href="#" onclick="copy('${project.id}','${project.projectType}','${projectName}','${filenameMap[project.id]}','${urlMap[project.id]}','${curriculumBaseDir}')" >Copy to <i>My Projects</i></a></li>
								<li><c:if test="${project.projectType=='ROLOO'}"><a href="../vle/vle.html?runId=${project.previewRun.id}&summary=true">Project Summary</a></c:if></li>
							</ul>
					</tr>
								<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title2" style="width:90px;">Project Family</th>
								<th id="title3" style="width:280px;" >Subject</th>
								<th id="title4" style="width:70px;">Grade Level</th>
								<th id="title5" style="width:105px;">Total Hours</th>
								<th id="title6" style="width:110px;">Computer Hours</th>
								<th id="title7" style="width:72px;">Language</th>
								<th id="title8" style="width:82px;">Tech Needs</th>
								<th id="title9" style="width:60px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">[English]</td> 
								<td class="dataCell">[Flash, Java]</td> 
								<td class="dataCell">${usageMap[project.id]}</td>
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">[List of comma-separated keywords go here]</td>
											</tr>

											<tr>
												<th>Tech Details:</th>
												<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<tr> 
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											<tr>
												<th>Contact Info:</th>
												<td>[Name and Email goes here]</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
				</table>

	</c:forEach>
		</c:otherwise>
	</c:choose>



</div>


<div id="tab4">  <!--  Archived projects tab -->

	<c:choose>
		<c:when test="${fn:length(archivedOwnedProjectsList) == 0 && fn:length(archivedSharedProjectsList) == 0}">
		   <h5>You currently do not have any archived projects.</h5>
		</c:when>
		<c:otherwise>
		    


		    <div id="customProjectInstructions">Archived Projects which you owned:</div>
			<c:if test="${fn:length(archivedOwnedProjectsList) == 0}">
				<h5>None</h5>
			</c:if>
			<c:forEach var="project" items="${archivedOwnedProjectsList}">
				<c:choose>
					<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
						<c:set var="projectName" value="${project.metadata.title}"/>
					</c:when>
					<c:otherwise>
						<c:set var="projectName" value="${project.name}"/>
					</c:otherwise>
				</c:choose>

					<table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCell" colspan="3">
									<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
									<c:if test="${fn:length(project.sharedowners) > 0}">
										<div id="sharedNamesContainerArchived">
											This project is shared with:
											<div id="sharedNames">
												<c:forEach var="sharedowner" items="${project.sharedowners}">
												  <c:out value="${sharedowner.userDetails.firstname}"/>
												  <c:out value="${sharedowner.userDetails.lastname}"/>
												  <c:out value=",  "/>
												</c:forEach>
											</div>
										</div>
									</c:if>
							</td>
							<td class="actions" colspan="8"> 
									<ul>
										<li><a href="#" style="color:#666;">Un-Archived this Project</a></li>
									</ul>
							</td>
								<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title2" style="width:90px;">Project Family</th>
								<th id="title3" style="width:280px;" >Subject</th>
								<th id="title4" style="width:70px;">Grade Level</th>
								<th id="title5" style="width:105px;">Total Hours</th>
								<th id="title6" style="width:110px;">Computer Hours</th>
								<th id="title7" style="width:72px;">Language</th>
								<th id="title8" style="width:82px;">Tech Needs</th>
								<th id="title9" style="width:60px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">[English]</td> 
								<td class="dataCell">[Flash, Java]</td> 
								<td class="dataCell">${usageMap[project.id]}</td>
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">[List of comma-separated keywords go here]</td>
											</tr>

											<tr>
												<th>Tech Details:</th>
												<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<tr> 
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											<tr>
												<th>Contact Info:</th>
												<td>[Name and Email goes here]</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>

	</c:forEach>
	
		    <div id="customProjectInstructions">Archived Projects which were shared with you:</div>
			<c:if test="${fn:length(archivedSharedProjectsList) == 0}">
				<h5>None.</h5>
			</c:if>
			<c:forEach var="project" items="${archivedSharedProjectsList}">
				<c:choose>
					<c:when test='${project.metadata != null && project.metadata.title != null && project.metadata.title != ""}'>
						<c:set var="projectName" value="${project.metadata.title}"/>
					</c:when>
					<c:otherwise>
						<c:set var="projectName" value="${project.name}"/>
					</c:otherwise>
				</c:choose>
					<table id="projectOverviewTable">
							<tr id="row1">
							<td id="titleCell" colspan="3">
									<a href="../projectinfo.html?projectId=${project.id}">${projectName}</a>
									<c:if test="${fn:length(project.sharedowners) > 0}">
										<div id="sharedNamesContainerArchived">
											This project is shared with:
											<div id="sharedNames">
												<c:forEach var="sharedowner" items="${project.sharedowners}">
												  <c:out value="${sharedowner.userDetails.firstname}"/>
												  <c:out value="${sharedowner.userDetails.lastname}"/>
												  <c:out value=",  "/>
												</c:forEach>
											</div>
										</div>
									</c:if>
									
							</td>
							<td class="actions" colspan="8"> 
							</tr>
							<tr id="row2">
								<th id="title1" style="width:60px;">Project ID</th>
								<th id="title1" style="width:90px;">Project Family</th>
								<th id="title2" style="width:292px;" >Subject(s)</th>
								<th id="title3" style="width:100px;">Grades</th>
								<th id="title4" style="width:110px;">Total Time (hrs)</th>
								<th id="title5" style="width:110px;">Computer Time (hrs)</th>
								<th id="title6" style="width:92px;">Language</th>
								<th id="title7" style="width:90px;">Usage</th>
							</tr>
							<tr id="row3">
								<td class="dataCell libraryProjectSmallText">${project.id}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.familytag}</td>       		   
								<td class="dataCell libraryProjectSmallText">${project.metadata.subject}</td>
								<td class="dataCell">${project.metadata.gradeRange}</td>              
								<td class="dataCell">${project.metadata.totalTime}</td>              
								<td class="dataCell">${project.metadata.compTime}</td> 
								<td class="dataCell">[English]</td> 
								<td class="dataCell">${usageMap[project.id]} runs</td>
					
							</tr>
							<tr id="row4">  
								<td colspan="9">
									<a id="hideShowLink" href="#" onclick="toggleDetails(${project.id})">Hide/Show project details</a>
									<div id="details_${project.id}">
										<table id="detailsTable">
											<tr>
												<th>Summary:</th>
												<td class="summary">${project.metadata.summary}</td>
											</tr>
											<tr>
												<th>Keywords:</th>
												<td class="keywords">[List of comma-separated keywords go here]</td>
											</tr>

											<tr>
												<th>Tech Details:</th>
												<td>[This project requires Flash for Steps x,y,z and requires Java for steps a,b,c.]</td>
											</tr>
											<tr>
												<th>Created On:</th>
												<td class="keywords"><fmt:formatDate value="${project.dateCreated}" type="both" dateStyle="short" timeStyle="short" /></td>
											</tr>
											<tr> 
												<th>Original Author:</th>
												<td>[Name goes here]</td>
											</tr>
											<tr>
												<th>Contact Info:</th>
												<td>[Name and Email goes here]</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>

	</c:forEach>	
		</c:otherwise>
	</c:choose>


</div>

<div id="tab5">  <!--  My Project Runs tab -->
<h5>A listing of the project runs you have set up for classroom use can be found on the <a href="/webapp/teacher/index.html">Home Page</a> or in the <a href="/webapp/teacher/run/myprojectruns.html">Management/My Project Runs</a> section.</h5>
</div>

</div>
</div>


  
	
</div>

<script type="text/javascript">
    var tabView = new YAHOO.widget.TabView('projectInfoTabs');
    tabView.set('activeIndex', 0);
</script>

</body>
</html>
