<%@ include file="include.jsp"%>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" >
<html lang="en">
<head>

<title>Score Summary - ${projectTitle} (${curnitId})</title>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />  

<%@ include file="currentScoreStyles.jsp"%>
  
<script type="text/javascript">

  // drawPercentBar()
  // Written by Matthew Harvey (matt AT unlikelywords DOT com)
  // (http://www.unlikelywords.com/html-morsels/)
  // Mod by Yvonne
  // (http://www.cogknition.org/knitblogging/percentagebar/)
  // Distributed under the Creative Commons 
  // "Attribution-NonCommercial-ShareAlike 2.0" License
  // (http://creativecommons.org/licenses/by-nc-sa/2.0/)
  function drawPercentBar(percent) 
  { 

	var width = 180;

	var color = "#CD62AD";
	var background = "#FFFFFF";
	var border = "#4C0039";

    if (!color) { color = "#B0B0B0"; }
    if (!background) { background = "none"; }
    if (!border) { border = "#000000"; }
 
    var pixels = width * (percent / 100); 

    document.write("<div style=\"position: relative; line-height: 1em; background-color: " 
                   + background + "; border: 1px solid " + border + "; width: " 
                   + width + "px\">"); 
    document.write("<div style=\"height: 1.5em; width: " + pixels + "px; background-color: "
                   + color + ";\"><\/div>"); 
    document.write("<div style=\"position: absolute; text-align: center; padding-top: .25em; width: " 
                   + width + "px; top: 0; left: 0\">" + percent + "%<\/div>");
    document.write("<\/div>"); 
  } 

</script>

<html>

<head>

<title>Print Image Only</title>

<script>
function makepage(src, divElement)
{
  // We break the closing script tag in half to prevent
  // the HTML parser from seeing it as a part of
  // the *main* page.

  return "<html>\n" +
    "<head>\n" +
    "<title>Temporary Printing Window</title>\n" +
    "<script>\n" +
    "function step1() {\n" +
    "  setTimeout('step2()', 10);\n" +
    "}\n" +
    "function step2() {\n" +
    "  window.print();\n" +
    "  window.close();\n" +
    "}\n" +
    "</scr" + "ipt>\n" +
    "</head>\n" +
    "<body onLoad='step1()'>\n" +
    divElement.innerHTML +
    "</body>\n" +
    "</html>\n";
}

function printme(evt,divElement)
{
  if (!evt) {
    // Old IE
    evt = window.event;
  }    
  var image = evt.target;
  if (!image) {
    // Old IE
    image = window.event.srcElement;
  }
  src = image.src;
  link = "about:blank";
  var pw = window.open(link, "_new");
  pw.document.open();

  var varPrint = document.getElementById(divElement);
  
  pw.document.write(makepage(src, varPrint));
  pw.document.close();
}
</script>
<script type="text/javascript">
var tabView = new YAHOO.widget.TabView("scoreTabs");
tabView.set('activeIndex', 0);
</script> 

<link href="../../<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="../../<spring:theme code="teachergradingstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

</head>


<body class=" yui-skin-sam">

<div style="text-align:center;">   
<!--This bad boy ensures centering of block level elements in IE (avoiding margin:auto bug). -->

<div id="centeredDiv">

<%@ include file="../headerteacher.jsp"%>


<h4><spring:message code="teacher.currentscore.1"/></h4>

<%  %>
 
<div style="align:left;">
${projectTitle} (${curnitId})
<c:set var="totalPossibleScore" value="0"/>

<c:set var="numberOfPeriods" value="${fn:length(scoreMap)}"/>
<c:choose>
      <c:when test="${numberOfPeriods == '0' }">
			
			<br><br>
			<h3><spring:message code="teacher.currentscore.2"/></h3>
	  </c:when>

      <c:otherwise>
		<!--  do the tabs -->

<br><br>

<div id="scoreTabs" class="yui-navset">
    <ul class="yui-nav">
    	<c:forEach var="periodEntry" varStatus="periodStatus" items="${scoreMap}">
        	<li><a href="#${periodEntry.key}"><em>Period ${periodEntry.key}</em></a></li>
        </c:forEach>
        <li><a href="#allPeriods"><em><spring:message code="teacher.currentscore.3"/></em></a></li>
    </ul>            
    <div class="yui-content">
        <c:forEach var="periodEntry" varStatus="periodStatus" items="${scoreMap}">
			
        	<div>
				<span class="yui-button yui-push-button"><em class="first-child">
					<button type="submit" name="Print" onClick="printme(event,'print_section_${periodEntry.key}')"><spring:message code="teacher.currentscore.4"/></button></em>
				</span>
				<div id="print_section_${periodEntry.key}">
				<table border="1" >
				<tr>
					<th><spring:message code="teacher.currentscore.5"/></th>
					<th><spring:message code="teacher.currentscore.6"/></th>
					<th><spring:message code="teacher.currentscore.7"/></th>
					<th><spring:message code="teacher.currentscore.8"/></th>
					<th><spring:message code="teacher.currentscore.9"/></th>
					<th><spring:message code="teacher.currentscore.10"/></th>
					<th><spring:message code="teacher.currentscore.11"/></th>
				</tr>
					<c:set var="countGradedSteps" value="0"/>
					<c:set var="countAccScoreRaw" value="0"/>
					<c:set var="countAccScorePercent" value="0"/>
					<c:set var="countPercentageCompleted" value="0"/>
					<c:set var="numberOfItems" value="0"/>
					<c:set var="totalGradableSteps" value="0"/>
					
					<c:forEach var="scoreEntry" varStatus="scoreStatus" items="${periodEntry.value}">
					
						<!-- set up vars -->
						<c:set var="numberOfItems" value="${scoreStatus.count}"/>
						<c:set var="countGradedSteps" value="${countGradedSteps +  scoreEntry.totalGradedSteps}"/>
						<c:set var="countAccScoreRaw" value="${countAccScoreRaw + scoreEntry.totalAccumulatedScore}"/>
						<c:set var="countAccScorePercent" value="${countAccScorePercent + (scoreEntry.totalAccumulatedScore/scoreEntry.totalAccumulatedPossibleScore)*100}"/>
						<c:set var="countPercentageCompleted" value="${countPercentageCompleted + (scoreEntry.totalGradedSteps/scoreEntry.totalGradableSteps)*100}"/>
						<c:set var="totalGradableSteps" value="${scoreEntry.totalGradableSteps}"/>
						
						<c:set var="totalPossibleScore" value="${scoreEntry.totalPossibleScore}"/>
						
						<!-- table -->
						<tr>
						<td align="center">${scoreEntry.lastName}, ${scoreEntry.firstName}</td>
						<td align="center">${scoreEntry.username}</td>
						<td align="center">${scoreEntry.totalAccumulatedScore}/${scoreEntry.totalAccumulatedPossibleScore}</td>
						<td align="center"><fmt:formatNumber type="number" value="${(scoreEntry.totalAccumulatedScore/scoreEntry.totalAccumulatedPossibleScore)*100}" maxFractionDigits="0"/>%</td>
						<td align="center">${scoreEntry.totalGradedSteps}</td>
						<td align="center">${scoreEntry.totalGradableSteps}</td>
						<td ><script type="text/javascript">drawPercentBar(<fmt:formatNumber type="number" value="${(scoreEntry.totalGradedSteps/scoreEntry.totalGradableSteps)*100}" maxFractionDigits="0"/>); </script></td>
						</tr>
		
					</c:forEach>

					<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					</tr>

					<tr>
					<th></th>
					<th></th>
					<th></th>
					<th><spring:message code="teacher.currentscore.12"/></th>
					<th><spring:message code="teacher.currentscore.13"/></th>
					<th><spring:message code="teacher.currentscore.14"/></th>
					<th><spring:message code="teacher.currentscore.15"/></th>
					</tr>
					<tr>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"><em><spring:message code="teacher.currentscore.16"/></em></td>
						<td align="center"><fmt:formatNumber type="number" value="${countAccScorePercent/numberOfItems}" maxFractionDigits="0"/>%</td>
						<td align="center"><fmt:formatNumber type="number" value="${countGradedSteps/numberOfItems}" maxFractionDigits="0"/></td>
						<td align="center">${totalGradableSteps}</td>
						<td ><script type="text/javascript">drawPercentBar(<fmt:formatNumber type="number" value="${countPercentageCompleted/numberOfItems}" maxFractionDigits="0"/>); </script></td>
					</tr>
				</table>
				</div>
			</div>
        </c:forEach>
        <!-- all periods -->
        <div>
       		<span class="yui-button yui-push-button"><em class="first-child">
					<button type="submit" name="Print" onClick="printme(event,'print_section_${periodEntry.key}')">Print This Report</button></em>
			</span>
			<div id="print_section_${periodEntry.key}">
        	<table border="1" >
				<tr>
				
					<th><spring:message code="teacher.currentscore.17"/></th>
					<th><spring:message code="teacher.currentscore.18"/></th>
					<th><spring:message code="teacher.currentscore.19"/></th>
					<th><spring:message code="teacher.currentscore.20"/></th>
					<th><spring:message code="teacher.currentscore.21"/></th>
					</tr>

					<c:set var="allCountGradedSteps" value="0"/>
					<c:set var="allCountAccScorePercent" value="0"/>
					<c:set var="allCountPercentageCompleted" value="0"/>
					<c:set var="allNumberOfItems" value="0"/>
					<c:set var="allTotalGradableSteps" value="0"/>

			 <c:forEach var="periodEntry" varStatus="periodStatus" items="${scoreMap}">
			
				
				
					<c:set var="countGradedSteps" value="0"/>
					<c:set var="countAccScoreRaw" value="0"/>
					<c:set var="countAccScorePercent" value="0"/>
					<c:set var="countPercentageCompleted" value="0"/>
					<c:set var="numberOfItems" value="0"/>
					<c:set var="totalGradableSteps" value="0"/>
					<c:set var="allNumberOfItems" value="${periodStatus.count}"/>
					<c:forEach var="scoreEntry" varStatus="scoreStatus" items="${periodEntry.value}">
					
						<!-- set up vars -->
						<c:set var="numberOfItems" value="${scoreStatus.count}"/>
						<c:set var="countGradedSteps" value="${countGradedSteps +  scoreEntry.totalGradedSteps}"/>
						<c:set var="countAccScoreRaw" value="${countAccScoreRaw + scoreEntry.totalAccumulatedScore}"/>
						<c:set var="countAccScorePercent" value="${countAccScorePercent + (scoreEntry.totalAccumulatedScore/scoreEntry.totalAccumulatedPossibleScore)*100}"/>
						<c:set var="countPercentageCompleted" value="${countPercentageCompleted + (scoreEntry.totalGradedSteps/scoreEntry.totalGradableSteps)*100}"/>
						<c:set var="totalGradableSteps" value="${scoreEntry.totalGradableSteps}"/>
						
						
						
					</c:forEach>
					<c:set var="allCountGradedSteps" value="${allCountGradedSteps + (countGradedSteps/numberOfItems)}"/>
					<c:set var="allCountAccScorePercent" value="${allCountAccScorePercent + (countAccScorePercent/numberOfItems)}"/>
					<c:set var="allCountPercentageCompleted" value="${allCountPercentageCompleted + (countPercentageCompleted/numberOfItems)}"/>
				
					<tr>
						
						
						<td align="center">${periodEntry.key}</td>
						<td align="center"><fmt:formatNumber type="number" value="${countAccScorePercent/numberOfItems}" maxFractionDigits="0"/>%</td>
						<td align="center"><fmt:formatNumber type="number" value="${countGradedSteps/numberOfItems}" maxFractionDigits="0"/></td>
						<td align="center">${totalGradableSteps}</td>
						<td ><script type="text/javascript">drawPercentBar(<fmt:formatNumber type="number" value="${countPercentageCompleted/numberOfItems}" maxFractionDigits="0"/>); </script></td>
					</tr>
				
			
        </c:forEach>
					<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					</tr>

					<tr>
					<th><spring:message code="teacher.currentscore.22"/></th>
					<th><spring:message code="teacher.currentscore.18"/></th>
					<th><spring:message code="teacher.currentscore.19"/></th>
					<th><spring:message code="teacher.currentscore.20"/></th>
					<th><spring:message code="teacher.currentscore.21"/></th>
					</tr>
		<!-- all periods average -->
				<tr>
						<td align="center"></td>
						<td align="center"><fmt:formatNumber type="number" value="${allCountAccScorePercent/allNumberOfItems}" maxFractionDigits="0"/>%</td>
						<td align="center"><fmt:formatNumber type="number" value="${allCountGradedSteps/allNumberOfItems}" maxFractionDigits="0"/></td>
						<td align="center">${totalGradableSteps}</td>
						<td ><script type="text/javascript">drawPercentBar(<fmt:formatNumber type="number" value="${allCountPercentageCompleted/allNumberOfItems}" maxFractionDigits="0"/>); </script></td>
					</tr>
        </table>
        </div>
    </div>
</div>
      </c:otherwise>
 </c:choose>
</body>
</html>
