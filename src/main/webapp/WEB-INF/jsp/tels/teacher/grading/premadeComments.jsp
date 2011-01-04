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
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />  
 
<script type="text/javascript" src="/webapp/javascript/tels/prototype.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/scriptaculous.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/effects.js"></script>
<script type="text/javascript" src="/webapp/javascript/tels/controls.js"></script>

<%@ include file="./styles.jsp"%>

<link href="../../<spring:theme code="yui-fonts-min-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="yui-container-stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

</head>

<body class="yui-skin-sam" style="background-color:#CCCCCC;">

<script type="text/javascript">

	var mode = new Array();

	var inPlaceEditor = new Array();
	
	var commentIdToDbId = new Array();

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

	<c:forEach var="someAct" varStatus="varAct" items="${curnitMap.project.activity}">
			<c:forEach var="someStep" varStatus="varStep" items="${someAct.step}">
				YAHOO.util.Event.on("gradeAct${someAct.number}Step${someStep.number}", "click", init);
			</c:forEach>
	</c:forEach>
	
	function addComments() {
		window.opener.document.getElementById("${commentBox}").value = document.getElementById("previewComments").value;
		self.close();
	}
	
	function showCommentList() {
		var selectedList = document.getElementById("commentLists").selectedIndex;
		var commentLists = document.getElementById("commentLists").options;

		for (var i=0;i<commentLists.length;i++) {
			if(i == selectedList) {
				document.getElementById(commentLists[i].value).style.display = "";
			} else {
        		document.getElementById(commentLists[i].value).style.display = "none";
        	}
    	}
	}
	
	function toggleComment(commentId) {
		var previewComments = document.getElementById("previewComments").value;
		var comment = document.getElementById(commentId).value;
		if(previewComments.indexOf(comment) == -1) {
			previewComments += comment + " ";
		} else {
			previewComments = previewComments.replace(comment + " ", "");
		}

		document.getElementById("previewComments").value = previewComments;
	}
	

	
	function openEditList(listNumber) {
		listId = "premadeCommentList" + listNumber;
		
		mode[listId] = "edit";
		
		//TODO remove this for loop, it's not necessary
		var commentLists = document.getElementById("commentLists");
		for (var x=0;x<commentLists.length;x++) {
			if(commentLists[x].value == listId) {
				document.getElementById(commentLists[x].value).style.display = "";
				
				var checkBoxes = document.getElementById(listId).elements["checkBoxes"];
				var numCheckBoxes;
				if(checkBoxes != undefined) {
					if(checkBoxes.length == undefined) {
						numCheckBoxes = 1;
					} else {
						numCheckBoxes = checkBoxes.length;
					}
				} else {
					numCheckBoxes = 0;
				}
				for (var i=1;i<numCheckBoxes + 1;i++) {
					commentId = commentIdToDbId[listId + '_' + i];
					
					if(inPlaceEditor[listId + '_' + i] == undefined) {
						inPlaceEditor[listId + '_' + i] = new Ajax.InPlaceEditor(listId + "_" + i, '/webapp/teacher/grading/editComment.html', 
						{ cols:52, okText: "Save", cancelText: "Cancel",					
						 formId: commentId,
							callback:function(form, value) {
								return "commentId=" + form.id + "&editedComment=" + value;
			    			}
			    			});
			    		document.getElementById(listId + "_" + i + "_checkboxval").style.display = "none";
					}

    			}
			} else {
				document.getElementById(commentLists[x].value).style.display = "none";
			}
			
		}
		document.getElementById("clickToEditMessage" + listNumber).style.display = "";
		document.getElementById("openEditList" + listNumber).style.display = "none";
		document.getElementById("useList" + listNumber).style.display = "";
	}
	
	function useList(listNumber) {
		var listId = "premadeCommentList" + listNumber;
		mode[listId] = "view";
		
		var commentLists = document.getElementById("commentLists");
		for (var x=0;x<commentLists.length;x++) {
			if(commentLists[x].value == listId) {
				document.getElementById(commentLists[x].value).style.display = "";
				
				var checkBoxes = document.getElementById(listId).elements["checkBoxes"];
				var numCheckBoxes;
				if(checkBoxes != undefined) {
					if(checkBoxes.length == undefined) {
						numCheckBoxes = 1;
					} else {
						numCheckBoxes = checkBoxes.length;
					}
				} else {
					numCheckBoxes = 0;
				}
				for (var i=1;i<numCheckBoxes + 1;i++) {
					document.getElementById(listId + "_" + i + "_checkboxval").value = 
						document.getElementById(listId + "_" + i).innerHTML; 
			    	
			    	if(inPlaceEditor[listId + '_' + i] != undefined) {
			    		inPlaceEditor[listId + '_' + i].dispose();
			    		inPlaceEditor[listId + '_' + i] = undefined;
			    	}
			    	
			    	document.getElementById(listId + "_" + i + "_checkboxval").style.display = "";
    			}
			} else {
				document.getElementById(commentLists[x].value).style.display = "none";
			}
			
		}
		document.getElementById("clickToEditMessage" + listNumber).style.display = "none";
		document.getElementById("useList" + listNumber).style.display = "none";
		document.getElementById("openEditList" + listNumber).style.display = "";
	}
	
	function createNewList() {
		var newListName = document.getElementById("newListField").value;
		var url = "createNewCommentList.html";
		var postData = 'label=' + newListName;
		var callBack = {
						success: function(o) {
												var newListNumber = o.responseText;
												addNewListToDropDown(newListNumber, newListName);
												addNewListToDisplay(newListNumber, newListName);
												mode["premadeCommentList" + newListNumber] = "view";
											},
						failure: function(o){ }
						};
		var request = YAHOO.util.Connect.asyncRequest('POST', url, callBack, postData);
		
		document.getElementById("newListField").value = "";
		document.getElementById("createNewListDisplay").style.display = "none";
	}
	
	function addNewListToDropDown(listNumber, listName) {
		var newOption = document.createElement('option');
		newOption.value = "premadeCommentList" + listNumber;
		newOption.text = listName;
		newOption.selected = "selected";
		document.getElementById('commentLists').appendChild(newOption);
	}
	
	function addNewListToDisplay(listNumber, listName) {
		var listId = "premadeCommentList" + listNumber;
		var newForm = document.createElement('form');

		newForm.setAttribute("id", "premadeCommentList" + listNumber);
		//newForm.innerHTML += " <a href='#' id='duplicateList' onclick='duplicateList(" + listId + ")'>Duplicate List</a>";
		//newForm.innerHTML += " <a href='#' id='renameList' onclick='renameList(" + listId + ")'>Rename List</a>";
		//newForm.innerHTML += " <a href='#' id='shareList' onclick='shareList(" + listId + ")'>Share List</a>";
		//newForm.innerHTML += " <a href='#' id='deleteList' onclick='deleteList(" + listId + ")'>Delete List</a>";
		//newForm.innerHTML += " <a href='#' id='newList' onclick='toggleCreateNewListDisplay()'>Create New List</a>";
		newForm.innerHTML = "<a href='#' id='addCommentToList' onclick='toggleAddCommentDisplay(" + listNumber + ")'>Add Comment To List</a>";
		newForm.innerHTML += " <a href='#' id='openEditList" + listNumber + "' style='display:none' onclick='openEditList(" + listNumber + ")'>Edit List</a>";
		newForm.innerHTML += " <a href='#' id='useList" + listNumber + "' style='display:none' onclick='useList(" + listNumber + ")'>Save List</a>";
		newForm.innerHTML += "<p class='addCommentDisplayClass'  id='addCommentDisplay" + listNumber + "'>Enter a new comment: <input id='addCommentField" + listNumber + "' type='text' /><input type='button' value='Add Comment' onclick='addCommentToList(" + listNumber + ")' /></p>";
		newForm.innerHTML += "<p class='clickToEditMessageClass' id='clickToEditMessage" + listNumber + "' style='display:none'>Click Comments to Edit</p>";
		document.getElementById('commentButtonsAndCheckboxes').appendChild(newForm);
	}
	
	function deleteList() {
		var url = "deleteCommentList.html";
		var postData = 'label=abc';
		var request = YAHOO.util.Connect.asyncRequest('POST', url, null, postData);	
	}
	
	function addCommentToList(listNumber) {
		var checkBoxes = document.getElementById("premadeCommentList" + listNumber).elements["checkBoxes"];
		
		var commentNumber;
		
		if (checkBoxes == undefined) {
			commentNumber = 1;
		} else {
			if(checkBoxes.length == undefined) {
				commentNumber = 2;
			} else {
				commentNumber = checkBoxes.length + 1;
			}
		}

		var comment = document.getElementById('addCommentField' + listNumber).value;
		var url = "addCommentToList.html";
		var postData = 'listNumber=' + listNumber + '&comment=' + document.getElementById('addCommentField' + listNumber).value;
		var callBack = {
						success: function(o) {
									commentIdToDbId["premadeCommentList" + listNumber + "_" + commentNumber] = o.responseText;
									var premadeCommentForm = document.getElementById("premadeCommentList" + listNumber);
									var newCommentTable = document.createElement("table");
									var newTableTr = document.createElement("tr");
									var newTableTdCheckBox = document.createElement("td");
									var newTableTdP = document.createElement("td");
									newTableTdP.setAttribute("width", "400");
									newTableTdCheckBox.innerHTML = "<input type='checkbox' value='" + comment + "' id='premadeCommentList" + listNumber + "_" + commentNumber + "_checkboxval' name='checkBoxes' onclick=\"toggleComment('premadeCommentList" + listNumber + "_" + commentNumber + "_checkboxval')\" />";
									newTableTdP.innerHTML = "<p id='premadeCommentList" + listNumber + "_" + commentNumber + "' name='checkBoxLabels'>" + comment + "</p>";
		
									premadeCommentForm.appendChild(newCommentTable);
									newCommentTable.appendChild(newTableTr);
									newTableTr.appendChild(newTableTdCheckBox);
									newTableTr.appendChild(newTableTdP);
									
									if(mode["premadeCommentList" + listNumber] == "edit") {
										openEditList(listNumber);
									} else if(mode["premadeCommentList" + listNumber] == "view") {
										document.getElementById("openEditList" + listNumber).style.display = "";
									}
									},
						failure: function(o){}
						};
		var request = YAHOO.util.Connect.asyncRequest('POST', url, callBack, postData);	
		
		//document.getElementById("addCommentDisplay" + listNumber).style.display = "none";
		document.getElementById("addCommentField" + listNumber).value = "";
	}
	
	function toggleAddCommentDisplay(listId) {
		if(document.getElementById("addCommentDisplay" + listId).style.display == "") {
			document.getElementById("addCommentDisplay" + listId).style.display = "none";
		} else {
			document.getElementById("addCommentDisplay" + listId).style.display = "";
		}
	}
	
	function toggleCreateNewListDisplay() {
		var commentLists = document.getElementById("commentLists");
		for (var i=0;i<commentLists.length;i++) {
			document.getElementById(commentLists[i].value).style.display = "none";
		}
		
		if(document.getElementById("createNewListDisplay").style.display == "") {
			document.getElementById("createNewListDisplay").style.display = "none";
			showCommentList();
		} else {
			document.getElementById("createNewListDisplay").style.display = "";
		}
	}
</script>

<div id="premadeCommentsWindowBorder">

<div id="premadeComments"><spring:message code="teacher.grading.premade.1"/></div> 

<h6 style="padding:0px 10px 10px 10px; margin:10px;"><spring:message code="teacher.grading.premade.2"/></h6>

<div>
	<a href="#" id="newList" onclick="toggleCreateNewListDisplay()"><spring:message code="teacher.grading.premade.3"/></a>
	<form onsubmit="return false;" autocomplete='false'>
	<p id="createNewListDisplay" style="display:none"><spring:message code="teacher.grading.premade.4"/><input id="newListField" type="text" /><input type="submit" value="Create New List" onclick="createNewList()" /></p>
	</form>
</div>

<div id=headerMyLists><spring:message code="teacher.grading.premade.5"/></div>
<select id="commentLists" name="commentLists" onchange="showCommentList()">
	<c:forEach var="premadeCommentList" items="${premadeCommentLists}">
		<option value="premadeCommentList${premadeCommentList.id}">${premadeCommentList.label}</option>
	</c:forEach>
</select>

<div id="commentButtonsAndCheckboxes">

	<c:forEach var="premadeCommentList" items="${premadeCommentLists}" varStatus="listStatus">
		<form id="premadeCommentList${premadeCommentList.id}" style="display:none" autocomplete='off'>
<!-- 
			<a href="#" id="duplicateList" onclick="duplicateList('premadeCommentList${premadeCommentList.id}')">Duplicate List</a>
			<a href="#" id="renameList" onclick="renameList('premadeCommentList${premadeCommentList.id}')">Rename List</a>
			<a href="#" id="shareList" onclick="shareList('premadeCommentList${premadeCommentList.id}')">Share List</a>
			<a href="#" id="deleteList" onclick="deleteList('premadeCommentList${premadeCommentList.id}')">Delete List</a>
 -->
			
			<a href="#" id="addCommentToList" onclick="toggleAddCommentDisplay(${premadeCommentList.id})"><spring:message code="teacher.grading.premade.6"/></a>
			<c:if test="${fn:length(premadeCommentList.premadeCommentList) != 0}">
				<a href="#" id="openEditList${premadeCommentList.id}" onclick="openEditList('${premadeCommentList.id}')"><spring:message code="teacher.grading.premade.7"/></a>
			</c:if>

			<a href="#" id="useList${premadeCommentList.id}" style="display:none" onclick="useList('${premadeCommentList.id}')"><spring:message code="teacher.grading.premade.8"/></a>

			
			<p class="addCommentDisplayClass" id="addCommentDisplay${premadeCommentList.id}" style="display:none"><spring:message code="teacher.grading.premade.9"/>&nbsp;<input class="addCommentFieldClass" id="addCommentField${premadeCommentList.id}" type="text" /><input class="createCommentButton" type="button" value="Create Comment" onclick="addCommentToList('${premadeCommentList.id}')" /></p>
			
			<p class="clickToEditMessageClass" id="clickToEditMessage${premadeCommentList.id}" style="display:none"><spring:message code="teacher.grading.premade.10"/></p> 
			
		<c:forEach var="premadeComment" items="${premadeCommentList.premadeCommentList}" varStatus="commentStatus">
				<c:set var="premadeCommentUnescaped" value="${premadeComment.comment}" />
				
				<table>
					<tr>
						<td>
							<input type="checkbox" value="${premadeComment.comment}" id="premadeCommentList${premadeCommentList.id}_${commentStatus.count}_checkboxval" name="checkBoxes" onclick="toggleComment('premadeCommentList${premadeCommentList.id}_${commentStatus.count}_checkboxval')" />
							<script>
								commentIdToDbId["premadeCommentList${premadeCommentList.id}_${commentStatus.count}"] = "${premadeComment.id}";
								mode["premadeCommentList${premadeCommentList.id}"] = "view";
							</script>
						</td>
						<td style="width:700px;">
							<p id="premadeCommentList${premadeCommentList.id}_${commentStatus.count}" name="checkBoxLabels">${premadeCommentUnescaped}</p>
						</td>
					</tr>
				</table>
			</c:forEach>
		</form>
		<c:if test="${listStatus.first}">
			<script>document.getElementById("premadeCommentList${premadeCommentList.id}").style.display = "";</script>
		</c:if>
		
	</c:forEach>

</div>

<div id="headerPreview"><spring:message code="teacher.grading.premade.11"/></div>

<textarea id="previewComments" rows="7" cols="60"></textarea>
	
<input id="pastePreviewButton" type="button" value="<spring:message code="teacher.grading.premade.12"/>" onclick="addComments()" />
		<!--	</form> -->
<script>document.getElementById("previewComments").value = window.opener.document.getElementById("${commentBox}").value</script>

</div>      <!--End of premadeCommentsWindowBorder-->

</body>

</html>
