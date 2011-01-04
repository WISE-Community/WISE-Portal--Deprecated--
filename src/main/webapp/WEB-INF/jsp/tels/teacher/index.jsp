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


<%@ include file="./projects/styles.jsp"%>

<!-- SuperFish drop-down menu from http://www.electrictoolbox.com/jquery-superfish-menus-plugin/  -->

<link rel="stylesheet" type="text/css" href=".././themes/tels/default/styles/teacher/superfish.css" media="screen">
<script type="text/javascript" src=".././javascript/tels/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src=".././javascript/tels/jquerycookie.js"></script>
<script type="text/javascript" src=".././javascript/tels/superfish.js"></script>
<script type="text/javascript" src=".././javascript/tels/browserdetect.js"></script>
<script type="text/javascript" src=".././javascript/tels/checkCompatibility.js"></script>

<script type="text/javascript">
    
            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });
    // only alert user about browser comptibility issue once.
    if ($.cookie("hasBeenAlertedBrowserCompatibility") != "true") {
    	alertBrowserCompatibility();
    }
	$.cookie("hasBeenAlertedBrowserCompatibility","true");           
</script>

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
<!--Disabled the next three scripts as they are conflicting with the SuperFish menu.  Need to debug.-->
<!--  <script src=".././javascript/tels/prototype.js" type="text/javascript" ></script> -->
<!--  <script src=".././javascript/tels/effects.js" type="text/javascript" ></script>   -->
<!--  <script src=".././javascript/tels/scriptaculous.js" type="text/javascript" ></script>  -->

<title><spring:message code="application.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="../javascript/tels/iefixes.js"></script>
<![endif]-->

<script type='text/javascript'>
var isTeacherIndex = true; //global var used by spawned pages (i.e. archive run)
</script>


<script type="text/javascript">

/***********************************************
* ADDED BY MATTFISH  DEC 2009
* IFrame SSI script II- © Dynamic Drive DHTML code library (http://www.dynamicdrive.com)
* Visit DynamicDrive.com for hundreds of original DHTML scripts
* This notice must stay intact for legal use
***********************************************/

//Input the IDs of the IFRAMES you wish to dynamically resize to match its content height:
//Separate each ID with a comma. Examples: ["myframe1", "myframe2"] or ["myframe"] or [] for none:
var iframeids=["dynamicFrame"]

//Should script hide iframe from browsers that don't support this script (non IE5+/NS6+ browsers. Recommended):
var iframehide="yes"

var getFFVersion=navigator.userAgent.substring(navigator.userAgent.indexOf("Firefox")).split("/")[1]
var FFextraHeight=parseFloat(getFFVersion)>=0.1? 16 : 0 //extra height in px to add to iframe in FireFox 1.0+ browsers

function resizeCaller() {
var dyniframe=new Array()
for (i=0; i<iframeids.length; i++){
if (document.getElementById)
resizeIframe(iframeids[i])
//reveal iframe for lower end browsers? (see var above):
if ((document.all || document.getElementById) && iframehide=="no"){
var tempobj=document.all? document.all[iframeids[i]] : document.getElementById(iframeids[i])
tempobj.style.display="block"
}
}
}

function resizeIframe(frameid){
var currentfr=document.getElementById(frameid)
if (currentfr && !window.opera){
currentfr.style.display="block"
if (currentfr.contentDocument && currentfr.contentDocument.body.offsetHeight) //ns6 syntax
currentfr.height = currentfr.contentDocument.body.offsetHeight+FFextraHeight; 
else if (currentfr.Document && currentfr.Document.body.scrollHeight) //ie5+ syntax
currentfr.height = currentfr.Document.body.scrollHeight;
if (currentfr.addEventListener)
currentfr.addEventListener("load", readjustIframe, false)
else if (currentfr.attachEvent){
currentfr.detachEvent("onload", readjustIframe) // Bug fix line
currentfr.attachEvent("onload", readjustIframe)
}
}
}

function readjustIframe(loadevt) {
var crossevt=(window.event)? event : loadevt
var iframeroot=(crossevt.currentTarget)? crossevt.currentTarget : crossevt.srcElement
if (iframeroot)
resizeIframe(iframeroot.id);
}

function loadintoIframe(iframeid, url){
if (document.getElementById)
document.getElementById(iframeid).src=url
}

if (window.addEventListener)
window.addEventListener("load", resizeCaller, false)
else if (window.attachEvent)
window.attachEvent("onload", resizeCaller)
else
window.onload=resizeCaller

</script>

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

            /**
             * Asynchronously updates the run with the given id on the server and 
             * displays the appropriate method when completed.
             */
            function extendReminder(id){
				var runLI = document.getElementById('extendReminder_' + id);
				var callback = {
						success:function(o){
							runLI.innerHTML = '<font color="24DD24">You will be reminded to archive project run id ' + id + ' again in 30 days.</font>';
						},
						failure:function(o){
							runLI.innerHTML = '<font color="DD2424">Unable to update the project run with id ' + id + ' on server.</font>';
						},
						scope:this
				};

				runLI.innerHTML = 'Updating run on server...';
				YAHOO.util.Connect.asyncRequest('GET', 'run/manage/extendremindertime.html?runId=' + id, callback, null);
            };

            function archiveRun(runId){
				var runLI = document.getElementById('extendReminder_' + runId);
				
				var callback = {
					success:function(o){
						/* update message on teacher index page announcements section */
						runLI.innerHTML = '<font color="24DD24">Run with id ' + runId + ' has been archived.</font>';

						/* remove archived run from quick runs list */
						var child = window.frames['dynamicFrame'].document.getElementById('runTitleRow_' + runId);
						child.parentNode.removeChild(child);
					},
					failure:function(o){
						/* set failure message */
						runLI.innerHTML = '<font color="992244">Unable to archive run! Refresh this page to try again.</font>';
					},
					scope:this
				};	

				runLI.innerHTML = 'Archiving run on server...';
				YAHOO.util.Connect.asyncRequest('POST', 'run/manage/archiveRun.html?runId=' + runId, callback, null);
            };

            // asynchronously archives a message
            function archiveMessage(messageId, sender) {
				var messageDiv = document.getElementById('message_' + messageId);
				
				var callback = {
					success:function(o){
						/* update message on teacher index page announcements section */
						messageDiv.parentNode.removeChild(messageDiv);
						document.getElementById("message_confirm_div_" + messageId).innerHTML = '<font color="24DD24">Message from ' + sender + ' has been archived.</font>';
						/* update count of new message in message count div */
						var messageCountDiv = document.getElementById("newMessageCountDiv");
						var messages = document.getElementsByClassName("messageDiv");
						if (messages.length > 0) {
							messageCountDiv.innerHTML = "You have " + messages.length + " new message(s).";
						} else {
							messageCountDiv.innerHTML = "";
						}
					},
					failure:function(o){
						/* set failure message */
						messageDiv.innerHTML = '<font color="992244">Unable to archive message! Refresh this page to try again.</font>';
					},
					scope:this
				};	

				messageDiv.innerHTML = 'Archiving message on server...';
				YAHOO.util.Connect.asyncRequest('POST', '/webapp/message.html?action=archive&messageId='+messageId, callback, null);
            }
        </script>
    
<body class="yui-skin-sam"> 

<div id="centeredDiv">

<%@ include file="headerteacher.jsp"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="column1">

<div class="panelStyleStatus">

				<div id="headerTeacherHome">Status</div>

				<table id="teacherStatusTable" cellpadding="3" cellspacing="0">
						<tr>
						<th><spring:message code="teacher.index.4" /></th>
								<td><c:choose>
										<c:when test="${user.userDetails.lastLoginTime == null}">
												<spring:message code="teacher.index.5" />
										</c:when>
										<c:otherwise>
												<fmt:formatDate value="${user.userDetails.lastLoginTime}" type="both" dateStyle="short" timeStyle="short" />
										</c:otherwise>
								</c:choose></td>
						</tr>
						<tr class="tableRowBorder">
								<th><spring:message code="teacher.index.3" /></th>
								<c:set var="current_date" value="<%= new java.util.Date() %>" />
								<td><fmt:formatDate value="${current_date}" type="both" dateStyle="short" timeStyle="short" /></td>
						</tr>
						
				</table>

				</div>

<div class="panelStyleMessages">

<div id="headerTeacherHome">Messages</div>

<table id="teacherMessageTable" cellpadding="2" cellspacing="0">
		<tr>
				<td>
				<ul class="announcementsList">
						<li><b> <c:choose>
								<c:when test="${(current_date.hours>=4) && (current_date.hours<5)}">
										<spring:message code="teacher.index.7A" />
								</c:when>
								<c:when test="${(current_date.hours>=5) && (current_date.hours<6)}">
										<spring:message code="teacher.index.7C" />
								</c:when>
								<c:when test="${(current_date.hours>=6) && (current_date.hours<6.5)}">
										"Each morning we are born again.  What we do today is what matters most."  (Guatama Siddharta)
								</c:when>
								<c:when test="${(current_date.hours>=6.5) && (current_date.hours<7)}">
										<spring:message code="teacher.index.7D" />
								</c:when>
								<c:when test="${(current_date.hours>=7) && (current_date.hours<9)}">
										<spring:message code="teacher.index.7B" />
								</c:when>
								<c:when test="${(current_date.hours>=9) && (current_date.hours<10)}">
										<spring:message code="teacher.index.7E" />
								</c:when>
								<c:when test="${(current_date.hours>=10) && (current_date.hours<11)}">
										<spring:message code="teacher.index.7F" />
								</c:when>
								<c:when test="${(current_date.hours>=11) && (current_date.hours<11.5)}">
										<spring:message code="teacher.index.7G" />
								</c:when>
								<c:when test="${(current_date.hours>=11.5) && (current_date.hours<12)}">
										"Time flies like an arrow.  Fruit flies like a banana."  (Groucho Marx)
								</c:when>
								<c:when test="${(current_date.hours>=12) && (current_date.hours<15)}">
										<spring:message code="teacher.index.8A" />
								</c:when>
								<c:when test="${(current_date.hours>=15) && (current_date.hours<18)}">
										<spring:message code="teacher.index.8B" />
								</c:when>
								<c:when test="${(current_date.hours>=18) && (current_date.hours<22)}">
										<spring:message code="teacher.index.8C" />
								</c:when>
								<c:when test="${(current_date.hours>=22) && (current_date.hours<23)}">
										<spring:message code="teacher.index.9A" />
								</c:when>
								<c:when test="${(current_date.hours>=23) && (current_date.hours<24)}">
										<spring:message code="teacher.index.9B" />
								</c:when>
								<c:otherwise>
										<spring:message code="teacher.index.9C" />
								</c:otherwise>
						</c:choose> </b></li>
						<c:if test="${not user.userDetails.emailValid}">
						   <div id="invalidEmailDiv" style="color:red">Your email seems to be invalid. Please <a href="management/updatemyaccountinfo.html">EDIT</a> it now.</div>
						</c:if>
						<c:forEach var="run" items="${run_list}">
								<c:if test='${(run.archiveReminderTime.time - current_date.time) < 0}'>
										<li id='extendReminder_${run.id}'>Your project run <i>${run.name}</i> has been open since
										<fmt:formatDate value="${run.starttime}" type="date" dateStyle="short" timeStyle="short" />.
										 Do
										you want to archive it now? [ <a class="runArchiveLink"
												onclick="archiveRun('${run.id}')"><font
												color='blue'>Yes</font></a>/ <a class="runArchiveLink" onclick='extendReminder("${run.id}")'><font color='blue'>Remind Me Later</font></a>].</li>
								</c:if>
						</c:forEach>
						<c:if test="${fn:length(unreadMessages) > 0}">
							<div id="newMessageCountDiv"><c:out value="You have ${fn:length(unreadMessages)} new message(s)."/><br/></div>
							<c:forEach var="message" items="${unreadMessages}">
							    <div class="messageDiv" id="message_${message.id}">
							    <table class='messageDisplayTable'>
								<tr><th>Date:</th><td><fmt:formatDate value="${message.date}" type="both" dateStyle="short" timeStyle="short" /></td></tr>
								<tr><th>From:</th><td><c:out value="${message.sender.userDetails.username}"/></td></tr>
								<tr><th>Subject:</th><td><c:out value="${message.subject}"/></td></tr>
								<tr><td colspan='2' class='messageBody'><c:out value="${message.body}" /></td></tr>
								<tr><td colspan='2'>
									<a class="messageArchiveLink" onclick="archiveMessage('${message.id}', '${message.sender.userDetails.username}');">Archive</a> | 
									<a class="messageReplyLink" href="/webapp/message.html?action=index">Reply</a></td></tr>
								</table>
								</div>
								<div id="message_confirm_div_${message.id}"></div>
							</c:forEach>
						</c:if>
				</ul>
				</td>
		</tr>
</table>

<div id="manageMessageContainer"><a href="/webapp/message.html?action=index">View & Send Messages</a></div>

</div>

<!--  
		<div class="panelStyleCommunity">
				<div id="headerTeacherHome">Community Tools</div>
				<ul>
						<li>Launch your <a href="#" class="lineThrough">Community Overview</a></li>
						<li>Launch <a href="#" class="lineThrough">MyShared Projects Forum</a></li>
						<li>Launch <a href="#" class="lineThrough">SharedWithMe Forum</a></li>
						<li>Launch <a href="#" class="lineThrough">Mentor Forum</a></li>
						<li>Launch <a href="#" class="lineThrough">Professional Development Forum</a></li>
				</ul>
		</div>
-->

</div>

<div id="column2">

<div class="panelStyleMyProjectRuns">

				<div id="headerTeacherHome">My Project Runs</div>

				<iframe id="dynamicFrame" name="dynamicFrame" src="run/projectruntabs.html" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"
						vspace="0" hspace="0" style="overflow: auto; width: 100%; display: none; margin-top: 5px;"></iframe>

				</div>
</div>

</div>   <!-- End of centeredDiv-->

</body>

</html>









