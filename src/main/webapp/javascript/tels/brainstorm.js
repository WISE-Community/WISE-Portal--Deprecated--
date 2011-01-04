
function Answers(){
	this.answers = [];
	this.choices = [];
	this.type;
	this.allAnswers = [];
};

Answers.prototype.setAnswers = function(xmlAnswers){
	var xAnswers = xmlAnswers.getElementsByTagName('answer');
	if(xAnswers!=null && xAnswers[0]!=null){
		for(x=0;x<xAnswers.length;x++){
			this.setAnswer(xAnswers[x]);
		};
	};	
	
	var xChoices = xmlAnswers.getElementsByTagName('choice');
	if(xChoices!=null && xChoices[0]!=null){
		for(yh=0;yh<xChoices.length;yh++){
			this.setChoice(xChoices[yh]);
		};
	};
};

Answers.prototype.getAnswers = function(){
	return this.answers;
};

Answers.prototype.setAnswer = function(xmlAnswer){
	this.answers.push(new Answer(xmlAnswer));
	this.allAnswers.push(new Answer(xmlAnswer));
};

Answers.prototype.addAnswer = function(answer){
	this.answers.push(answer);
};

Answers.prototype.getAnswerById = function(id){
	var foundAnswer;
	for(aa=0;aa<this.answers.length;aa++){
		if(this.answers[aa].getId()==id){
			return this.answers[aa];
		};
	};
};

Answers.prototype.getType = function(){
	return this.type;
};

Answers.prototype.setType = function(type){
	this.type = type;
};

Answers.prototype.setChoice = function(xmlChoice){
	this.choices.push(new Choice(xmlChoice));
};

Answers.prototype.getChoices = function(){
	return this.choices;
};

function oldestFirst(a, b){
	return Number(b.getLatestRevision().getId()) - Number(a.getLatestRevision().getId());
};

function newestFirst(a, b){
	return Number(b.getLatestRevision().getId()) - Number(a.getLatestRevision().getId());
};

function helpfulness(a, b){	
	return Number(a.getHelpfulWorkgroups().length) - Number(b.getHelpfulWorkgroups().length);
};

Answers.prototype.sort = function(criteria, sortingOrder){
	//var sortCriteria  // 0=sortbytime, 1=sortbyhelpfulness
	//var sorOrder      // 0=decreasing, 1=increasing
	
	//users javascript's array[].sort(function(a,b)), 
	// where function(a,b) returns 
	// -1 if a should be before b in the array
	// 0  if a and b are the same
	// 1 if a should be after b in the array
	if (criteria==0) {
		this.answers = this.answers.sort(newestFirst);
		if (sortingOrder==1) {
    	    this.answers.reverse();
		}
    } else if (criteria==1) {
    	this.answers = this.answers.sort(helpfulness);
    	if (sortingOrder==1) {
    	    this.answers.reverse();
    	}
    }
};

Answers.prototype.toString = function(){
	var outAnswers = "Answers: ";
	for(l=0;l<this.answers.length;l++){
		outAnswers = outAnswers + this.answers[l].toString();
	};
	return outAnswers;
};

function isTeacherTagged(answer){	
	var answerTags = answer.getAnswerTags();
	for (at=0;at<answerTags.length;at++) {
		if (answerTags[at].getIsTeacherAnswerTag()) {
			return true;
		}
	}
	return false; 
};

Answers.prototype.filter = function(isFilterOn){
	if (isFilterOn) {
		this.answers = this.answers.filter(isTeacherTagged);
	} else {
		this.answers = this.allAnswers;	
	}
};

function Answer(xmlAnswer){
	this.id;
	this.revisions = [];
	this.workgroup;
	this.comments = [];
	this.anonymous;
	this.helpfulWorkgroups= [];
	this.answerTags = [];
	
	this.setAnswer(xmlAnswer);
};

Answer.prototype.setAnswer = function(xmlAnswer){
	this.setId(xmlAnswer.childNodes[0]);
	this.setRevisions(xmlAnswer.getElementsByTagName('revisions'));
	this.setWorkgroup(xmlAnswer.childNodes[4]);
	this.setComments(xmlAnswer.getElementsByTagName('comments'));
	this.setAnonymous(xmlAnswer.childNodes[1]);
	this.setHelpfulWorkgroups(xmlAnswer.getElementsByTagName('helpfulworkgroups'));
	this.setAnswerTags(xmlAnswer.getElementsByTagName('answertags'));
};

Answer.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId.childNodes[0].nodeValue;
	};
};

Answer.prototype.setRevisions = function(xmlRevisions){
	if(xmlRevisions!=null && xmlRevisions[0]!=null){
		var revisions = xmlRevisions[0].getElementsByTagName('revision');
		if(revisions!=null && revisions[0]!=null){
			for(h=0;h<revisions.length;h++){
				this.revisions.push(new Revision(revisions[h]));
			};
		};
	};
};

Answer.prototype.setWorkgroup = function(xmlWorkgroup){
	if(xmlWorkgroup!=null){
		this.workgroup=(new Workgroup(xmlWorkgroup));
	};
};

Answer.prototype.setComments = function(xmlComments){
	if(xmlComments!=null && xmlComments[0]!=null){
		var comments = xmlComments[0].getElementsByTagName('comment');
		if(comments!=null && comments[0]!=null){
			for(j=0;j<comments.length;j++){
				this.comments.push(new Comment(comments[j]));
			};
		};
	};
};

Answer.prototype.setAnonymous = function(xmlAnon){
	if(xmlAnon!=null){
		this.anonymous=booleanValueOf(xmlAnon.childNodes[0].nodeValue);
	};
};

Answer.prototype.setAnswerTag = function(xmlAnswerTag){
	if(xmlAnswerTag!=null){
		this.answerTag=(new AnswerTag(xmlAnswerTag));
	};
};

Answer.prototype.setAnswerTags = function(xmlAnswerTags){
	if(xmlAnswerTags!=null && xmlAnswerTags[0]!=null){
		var answerTags = xmlAnswerTags[0].getElementsByTagName('answertag');
		if(answerTags!=null && answerTags[0]!=null){
			for(af=0;af<answerTags.length;af++){
				this.answerTags.push(new AnswerTag(answerTags[af]));
			};
		};
	};
};

Answer.prototype.getAnswerTags = function(){
	return this.answerTags;
};

function booleanValueOf(v){
	if(v=='true'){
		return true;
	} else {
		return false;
	}
};

Answer.prototype.setHelpfulWorkgroups = function(xmlHelpfulWorkgroups){
	if(xmlHelpfulWorkgroups!=null && xmlHelpfulWorkgroups[0]!=null){
		var helpfulWorkgroups = xmlHelpfulWorkgroups[0].getElementsByTagName('workgroup');
		if(helpfulWorkgroups!=null && helpfulWorkgroups[0]!=null){
			for(af=0;af<helpfulWorkgroups.length;af++){
				this.helpfulWorkgroups.push(new Workgroup(helpfulWorkgroups[af]));
			};
		};
	};
};

Answer.prototype.addRevision = function(revision){
	this.revisions.push(revision);
};

Answer.prototype.addComment = function(comment){
	this.comments.push(comment);
};

Answer.prototype.getId = function(){
	return this.id;
};

Answer.prototype.getRevisions = function(){
	return this.revisions;
};

Answer.prototype.getWorkgroup = function(){
	return this.workgroup;
};

Answer.prototype.getComments = function(){
	return this.comments;
};

Answer.prototype.isAnonymous = function(){
	return this.anonymous;
};

Answer.prototype.getHelpfulWorkgroups = function(){
	return this.helpfulWorkgroups;
};

Answer.prototype.getLatestRevision = function(){
	return this.revisions[this.revisions.length-1];
};

Answer.prototype.getOtherRevisions = function(){
	var others = [];
	for(r=0;r<this.revisions.length - 1;r++){
		others.push(this.revisions[r]);
	};
	return others;
};

Answer.prototype.toString = function(){
	var outAnswer = "(Answer: id=" + this.id + " anon=" + this.anonymous + "(Revisions: ";
	for(y=0;y<this.revisions.length;y++){
		outAnswer = outAnswer + this.revisions[y].toString();
	};
	outAnswer = outAnswer + ") (Comments: ";
	for(d=0;d<this.comments.length;d++){
		outAnswer = outAnswer + this.comments[d].toString();
	};
	outAnswer = outAnswer + ") " + this.workgroup.toString() + " (Helpful workgroups: ";
	for(s=0;s<this.helpfulWorkgroups.length;s++){
		outAnswer = outAnswer + this.helpfulWorkgroups[s].toString();
	};
	outAnswer = outAnswer + ") )";
	return outAnswer;
};

function Revision(xmlRevision){
	this.timestamp;
	this.body;
	this.id;
	this.displayname;
	this.setRevision(xmlRevision);
};

Revision.prototype.setRevision = function(xmlRevision){
	this.setId(xmlRevision.getElementsByTagName('id'));
	this.setBody(xmlRevision.getElementsByTagName('body'));
	this.setTimestamp(xmlRevision.getElementsByTagName('timestamp'));
	this.setDisplayname(xmlRevision.getElementsByTagName('displayname'));
};

Revision.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId[0].childNodes[0].nodeValue;
	};
};

Revision.prototype.setBody = function(xmlBody){
	if(xmlBody!=null){
		this.body=xmlBody[0].textContent;
	};
};

Revision.prototype.setTimestamp = function(xmlTimestamp){
	if(xmlTimestamp!=null){
		this.timestamp=xmlTimestamp[0].childNodes[0].nodeValue;
	};
};

Revision.prototype.setDisplayname = function(xmlDisplayname){
	if(xmlDisplayname!=null && xmlDisplayname != "" && xmlDisplayname.length > 0){
		this.displayname=xmlDisplayname[0].childNodes[0].nodeValue;
	};
};
Revision.prototype.toString = function(){
	var outRevision = "(Revision: id=" + this.id + " body=" + this.body + " timestamp=" + this.timestamp + ")";
	return outRevision;
};

Revision.prototype.getId = function(){
	return this.id;
};

Revision.prototype.getBody = function(){
	return this.body;
};

Revision.prototype.getTimestamp = function(){
	return this.timestamp;
};

Revision.prototype.getDisplayname = function(){
	return this.displayname;
};

function Comment(xmlComment){
	this.id;
	this.workgroup;
	this.timestamp;
	this.body;
	this.anonymous;
	this.setComment(xmlComment);
};

Comment.prototype.setComment = function(xmlComment){
	this.setId(xmlComment.childNodes[0]);
	this.setWorkgroup(xmlComment.childNodes[2]);
	this.setTimestamp(xmlComment.getElementsByTagName('timestamp'));
	this.setBody(xmlComment.getElementsByTagName('body'));
	this.setAnonymous(xmlComment.getElementsByTagName('anon'));
};

Comment.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId.childNodes[0].nodeValue;
	};
};

Comment.prototype.setWorkgroup = function(xmlWorkgroup){
	if(xmlWorkgroup!=null){
		this.workgroup = new Workgroup(xmlWorkgroup);
	};
};

Comment.prototype.setTimestamp = function(xmlTimestamp){
	if(xmlTimestamp!=null){
		this.timestamp=xmlTimestamp[0].childNodes[0].nodeValue;
	};
};

Comment.prototype.setBody = function(xmlBody){
	if(xmlBody!=null){
		this.body=xmlBody[0].childNodes[0].nodeValue;
	};
};

Comment.prototype.setAnonymous = function(xmlAnon){
	if(xmlAnon!=null || xmlAnon[0]!=null){
		this.anonymous=booleanValueOf(xmlAnon[0].childNodes[0].nodeValue);
	};
};

Comment.prototype.toString = function(){
	var outComment = "(Comment: id=" + this.id + " anon=" + this.anonymous + " workgroup=" + this.workgroup.toString();
	outComment = outComment + " body=" + this.body + " timestamp=" + this.timestamp + ")";
	return outComment;
};

Comment.prototype.getId = function(){
	return this.id;
};

Comment.prototype.getWorkgroup = function(){
	return this.workgroup;
};

Comment.prototype.getTimestamp = function(){
	return this.timestamp;
};

Comment.prototype.getBody = function(){
	return this.body;
};

Comment.prototype.isAnonymous = function(){
	return this.anonymous;
};

function Workgroup(xmlWorkgroup){
	this.id;
	this.members = [];
	this.setWorkgroup(xmlWorkgroup);
};

Workgroup.prototype.setWorkgroup = function(xmlWorkgroup){
	this.setId(xmlWorkgroup.childNodes[0]);
	this.setMembers(xmlWorkgroup.getElementsByTagName('student'));
};

Workgroup.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId.childNodes[0].nodeValue;
	};
};

Workgroup.prototype.setMembers = function(xmlMembers){
	if(xmlMembers!=null && xmlMembers[0]!=null){
		for(a=0;a<xmlMembers.length;a++){
			this.members.push(new Member(xmlMembers[a]));
		};
	};
};

Workgroup.prototype.toString = function(){
	var outWorkgroup = "(Workgroup: id=" + this.id + " members=";
	for(e=0;e<this.members.length;e++){
		outWorkgroup = outWorkgroup + this.members[e].toString();
	};
	outWorkgroup = outWorkgroup + ")";
	return outWorkgroup;
};

Workgroup.prototype.getId = function(){
	return this.id;
};

Workgroup.prototype.getMembers = function(){
	return this.members;
};

function Member(xmlMember){
	this.id;
	this.firstname;
	this.lastname;
	this.setMember(xmlMember);
};

Member.prototype.setMember = function(xmlMember){
	this.setId(xmlMember.getElementsByTagName('id'));
	this.setFirstname(xmlMember.getElementsByTagName('firstname'));
	this.setLastname(xmlMember.getElementsByTagName('lastname'));
};

Member.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId[0].childNodes[0].nodeValue;
	};
};

Member.prototype.setFirstname = function(xmlFirst){
	if(xmlFirst!=null){
		this.firstname=xmlFirst[0].childNodes[0].nodeValue;
	};
};

Member.prototype.setLastname = function(xmlLast){
	if(xmlLast!=null){
		this.lastname=xmlLast[0].childNodes[0].nodeValue;
	};
};

Member.prototype.toString = function(){
	var outMember = "(Member: id=" + this.id + " firstname=" + this.firstname + " lastname=" + this.lastname + ")";
	return outMember;
};

Member.prototype.getId = function(){
	return this.id;
};

Member.prototype.getFirstname = function(){
	return this.firstname;
};

Member.prototype.getLastname = function(){
	return this.lastname;
};


function AnswerTag(xmlAnswerTag){
	this.id;
	this.type;
	this.isTeacherAnswerTag;
	this.explanation;
	this.workgroup;
	this.setAnswerTag(xmlAnswerTag);
};

AnswerTag.prototype.setAnswerTag = function(xmlAnswerTag){
	this.setId(xmlAnswerTag.childNodes[0]);
	this.setType(xmlAnswerTag.childNodes[1]);
	this.setIsTeacherAnswerTag(xmlAnswerTag.childNodes[2]);
	this.setExplanation(xmlAnswerTag.childNodes[3]);
	this.setWorkgroup(xmlAnswerTag.childNodes[4]);
};

AnswerTag.prototype.setId = function(xmlId){
	if(xmlId!=null){
		this.id=xmlId.childNodes[0].nodeValue;
	};
};

AnswerTag.prototype.setType = function(xmlType){
	if(xmlType!=null){
		this.type=xmlType.childNodes[0].nodeValue;
	};
};

AnswerTag.prototype.setIsTeacherAnswerTag = function(xmlIsTeacherAnswer){
	if(xmlIsTeacherAnswer!=null){
		this.isTeacherAnswerTag=xmlIsTeacherAnswer.childNodes[0].nodeValue;
	};
};

AnswerTag.prototype.setExplanation = function(xmlExplanation){
	if(xmlExplanation!=null){
		this.explanation=xmlExplanation.childNodes[0].nodeValue;
	};
};

AnswerTag.prototype.setWorkgroup = function(xmlWorkgroup){
	if(xmlWorkgroup!=null){
		this.workgroup = new Workgroup(xmlWorkgroup);
		//this.workgroup=xmlWorkgroup.childNodes[0].nodeValue;
	};
};

AnswerTag.prototype.getId = function(){
	return this.id;
};

AnswerTag.prototype.getType = function(){
	return this.type;
};

AnswerTag.prototype.getIsTeacherAnswerTag = function(){
	return this.isTeacherAnswerTag;
};

AnswerTag.prototype.getExplanation = function(){
	return this.explanation;
};

AnswerTag.prototype.getWorkgroup = function(){
	return this.workgroup;
};

function Choice(xmlChoice){
	this.identifier = xmlChoice.getElementsByTagName('identifier')[0].childNodes[0].nodeValue;
	this.content;
	if(xmlChoice.getElementsByTagName('content')[0].childNodes[0].nodeValue==null){
		var imgNode = xmlChoice.getElementsByTagName('content')[0].childNodes[0]; 
		var img = "<img src=\"" + imgNode.getAttribute('src') + "\"/>";
		this.content = img;
	} else {
		this.content = xmlChoice.getElementsByTagName('content')[0].childNodes[0].nodeValue;
	};
};

Choice.prototype.getIdentifier = function(){
	return this.identifier;
};

Choice.prototype.getContent = function(){
	return this.content;
};

Choice.prototype.matches = function(identifier){
	return this.identifier==identifier;
};

/**
* functions for building elements and inserting them into
* the appropriate place for the student brainstorm
**/

function createAttribute(doc, node, type, val){
	var attribute = doc.createAttribute(type);
	attribute.nodeValue = val;
	node.setAttributeNode(attribute);
};

function createElement(doc, type, attrArgs){
	var newElement = doc.createElement(type);
	if(attrArgs!=null){
		for(var option in attrArgs){
			createAttribute(doc, newElement, option, attrArgs[option]);
		};
	};
	return newElement;
};

/**
 * Returns true iff the specified Workgroup has tagged the
 * specified answer.
 * @param workgroupId
 * @param answer
 * @return
 */
function tagged(workgroupId, answer){
	var answertags = answer.getAnswerTags();  //answertags is an array of AnswerTag.
	var tagged = false;
	for(ab=0;ab<answertags.length;ab++){
		if(answertags[ab].getWorkgroup().getId()==workgroupId){
			tagged=true;
		};
	};	
	return tagged;
};

function createAnswerElements(doc, answers, workgroupId, brainstormId){
	var answerElements = [];
	var answerArray = answers.getAnswers();
	
	for(w=0;w<answerArray.length;w++){
		answerElements.push(createAnswerElement(doc, answerArray[w], workgroupId, brainstormId, answers.getType(), answers.getChoices()));
	};
	return answerElements;
};

function createAnswerElement(doc, answer, workgroupId, brainstormId, type, choices){
	var answerElement = createElement(doc, 'div', {id:answer.getId(), name:'answer', 'class':'studentResponse'});
	var answerTable = createElement(doc,'table', {id:'revisionBoxTable'});
	answerElement.appendChild(answerTable);
	
	answerTable.appendChild(createLatestRevisionElement(doc, workgroupId, answer, brainstormId, type, choices));
	if(answer.getRevisions().length>1){
		answerTable.appendChild(createOtherRevisionElements(doc, answer, type, choices));
	};
	if(answer.getComments().length > 0){
		answerTable.appendChild(createCommentsElement(doc, workgroupId, answer, brainstormId));
	};

	return answerElement;
}

function createLatestRevisionElement(doc, workgroupId, answer, brainstormId, type, choices){
	var revisionElement = createElement(doc, 'tr', {id:answer.getLatestRevision().getId(), 'class':'currentResponseBoxTR', name:'revision'});
	var revisionTable = createElement(doc, 'table', {'class':'currentResponseBoxInsetTable'});
	revisionElement.appendChild(revisionTable);
	revisionTable.appendChild(createRevisionHead(doc, workgroupId, answer));
	revisionTable.appendChild(createRevisionBody(doc, workgroupId, answer, brainstormId, type, choices));
	
	return revisionElement;
};

function createRevisionHead(doc, workgroupId, answer){
    var head = null;
	if(answer.getWorkgroup().getId()==workgroupId){
	    head = createElement(doc, 'thead', {'class':'theadowner'});
	} else {
	    head = createElement(doc, 'thead');
	}
	var headRow = createElement(doc, 'tr');
	var cell1 = createElement(doc, 'th', {'class':'headerStudentName'});
	var cell2 = createElement(doc, 'th', {'class':'headerResponseInfo'});
	var cell3 = createElement(doc, 'th', {'class':'headerResponseInfo'});
	var divNames = createElement(doc, 'div');
	var divTime = createElement(doc, 'div');
	var divHelpful = createElement(doc, 'div');
	var namesText;
	if(answer.isAnonymous()){
		namesText = doc.createTextNode("Anonymous");
	} else if (answer.getLatestRevision().getDisplayname() != null 
			&& answer.getLatestRevision().getDisplayname() != "") {
		namesText = doc.createTextNode(answer.getLatestRevision().getDisplayname());
	} else {
		namesText = doc.createTextNode(getNames(answer.getWorkgroup()));
	};
	var timeText = doc.createTextNode(answer.getLatestRevision().getTimestamp());
	var helpfulText = doc.createTextNode(answer.getHelpfulWorkgroups().length + ' students found this post helpful');
	
	divNames.appendChild(namesText);
	divTime.appendChild(timeText);
	divHelpful.appendChild(helpfulText);
	cell1.appendChild(divNames);
	cell2.appendChild(divTime);
	cell3.appendChild(divHelpful);
	headRow.appendChild(cell1);
	headRow.appendChild(cell2);
	headRow.appendChild(cell3);
	head.appendChild(headRow);
	return head;
};

function createRevisionBody(doc, workgroupId, answer, brainstormId, type, choices){
	var tbody = createElement(doc, 'tbody');
	var revHead = createElement(doc, 'tr');
	var revBody = createElement(doc, 'tr');
	var revFoot = createElement(doc, 'tr');
	var cell1 = createElement(doc, 'td', {'class':'addCommentTD', colSpan:'2'});
	var cell2 = createElement(doc, 'td', {'class':'reviseResponseTD'});
	var divAddComment = createElement(doc, 'div');
	var divVar = createElement(doc, 'div');
	
	divAddComment.innerHTML = '<a href="#" onclick="addCommentPopUp(' + workgroupId + ',' + answer.getId() + ',' + brainstormId + ')">Add a Comment</a>';
	if (answer.getWorkgroup().getId()==workgroupId){
		divVar.innerHTML ='<a href="#" onclick="addRevisionPopUp(' + workgroupId + ',' + answer.getId() + ',' + brainstormId + ')">Revise this Response</a>';
	} else {
		var helpful;
		var fHelp = foundHelpful(workgroupId, answer);
		var helpfulTxt = createElement(doc, 'label', {});		
		helpfulTxt.innerHTML = 'I found this response helpful';
		if(fHelp){
			helpful = createElement(doc, 'input', {type:'checkbox', id:'helpful_' + workgroupId + '_' + answer.getId(), checked:'checked', value:'helpful', onclick:'javascript:markAnswerAsHelpful(' + workgroupId +', ' + answer.getId() + ')'});
		} else {
			helpful = createElement(doc, 'input', {type:'checkbox', id:'helpful_' + workgroupId + '_' + answer.getId(), value:'helpful', onclick:'javascript:markAnswerAsHelpful(' + workgroupId +', ' + answer.getId() + ')'});
		};
		divVar.appendChild(helpful);
		divVar.appendChild(helpfulTxt);
	};
	
	if(answer.getRevisions().length > 1){
		var revRow = createElement(doc, 'td', {'class':'currentRevisionNumber'});
		revRow.appendChild(doc.createTextNode('Revision ' + answer.getRevisions().length));
	    revHead.appendChild(revRow);		
	};

	cell1.appendChild(divAddComment);
	cell2.appendChild(divVar);
	revFoot.appendChild(cell1);
	revFoot.appendChild(cell2);
	var revPre = createElement(doc, 'td', {'class':'currentResponseText', colSpan:'3'});

	if(type == 'SINGLE_CHOICE'){
		revPre.innerHTML = getChoice(answer.getLatestRevision().getBody(), choices);
	} else {
		revPre.innerHTML = answer.getLatestRevision().getBody();
	};
	revBody.appendChild(revPre);
	tbody.appendChild(revHead);
	tbody.appendChild(revBody);
	tbody.appendChild(revFoot);
	return tbody;
};

function foundHelpful(workgroupId, answer){
	var workgroups = answer.getHelpfulWorkgroups();
	var helpful = false;
	for(ab=0;ab<workgroups.length;ab++){
		if(workgroups[ab].getId()==workgroupId){
			helpful=true;
		};
	};	
	return helpful;
};

function createOtherRevisionElements(doc, answer, type, choices){
	var otherRevisions = answer.getOtherRevisions();
	var others = createElement(doc, 'tr', {name:'revisionrow'});
	var othersTable = createElement(doc, 'table', {name:'revisionTable', id:'revisionTable'});
	var head = createElement(doc, 'tr');
	var headDiv = createElement(doc, 'td', {'class':'revisionTableHeader'});
	
	headDiv.appendChild(doc.createTextNode('Revisions'));
	head.appendChild(headDiv);
	othersTable.appendChild(head);
	others.appendChild(othersTable);
	
	var names;
	if(answer.isAnonymous()){
		names = 'Anonymous'; 
	} else {
		names = getNames(answer.getWorkgroup());
	};
	for(o=0;o<otherRevisions.length;o++){
		var newRow = createElement(doc, 'tr');
		var newTD = createElement(doc, 'td', {'class':'revisionTextTD'});
		var spanDiv = createElement(doc, 'span', {'class':'revisionTextTag'});
		var newRevisionTextBody = (o+1) + ': ';
		if(type == 'SINGLE_CHOICE'){
		 	newRevisionTextBody = newRevisionTextBody + getChoice(otherRevisions[o].getBody(), choices);
		 } else {
		 	newRevisionTextBody = newRevisionTextBody + otherRevisions[o].getBody();
		 };
		var newRevisionTextTag =  ' (' + names + ', ' + otherRevisions[o].getTimestamp() + ')';
				
		othersTable.appendChild(newRow);
		newRow.appendChild(newTD);
		var revisionTextElement = createElement(doc, "div");
		revisionTextElement.innerHTML = newRevisionTextBody;
		newTD.appendChild(revisionTextElement);
		spanDiv.appendChild(doc.createTextNode(newRevisionTextTag));
		newTD.appendChild(spanDiv);
		
	};
	return others;
};

function createCommentsElement(doc, workgroupId, answer, brainstormId){
	var comments = answer.getComments();
	var commentElement = createElement(doc, 'tr', {name:'comments', id:answer.getId()});
	var commentTable = createElement(doc, 'table', {name:'commentsTable', id:'commentsTable'});
	var head = createElement(doc, 'tr');
	var numOfComments = createElement(doc, 'td', {'class':'commentsTableTD1'});
	var divAddComment = createElement(doc, 'td');
	
	numOfComments.appendChild(doc.createTextNode(comments.length + ' comments'));
	divAddComment.innerHTML = '<a href="#" onclick="addCommentPopUp(' + workgroupId + ',' + answer.getId() + ',' + brainstormId  + ')">Add a Comment</a>';
	head.appendChild(numOfComments);
	head.appendChild(divAddComment);
	commentTable.appendChild(head);
	commentElement.appendChild(commentTable);
	
	for(i=0;i<comments.length;i++){
		var workgroup = comments[i].getWorkgroup();
		var names;
		if(comments[i].isAnonymous()){
			names="Anonymous";
		} else {
			names=getNames(workgroup);
		};
		
		var newComment = createElement(doc, 'tr');
		var newTD = createElement(doc, 'td', {'class':'commentsTextTD', colSpan:'2'});
		var spanDiv = createElement(doc, 'span', {'class':'commentsTextTag'});
		var newCommentsTextDiv = createElement(doc, 'div');
		newCommentsTextDiv.innerHTML = comments[i].getBody();
		var newCommentsTextBody = newTD.appendChild(newCommentsTextDiv);		
		var newCommentsTextTag =   '  (' + names + ', ' + comments[i].getTimestamp() + ')';
		
		commentTable.appendChild(newComment);
		newComment.appendChild(newTD);
		newTD.appendChild(newCommentsTextBody);
		spanDiv.appendChild(doc.createTextNode(newCommentsTextTag));	
		newTD.appendChild(spanDiv);
			
	};
	return commentElement;
};

function getNames(workgroup){
	var names = "";
	var members = workgroup.getMembers();
	for(u=0;u<members.length;u++){
		names = names + members[u].getFirstname() + " " + members[u].getLastname();
		if(u!=members.length-1){
			names = names + " & ";
		};
	};
	return names;
};

function toggle_visibility(id) {
   var e = document.getElementById(id);
   if(e.style.display == 'none')
      e.style.display = 'block';
   else
      e.style.display = 'none';
};

function toggle_visibility_by_name(name) {
   var commentsTableArray = document.getElementsByName(name);
   for (xx=0;xx<commentsTableArray.length;xx++) {
       var e = commentsTableArray[xx];
       if(e.style.display == 'none')
          e.style.display = 'table';
       else
          e.style.display = 'none';       
   }
};

function getChoice(identifier, choices){
	var retChoice;
	for(yj=0;yj<choices.length;yj++){
		if(choices[yj].matches(identifier)){
			retChoice = choices[yj].getContent();
		};
	};
	return retChoice;
};