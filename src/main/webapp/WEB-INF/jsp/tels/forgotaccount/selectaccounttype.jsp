<%@ include file="../include.jsp"%>
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

<!-- $Id: login.jsp 341 2007-04-26 22:58:44Z hiroki $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script src="<spring:theme code="generalsource"/>" type="text/javascript"></script>

<title><spring:message code="forgotaccount.selectaccounttype.findYourPassword" /></title>
</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="<spring:message code="wiseHomepage" />"><spring:message code="wise" /></a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="forgotaccount.selectaccounttype.lostUsernameOrPassword"/></div>
				<div class="infoContentBox">
					<div id="lostSubHeader"><spring:message code="forgotaccount.selectaccounttype.whatSortofWISEAccount"/></div><br/>
					<div><a href="student/passwordreminder.html" class="wisebutton"><spring:message code="forgotaccount.selectaccounttype.studentAccount"/></a></div>
					<div><spring:message code="forgotaccount.selectaccounttype.or"/></div>
					<div><a href="teacher/index.html" class="wisebutton" style="margin-top:.25em;"><spring:message code="forgotaccount.selectaccounttype.teacherAccount"/></a></div>
				</div>
				<a href="/webapp/index.html" title="<spring:message code="wiseHome" />"><spring:message code="returnHome"/></a>
			</div>
		</div>
	</div>
</div>	
</body>
</html>
