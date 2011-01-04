<%@ include file="include.jsp"%>
<!-- 
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<%@page
	import="org.telscenter.sail.webapp.domain.grading.GradeWorkAggregate"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="styles.jsp"%>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /> 
<link href="../../<spring:theme code="spryrating"/>" media="screen" rel="stylesheet" type="text/css"/>

<!-- use apaches string utils -->

<script type='text/javascript' src='/webapp/dwr/interface/StringUtilsJS.js'></script>
<script type='text/javascript' src='/webapp/dwr/engine.js'></script>
<script language="JavaScript" type="text/javascript" src="../../javascript/tels/spryrating.js"></script>
</head>
<body class=" yui-skin-sam">
<script type="text/javascript">

	//preload image if browser is not IE because animated gif will just freeze if user is using IE
	if(navigator.appName != "Microsoft Internet Explorer") {
		loadingImage = new Image();
		loadingImage.src = "/webapp/themes/tels/default/images/rel_interstitial_loading.gif";
	}
	
	YAHOO.namespace("example.container");

	function openPremadeComments() {

		var premadeCommentsPanel = new YAHOO.widget.Panel("premadeComments",  
                                                    { width: "800px",
                                                      fixedcenter: true, 
                                                      close: true, 
                                                      draggable: true, 
                                                      zindex:4,
                                                      modal: true
                                                    } 
                                                );
		premadeCommentsPanel.setBody("<p>Hello</p>");
		premadeCommentsPanel.render(document.body);
		premadeCommentsPanel.show();
		//abc.render(document.body);
	}

	function popup(URL) {
  		window.open(URL, 'PremadeComments', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=800,height=740,left = 450,top = 150');
  	}
  	
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

        // Show the Panel
        YAHOO.example.container.wait.show();
    }

		YAHOO.util.Event.on("previousStepLinkTop", "click", init);
		YAHOO.util.Event.on("nextStepLinkTop", "click", init);
		YAHOO.util.Event.on("previousStepLinkBottom", "click", init);
		YAHOO.util.Event.on("nextStepLinkBottom", "click", init);
		
		var activeIndex = ${tab};
			
		//create tab
	    var tabView = new YAHOO.widget.TabView('periodTabs'); 
	    
		tabView.set('activeIndex', ${tab});								        
	    tabView.addListener('activeTabChange', handleTabClick);
	    
	    /**
	     * When tabs change handle a click
	     */
	     function handleTabClick(e) {
	     	 var nextVar = document.getElementById('nextStepLinkTop');  
	     	 var tabIndex = tabView.getTabIndex( e.newValue );
	     	 nextVar.href = 'gradingtool.html?runId=${run.id}&podUUID=${next.podUUID}&tab='+tabIndex;

	     	 var nextVar = document.getElementById('nextStepLinkBottom');  
	     	 var tabIndex = tabView.getTabIndex( e.newValue );
	     	 nextVar.href = 'gradingtool.html?runId=${run.id}&podUUID=${next.podUUID}&tab='+tabIndex;

	     	 
	     	 //previousStep
	     	 var previousVar = document.getElementById('previousStepLinkTop');
	     	 if( previousVar != null ) {  
	     	 	var tabIndex = tabView.getTabIndex( e.newValue );
	     	 	previousVar.href = 'gradingtool.html?runId=${run.id}&podUUID=${previous.podUUID}&tab='+tabIndex;
	     	 }// if
	     	 
	     	 var previousVar = document.getElementById('previousStepLinkBottom');
	     	 if( previousVar != null ) {  
	     	 	var tabIndex = tabView.getTabIndex( e.newValue );
	     	 	previousVar.href = 'gradingtool.html?runId=${run.id}&podUUID=${previous.podUUID}&tab='+tabIndex;
	     	 }// if
	     	 
	     	 activeIndex = tabView.getTabIndex(e.newValue);
	    } 

	
	function enableButton( textarea,podId,rimName,period) {
		
		var buttonText = 'pushbutton-'+podId+'_'+rimName+'_'+period;
		var savedText = 'saved-'+podId+'_'+rimName+'_'+period;
		
		var buttons = document.getElementById(buttonText);
		var names = document.getElementsByTagName(buttonText);
		for(var i = 0; i < names.length; i++) {
				//YAHOO.log( 'dfdfd' + names[i]);
			}
			
		//set the textarea background color white
		textarea.style.backgroundColor ="#FFFFFF";
		
		//make the comment "not saved"
		var savedEl = YAHOO.util.Dom.getElementsByClassName(savedText, 'div');
		
		//YAHOO.log( 'saved ' + savedEl );
		for(var i = 0; i < savedEl.length; i++) {
			savedEl[i].innerHTML = "not saved";
		}
			
		
	};
	
	/**
	 * submits the annotation
	 */
	function doSubmit(button,podId,rimName,period,workgroupId,runId) {
			//YAHOO.log('podId' + podId);
			//YAHOO.log('rimName' + rimName);
			//YAHOO.log('pe' + period);
			//YAHOO.log('runId' + runId);
			//YAHOO.log( 'button:' + button );
			//button.disabled = 'true';
			
			var savedText = 'saved-'+podId+'_'+workgroupId;
			var commentedText = 'comment-'+podId+'_'+workgroupId;
			var teacherScore = 'teacher-score-'+podId+'_'+workgroupId;
			var possibleScore = 'possible-score-'+podId+'_'+workgroupId;
			
			// alert('found: ' + YAHOO.util.Dom.getElementsByClassName(savedText, 'div').length + ' elements');
			
			var savedMessageLabel = YAHOO.util.Dom.getElementsByClassName(savedText, 'div');
			
			var tel = YAHOO.util.Dom.getElementsByClassName(commentedText, 'textarea');
			
			var teacherScoreElement = YAHOO.util.Dom.getElementsByClassName(teacherScore, 'input');
			
			var possibleScoreElement = YAHOO.util.Dom.getElementsByClassName(possibleScore, 'input');
			
			var teacherScore = teacherScoreElement[0].value;
			
			var possibleScore = possibleScoreElement[0].value;
			
			var possibleScoreResult;


		//checkk the inputs of the score boxes
			StringUtilsJS.isNumeric(teacherScore, {
					  callback:function(teacherScoreResult) { 

					    // if the result is false display a dialog
					  	if( teacherScoreResult == false && !(teacherScore == "unscored")) {
					  		displayScoreDialog(teacherScore + " is not a valid score, please input a number"); 
					  	} else {
					  		if( teacherScore == "unscored" || eval(teacherScore) <=  eval(possibleScore) ) {
								/*
								* Remember to encode the key-value string if and when
								* the string contains special characters.
								*/
								var sUrl = "gradingsubmit.html";
								var postData = 'workgroupId='+workgroupId+'&runId='+runId+'&podId='+podId+'&rimName='+rimName+'&annotationContent='+tel[0].value+'&teacherScore='+teacherScore+'&possibleScore='+possibleScore;
								
								var request = YAHOO.util.Connect.asyncRequest('POST', sUrl, null, postData);	
								
								//change the comment			
								savedMessageLabel[0].innerHTML = "information saved!";
								
								YAHOO.util.Dom.setStyle(commentedText, 'background-color', 'white'); 
					  		} else {
					  			displayScoreDialog(teacherScore + " cannot be greater than the possible score "+ possibleScore); 
					  		}
					  	}// if
					  }
				});
			};

			/**
			 * display score is incorrect dialog
			 *
			 * @param wrongScore - the incorrect input
			 */
			function displayScoreDialog(wrongScore) {
				// Instantiate the Dialog
				var teacherScoreErrorDialog = 
								new YAHOO.widget.SimpleDialog("possibleScoreErrorDialog", 
										 { width: "300px",
										   fixedcenter: true,
										   modal: true,
										   visible: false,
										   draggable: false,
										   close: true,
										   text: wrongScore,
										   icon: YAHOO.widget.SimpleDialog.ICON_WARN,
										   constraintoviewport: true
										 } );
			
				teacherScoreErrorDialog.setHeader("<center>Score Error</center>"); 
				teacherScoreErrorDialog.render(document.body); 
				teacherScoreErrorDialog.show();
			
			}
			
	/**
	* Functions for star-rating
	**/
	function clearOthers(rating, checkbox){
		rating.setValue(0)
		checkbox.checked = false;
	}
														
	function revisionClicked(rating, score, revision){
		if(revision.checked){
			rating.setValue(0);
			score.value = "revision required";
		}
	}			
		
	
	/**
	* GradingCellInfo Object for making asyncronous requests
	* and filling in appropriate gradingcell fields
	**/
	function GradingCellInfo(runId, workgroupId, podId, tabIndex){

		this.runId = runId;
		this.workgroupId = workgroupId;
		this.podId = podId;
		this.tabIndex = tabIndex;

		this.callback = {
			customevents:{
			onStart:this.handleEvent.start,
			onComplete:this.handleEvent.complete
			},
			success:this.handleSuccess,
			failure:this.handleFailure,
			scope:this
		};
	};
	
	GradingCellInfo.prototype.startRequest = function(){
		YAHOO.util.Connect.asyncRequest('GET', 'gradingcellinfo.html?runId=' + this.runId + '&workgroupId=' + this.workgroupId + '&podUUID=' + this.podId, this.callback);
	};
	
	GradingCellInfo.prototype.handleSuccess = function(o){
		var xmlDoc = o.responseXML;
		if(xmlDoc == null){
			this.handleFailure();
		}
		var score = xmlDoc.getElementsByTagName('score');
		var comment = xmlDoc.getElementsByTagName('comments');
		var prompts = xmlDoc.getElementsByTagName('prompt');
		var responses = xmlDoc.getElementsByTagName('response');
		var promptresponses = xmlDoc.getElementsByTagName('promptresponse');
		
		if(score.length > 0 && score[0].childNodes.length > 0){
			document.getElementById("teacher-score-" + this.podId + "_" + this.workgroupId).value = score[0].childNodes[0].nodeValue;
		} else {
			document.getElementById("teacher-score-" + this.podId + "_" + this.workgroupId).value = "";
		}
		if(comment.length > 0 && comment[0].childNodes.length > 0){
			document.getElementById("comment-" + this.podId + "_" + this.workgroupId).value = comment[0].childNodes[0].nodeValue;
		}
		for(y=0;y<prompts.length;y++) {
		   document.getElementById("prompt_" + y + "_" + this.workgroupId).innerHTML = prompts[y].textContent;
		}
		for(x=0;x<responses.length;x++){
			if(responses[x].childNodes.length > 0){
				if(responses[x].childNodes[0].nodeValue == "no student response yet"){
					responses[x].childNodes[0].nodeValue = "<font color='666666'><i>no student response yet</i></font>";
				}
				document.getElementById("answer_" + x + "_" + this.workgroupId).innerHTML = responses[x].childNodes[0].nodeValue;
			} else {
				document.getElementById("answer_" + x + "_" + this.workgroupId).innerHTML = "";
			}
		}
	};
	
	GradingCellInfo.prototype.handleFailure = function(o){
		document.getElementById("teacher-score-" + this.podId + "_" + this.workgroupId).value = "error";
		document.getElementById("comment-" + this.podId + "_" + this.workgroupId).value = "error loading data for this cell";
	};
	
	GradingCellInfo.prototype.handleEvent = {
		start:function(eventType, args){
			//loading image moved -- now launches when request is added to requestManager
		},
		complete:function(eventType, args){
			document.getElementById("load_" + this.workgroupId).innerHTML = "";
			requestManager.finished(this);
		}	
	};
	
	/**
	* Request Manager - manages the asynchronous GET requests of given object (o)
	* and keeps five (this.MAX) running at any given time - prioritizes
	* requests for the currently selected tab
	**/
	function RequestManager(){
		this.MAX = 5;
		this.activeRequests = [];
		this.queuedRequests = [];
		
	};

	RequestManager.prototype.addRequest = function(o){
		if(this.queuedRequests[o.tabIndex] == null){
			this.queuedRequests[o.tabIndex] = [];
		}
		this.queuedRequests[o.tabIndex].push(o);
	};
	
	RequestManager.prototype.finished = function(o){
		this.activeRequests.splice(this.activeRequests.indexOf(o),1);
		this.nextRequest();
	};
	
	RequestManager.prototype.nextRequest = function(){
		if(this.queuedRequests != null && this.queuedRequests[activeIndex].length > 0){
			var queuedCell = this.queuedRequests[activeIndex].shift();
			this.activeRequests.push(queuedCell);
			queuedCell.startRequest();
		} else {
			for(x=0;x<this.queuedRequests.length;x++){
				if(this.queuedRequests != null && this.queuedRequests[x] != null && this.queuedRequests[x].length > 0){
					var queuedCell = this.queuedRequests[x].shift();
					this.activeRequests.push(queuedCell);
					queuedCell.startRequest();
					break;
				}
			}
		}
	};
	
	RequestManager.prototype.start = function(){
		for(z=0;z<this.MAX;z++){
			this.nextRequest();
		}
	};
	
	var requestManager = new RequestManager();
</script>





<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>


<div id="overviewHeaderGradingv2"><spring:message code="teacher.gradingtool.1"/></div>

<div id="gradeStepSelectedProject">${projectTitle} <span id="projectIdLabel">(Project Run ID: ${run.project.id})</span></div>

<table id="currentStepTable" >
  <tr>
  	<td id="currentStepLabel">Activity ${activityNumber+1}, Step ${step.number+1}: <span style="font-weight:normal;">${step.title}</span></td>
    
     
    <td class="currentStepNavLink">
        <c:choose>
				<c:when test="${!empty previous}">
					<a id="previousStepLinkTop" href="gradingtool.html?runId=${run.id}&podUUID=${previous.podUUID}&tab=${tab}">
	    			<spring:message code="teacher.gradingtool.2"/></a>
				</c:when>
				<c:otherwise>
					<spring:message code="teacher.gradingtool.2"/>
				</c:otherwise>
		</c:choose>
	</td>
    
    <td class="currentStepNavLink"><a href="gradebystep.html?runId=${run.id}"><spring:message code="teacher.gradingtool.3"/></a>
    </td>
    
    <td class="currentStepNavLink"> 
	  <c:choose>
			<c:when test="${!empty next}">
				<a id="nextStepLinkTop" href="gradingtool.html?runId=${run.id}&podUUID=${next.podUUID}&tab=${tab}"><spring:message code="teacher.gradingtool.4"/></a>
			</c:when>
			<c:otherwise>
				<spring:message code="teacher.gradingtool.4"/>
			</c:otherwise>
		</c:choose>
	</td>	
	
  </tr>
 </table>
 
<c:set var="ratingVar" value="0"/>
<c:set var="tIndex" value="0"/>

<div id="periodTabs" class="yui-navset"> 
		<!-- create the tabs nav -->
		<ul class="yui-nav" style="font-size:.8em; text-transform:uppercase;"> 
			<c:forEach var="period" varStatus="astatus" items="${run.periods}">
				 <li style="margin-right:4px;"><a href="${period.name}"><em>Period ${period.name}</em></a></li>
			 </c:forEach> 
		 </ul>   
		 <!-- create the tabs content -->
		<div class="yui-content" style="background-color:#FFFFFF;">
			<c:forEach var="period" varStatus="astatus" items="${run.periods}">
			<div>
				<!-- Actual Tab 
					${workgroupAggregateObj} = workgroupAggregateObj
				 -->
				 <c:choose>
				 	<c:when test="${empty workgroups[period.id]}">
				 		<div id="noTeamsInPeriod" style="padding:20px 0;">
				 			<spring:message code="teacher.gradingtool.5"/>
				 		</div>
				 	</c:when>
				 	<c:otherwise>
				 		<c:forEach var="workgroup" varStatus="workgroupStatus" items="${workgroups[period.id]}">
							<div align="center">
							<table id="gradingTeamTable"  border="1" class="sample">
								<tr id="groupHeaderRow">
									<td class="boldText" width="45%">
										<div  class="tdHeader">
										<class="headerFont">Team ${workgroup.id}:
										<c:forEach var="user" varStatus="userStatus" items="${workgroup.members}">
											${user.userDetails.firstname} ${user.userDetails.lastname}
										 	<c:if test="${userStatus.last=='false'}">&</c:if>
										</c:forEach></class>
										</div>
									</td>
									<td width="35%">
										<div align="center" class="tdHeader" class="headerFont"><spring:message code="teacher.gradingtool.6"/> <span id="preMadeCommentsLink"><a href="javascript:popup('premadeComments.html?commentBox=comment-${step.podUUID}_${workgroup.id}')"><spring:message code="teacher.gradingtool.7"/></a></span></div>
									</td>
									<td width="20%">
										<div align="center" class="tdHeader" class="headerFont"><spring:message code="teacher.gradingtool.8"/></div>
									</td>
								</tr>
								
								<!-- beginning of cell table - prompts -->
								<c:set var="rimIndex" value="0"/>
								<c:forEach var="rimFromStep" varStatus="rimListStatus" items="${step.rim}">
								<tr>
									<td id="stepQuestionField" class="questionField">
									<!--  
									<c:choose>
										<c:when test="${fn:length(step.rim) > 1}">
											<b>Part ${rimListStatus.count}:</b> ${rimFromStep.prompt}
										</c:when>
										<c:otherwise>
											${rimFromStep.prompt}
										</c:otherwise>
									</c:choose>
									<td>
						            	<div id="stepStudentAnswerField" class="answerDiv">
											<div id="answer_${rimIndex}_${workgroup.id}">answer here</div>
										</div>
									</td>	
									-->
									    <div id="prompt_${rimIndex}_${workgroup.id}">prompt here</div>
										<div id="stepStudentAnswerField" class="answerDiv">
											<div id="answer_${rimIndex}_${workgroup.id}">answer here</div>
										</div>								
									</td>
									
									<!-- comment textbox -->
									<c:if test="${rimListStatus.first}">
										<td id="teacherFeedbackTd" rowspan="${fn:length(step.rim)*2}">
											<div align="center">
											<div id="div_${step.podUUID}_${workgroup.id}" >
												<sec:accesscontrollist domainObject="${run}" hasPermission="16,2">
  													<textarea id="comment-${step.podUUID}_${workgroup.id}" class="comment-${step.podUUID}_${workgroup.id}" cols="45" rows="6"  onkeypress="enableButton(this,'${step.podUUID}','${workgroup.id}','${period}')" ></textarea>
												</sec:accesscontrollist>
											</div>
											</div>
											<div id="load_${workgroup.id}" align="center" disabled="true"></div>
										</td>
									</c:if>
									
									<!-- start asynchronous calls to fill in table -->
									<c:if test="${rimListStatus.last}">
										<script type="text/javascript">
											requestManager.addRequest(new GradingCellInfo(${run.id}, ${workgroup.id}, '${step.podUUID}', ${tIndex}));
											document.getElementById("load_${workgroup.id}").innerHTML = '<font color="8B0000"><i>Loading data for this team</i></font><br><img src=/webapp/themes/tels/default/images/rel_interstitial_loading.gif />';
										</script>
									</c:if>
									
									<!-- grading -->
									<c:if test="${rimListStatus.first}">
										<td rowspan="${fn:length(step.rim)*2}">						   
											<div align="center">
												<sec:accesscontrollist domainObject="${run}" hasPermission="16,2">
													<input class="teacher-score-${step.podUUID}_${workgroup.id}" id="teacher-score-${step.podUUID}_${workgroup.id}" type="text" size="7" value="" onfocus="clearOthers(rating${ratingVar}, document.getElementById('checkbox-${step.podUUID}_${workgroup.id}'))"/>
													<span id="scoreBoxStyling3">&nbsp;<spring:message code="teacher.gradingtool.14"/>&nbsp;</span>
													<input id="possible-score-${step.podUUID}_${workgroup.id}" class="possible-score-${step.podUUID}_${workgroup.id}" disabled="true" readonly="true" type="text" size="1" value="${step.possibleScore}"/>
													<div id="spryrating-teacher-score-${step.podUUID}_${workgroup.id}" class="ratingContainer" align="center">
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingButton"></span>
														<span class="ratingCounter"></span>
													</div>
													
													<script type="text/javascript">
														var rating${ratingVar} = new Spry.Widget.Rating("spryrating-teacher-score-${step.podUUID}_${workgroup.id}", {counter: "true"});
														function updateAfterRate(notifyType, notifier, data){
															if (notifyType == "onPostRate"){
		    													var outOf = document.getElementById("possible-score-${step.podUUID}_${workgroup.id}").value;
		    													var rated = rating${ratingVar}.getValue();
		    													var score;
		    													switch(rated){
		    													case 8:
		    														score = outOf;
		    														break;
		    													case 7:
		    														score = Math.round(.95 * outOf);
		    														break;
		    													case 6:
		    														score = Math.round(.9 * outOf);
		    														break;
		    													case 5:
		    														score = Math.round(.85 * outOf);
		    														break;
		    													case 4:
		    														score = Math.round(.8 * outOf);
		    														break;
		    													case 3:
		    														score = Math.round(.75 * outOf);
		    														break;
		    													case 2:
		    														score = Math.round(.7 * outOf);
		    														break;
		    													case 1:
		    														score = Math.round(.65 * outOf);
							   										break;
																default:
																	score = 0;																						    		
																}															
																document.getElementById("teacher-score-${step.podUUID}_${workgroup.id}").value = score;
																document.getElementById("checkbox-${step.podUUID}_${workgroup.id}").checked = false;
															}
														}
														rating${ratingVar}.addObserver(updateAfterRate);
													</script><br>
													
													<div id="revisionRequiredArea">
	     												<form onclick="revisionClicked(rating${ratingVar}, document.getElementById('teacher-score-${step.podUUID}_${workgroup.id}'), document.getElementById('checkbox-${step.podUUID}_${workgroup.id}'))">
	     													<input type="checkbox" name="checkBox" id="checkbox-${step.podUUID}_${workgroup.id}"/><span><spring:message code="teacher.gradingtool.11"/></span>
	     												</form>
    												</div>
											
													<c:set var="ratingVar" value="${ratingVar + 1}"/>
													
													<div id="gradingSaveButton">
														<span id="pushbutton-${step.podUUID}_${workgroup.id}" class="yui-button yui-push-button">
    					                                	<em class="first-child"><button type="submit" name="pushbutton-${step.podUUID}_${workgroup.id}" onClick="javascript:doSubmit(this,'${step.podUUID}','null','${period}','${workgroup.id}','${run.id}')"><spring:message code="teacher.gradingtool.12"/><br><spring:message code="teacher.gradingtool.13"/></button></em>
														</span>
													</div>
																			    
													<div id="scoringHelpLink">
														<a href="#" style="color:#999999;"><spring:message code="teacher.gradingtool.15"/></a>
													</div>
												</sec:accesscontrollist>
												<div class="saved-${step.podUUID}_${workgroup.id}" style="display: inline; width: 11%;"></div>	
											</div>
										</td>
									</c:if>
								</tr>
								<c:set var="rimIndex" value="${rimIndex + 1}"/>
								</c:forEach>
							</table>
							</div>
						</c:forEach>
				 	</c:otherwise>
				 </c:choose>
			<c:set var="tIndex" value="${tIndex+1}"/>
			</div>
			</c:forEach>		 
</div>

<script type="text/javascript">requestManager.start();</script>

<table id="currentStepTable" >
  <tr>
  	<td id="currentStepLabel"></td>
    <td class="currentStepNavLink">
    
    <c:choose>
			<c:when test="${!empty previous}">
				<a id="previousStepLinkBottom" href="gradingtool.html?runId=${run.id}&podUUID=${previous.podUUID}&tab=${tab}">
    			<spring:message code="teacher.gradingtool.2"/></a>
			</c:when>
			<c:otherwise>
				<spring:message code="teacher.gradingtool.2"/>
			</c:otherwise>
	</c:choose>

</td>
    <td class="currentStepNavLink"><a href="gradebystep.html?runId=${run.id}"><spring:message code="teacher.gradingtool.3"/></a></td>
    <td class="currentStepNavLink"> 

	  <c:choose>
			<c:when test="${!empty next}">
				<a id="nextStepLinkBottom" href="gradingtool.html?runId=${run.id}&podUUID=${next.podUUID}&tab=${tab}"><spring:message code="teacher.gradingtool.4"/></a>
			</c:when>
			<c:otherwise>
				<spring:message code="teacher.gradingtool.4"/>
			</c:otherwise>
	</c:choose>


</td>		
  </tr>
 </table>
 
<!-- uncomment this section if you want to display the yahoo logger
     remember to comment it before committing to repository
<div id="myLogger"></div>
<script type="text/javascript">
var myLogReader = new YAHOO.widget.LogReader("myLogger");
</script>
-->
<div id="container"></div>

</div>    <!--end of Centered Div-->

</body>
</html>