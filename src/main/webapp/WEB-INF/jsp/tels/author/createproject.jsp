<%@ include file="../include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="./javascript/tels/rotator.js"></script>


<!--CSS for Controls:--> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/container/assets/skins/sam/container.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/menu/assets/skins/sam/menu.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/autocomplete/assets/skins/sam/autocomplete.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/button/assets/skins/sam/button.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/calendar/assets/skins/sam/calendar.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/colorpicker/assets/skins/sam/colorpicker.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/datatable/assets/skins/sam/datatable.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/editor/assets/skins/sam/editor.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/logger/assets/skins/sam/logger.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/tabview/assets/skins/sam/tabview.css"> 
<link rel="stylesheet" type="text/css" href="../../javascript/tels/yui/treeview/assets/skins/sam/treeview.css"> 
<link href="<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" /> 

<!--JavaScript source files for the entire YUI Library:--> 
 
<!--Utilities (also aggregated in yahoo-dom-event.js and utilities.js; see readmes in the 
YUI download for details on each of the aggregate files and their contents):--> 
<script type="text/javascript" src="../../javascript/tels/yui/yahoo/yahoo-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/dom/dom-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/event/event-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/element/element-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/animation/animation-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/connection/connection-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/datasource/datasource-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/dragdrop/dragdrop-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/history/history-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/imageloader/imageloader-experimental-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/yuiloader/yuiloader-beta-min.js"></script> 
 
<!--YUI's UI Controls:--> 
<script type="text/javascript" src="../../javascript/tels/yui/container/container-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/menu/menu-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/autocomplete/autocomplete-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/button/button-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/calendar/calendar-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/colorpicker/colorpicker-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/datatable/datatable-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/editor/editor-beta-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/logger/logger-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/slider/slider-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/tabview/tabview-min.js"></script> 
<script type="text/javascript" src="../../javascript/tels/yui/treeview/treeview-min.js"></script>

<script type="text/javascript" src="../../javascript/tels/yui/yahoo/yahoo.js"></script>
<script type="text/javascript" src="../../javascript/tels/yui/event/event.js"></script>  
<script type="text/javascript" src="../../javascript/tels/yui/connection/connection.js"></script> 
<script type="text/javascript" src="../../javascript/tels/utils.js"></script>

<title>Contact WISE General Issues</title>

</head>

<body class="yui-skin-sam">

<script type="text/javascript">

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
    
            YAHOO.example.container.wait.setHeader("Loading, please wait...");
            YAHOO.example.container.wait.setBody("<img src=\"http://us.i1.yimg.com/us.yimg.com/i/us/per/gr/gp/rel_interstitial_loading.gif\"/>");
            YAHOO.example.container.wait.render(document.body);

        }

        // Show the Panel
        YAHOO.example.container.wait.show();
        
    }
    
    YAHOO.util.Event.on("sendMessageButton", "click", init);
		
</script>


<div id="centeredDiv">


<div id="pageTitle"><h2>Create a Project</h2></div>
     
<div id="pageSubtitle">This page is for select (advanced) users of the portal only. Here, you'll be selecting a curriculum unit (Curnit/Module) and a Jnlp resource. Together, they make up a "Project" that can be set up to be run in a classroom.</div>
						
<div id="pageSubtitleLevel2">
	<ul>
		<li>#1: choose a Curnit/Module</li>
		<li>#2: choose a Jnlp</li>
		<li>#3: click on "Create Project"</li>
		<li>#4: go to the Project Library (in the teacher's portal). The project should now be listed there, and you can then set it up for a classroom run</li>
	</ul>
</div>

<!-- Support for Spring errors object -->
<div id="regErrorMessages">
<spring:bind path="projectParameters.*">
  <c:forEach var="error" items="${status.errorMessages}">
        <br /><c:out value="${error}"/>
    </c:forEach>
</spring:bind>
</div>

<form:form commandName="projectParameters" method="post" action="createproject.html" id="createprojectform" autocomplete='off'>  
  <dl>
    <dt><label for="projectname" id="projectnameLabel"><span class="asterix">* </span>Enter Project Name:</label> </dt>
	<dd>
	    <form:input path="projectname" id="projectname" size="30" maxlength="50"/>
	</dd>
  
    <dt><label for="curnitId" id="curnitIdLabel"><span class="asterix">* </span>Choose a Curnit/Module:</label> </dt>
	<dd><form:select path="curnitId" id="curnitId">
	      <c:forEach items="${curnits}" var="curnit">
            <form:option value="${curnit.id}">
            	${curnit.id}: ${curnit.name}
            </form:option>
          </c:forEach>
		</form:select>
	</dd>

	<dt><label for="jnlpId" id="jnlpIdLabel"><span class="asterix">* </span>Choose a JNLP to use with the Curnit/Module:</label> </dt>
	<dd><form:select path="jnlpId" id="jnlpId">
	      <c:forEach items="${jnlps}" var="jnlp">
            <form:option value="${jnlp.id}">
            	${jnlp.sdsJnlp.name}
            </form:option>
          </c:forEach>
		</form:select>
	</dd>

  </dl>
  
     <div id="asterixWarning">Items marked with <span style="font-size:1.1em; font-weight:bold;">*</span> are required.</div>  
        
    <div align="center"><input type="submit" id="sendMessageButton" value="Create Project" ></input></div>
                  
</form:form>

</div>   <!--End of the CenteredDiv -->

<h5><a href="../index.html">Return to WISE Home Page</a></h5>

</body>
</html>