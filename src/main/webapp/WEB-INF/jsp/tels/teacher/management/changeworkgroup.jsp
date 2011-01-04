<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"
    type="text/css" />
    
<script type="text/javascript" src="./javascript/tels/rotator.js"></script>
    
<title><spring:message code="application.title" /></title>
</head>

<body>

<h2><spring:message code="changeworkgroup.menu" /></h2>

<h3><spring:message code="changeworkgroupto.message" /></h3>

<form:form method="post" action="changeworkgroup.html" commandName="changeWorkgroupParameters" id="changeWorkgroups" autocomplete='off'>
       <form:select path="workgroupToId" id="workgroupTo">       
          <c:forEach items="${workgroupsTo}" var="workgroupToChoice">
            <form:option value="${workgroupToChoice.id}">
               ${workgroupToChoice.sdsWorkgroup.name}
            </form:option>
          </c:forEach>
          <form:option value="-1">
             <spring:message code="teacher.manage.changeworkgroup.1"/>
          </form:option>
          <form:option value="-2">
              <spring:message code="teacher.manage.changeworkgroup.2"/>
          </form:option>   
        </form:select> 
      <input type="image" id="save" src="../<spring:theme code="register_save" />" 
    onmouseover="swapSaveImage('save',1)" 
    onmouseout="swapSaveImage('save',0)"
    /></form:form>
</body>
</html>