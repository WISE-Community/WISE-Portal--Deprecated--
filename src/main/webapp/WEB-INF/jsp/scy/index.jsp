<%@ include file="include.jsp" %>

<!-- $Id: index.jsp 2450 2009-09-02 00:30:39Z supersciencefish $ -->
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

<!-- $Id: index.jsp 2450 2009-09-02 00:30:39Z supersciencefish $ -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>

    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.1/build/reset-fonts-grids/reset-fonts-grids.css"/>
    <link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css"/>

    <link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico">
    <title><spring:message code="application.title"/></title>
</head>

<body>

<div id="doc3" class="yui-t7" style="">
    <div style="height:1em"></div>
    <div id="hd" class="border top header">
        <div class="logo">
            <div class="title">
                SCY - Science Created by YOU
            </div>
        </div>
        <div class="menubar">
        <div class="topmenu" style="margin: 4px 1em 2px  1em;">
                <sec:authorize ifAllGranted="ROLE_USER">
                    <div id="usernameBannerHome"><sec:authentication property="principal.username"/></div>
                    <div id="signOutBannerHome"><a id="styleOverRideSafari1" href="<c:url value="/j_spring_security_logout"/>">
                        <spring:message code="log.out"/></a></div>
                    <sec:authorize ifAllGranted="ROLE_STUDENT">
                        <div id="signOutBannerHome"><a href="student/index.html">
                            <spring:message code="header.student"/></a>
                        </div>
                    </sec:authorize>
                    <sec:authorize ifAllGranted="ROLE_TEACHER">
                        <span id="signOutBannerHome">
                            <a href="teacher/index.html"><spring:message code="header.teacher"/></a>
                        </span>
                    </sec:authorize>
                    <sec:authorize ifAllGranted="ROLE_ADMINISTRATOR">
                        <span id="signOutBannerHome">
                            <a href="admin/index.html"><spring:message code="header.admin"/></a>
                        </span>
                    </sec:authorize>
                </sec:authorize>
            </div>
        </div>
    </div>
    <div id="bd" class="border bottom">
        <div id="yui-main">
            <div class="yui-b body" style="margin:0;padding: 1em;">
                <form id="home" method="post" action="j_acegi_security_check">
                    <dl id="signinDefinList">
                        <dt><label for="j_username"><spring:message code="username"/></label></dt>
                        <dd><input class="dataBoxStyle" type="text" name="j_username" id="j_username" size="18"
                                   maxlength="60"/></dd>

                        <!--This unusually placed script gets the cursor into the First Name field immediately on page load.
                                                            It must appear immediately after the Input field in question  (MattFish)-->
                        <script type="text/javascript">
                            document.getElementById('j_username').focus();
                        </script>

                        <dt><label for="j_password"><spring:message code="password"/></label></dt>
                        <dd><input class="dataBoxStyle" type="password" name="j_password" id="j_password" size="18"
                                   maxlength="30"/></dd>
                    </dl>

                    <div class="alignRight"><input type="image" id="signInButton" img
                                                   src="./themes/tels/default/images/SignIn.png"
                                                   width="100" height="27" alt="Sign In Button"
                                                   onmouseover="MM_swapImage('signInButton','','./themes/tels/default/images/SignInRoll.png',1)"
                                                   onmouseout="MM_swapImgRestore()"
                                                   onclick="Effect.toggle('waiting', 'appear')"/></div>
                </form>

                <ul id="signInLinkPosition">
                    <!--li><a href="forgotaccount/selectaccounttype.html" id="forgotlink"><spring:message
                            code="findalostusername"/></a>
                    </li-->
                    <li><a href="signup.html" id="joinlink">Create new SCY account</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="yui-b">
    <!--div id="taskbar"></div-->
</div>
</div>
<div id="ft">
</div>
</div>
</body>

</html>

