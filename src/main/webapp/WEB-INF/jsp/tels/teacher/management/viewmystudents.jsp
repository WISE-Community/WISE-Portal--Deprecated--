<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html lang="en">

<link href="../../<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />


<title><spring:message code="viewmystudents.message" /></title>

<!-- FOR LATER REFACTOR <script src="../../../javascript/tels/custom-yui/changegroupdnd.js" type="text/javascript"> </script> -->
<head>
<%@ include file="../grading/styles.jsp"%>
<script type="text/javascript" src="../.././javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../.././javascript/tels/yui/event/event.js"></script>  
<script type="text/javascript" src="../.././javascript/tels/yui/connection/connection.js"></script> 
<script type="text/javascript" src="../.././javascript/tels/general.js"></script>
<script type="text/javascript" src="../.././javascript/tels/utils.js"></script>
<script type="text/javascript" src="../.././javascript/tels/teacher/management/viewmystudents.js"></script>



<script>
if (${workgroupsWithoutPeriod != ""}) {
	alert("You have workgroups that are not associated with periods. "
			+" Please talk to a WISE staff to fix this problem. ID: ${workgroupsWithoutPeriod}");
}
    var tabView;
	function init() {
   		tabView = new YAHOO.widget.TabView('tabSystem');
		tabView.set('activeIndex', ${tabIndex});
    }
    YAHOO.util.Event.onDOMReady(init);

        var newGroupCount = 0;
        var numPeriods = ${fn:length(viewmystudentsallperiods)};
        var workgroupchanges = new Array();
        
        var handleSuccess = function(o){

			if(o.responseText !== undefined){
				var newHREF= window.location.href + "&tabIndex=" + o.responseText;
	   			setTimeout("window.location.href='" +newHREF +"'", 500);
			}
}

var callback =
{
  success: handleSuccess 
}


function createNewWorkgroup(periodId, runId) {
  //alert(newGroupCount);
  var newWorkgroupId = -1 - newGroupCount;
  var workareaDiv = document.getElementById("div_for_new_workgroups_"+periodId);
  workareaDiv.innerHTML += "<div class='workarea' id='newgroup_div_"+periodId+"_"+newWorkgroupId+"'>"
                          +"<ul id='ul_"+periodId+"_newgroup_"+newWorkgroupId+"' class='draglist'><li>UNSAVED TEAM. Drag student names here, then click SAVE button (below) to confirm changes.</li></ul>"
                          +"</div>";
                          
   // need to iterate through all of the newgroups
   // and re-register DDTarget and DDList; not sure why,
   // but is needed HT                       
   for (q=0; q <= newGroupCount; q++) {
        var newWGId = - 1 - q;
        var ulid= "ul_"+periodId+"_newgroup_"+newWGId;
        new YAHOO.util.DDTarget(ulid);
        var ulElm = document.getElementById(ulid);
        var liElmsInUl = ulElm.getElementsByTagName("li");
        for (h=0; h<liElmsInUl.length; h++) {
            new YAHOO.example.DDList(liElmsInUl[h].id);
        }
   }
                              
  newGroupCount++;
}
</script>

<script type="text/javascript">

    YAHOO.namespace("example.container");

    function initLoading() {

        if (!YAHOO.example.container.wait) {

            // Initialize the temporary Panel to display while waiting for external content to load

            YAHOO.example.container.wait = 
                    new YAHOO.widget.Panel("wait",  
                                                    { width: "240px", 
                                                      fixedcenter: true, 
                                                      close: false, 
                                                      draggable: false, 
                                                      zindex:4,
                                                      modal: true,
                                                      visible: false
                                                    } 
                                                );
    
            YAHOO.example.container.wait.setHeader("Loading, please wait...");
            YAHOO.example.container.wait.setBody("<img src=/webapp/themes/tels/default/images/rel_interstitial_loading.gif />");
            YAHOO.example.container.wait.render(document.body);

        }

        // Define the callback object for Connection Manager that will set the body of our content area when the content has loaded
        var callback = {
            success : function(o) {
                YAHOO.example.container.wait.hide();
            },
            failure : function(o) {
                YAHOO.example.container.wait.hide();
            }
        }
    
        // Show the Panel
        YAHOO.example.container.wait.show();
        
    }
    
    <c:forEach var="viewmystudentsperiod" items="${viewmystudentsallperiods}" >
          YAHOO.util.Event.on("saveButton_${viewmystudentsperiod.period.id}", "click", initLoading);
    </c:forEach>
		
</script>


<script type="text/javascript"><!--
(function() {

var Dom = YAHOO.util.Dom;
var Event = YAHOO.util.Event;
var DDM = YAHOO.util.DragDropMgr;

//////////////////////////////////////////////////////////////////////////////
// example app
//////////////////////////////////////////////////////////////////////////////
YAHOO.example.DDApp = {
    init: function() { 
         // this function initializes the drag-able lists and adds action listeners to the 
         // save button
         //alert(${fn:length(viewmystudentsallperiods)});
        <c:forEach var="viewmystudentsperiod" items="${viewmystudentsallperiods}" >
          Event.on("saveButton_${viewmystudentsperiod.period.id}", "click", this.showOrder);
          Event.on("switchButton", "click", this.switchStyles);
          new YAHOO.util.DDTarget("ul_${viewmystudentsperiod.period.id}_groupless");
          //alert("ul_${viewmystudentsperiod.period.name}");
          //alert(${fn:length(viewmystudentsperiod.grouplessStudents)});
          <c:forEach var="grouplessStudent" items="${viewmystudentsperiod.grouplessStudents}" >
            //alert("li_${grouplessStudent.id}");
            new YAHOO.example.DDList("li_${grouplessStudent.id}_groupless");
            //alert("li_${grouplessStudent.id}");
          </c:forEach>
          //alert(${fn:length(viewmystudentsperiod.workgroups)});
          <c:forEach var="workgroupInPeriod" items="${viewmystudentsperiod.workgroups}" >
            new YAHOO.util.DDTarget("ul_${viewmystudentsperiod.period.id}_workgroup_${workgroupInPeriod.id}");
            <c:forEach var="workgroupMember" items="${workgroupInPeriod.members}" >
              new YAHOO.example.DDList("li_${workgroupMember.id}_${workgroupInPeriod.id}");
            </c:forEach>
          </c:forEach>
        </c:forEach>
    },

    showOrder : function(event) {
        // this function saves the workgroup configurations of the group
        // it also popus the current workgroup configuration
        var elTarget = YAHOO.util.Event.getTarget(event);    
        var parseList = function(ul, title) {
            var items = ul.getElementsByTagName("li");
            var out = title + ": ";
            for (i=0;i<items.length;i=i+1) {
                out += items[i].id + " ";
            }
            return out;
        };
        
        //alert(elTarget.id);
        
        var changes = "";
        for (key in workgroupchanges) {
            changes += "userId: " + key + "workgroupFrom: " + workgroupchanges[key]["workgroupFrom"]
                    + "workgroupTo: " + workgroupchanges[key]["workgroupTo"] + "\n";
        }
        //alert(changes);
        
        <c:forEach var="viewmystudentsperiod" items="${viewmystudentsallperiods}" >
          var periodId=${viewmystudentsperiod.period.id}
          if (elTarget.id == "saveButton_"+periodId) {
            var grouplessUl=Dom.get("ul_"+periodId+"_groupless")
            var out = parseList(grouplessUl, "unassigned students")

            <c:forEach var="workgroupInPeriod" items="${viewmystudentsperiod.workgroups}" >
              var workgroupUl = document.getElementById("ul_"+periodId+"_workgroup_${workgroupInPeriod.id}");
              out += parseList(workgroupUl, "\nWorkgroup with id: ${workgroupInPeriod.id}");
            </c:forEach>
            //alert(out);
            var submitChangesUrl = "submitworkgroupchanges.html";
            var numChanges = 0;
            for (key in workgroupchanges) {
              numChanges++;
            }
            var changeIndex = 0;
            var postData = 'tabIndex='+tabView.get("activeIndex")+'&numChanges=' + numChanges + '&periodId='+periodId+'&runId='+${viewmystudentsperiod.run.id};
            for (userId in workgroupchanges) {              
              var workgroupFrom = workgroupchanges[userId]["workgroupFrom"];
              var workgroupTo = workgroupchanges[userId]["workgroupTo"];
              postData += '&userId_'+changeIndex +'='+userId+'&workgroupFrom_'+changeIndex +'='+workgroupFrom+'&workgroupTo_'+changeIndex +'='+workgroupTo;
              changeIndex++;
            }
            //alert(postData);
            var request = YAHOO.util.Connect.asyncRequest('POST', submitChangesUrl, callback, postData);
            // make sure that *all* changes in workgroupchanges are persisted...so wait 5-6 seconds and then refresh the page
            //setTimeout( "window.location.reload()", 5000 );
            
          }
        </c:forEach>
                
    },

    switchStyles: function() {
        Dom.get("ul1").className = "draglist_alt";
        Dom.get("ul2").className = "draglist_alt";
    }
    
};

//////////////////////////////////////////////////////////////////////////////
// custom drag and drop implementation
//////////////////////////////////////////////////////////////////////////////

YAHOO.example.DDList = function(id, sGroup, config) {

    YAHOO.example.DDList.superclass.constructor.call(this, id, sGroup, config);

    this.logger = this.logger || YAHOO;
    var el = this.getDragEl();
    Dom.setStyle(el, "opacity", 0.67); // The proxy is slightly transparent

    this.goingUp = false;
    this.lastY = 0;
};

YAHOO.extend(YAHOO.example.DDList, YAHOO.util.DDProxy, {

    startDrag: function(x, y) {
        this.logger.log(this.id + " startDrag");
        //var workgroupli = document.getElementById(this.id);
        
        //workgroupchanges[this.id] = workgroupli.innerHTML;
        //this.logger.log("body: " + workgroupli.innerHTML + " startDrag");

        // make the proxy look like the source element
        var dragEl = this.getDragEl();
        var clickEl = this.getEl();
        Dom.setStyle(clickEl, "visibility", "hidden");

        dragEl.innerHTML = clickEl.innerHTML;

        Dom.setStyle(dragEl, "color", Dom.getStyle(clickEl, "color"));
        Dom.setStyle(dragEl, "backgroundColor", Dom.getStyle(clickEl, "backgroundColor"));
        Dom.setStyle(dragEl, "border", "2px solid gray");
    },

    endDrag: function(e) {
        this.logger.log(this.id + " endDrag");
        var lastIndexOf_ = this.id.lastIndexOf("_");
        var workgroupFrom = this.id.substr(lastIndexOf_ + 1);
        var userId = this.id.substring(3, lastIndexOf_);
        this.logger.log("last index: " + lastIndexOf_);
        this.logger.log("workgroupFrom: " + workgroupFrom);
        this.logger.log("userId: " + userId);
        workgroupchanges[userId] = new Array();
        workgroupchanges[userId]["workgroupFrom"] = workgroupFrom;
        var elTarget = YAHOO.util.Event.getTarget(e);    
        this.logger.log("elTarget.id: " + elTarget.id);
        this.logger.log("elTarget.tagName: " + elTarget.tagName);
        this.logger.log("elTarget.parentNode: " + elTarget.parentNode);
        this.logger.log("elTarget.parentNode.tagName: " + elTarget.parentNode.tagName);

        var srcEl = this.getEl();
        var proxy = this.getDragEl();

        // Show the proxy element and animate it to the src element's location
        Dom.setStyle(proxy, "visibility", "");
        var a = new YAHOO.util.Motion( 
            proxy, { 
                points: { 
                    to: Dom.getXY(srcEl)
                }
            }, 
            0.2, 
            YAHOO.util.Easing.easeOut 
        )
        var proxyid = proxy.id;
        var thisid = this.id;

        // Hide the proxy and show the source element when finished with the animation
        a.onComplete.subscribe(function() {
                Dom.setStyle(proxyid, "visibility", "hidden");
                Dom.setStyle(thisid, "visibility", "");
                
                var element = document.getElementById(thisid);
                //alert("element: " + element);
                //alert("element.id: " + element.id);
                //alert("element.parentNode.tagName: " + element.parentNode.tagName);
                //alert("element.parentNode.id: " + element.parentNode.id);
                workgroupToUlStr = element.parentNode.id;
                var lastIndexOf_ = workgroupToUlStr.lastIndexOf("_");
                var workgroupTo = workgroupToUlStr.substr(lastIndexOf_ + 1);
                //alert("workgroupTo: " + workgroupTo);
        		workgroupchanges[userId]["workgroupTo"] = workgroupTo;
                
            });
        a.animate();
    },

    onDragDrop: function(e, id) {
        //this.logger.log(this.id + " onDragDrog");

        // If there is one drop interaction, the li was dropped either on the list,
        // or it was dropped on the current location of the source element.
        if (DDM.interactionInfo.drop.length === 1) {

            // The position of the cursor at the time of the drop (YAHOO.util.Point)
            var pt = DDM.interactionInfo.point; 

            // The region occupied by the source element at the time of the drop
            var region = DDM.interactionInfo.sourceRegion; 

            // Check to see if we are over the source element's location.  We will
            // append to the bottom of the list once we are sure it was a drop in
            // the negative space (the area of the list without any list items)
            if (!region.intersect(pt)) {
                var destEl = Dom.get(id);
                var destDD = DDM.getDDById(id);
                destEl.appendChild(this.getEl());
                destDD.isEmpty = false;
                DDM.refreshCache();
            }

        }
    },

    onDrag: function(e) {

        // Keep track of the direction of the drag for use during onDragOver
        var y = Event.getPageY(e);

        if (y < this.lastY) {
            this.goingUp = true;
        } else if (y > this.lastY) {
            this.goingUp = false;
        }

        this.lastY = y;
    },

    onDragOver: function(e, id) {
    
        var srcEl = this.getEl();
        var destEl = Dom.get(id);

        // We are only concerned with list items, we ignore the dragover
        // notifications for the list.
        if (destEl.nodeName.toLowerCase() == "li") {
            var orig_p = srcEl.parentNode;
            var p = destEl.parentNode;

            if (this.goingUp) {
                p.insertBefore(srcEl, destEl); // insert above
            } else {
                p.insertBefore(srcEl, destEl.nextSibling); // insert below
            }

            DDM.refreshCache();
        }
    }
});

Event.onDOMReady(YAHOO.example.DDApp.init, YAHOO.example.DDApp, true);

})();
--></script>

<!--Simple script for hiding and showing Instructions Div-->
<script type="text/javascript">
<!--
    function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }
//-->
</script>

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

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="../../<spring:theme code="viewmystudentsstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /><link href="../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

</head>

<body class="yui-skin-sam">

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Manage Students<span id="navigationSubHeader1">management</span></div>

<table id="projectTitleBox" border=0>
	<tr>
		<th>${project_name}</th>
		<td>(Project ID: ${project_id})</td>
	</tr>
</table>

<div id="printLink">
	<img src="../../themes/tels/default/images/printer.png" width="16" height="16" alt="Printer Icon" />
    <a id="printLinkText" href="studentlist.html?runId=${run.id}"><spring:message code="teacher.manage.viewstudents.20"/></a>
</div>

<div id="exportToExelLink">
	<img src="../../themes/tels/default/images/printer.png" width="16" height="16" alt="Printer Icon" />
    <a id="printLinkText" href="studentlistexcel.html?runId=${run.id}"><spring:message code="teacher.manage.viewstudents.22"/></a>
</div>


<div id="tabSystem" class="yui-navset">
<ul class="yui-nav" style="font-size:.8em;"> 
	<c:forEach var="viewmystudentsperiod" varStatus="periodStatus" items="${viewmystudentsallperiods}">
		<li style="padding-right:3px; padding-top:0px; margin-top:0px;"><a href="${viewmystudentsperiod.period.name}"><em>Period ${viewmystudentsperiod.period.name}</em></a></li>
	</c:forEach>
</ul>
<div class="yui-content" style="background-color:#FFFFFF;">

  <c:forEach var="viewmystudentsperiod" varStatus="periodStatus" items="${viewmystudentsallperiods}">
	<div><c:choose>
		<c:when test="${fn:length(viewmystudentsperiod.period.members) == 0}">
   		    <!--  there is NO student in this period  -->
				<spring:message code="teacher.manage.viewstudents.2"/>
			</c:when>
		<c:otherwise>
		    <!--  there are students in this period  -->
		    <ul id="periodHeaderBar">
		    	<li class="periodHeaderStart"><spring:message code="teacher.manage.viewstudents.3"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.period.members)}</span></li>
		    	<li class="periodHeaderStart"><spring:message code="teacher.manage.viewstudents.4"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.workgroups)}</span></li>
		    	<li class="periodHeaderStart""><spring:message code="teacher.manage.viewstudents.5"/>&nbsp;<span class="manageDataStyle">${viewmystudentsperiod.run.runcode}-${viewmystudentsperiod.period.name}</span></li>
		    	<li class="viewStudentsLink"><a onclick="javascript:createNewWorkgroup(${viewmystudentsperiod.period.id}, ${viewmystudentsperiod.run.id});"><spring:message code="teacher.manage.viewstudents.6"/></a></li>
		     	<li class="viewStudentsLink"><a onclick="javascript:popup640('batchstudentchangepassword.html?groupId=${viewmystudentsperiod.period.id}&runId=${viewmystudentsperiod.run.id}');"><spring:message code="teacher.manage.viewstudents.7"/></a></li>
		       	<li style="display:none;" class="viewStudentsLink"><a href="#" onclick="javascript:popup('#');"><spring:message code="teacher.manage.viewstudents.8"/></a></li>
		    </ul>
		  	
		  <div href="#" id="instructionsBar" onclick="toggle_visibility('viewStudentsInstructions');">Help <span class="subText">&nbsp;&nbsp;Click here to show/hide instructions</span></div>
		 
			<div style="display:none;" id="viewStudentsInstructions">
						<table>
								<tr>
										<th>Create New Teams:</th>
										<td>Click the "Create a New Team" button to create an empty team box. Click/drag 1-3 student names into the
										box. Click SAVE.</td>
								</tr>
								<tr>
										<th>Remove a Student</th>
										<td>Click the "</td>
								</tr>
								<tr>
										<th>Moving Unassigned Students:</th>
										<td>Click/drag unassigned students from one box to another. Click SAVE CHANGES.</td>
								</tr>

								<tr>
										<th>Moving Students already in a Team:</th>
										<td>Click the "Create a New Team" button to create an empty team box. Click/drag 1-3 student names into the
										box. Click SAVE.</td>
								</tr>
								<!-- 
								<tr>
										<th>Exporting a Team's Work to PDF</th>
										<td>Click the "Create PDF file" link within a particular team box.</td>
								</tr>
								 -->
						</table>

						</div>	
		<table id="manageStudentsTable">
			<tr>
			<td>
			<div class="workarea" id="groupless_div_${viewmystudentsperiod.period.id}">
			  <ul id="ul_${viewmystudentsperiod.period.id}_groupless" class="draglist">
			    <li class="grouplessHeader"><spring:message code="teacher.manage.viewstudents.17"/></li>

                <c:forEach var="mem" items="${viewmystudentsperiod.grouplessStudents}">
			      <li class="grouplesslist" id="li_${mem.id}_groupless">
			      
			         <span id="userNameWithinView">${mem.userDetails.firstname} ${mem.userDetails.lastname}</span>
    			     <span id="userLinksBar">
    			     <a class="userLinks" onclick="javascript:popupSpecial('../../studentinfo.html?userName=${mem.userDetails.username}');" href="#" >Info</a>
    			     <a class="userLinks" href="#" onclick="javascript:popup640('changestudentpassword.html?userName=${mem.userDetails.username}');">Password</a>
    			     <a class="userLinks" href="#" onclick="javascript:popup640('changestudentperiod.html?userId=${mem.id}&runId=${viewmystudentsperiod.run.id}&projectCode=${viewmystudentsperiod.period.name}');">Period</a>
    			     <a class="userLinks" href="#" onclick="javascript:popupSpecial('removestudentfromrun.html?runId=${viewmystudentsperiod.run.id}&userId=${mem.id}');">Remove</a>
    			     </span>
    			  </li>
			    </c:forEach>
  			  </ul>
			</div>
			</td>
			<td>
			<div id="div_for_new_workgroups_${viewmystudentsperiod.period.id}"></div>
			</td>
			</tr>
			<tr>
            <c:forEach var="workgroupInPeriod" varStatus="workgroupVarStatus" items="${viewmystudentsperiod.workgroups}" >
                <td>
              <div class="workarea" id="div_${workgroupInPeriod.id}">
			    <ul id="ul_${viewmystudentsperiod.period.id}_workgroup_${workgroupInPeriod.id}" class="draglist">  
			      <li class="workgroupHeader">TEAM ${workgroupInPeriod.id}
			        <!-- <a class="createPdfLink" href="${workgroupInPeriod.workPDFUrl}"><spring:message code="teacher.manage.viewstudents.18"/></a>   -->
			      </li>
			      
			      <c:forEach var="workgroupMember" items="${workgroupInPeriod.members}">
			      
			        <li class="workgrouplist" id="li_${workgroupMember.id}_${workgroupInPeriod.id}">
			         <span id="userNameWithinView">${workgroupMember.userDetails.firstname} ${workgroupMember.userDetails.lastname} (${workgroupMember.userDetails.username})</span>
    			     <span id="userLinksBar">
    			     <a class="userLinks" onclick="javascript:popupSpecial('../../studentinfo.html?userName=${workgroupMember.userDetails.username}');" href="#" >Info</a>
    			     <a class="userLinks" href="#" onclick="javascript:popup640('changestudentpassword.html?userName=${workgroupMember.userDetails.username}');">Password</a>
    			     <a class="userLinks" href="#" onclick="javascript:popup640('changestudentperiod.html?userId=${workgroupMember.id}&runId=${viewmystudentsperiod.run.id}&projectCode=${viewmystudentsperiod.period.name}');">Period</a>
       			     <a class="userLinks" href="#" onclick="javascript:popup640('removestudentfromrun.html?runId=${viewmystudentsperiod.run.id}&userId=${workgroupMember.id}');">Remove</a>
    			     </span>
			        </li>
			      </c:forEach>
			    </ul>
			   </div>
                 </td>                
                <c:choose>
                    <c:when test="${workgroupVarStatus.index % 2 == 1}" >
                      </tr><tr>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
              </c:choose>
            </c:forEach>
            </tr>
            </table>
            
         <div id="saveBar">
         		<input type="button" class="saveButton" id="saveButton_${viewmystudentsperiod.period.id}" 
            	value="<spring:message code="teacher.manage.viewstudents.19"/>" />
          </div> 
     
		</c:otherwise>
	</c:choose>
	
	
	</div>
    </c:forEach>
</div>

</div> 


</div>     <!--End of Centered Div-->

<!-- 
// THE DEBUGGING CONSOLE...UNCOMMENT TO DISPLAY

<div id="myLogger"></div>
<script type="text/javascript">
var myLogReader = new YAHOO.widget.LogReader("myLogger");
</script>
 -->
 
</body>
</html>