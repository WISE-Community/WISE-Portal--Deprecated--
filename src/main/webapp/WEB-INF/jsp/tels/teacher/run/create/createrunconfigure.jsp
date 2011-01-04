<%@ include file="include.jsp"%>
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

<!-- $Id: setupRun3.jsp 357 2007-05-03 00:49:48Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<script src="./javascript/tels/general.js" type="text/javascript" ></script>
<script src="./javascript/tels/effects.js" type="text/javascript" ></script>
<script src="./javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="./javascript/tels/scriptaculous.js" type="text/javascript" ></script>


<title><spring:message code="teacher.setup-project-run-step-three" /></title>

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

</head>

<!-- Support for Spring errors object -->
<spring:bind path="runParameters.postLevel">
  <c:forEach var="error" items="${status.errorMessages}">
    <c:choose>
      <c:when test="${fn:length(error) > 0}" >
        <script type="text/javascript">
          <!--
            alert("${error}");
          //-->
        </script>
      </c:when>
    </c:choose>
  </c:forEach>
</spring:bind>

<body>

<div id="centeredDiv">

<%@ include file="../../headerteacher.jsp"%> 

<div id="navigationSubHeader2">Project Run Setup<span id="navigationSubHeader1">projects</span></div> 

<h1 id="titleBarSetUpRun" class="blueText"><spring:message code="teacher.setup-project-classroom-run" /></h1>

<div id="setUpRunBox">

<form:form method="post" commandName="runParameters" autocomplete='off'>

<div id="stepNumber"><spring:message code="teacher.run.setup.28.1"/><span class="blueText">&nbsp;<spring:message code="teacher.run.setup.28.2"/></span></div>

<h5 style="margin:20px 0px 15px 0;"><spring:message code="teacher.run.setup.28.3"/>&nbsp;<em><spring:message code="teacher.run.setup.28.4"/></em>.</h5>


	<div>
		<b>How many students per computer during the project?</b><br/>
		<form:radiobutton path="maxWorkgroupSize" value='1'/>Always 1 student per computer.<br/>
		<form:radiobutton path="maxWorkgroupSize" value='3'/>1, 2, or 3 students per computer.</br>
	</div>
	<br/>
	<br/>
	<div>
		<b>Select the Post Level for this run.</b><br/>
		<c:choose>
			<c:when test="${minPostLevel==5}">
				<br/>
				The author of this project requires that this run log students' data at the highest level. If you would<br/>
				like to override this setting, please <a href="webapp/contactwisegeneral.html">contact WISE.</a><br/>
			</c:when>
			<c:otherwise>	
				<c:forEach var='postLevel' items='${implementedPostLevels}'>
					<c:if test="${postLevel >= minPostLevel}">
						<form:radiobutton path='postLevel' value='${postLevel}'/>${postLevelTextMap[postLevel]}<br/>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>     

<div class="center">
<input type="submit" name="_target2" value="<spring:message code="navigate.back"/>" />
<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel"/>" />
<input type="submit" name="_target4" value="<spring:message code="navigate.next"/>" />
</div>

</form:form>

<!--end of centered div-->
</div>
</body>
</html>