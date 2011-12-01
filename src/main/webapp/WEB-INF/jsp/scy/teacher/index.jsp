<%@ include file="./include.jsp"%>
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

<!-- Core + Skin CSS --> 
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.1/build/menu/assets/skins/sam/menu.css"> 
 
<!-- Dependencies -->  
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/yahoo-dom-event/yahoo-dom-event.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/container/container_core-min.js"></script> 
 
<!-- Source File --> 
<!--<script type="text/javascript" src="http://yui.yahooapis.com/2.5.1/build/menu/menu-min.js"></script> -->
<!--The line above was commented out to switch from Slide animation to instant pop-up-->

<link href="../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script src=".././javascript/tels/general.js" type="text/javascript" ></script>
<script src=".././javascript/tels/prototype.js" type="text/javascript" ></script>
<script src=".././javascript/tels/effects.js" type="text/javascript" ></script>
<script src=".././javascript/tels/scriptaculous.js" type="text/javascript" ></script>

<title><spring:message code="application.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->



</head>

        <!-- Page-specific script -->

        <script type="text/javascript">

            /*
                 Initialize and render the MenuBar when its elements are ready 
                 to be scripted.
            */

            YAHOO.util.Event.onContentReady("quickToolsActionMenu", function () {

                /*
                     Instantiate a MenuBar:  The first argument passed to the 
                     constructor is the id of the element in the page 
                     representing the MenuBar; the second is an object literal 
                     of configuration properties.
                */

                var oMenuBar = new YAHOO.widget.MenuBar("quickToolsActionMenu", { 
                                                            autosubmenudisplay: true, 
                                                            hidedelay: 250, 
                                                            lazyload: true });

                /*
                     Define an array of object literals, each containing 
                     the data necessary to create a submenu.
                */

                var aSubmenuData = [
                
                    {
                        id: "quickToolsActionsList", 
                        itemdata: [ 
                            { text: "<spring:message code="teacher.index.41"/>", url: "http://www.excite.com" },
                            { text: "<spring:message code="teacher.index.42"/>", url: "http://news.google.com" },
                            { text: "<spring:message code="teacher.index.43"/>", url: "http://www.nytimes.com" },    
                        ]
                                      
                    },                   
                                             
                ];
                
                
                   
                
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

        </script>
        
<body class="yui-skin-sam"> 

<div id="centeredDiv">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table id="teacherHomeTable1" >
<tr>
<td id="welcomePanel" class="panelStyling">
			
			<div id="headerTeacherHome"><spring:message code="teacher.index.1"/></div>
			
			<table id="teacherWelcomeBoxTable"  cellpadding="3" cellspacing="0" >
					<tr class="tableRowBorder">
						<td class="tableColor" style="width:26%;"><spring:message code="teacher.index.2"/></td>
		                <td><sec:authentication property="principal.firstname" /> <sec:authentication property="principal.lastname" /></td>
					</tr>
					<tr class="tableRowBorder">
						<td class="tableColor" style="width:26%;"><spring:message code="teacher.index.3"/></td>
						<c:set var="current_date" value="<%= new java.util.Date() %>" />
						<td><fmt:formatDate value="${current_date}" type="both" dateStyle="short" timeStyle="short" /></td>
					</tr>
					<tr class="tableRowBorder">
						<td class="tableColor"><spring:message code="teacher.index.4"/></td>
						<td>
						<c:choose>
							<c:when test="${user.userDetails.lastLoginTime == null}">
								<spring:message code="teacher.index.5"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${user.userDetails.lastLoginTime}" 
									type="both" dateStyle="short" timeStyle="short" />
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td class="tableColor"><spring:message code="teacher.index.6"/></td>
						<td>
							<ul>
							<li><b>
							<c:choose>
						        <c:when test="${(current_date.hours>=3) && (current_date.hours<12)}" >
						            <spring:message code="teacher.index.7"/>
						        </c:when>
						        <c:when test="${(current_date.hours>=12) && (current_date.hours<18)}" >
									<spring:message code="teacher.index.8"/>
						        </c:when>
						        <c:otherwise>
									<spring:message code="teacher.index.9"/>
						        </c:otherwise>
						    </c:choose>
		    				</b></li>
							
							</ul>
						</td>
					</tr>
				</table> 
</td> 

<td style="width:12px;"></td>

<td id="projectsPanel" class="panelStyling" >

			<div id="headerTeacherHome"><spring:message code="teacher.index.10"/></div>

          	<div id="quickToolsContainer">
          	
          	<table id="quickToolsTable">
				    <tr>
				        <th><spring:message code="teacher.index.38"/></th>
				        <th><spring:message code="teacher.index.39A"/></th>
				        <th><spring:message code="teacher.index.39B"/></th>
				    </tr>
					
					<c:forEach var="run" items="${run_list}">
						<tr>
							<td style="width:40%;font-size:.7em;">${run.name}</td>
							<td style="width:10%;font-size:.6em;">${run.id}</td>
							<td style="padding:2px 4px;">
								<ul id="quickToolLinks">
									<li><a href="/webapp/previewproject.html?projectId=${run.project.id}"><spring:message code="teacher.index.41"/></a></li>
									<li><a href="grading/gradebystep.html?runId=${run.id}"><spring:message code="teacher.index.42"/></a></li>
									<li style="text-decoration:line-through"><a href="grading/selectworkgroup.html?runId=${run.id}"><spring:message code="teacher.index.43"/></a></li>
								</ul>
							</td>
					</c:forEach>
				
			  <!-- <c:forEach var="run" items="${run_list}">
						<tr>
							<td>${run.sdsOffering.name}</td>
							<td>${run.id}</td>
							<td>
							<div id="myMenu${run.id}" class="yuimenubar">
									<div class="bd">
										<ul class="first-of-type">
											<li class="yuimenubaritem first-of-type" style="width:100%;">
												<a class="yuimenubaritemlabel" href="#actions"><spring:message code="teacher.index.40"/></a>
												<div id="action" class="yuimenu">
													<div class="bd">
														<ul>
															<li class="yuimenuitem">
																<a class="yuimenuitemlabel" href="/webapp/previewproject.html?projectId=${run.project.id}"><spring:message code="teacher.index.41"/></a>
															</li>
															<li class="yuimenuitem">
																<a class="yuimenuitemlabel" href="grading/gradebystep.html?runId=${run.id}"><spring:message code="teacher.index.42"/></a>
															</li>
															<li class="yuimenuitem">
																<a class="yuimenuitemlabel" href="grading/selectworkgroup.html?runId=${run.id}"><spring:message code="teacher.index.43"/></a>
															</li>
														</ul>
													</div>
												</div>	
											</li>
										</ul>
									</div>
								</div>	
							</td>
						</tr>
					</c:forEach> -->
								  			   
			</table>
			</div>        <!--	end of quickToolsContainer	-->

</td>
</tr>
</table>

<table id="teacherHomeTable1" class="secondTableMargin" >
<tr>
<td id="dashboardPanel" class="panelStyling">

	<div id="headerTeacherHome"><spring:message code="teacher.index.13"/></div>
	
	<table id="dashboardSections" cellspacing="4" cellpadding="2">
		<tr>
			<td><a href="../teacher/index.html"	onmouseout="MM_swapImgRestore()"
				onmouseover="MM_swapImage('homebuttonmini','','.././themes/tels/default/images/teacher/Home-Mini-Button-Roll2.png',1)">
				<img src=".././themes/tels/default/images/teacher/Home-Mini-Button2.png"
				alt="Home Button Mini" id="homebuttonmini" /></a></td>
			<td><spring:message code="teacher.index.14"/></td>
		</tr>
		<tr>
			<td><a href="../teacher/projects/index.html"	onmouseout="MM_swapImgRestore()"
				onmouseover="MM_swapImage('projectbuttonmini','','.././themes/tels/default/images/teacher/Projects-Mini-Button-Roll2.png',1)">
				<img src=".././themes/tels/default/images/teacher/Projects-Mini-Button2.png"
				alt="Project Button Mini" id="projectbuttonmini" /></a></td>
			<td><spring:message code="teacher.index.15"/></td>
		</tr>
		<tr>
			<td><a href="../teacher/grading/overview.html"	onmouseout="MM_swapImgRestore()"
				onmouseover="MM_swapImage('gradingbuttonmini','','.././themes/tels/default/images/teacher/Grading-Mini-Button-Roll2.png',1)">
				<img src=".././themes/tels/default/images/teacher/Grading-Mini-Button2.png"
				alt="Grading Button Mini" id="gradingbuttonmini" /></a></td>
			<td><spring:message code="teacher.index.16"/></td>
		</tr>
		<tr>
			<td><a href="../teacher/management/overview.html"	onmouseout="MM_swapImgRestore()"
				onmouseover="MM_swapImage('managementbuttonmini','','.././themes/tels/default/images/teacher/Management-Mini-Button-Roll2.png',1)">
				<img src=".././themes/tels/default/images/teacher/Management-Mini-Button2.png"
				alt="Management Button Mini" id="managementbuttonmini" /></a></td>
			<td><spring:message code="teacher.index.17"/></td>
		</tr>
		<tr>
			<td><a href="../teacher/help/overview.html"	onmouseout="MM_swapImgRestore()"
				onmouseover="MM_swapImage('helpbuttonmini','','.././themes/tels/default/images/teacher/Help-Mini-Button-Roll2.png',1)">
				<img src=".././themes/tels/default/images/teacher/Help-Mini-Button2.png"
				alt="Help Button Mini" id="helpbuttonmini" /></a></td>
			<td><spring:message code="teacher.index.18"/></td>
		</tr>
	</table>
</td>

<td style="width:12px;"></td>

<td id="quickLinksPanel" class="panelStyling">

	<div id="headerTeacherHome"><spring:message code="teacher.index.19"/></div>

	<div id="quickLinks1">
		<div id="linkHeader"><spring:message code="teacher.index.20"/></div>
			<ul>
				<li><a href="projects/projectlibrary.html"><spring:message code="teacher.index.21"/></a></li>
				<li><a href="projects/bookmarkedprojects.html"><spring:message code="teacher.index.23"/></a></li>
				<li><a href="projects/customized/index.html"><spring:message code="teacher.index.24"/></a></li>
			</ul>
		<div id="linkHeader"><spring:message code="teacher.index.25"/></div>
			<ul>
				<li><a href="./grading/projectPickerGrading.html?gradeByType=step"><spring:message code="teacher.index.26"/></a></li>			
				<li><a href="./grading/projectPickerGrading.html?gradeByType=group"><spring:message code="teacher.index.27"/></a></li>
				<li class="inactivecolor"><spring:message code="teacher.index.28"/></li>
				<li><a href="./grading/premadeComments.html"><spring:message code="teacher.index.29"/></a></li>
			</ul>		
	</div>

	<div id="quickLinks2">
		<div id="linkHeader"><spring:message code="teacher.index.30"/></div>
		<ul>
			<li><a href="run/myprojectruns.html"><spring:message code="teacher.index.22"/></a></li>
			<li><a href="./management/projectPickerManagement.html"><spring:message code="teacher.index.31"/></a></li>			
			<li><a href="./management/projectpickerclassmonitor.html"><spring:message code="teacher.index.32"/></a></li>
			<li class="inactivecolor"><spring:message code="teacher.index.33"/></li>
			<li><a href="./management/updatemyaccount.html"><spring:message code="teacher.index.34"/></a></li>
		</ul> 
		<div id="linkHeader"><spring:message code="teacher.index.35"/></div> 
		<ul>
			<li class="inactivecolor"><spring:message code="teacher.index.36"/></li>
			<li><a href="../contactwisegeneral.html"><spring:message code="teacher.index.37"/></a></li>
		</ul>
	</div>

</td>
</tr>
</table>

</div>   <!-- End of centeredDiv-->

</body>

</html>









