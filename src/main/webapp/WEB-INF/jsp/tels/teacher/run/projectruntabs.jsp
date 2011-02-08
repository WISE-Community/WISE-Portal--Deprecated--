<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>

<%@ include file="yahooUIStyles.jsp"%>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<title><spring:message code="run.list" /></title>

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>

<script language="JavaScript">
	function popup(URL, title) 
  	{window.open(URL, title, 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=640,height=480,left = 320,top = 240');}
</script>

<script type="text/javascript">

	if(navigator.appName != "Microsoft Internet Explorer") {
		loadingImage = new Image();
		loadingImage.src = "/webapp/themes/tels/default/images/rel_interstitial_loading.gif";
	}
	
    YAHOO.namespace("example.container");

    function init() {

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

            //YAHOO.example.container.wait.setHeader("Loading, please wait...");
            YAHOO.example.container.wait.setBody("<table><tr align='center'>Loading, please wait...</tr><tr align='center'><img src=/webapp/themes/tels/default/images/rel_interstitial_loading.gif /></tr><table>");
            YAHOO.example.container.wait.render(document.body);

        }

        // Define the callback object for Connection Manager that will set the body of our content area when the content has loaded



        var callback = {
            success : function(o) {
                //content.innerHTML = o.responseText;
                //content.style.visibility = "visible";
                YAHOO.example.container.wait.hide();
            },
            failure : function(o) {
                //content.innerHTML = o.responseText;
                //content.style.visibility = "visible";
                //content.innerHTML = "CONNECTION FAILED!";
                YAHOO.example.container.wait.hide();
            }
        }
    
        // Show the Panel
        YAHOO.example.container.wait.show();
        
        // Connect to our data source and load the data
        //var conn = YAHOO.util.Connect.asyncRequest("GET", "assets/somedata.php?r=" + new Date().getTime(), callback);
    }

    YAHOO.util.Event.on("studentScoreSummary", "click", init);
    
    
		(function() {
   		 var tabView = new YAHOO.widget.TabView('tabSystem');})();
 </script>

<script type="text/javascript">
	function checkRuns(){
		//if(${current_run_list} == 0){          
			//  document.getElementById('runBox').innerHTML = '<div id="noRuns"><br/><h5>You have no current project runs.</h5><br/><h5>Explore the Project Library (in PROJECTS) to find a curriculum project and set it up for a run in your classroom.</h5><br/><h5>Or review <a href="#" style="text-decoration:line-through;">Setting Up a Project Run</a> in the WISE 4.0 Help Guide.</h5></div>';
		// }
	}

</script>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
</head>


<body class="yui-skin-sam" onload="checkRuns()">

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="centeredDivDynamicFrame">

<div id="tabSystem" class="yui-navset">
    <ul style="font-weight:bold; font-size:.7em; letter-spacing:1px;" class="yui-nav">
        <li style="margin:0 .4em 0 0px;" class="selected"><a href="#currentRuns"><em><spring:message code="teacher.run.myprojectruns.1A"/></em></a></li>
        <li><a href="#archivedRuns"><em><spring:message code="teacher.run.myprojectruns.1B"/></em></a></li>
    </ul>            
    <div class="yui-content" id="currentrunWrapper">
        <div id="currentRuns">
        		<div id="subHeader">To see an archived project run click the tab above.</div>
        	       		
        		<div id="runBox">
				
				<table id="currentRunTable" border="1" cellpadding="0" cellspacing="0" >
				    <tr>
				       <th style="width:250px;"class="tableHeaderMain">Project Run</th>
				       <th style="width:130px;" class="tableHeaderMain">Class Info</th>      
				       <th style="width:300px;" class="tableHeaderMain">Tools</th>
				    </tr>
				  <c:forEach var="run" items="${current_run_list}">
				  
				  <tr id="runTitleRow_${run.id}">
				    <td id="titleCell">
				    	<div id="runTitle">${run.name}</div>
				    	
					    	<c:forEach var="sharedowner" items="${run.sharedowners}">
					    	    <c:if test="${sharedowner == user}">
					    	    	<div id="sharedTeacherMsg1"><spring:message code="teacher.run.myprojectruns.6"/>
					    	    	<c:forEach var="owner" items="${run.owners}">
					    	    		${owner.userDetails.firstname} ${owner.userDetails.lastname}
					    	    	</c:forEach>
					    	    	</div></c:if>
					    	</c:forEach>
				     
						<table id="runTitleTable">
				      			<tr>
									<th>Access Code:</th>
									<td class="accesscodeClass">${run.runcode}</td>
								</tr>
								
				      			<tr>
				      				<th>Project Run ID:</hd>
				      				<td>${run.id}</td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.13"/></th>
				      				<td><fmt:formatDate value="${run.starttime}" type="date" dateStyle="short" /></td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.12"/></th>
				      				<c:choose>
				      				<c:when test="${run.project.familytag == 'TELS'}">
					      				<td>TELS Library Project</td>
				      				</c:when>
				      				<c:otherwise>
					      				<td>Custom Project</td>
				      				</c:otherwise>
				      				</c:choose>
				      			</tr>
								<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.11"/></th>
				      				<td>${run.project.id}</td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.40"/></th>
									<c:choose>
									  <c:when test="${run.project.parentProjectId != null}">
									    <td>${run.project.parentProjectId}</td>
									  </c:when>
									  <c:otherwise>
									    <td>N/A</td>
									  </c:otherwise>
									 </c:choose>
				      			</tr>
						</table>
				      	
					</td>
												
				    <td style="vertical-align:top; padding:0px;" >
				    	<table id="currentRunInfoTable" border="0" cellpadding="0" cellspacing="0">
				          <tr>
				            <th class="tableInnerHeader">Period</th>
				            <th style="display:none;" class="tableInnerHeader">Access Code</th>
				            <th class="tableInnerHeaderRight"><spring:message code="teacher.run.myprojectruns.9"/></th>
				          </tr>
				          <c:forEach var="period" items="${run.periods}">
				            <tr>
				              <td style="width:20%;" class="tableInnerData">${period.name}</td>
				              <td style="display:none;"  style="width:45%;" class="tableInnerData">${run.runcode}</td>
				              <td style="width:35%;" class="tableInnerDataRight">
				                <a href="../management/viewmystudents.html?runId=${run.id}&periodName=${period.name}" target="_top">${fn:length(period.members)}&nbsp;<spring:message code="teacher.run.myprojectruns.10"/></a></td>
				            </tr>
				          </c:forEach>
				        </table>
				        
				     </td> 
				    <td style="vertical-align:top; padding:1px 0;">
					    <ul id="actionList1">
					    <c:set var="isExternalProject" value="0"/>
					    
					        <c:forEach var="external_run" items="${externalprojectruns}">
					           <c:if test="${run.id == external_run.id}">
					                   <c:set var="isExternalProject" value="1"/>
					           </c:if>
					        </c:forEach>
					           <c:choose>
					               <c:when test="${isExternalProject == 1}">
					                  <li>Period Reports: <c:forEach var="periodInRun" items="${run.periods}"><a href="report.html?runId=${run.id}&groupId=${periodInRun.id}">${periodInRun.name}</a>&nbsp;</c:forEach></li>
					               </c:when>
					               <c:otherwise>
					        <li>
					        	Project:<a href="../../previewproject.html?projectId=${run.project.id}" target="_blank"> Preview</a>
				    			&nbsp;|&nbsp;<a href="../projects/projectinfo.html?projectId=${run.project.id}" target="_top"> Info</a>
					        	<sec:accesscontrollist domainObject="${run.project}" hasPermission="16">
					        		&nbsp;|&nbsp;<a href="#" onclick="if(confirm('You will be editing the project that is used for this run. If students have already started work on this run, this may have undesirable effects for their work. Are you sure you wish to proceed?')){window.top.location='../../author/authorproject.html?projectId=${run.project.id}&versionId=${run.versionId}';} return true;">Edit</a>
					        	</sec:accesscontrollist>
					        </li>
					        <li><a href="editrun.html?runId=${run.id}" target="_top">Edit Run Info</a></li>
							<li><spring:message code="teacher.run.myprojectruns.16"/> (<spring:message code="teacher.run.myprojectruns.41"/>:<a href="../grading/gradework.html?runId=${run.id}&gradingType=step&getRevisions=false" target="_top"><spring:message code="teacher.run.myprojectruns.43"/></a>|<a href="../grading/gradework.html?runId=${run.id}&gradingType=step&getRevisions=true" target="_top"><spring:message code="teacher.run.myprojectruns.42"/></a>)</li>
   	                        <li><spring:message code="teacher.run.myprojectruns.17"/> (<spring:message code="teacher.run.myprojectruns.41"/>:<a href="../grading/gradework.html?runId=${run.id}&gradingType=team&getRevisions=false" target="_top"><spring:message code="teacher.run.myprojectruns.43"/></a>|<a href="../grading/gradework.html?runId=${run.id}&gradingType=team&getRevisions=true" target="_top"><spring:message code="teacher.run.myprojectruns.42"/></a>)</li>				    	
		                    <li><a href="../grading/gradework.html?runId=${run.id}&gradingType=team" target="_top">Scores Summary</a></li>
					               </c:otherwise>
					           </c:choose>
					    </ul>
						
						<ul id="actionList2">

							<sec:accesscontrollist domainObject="${run}" hasPermission="16">
    					      <li><a href="shareprojectrun.html?runId=${run.id}" target="_top">Share w/Another Teacher</a></li> 
  	                    	</sec:accesscontrollist>
					    	
					    	<c:set var="isExternalProject" value="0"/>
					      		<li><a href="./announcement/manageannouncement.html?runId=${run.id}" target="_top">Manage Announcements</a></li>
					        			    	
					    	<!-- 
					    	<li><a href="../run/brainstorm/createbrainstorm.html?runId=${run.id}" target="_top">Create Q&A Discussion</a></li>
					    	<c:if test="${not empty run.brainstorms}" >
					            <c:forEach var="brainstorm" items="${run.brainstorms}" varStatus="brainstormVS" >
					                <li class="qaBullet"><a href="../run/brainstorm/managebrainstorm.html?brainstormId=${brainstorm.id}">Manage Q&A #${brainstormVS.index+1}</a></li>
					            </c:forEach>
					    	</c:if>
					    	 -->		
							<li><a href="../../contactwiseproject.html?projectId=${run.project.id}" target="_top"><spring:message code="teacher.run.myprojectruns.22"/></a></li>
		                    <sec:accesscontrollist domainObject="${run}" hasPermission="16">					    	
					    	  <li><a href="#" onclick="javascript:popup('manage/archiveRun.html?runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />')">Archive Project</a></li>
					    	</sec:accesscontrollist>
					    	
					    </ul>

					</td>
				   </tr>
				  </c:forEach>
				</table>
				</div>
        </div><!-- end current runs tab -->

<div id="archivedRuns">
<h5 style="margin: 3px 0 0 0;" id="subHeader">The projects below have been archived.</h5>
<h5 style="margin: 5px 0 0 0;color:brown;" id="subHeader">Want to review information within an archived project run?</h5>
<h5 style="margin: 5px 0 10px 0;color:brown;" id="subHeader">First RESTORE the project run back to Current status. Then click the <i>My Current Project Runs</i> tab and refresh your web browser.</h5>
<div id="runBox">
				
				<table id="currentRunTable" border="1" cellpadding="0" cellspacing="0" >
				    <tr>
				       <th style="width:250px;"class="tableHeaderMain archive">Project Run</th>
				       <th style="width:130px;" class="tableHeaderMain archive">Class Info</th>      
				       <th style="width:300px;" class="tableHeaderMain archive">Tools</th>
				    </tr>
				  <c:forEach var="run" items="${ended_run_list}">
				  
				  <tr id="runTitleRow">
				    <td id="titleCell">
				    	<div id="runTitle">${run.name}</div>
				    	
					    	<c:forEach var="sharedowner" items="${run.sharedowners}">
					    	    <c:if test="${sharedowner == user}">
					    	    	<div id="sharedTeacherMsg1"><spring:message code="teacher.run.myprojectruns.6"/>
					    	    	<c:forEach var="owner" items="${run.owners}">
					    	    		${owner.userDetails.firstname} ${owner.userDetails.lastname}
					    	    	</c:forEach>
					    	    	</div></c:if>
					    	</c:forEach>
				     
						<table id="runTitleTable">
				      			<tr>
									<th>Access Code:</th>
									<td>${run.runcode}</td>
								</tr>
								
				      			<tr>
				      				<th>Project Run ID:</hd>
				      				<td>${run.id}</td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.13"/></th>
				      				<td class="accesscodeClass"><fmt:formatDate value="${run.starttime}" type="date" dateStyle="short" /></td>
				      			</tr>
								 <tr>
				      				<th>Archived On:</th>
				      				<td class="accesscodeClass"><fmt:formatDate value="${run.endtime}" type="date" dateStyle="short" /></td>
				      			</tr>
				      			<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.12"/></th>
				      				<td>UC Berkeley library project</td>
				      			</tr>
								<tr>
				      				<th><spring:message code="teacher.run.myprojectruns.11"/></th>
				      				<td>${run.project.id}</td>
				      			</tr>
				      			
						</table>
				      	
					</td>
												
				    <td style="vertical-align:top; padding:0px;" >
				    	<table id="currentRunInfoTable" border="0" cellpadding="0" cellspacing="0">
				          <tr>
				            <th class="tableInnerHeader">Period</th>
				            <th class="tableInnerHeaderRight"><spring:message code="teacher.run.myprojectruns.9"/></th>
				          </tr>
				          <c:forEach var="period" items="${run.periods}">
				            <tr>
				              <td style="width:20%;" class="tableInnerData">${period.name}</td>
				              <td style="width:35%;" class="tableInnerDataRight archivedNumberStudents">
				                ${fn:length(period.members)}&nbsp;<spring:message code="teacher.run.myprojectruns.10"/></td>
				            </tr>
				          </c:forEach>
				        </table>
				        
						
				     </td> 
				    <td style="vertical-align:top; padding:1px 0;">
					    <ul id="actionList1">
					
					        <li><a href="../../previewproject.html?projectId=${run.project.id}&versionId=${run.versionId}" target="_blank">View the Project</a></li>
					        <li><spring:message code="teacher.run.myprojectruns.16"/> (<spring:message code="teacher.run.myprojectruns.41"/>:<a href="../grading/gradework.html?runId=${run.id}&gradingType=step&getRevisions=false" target="_top"><spring:message code="teacher.run.myprojectruns.43"/></a>|<a href="../grading/gradework.html?runId=${run.id}&gradingType=step&getRevisions=true" target="_top"><spring:message code="teacher.run.myprojectruns.42"/></a>)</li>
   	                        <li><spring:message code="teacher.run.myprojectruns.17"/> (<spring:message code="teacher.run.myprojectruns.41"/>:<a href="../grading/gradework.html?runId=${run.id}&gradingType=team&getRevisions=false" target="_top"><spring:message code="teacher.run.myprojectruns.43"/></a>|<a href="../grading/gradework.html?runId=${run.id}&gradingType=team&getRevisions=true" target="_top"><spring:message code="teacher.run.myprojectruns.42"/></a>)</li>		
		                    <sec:accesscontrollist domainObject="${run}" hasPermission="16">					    	
					    	  <li><a href="#" onclick="javascript:popup('manage/startRun.html?runId=${run.id}&runName=<c:out value="${fn:escapeXml(run.name)}" />')">Restore to <i>My Current Project Runs</i> Tab</a></li>
					    	</sec:accesscontrollist>							
			
					    </ul>
						
					</td>
				   </tr>
				  </c:forEach>
				</table>
				</div>

</div>

</div>
</div>
</body>
</html>


