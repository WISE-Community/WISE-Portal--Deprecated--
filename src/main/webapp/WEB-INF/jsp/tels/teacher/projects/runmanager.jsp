<%@ include file="../include.jsp" %>

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

<!-- $Id: overview.jsp 997 2007-09-05 16:52:39Z archana $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >

<html lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../.././javascript/tels/general.js"></script>

<title><spring:message code="teacher.pro.runmanager.1"/></title>
</head>

<body>

<%@ include file="../headerteacher.jsp"%>

<div id="navigationSubHeader2">Manage my Project Runs<span id="navigationSubHeader1">management</span></div>

 <a href="../run/myprojectruns.html"><spring:message code="teacher.pro.runmanager.2"/></a>
 <h2><spring:message code="teacher.pro.runmanager.3"/></h2>
<div id="overviewContent"> 
<br />

<table border="1">
  <thead>
    <tr>
      <th><spring:message code="run.name.heading" /></th>
      <th><spring:message code="run.information" /></th>      
      <th><spring:message code="run.options.heading" /></th>
    </tr>
  </thead>
  <c:forEach var="run" items="${current_run_list}">
  <tr>
    <td>${run.sdsOffering.name}</td>
    <td><table border="1">
          <tr>
            <th><spring:message code="run.period" /></th>
            <th><spring:message code="teacher.project-code" /></th>
            <th><spring:message code="run.students" /></th>
          </tr>
          <c:forEach var="period" items="${run.periods}">
            <tr>
              <td>${period.name}</td>
              <td>${run.runcode}-${period.name}</td>
              <td>
                <c:choose>
                  <c:when test="${fn:length(period.members) == 0}" >
                    <spring:message code="teacher.pro.runmanager.4"/>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="member" items="${period.members}">${member.userDetails.firstname} ${member.userDetails.lastname}</c:forEach>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
        </table></td>
    <td>
      <c:choose>
        <c:when test="${fn:length(workgroup_map[run]) == 0}" >
        <spring:message code="no.workgroups" />
        </c:when>
        <c:otherwise>
            <c:forEach var="workgroup" items="${workgroup_map[run]}">
              <a href="${http_transport.baseUrl}/offering/${run.sdsOffering.sdsObjectId}/jnlp/${workgroup.sdsWorkgroup.sdsObjectId}">${workgroup.sdsWorkgroup.name}</a><br />
            </c:forEach>
        </c:otherwise>
      </c:choose>
      <br/>
      <a href="#" onclick="javascript:popup('manage/endRun.html?runId=${run.id}')"><spring:message code="teacher.pro.runmanager.5"/></a>
    </td>
   </tr>
  </c:forEach>
</table>

</div>

<h3><spring:message code="teacher.pro.runmanager.6"/></h3>
<table>
<tr>
<td><a href="changeperiods.html"><spring:message code="teacher.pro.runmanager.7"/></a></td>
<td><spring:message code="teacher.pro.runmanager.8"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.9"/></a></td>
<td><spring:message code="teacher.pro.runmanager.10"/> <a href="overview.html">Overview</a>, <a href="#">Teacher Guide</a>, <a href="#">Learning Goals</a>, <a href="#">Credits.</a></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.11"/></a></td>
<td><spring:message code="teacher.pro.runmanager.12"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.13"/></a></td>
<td><spring:message code="teacher.pro.runmanager.14"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.15"/></a></td>
<td><spring:message code="teacher.pro.runmanager.16"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.17"/></a></td>
<td><spring:message code="teacher.pro.runmanager.18"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.19"/></a></td>
<td><spring:message code="teacher.pro.runmanager.20"/></td>
</tr>
<tr>
<td><a href="#"><spring:message code="teacher.pro.runmanager.21"/></a></td>
<td><spring:message code="teacher.pro.runmanager.22"/></td>
</tr>

</table>


</body>
</html>

