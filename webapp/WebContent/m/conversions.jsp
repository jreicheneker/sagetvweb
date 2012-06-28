<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageairing" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageconv" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageconvfn" tagdir="/WEB-INF/tags/sage/functions/transcode" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Video Conversions</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Video Conversions" />
   </jsp:include>

   <sageconvfn:CleanupTranscodeJobs/>

   <sageconv:GetTranscodeJobs var="conversions"/>

   <sageutil:Size var="numConversions" data="${conversions}" />

   <c:if test="${numConversions == 0}">
      <div class="content">
         <div class="simplemessage">
            There are no video conversions in progress.
         </div>
      </div>
   </c:if>
   <c:if test="${numConversions != 0}">
      <sagedb:FilterByMethod var="jobsDone" data="${conversions}" method="GetTranscodeJobStatus" matchValue="COMPLETED" matchedPasses="true" />
      <sagedb:Sort var="jobsDone" data="${jobsDone}" descending="Boolean.FALSE" sortTechnique="Natural"/>

      <sagedb:FilterByMethod var="jobsWorking" data="${conversions}" method="GetTranscodeJobStatus" matchValue="TRANSCODING" matchedPasses="true" />
      <sagedb:Sort var="jobsWorking" data="${jobsWorking}" descending="Boolean.FALSE" sortTechnique="Natural"/>

      <sagedb:FilterByMethod var="jobsWaiting" data="${conversions}" method="GetTranscodeJobStatus" matchValue="WAITING TO START" matchedPasses="true" />
      <sagedb:Sort var="jobsWaiting" data="${jobsWaiting}" descending="Boolean.FALSE" sortTechnique="Natural"/>

      <sagedb:FilterByMethod var="jobsFailed" data="${conversions}" method="GetTranscodeJobStatus" matchValue="FAILED" matchedPasses="true" />
      <sagedb:Sort var="jobsFailed" data="${jobsFailed}" descending="Boolean.FALSE" sortTechnique="Natural"/>

      <sagedb:DataUnion var="allJobs" dataSet1="${jobsWorking}" dataSet2="${jobsWaiting}" />
      <sagedb:DataUnion var="allJobs" dataSet1="${allJobs}" dataSet2="${jobsFailed}" />
      <sagedb:DataUnion var="allJobs" dataSet1="${allJobs}" dataSet2="${jobsDone}" />

      <div class="content">
         <form method="post" action="${cp}/m/Command">
            <input type="hidden" name="returnto" value="${cp}/m/conversions.jsp"/>

            <c:forEach items="${allJobs}" var="job" varStatus="status">
               <sageconv:GetTranscodeJobShouldKeepOriginal var="keepOriginal" jobID="${job}"/> 
               <sageconv:GetTranscodeJobSourceFile var="sourceFile" jobID="${job}" /><%-- Media file --%>
               <sageconv:GetTranscodeJobDestFile var="destFile" jobID="${job}"/><%-- File path --%>
               <sagemf:IsMediaFileObject var="isMediaFileObject" object="${sourceFile}" />
               <c:if test="${!isMediaFileObject}">
                  <sagemf:GetMediaFileAiring var="sourceFile" mediaFile="${sourceFile}" />
               </c:if>
               <c:if test="${!empty sourceFile}">
                  <sagemf:GetMediaFileID var="sourceMediaFileId" mediaFile="${sourceFile}"/>
                  <c:if test="${keepOriginal}">
                     <c:if test="${!empty destFile}">
                        <sagemf:GetMediaFileForFilePath var="destMediaFile" filePath="${destFile}"/>
                        <c:if test="${!empty destMediaFile}">
                           <sagemf:GetMediaFileID var="destMediaFileId" mediaFile="${destMediaFile}"/>
                        </c:if>
                     </c:if>
                  </c:if>
                  <c:url var="conversionDetailUrl" value="conversiondetails.jsp">
                     <c:param name="JobId" value="${job}"></c:param>
                  </c:url>
                  <div class="listcell">
                     <sageconvfn:GetTranscodeJobTitle var="jobTitle" job="${job}"/>
                     <sageshow:GetShowEpisode var="episode" show="${sourceFile}" />
                     <div class="title"><input type="checkbox" value="${job}" name="JobId"/><b>${status.count}. <a href="${conversionDetailUrl}">${jobTitle}</a></b></div>
                     <c:if test="${!empty episode}">
                        <p>Episode: ${episode}</p>
                     </c:if>
                     <sageconv:GetTranscodeJobClipStart var="startTime" jobID="${job}"/>
                     <sageconv:GetTranscodeJobClipDuration var="duration" jobID="${job}"/>
                     <sageconv:GetTranscodeJobFormat var="quality" jobID="${job}"/>
                     <p>Conversion Length:
                     <c:choose>
                        <c:when test="${!empty startTime and !empty duration}">
                           <c:if test="${duration > 0}">
                              <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                              <sageutil:DurFormat var="endText" duration="${duration + startTime}" format="%h:%rm:%rs"/>
                              From ${startText} to ${endText}<%-- @ ${quality}--%>
                           </c:if>
                           <c:if test="${duration == 0}">
                              <c:if test="${startTime > 0}">
                                 <c:set var="startTime" value="${startTime}"/>
                                 <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                                 From ${startText} to End of Video<%-- @ ${quality}--%>
                              </c:if>
                              <c:if test="${startTime == 0}">
                                 Entire Video<%-- @ ${quality}--%>
                              </c:if>
                           </c:if>
                        </c:when>
                        <c:otherwise>
                           Entire Video<%-- @ ${quality}--%>
                        </c:otherwise>
                     </c:choose>
                     </p>
                     <p>Quality: ${quality}</p>
                     <sageconv:GetTranscodeJobStatus var="jobStatus" jobID="${job}"/>
                     <c:url var="originalDetailUrl" value="details.jsp">
                        <c:param name="MediaFileId" value="${sourceMediaFileId}"></c:param>
                     </c:url>
                     <c:if test="${keepOriginal}">
                        <c:url var="convertedDetailUrl" value="details.jsp">
                           <c:param name="MediaFileId" value="${destMediaFileId}"></c:param>
                        </c:url>
                     </c:if>
                     <c:if test="${jobStatus == 'COMPLETED'}">
                        <c:if test="${!keepOriginal}">
                           <c:choose>
                              <c:when test="${empty sourceFile}">
                                 <p>File Removed</p>
                              </c:when>
                              <c:otherwise>
                                 <p><a href="${originalDetailUrl}">[File Details]</a></p>
                              </c:otherwise>
                           </c:choose>
                           <p>Original Replaced</p>
                        </c:if>
                        <c:if test="${keepOriginal}">
                           <c:choose>
                              <c:when test="${empty sourceFile}">
                                 <p>Original File Removed</p>
                              </c:when>
                              <c:otherwise>
                                 <p><a href="${originalDetailUrl}">[Original File Details]</a></p>
                              </c:otherwise>
                           </c:choose>
                           <c:choose>
                              <c:when test="${empty destFile or empty destMediaFile}">
                                 <p>Converted File Removed</p>
                              </c:when>
                              <c:otherwise>
                                 <p><a href="${convertedDetailUrl}">[Converted File Details]</a></p>
                              </c:otherwise>
                           </c:choose>
                        </c:if>
                     </c:if>
                     <c:if test="${jobStatus == 'TRANSCODING' or jobStatus == 'WAITING TO START'}">
                        <c:if test="${!keepOriginal}">
                           <p><a href="${originalDetailUrl}">[Original File Details]</a></p>
                           <p>Replacing Original</p>
                        </c:if>
                        <c:if test="${keepOriginal}">
                           <p><a href="${originalDetailUrl}">[Original File Details]</a></p>
                           <p>Creating New File</p>
                        </c:if>
                     </c:if>
                     <sageconvfn:FormatJobStatus var="jobStatus" job="${job}"/>
                     <p>${jobStatus}</p>
                  </div>
               </c:if>
            </c:forEach>
            <div class="optionstitle">Options</div>
            <div class="optionsbody">
               <table>
                  <tr>
                     <td>
                        <button type="submit" value="CancelConversion" name="command">Clear Selected Conversions</button>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <button type="submit" value="ClearCompletedConversions" name="command">Clear All Completed Conversions</button>
                     </td>
                  </tr>
               </table>
            </div>
         </form>
      </div>
   </c:if>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
