<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<!-- 
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<script type="text/javascript">
	function topiframeOnLoad() {
		var getGradingConfigUrl = "${getGradingConfigUrl}";
		window.frames["topifrm"].load(getGradingConfigUrl);
	}
</script>

</head>

<body style="margin:0; overflow-y:hidden;">
<div id="wait"></div> 

<!--  BEGIN: for LD-inspired Projects that don't have curnitmap 
TODO: re-enable &minified=${minified}-->
<c:if test="${fn:length(getGradeWorkUrl) > 0}">
		<div>
			<iframe id="topifrm" src="${getGradeWorkUrl}?loadScriptsIndividually&permission=${permission}" name="topifrm" scrolling="auto" width="100%"
				height="100%" frameborder="0">Sorry, you cannot view this web page because your browser doesn't support iframes.</iframe>
		</div>
</c:if>

<!--  END: for LD-inspired Projects that don't have curnitmap -->
</body>

</html>
