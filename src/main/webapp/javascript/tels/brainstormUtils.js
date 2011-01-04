
	
	function popUp(URL, name){
		window.open(URL, name, 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=960,height=740,left = 450,top = 150');
	};
	
	function responsePopUp(workgroupId, brainstormId){
		popUp('brainstormresponse.html?workgroupId=' + workgroupId + '&brainstormId=' + brainstormId, 'TeamResponse');
	};
	
	function addCommentPopUp(workgroupId, answerId, brainstormId){
		popUp('addcomment.html?workgroupId=' + workgroupId + '&answerId=' + answerId + '&brainstormId=' + brainstormId, 'AddComment');
	};
	
	function addRevisionPopUp(workgroupId, answerId, brainstormId){
		popUp('addrevision.html?workgroupId=' + workgroupId + '&answerId=' + answerId + '&brainstormId=' + brainstormId, 'AddRevision');
	};
	
	function hideallanswers(brainstormId, cannotseeresponses) {
	  if(cannotseeresponses) {
	    var rtb = document.getElementById('responseTableBody');
	    rtb.style.display='none';
	    var rd = document.getElementById('cannotSeeMessage');
	    rd.innerHTML = "Please create a response.  After submitting it you'll be able to see responses from other students.";	    
	    rd.innerHTML = "Please create a new response.  After posting it you'll be able to see responses from other students.";
	  } else  {
	  };
	};
	
	function requestHelp(workgroupId, brainstormId) {
		var isChecked = document.getElementById('requesthelp_' + workgroupId + '_' + brainstormId).checked;
		if (isChecked) {
			var URL='requesthelp.html';
			var data='mark=1&workgroupId=' + workgroupId + '&brainstormId=' + brainstormId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		} else {
			var URL='requesthelp.html';
			var data='mark=0&workgroupId=' + workgroupId + '&brainstormId=' + brainstormId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		}
		
	};
	
	function markAnswerAsHelpful(workgroupId, answerId) {
		var isChecked = document.getElementById('helpful_' + workgroupId + '_' + answerId).checked;
		if (isChecked) {
			var URL='markanswerhelpful.html';
			var data='mark=1&type=helpful&workgroupId=' + workgroupId + '&answerId=' + answerId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		} else {
			var URL='markanswerhelpful.html';
			var data='mark=0&type=helpful&workgroupId=' + workgroupId + '&answerId=' + answerId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		}
	};
	
	function tagAnswer(workgroupId, answerId) {
		var isChecked = document.getElementById('tag_' + workgroupId + '_' + answerId).checked;
		if (isChecked) {
			var URL='markanswerhelpful.html';
			var data='mark=1&type=tag&workgroupId=' + workgroupId + '&answerId=' + answerId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		} else {
			var URL='markanswerhelpful.html';
			var data='mark=0&type=tag&workgroupId=' + workgroupId + '&answerId=' + answerId;
			var callback = 
				{
					success:function(o){},
					failure:function(o){}
				};
			YAHOO.util.Connect.asyncRequest('POST', URL, callback, data);
		}
	};
	
	function refreshResponses(){
		pageManager.refreshPage();
		getNumberOfPosts();
	};
	
	function sortBy(sortCriteria,sortingOrder){
		pageManager.setSortOrder(sortCriteria, sortingOrder);
		pageManager.updatePage();
	};

	function filter(isFilterOn){
		pageManager.setFilter(isFilterOn);
		pageManager.updatePage();
	};

	function getNumberOfPosts(){
		var numOfPostElement = document.getElementById('numOfPosts');
		var numOfPosts = document.getElementsByName('answer').length + document.getElementsByName('comment').length;
		if(numOfPosts==1){
			numOfPostElement.innerHTML = 'Student Responses (1 posting)';
		} else {
			numOfPostElement.innerHTML = 'Student Responses (' + numOfPosts + ' postings)';
		};
	};
	
	function setInstantPollState(val){
		var responseButton = document.getElementById('createResponseButton');
		var showLatestButton = document.getElementById('showLatestButton');
		
		if(val==true || val=="true"){
			responseButton.disabled = false;
			if(showLatestButton!=null){
				showLatestButton.disabled = true;
			};
		} else {
			responseButton.disabled = true;
			if(showLatestButton!=null){
				showLatestButton.disabled = false;
			};
		};
	};


	function pollNewPosts(brainstormId){
		this.callback={
			success: function(o){
				var out = "";
				var newPosts = Number(o.responseText) - pageManager.getTotalPosts();
				if(newPosts > 0){
					if(newPosts == 1){
						out = "1 new response received";
					} else {
						out = newPosts + " new responses received";
					};
				} else {
					out = "0 new responses received";
				};
				document.getElementById('numNewResponses').innerHTML=out;
			},
			failure: function(o){}, //do nothing, this runs on an interval
			scope:this
			};
	
		YAHOO.util.Connect.asyncRequest('GET', 'pollnewposts.html?brainstormId=' + brainstormId, this.callback);
	};
	
	function getInstantPollActive(id){
			var success = function(o){
				if(o.responseText!=null && o.responseText!=""){
					setInstantPollState(o.responseText);
				};
			};
			var failure = function(o){}; //do nothing, this runs on intervals
			var callback = {success:success, failure:failure};
			YAHOO.util.Connect.asyncRequest('GET', 'pollinstantpoll.html?brainstormId=' + id, callback);	
	};
	
	function getResultsGraph(id, pollGraph){
			var success = function(o){
				if(o.responseText!=null && o.responseText!=""){
					clearInterval(pollGraph);
					var parent = document.getElementById('column3');
					parent.removeChild(document.getElementById('graph'));
					var graphDiv = createElement(document, 'div', {id: 'graph'});
					var graphElement = createElement(document, 'img', {src:o.responseText});
					graphDiv.appendChild(graphElement);
					document.getElementById('column3').appendChild(graphDiv);
				};
			};
			var failure = function(o){
				alert('failed update to server retrieving graph data');
			};
			var callback = {success:success, failure:failure};
			YAHOO.util.Connect.asyncRequest('GET', 'resultsgraph.html?brainstormId=' + id, callback);
	};
	
	/**
	* PageManager manages adding and removing Answers, Revisions
	* and Comments for a given brainstorm as well as creating and
	* updating Answer tables and refreshing the elements of a page
	*/
	function PageManager(brainstormId, workgroupId, criteria, sortOrder, type){
		this.id = brainstormId;
		this.workgroupId = workgroupId;
		this.sortCriteria = criteria;
		this.sortOrder = sortOrder;
		this.answers;
		this.isFilterOn;
		this.type = type;
		this.pollPosts;
		this.pollGraph;
		this.pollInstantPoll;
		
		this.callback = {
			success:this.handleSuccess,
			failure:this.handleFailure,
			scope:this
		};
		
		this.getAllPosts = function(){
			YAHOO.util.Connect.asyncRequest('GET', 'getallposts.html?brainstormId=' + this.id, this.callback);
		};
			
		this.pollPosts = setInterval("pollNewPosts(" + this.id + "," + this.pollPosts + ")", 60000);
		this.getAllPosts();

		if(this.type=='SINGLE_CHOICE'){
			getInstantPollActive(this.id);
	  		this.pollInstantPoll = setInterval('getInstantPollActive(' + this.id + ')', 60000);
			getResultsGraph(this.id);
			this.pollGraph = setInterval("getResultsGraph(" + this.id + "," + this.pollGraph + ")", 60000);
		};
	};
	
	PageManager.prototype.handleFailure = function(o){
		//alert('failure');
		//alert(o.responseXML);
		//alert(o.responseText);
		//alert(o.getAllResponseHeaders);
		//alert(o.status);
		//alert(o.statusText);		
		//error stuff goes here
	};
	
	PageManager.prototype.handleSuccess = function(o){
		var xmlDoc = o.responseXML;
		if(xmlDoc==null){
			this.handleFailure(o);
		};
		this.answers = new Answers();
		this.answers.setAnswers(xmlDoc);
		this.answers.setType(this.type);
		this.updatePage();
	};
	
	//gets all posts from server and builds answer tables from new data
	PageManager.prototype.refreshPage = function(){
		this.getAllPosts();
	};
	
	PageManager.prototype.getAnswerById = function(id){
		return this.answers.getAnswerById(id);
	};
	
	PageManager.prototype.addAnswer = function(answer){
		this.answers.addAnswer(answer);
		this.updatePage();
	};
	
	PageManager.prototype.addRevision = function(revision, answerId){
		var answer = this.answers.getAnswerById(answerId);
		answer.addRevision(revision);
		this.updatePage();
	};
	
	PageManager.prototype.addComment = function(comment, answerId){
		var answer = this.answers.getAnswerById(answerId);
		answer.addComment(comment);
		this.updatePage();
	};
	
	PageManager.prototype.getTotalPosts = function(){
		var total = 0;
		var answers = this.answers.getAnswers();
		for(an=0;an<answers.length;an++){
			var answer = answers[an];
			total = total + answer.getRevisions().length + answer.getComments().length;
		};
		return total;
	};
	
	//builds answer tables from existing data without a request to server
	PageManager.prototype.updatePage = function(){
		var orderedElements;
		//alert('beforesort:' + this.answers.getAnswers().length);
		this.answers.sort(this.sortCriteria, this.sortOrder);
		//alert('aftersort:' + this.answers.getAnswers().length);
		this.answers.filter(this.isFilterOn);			
		orderedElements = createAnswerElements(document, this.answers, this.workgroupId, this.id);
		this.buildPage(orderedElements);		
	};
	
	PageManager.prototype.setSortOrder = function(criteria, order){
		this.sortCriteria = criteria;
		this.sortOrder = order;
	};
	
	PageManager.prototype.setFilter = function(isFilterOn){
		this.isFilterOn = isFilterOn;
	};

	PageManager.prototype.buildPage = function(elements){
		// removes all the divs with id=answer in responseTableBody div
		// then adds all the answers in elements to that responseTableBody div
		var answerNodes = document.getElementsByName('answer');
		var responseTableBodyNode = document.getElementById('responseTableBody');
		var responseTableBodyParent = responseTableBodyNode.parentNode;
		responseTableBodyParent.removeChild(responseTableBodyNode);
		var newResponseTableBody = createElement(document, 'div', {id:'responseTableBody'})
		responseTableBodyParent.appendChild(newResponseTableBody);
		
		//var answerelements = responseTableBodyNode.childNodes;
		//alert('answerelements.length: ' + answerelements.length);
		//alert('answerNodes.length:' + answerNodes.length)
		//var originalAnswerNodeLength = answerNodes.length;
		//for(xx=0;xx<originalAnswerNodeLength;xx++){
			//alert('id:' + answerNodes[xx].getAttribute('id'));
			//if(answerNodes[xx].getAttribute('id')!=0){
				//alert('id:' + answerNodes[xx].getAttribute('id'));
				//answerNodes[xx].parentNode.removeChild(answerNodes[xx]);
				//responseTableBodyNode.removeChild(answerNodes[xx]);
			//};
		//};
		//var answerNodes2 = document.getElementsByName('answer');
		//alert("answerNodes2.length:" + answerNodes2.length)
		
		for(cc=0;cc<elements.length;cc++){
			newResponseTableBody.appendChild(elements[cc]);
		};
		document.getElementById('numNewResponses').innerHTML="0 new responses received";
	};
	
	PageManager.prototype.setPollInterval = function(interval){
		clearInterval(this.pollPosts);
		this.pollPosts = setInterval("pollNewPosts(" + this.id + ")", interval);
	};