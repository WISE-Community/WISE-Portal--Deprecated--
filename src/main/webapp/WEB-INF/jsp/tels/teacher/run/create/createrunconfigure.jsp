<%@ include file="../../../include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<script src="/webapp/javascript/tels/effects.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/scriptaculous.js" type="text/javascript" ></script>


<title><spring:message code="teacher.setup-project-run-step-three" /></title>

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

<div id="pageWrapper">

	<%@ include file="../../../headermain.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">
					<spring:message code="teacher.setup-project-classroom-run" />
					<span class="pageTitle"><spring:message code="header.location.teacher.management"/></span>
				</div>
				<form:form method="post" commandName="runParameters" autocomplete='off'>
					<div class="panelContent">
						<div id="setUpRunBox">
							<div id="stepNumber" class="sectionHead"><spring:message code="teacher.run.setup.28.1"/>&nbsp;<spring:message code="teacher.run.setup.28.2"/></div>
							<div class="sectionContent">

								<h5><spring:message code="teacher.run.setup.28.3"/><spring:message code="teacher.run.setup.28.4"/>.</h5>


								<h5 style="margin:.5em;">
									How many students per computer during the project?<br/>
									<form:radiobutton path="maxWorkgroupSize" value='1'/>Always 1 student per computer.<br/>
									<form:radiobutton path="maxWorkgroupSize" value='${maxWorkgroupSize}'/>1~${maxWorkgroupSize} students per computer.
								</h5>
								<h5 style="margin:.5em;">
									Select the storage level for this run<br/>
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
								</h5>
							</div>
						</div>
						<div class="center">
							<input type="submit" name="_target2" value="<spring:message code="navigate.back"/>" />
							<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel"/>" />
							<input type="submit" name="_target4" value="<spring:message code="navigate.next"/>" />
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->

	<%@ include file="../../../footer.jsp"%>
</div>
</body>
</html>