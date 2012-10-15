<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>WISE Project Authoring Tool</title>
<script type='text/javascript'>
var portalAuthorUrl = "${portalAuthorUrl}";

function notifyFatal(type,args,obj){
	window.location = '/webapp/errors/outsideerror.html?msg=' + encodeURIComponent(args[0]);
};

function notifyCleaningComplete(type,args,obj){
	window.parent.processCleaningResults(args[0]);
};

function loaded(){
	window.frames['authorfrm'].eventManager.subscribe('fatalError', notifyFatal);
	window.frames['authorfrm'].eventManager.subscribe('notifyCleaningComplete', notifyCleaningComplete);
	window.frames['authorfrm'].eventManager.fire('portalMode', ["${portalAuthorUrl}", "${command}", "${relativeProjectUrl}", "${projectId}", "${projectTitle}", "${editPremadeComments}"]);
};
</script>

</head>

<body style="margin:0;padding:0;" >
<iframe id="authorfrm" src="${vleAuthorUrl}" name="authorfrm" scrolling="auto" width="100%" height="100%" frameborder="0">
 [Iframes not enabled]
</iframe>
</body>
</html>