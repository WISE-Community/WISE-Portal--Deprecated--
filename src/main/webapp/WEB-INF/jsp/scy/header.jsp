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
                <div id="bodyContainer" style="position:relative;height: 600px; width: 100%;">
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
                                <a href="../teacher/index.html"><spring:message code="header.teacher"/></a>
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
    </div>