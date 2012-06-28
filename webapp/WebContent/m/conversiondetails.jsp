<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageconv" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageconvfn" tagdir="/WEB-INF/tags/sage/functions/transcode" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <sageconvfn:GetTranscodeJobTitle var="jobTitle" job="${param.JobId}"/>
   <title>"${jobTitle}" Conversion Details</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Conversion Details" />
   </jsp:include>

<!-- TODO handle invalid job id -->
   <sageconv:GetTranscodeJobStatus var="jobStatus" jobID="${param.JobId}"/>

   <div class="content">
      <sageconv:GetTranscodeJobClipStart var="jobClipStart" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeJobClipDuration var="jobClipDuration" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeJobCompletePercent var="jobClipCompletePercent" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeJobSourceFile var="sourceFile" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeJobDestFile var="destFile" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeJobFormat var="format" jobID="${param.JobId}"/>
      <sageconv:GetTranscodeFormatDetails var="formatDetails" formatName="${format}"/>
      <sageconv:GetTranscodeJobShouldKeepOriginal var="keepOriginal" jobID="${param.JobId}"/>
      <sageutilfn:BoolToYesNo var="replaceOriginal" value="${!keepOriginal}"/>
      <sagemf:GetMediaFileAiring var="airing" mediaFile="${sourceFile}"/>
      <sagemf:GetMediaFileID var="mediaFileId" mediaFile="${sourceFile}"/>
      <sageshow:GetShowEpisode var="episode" show="${airing}"/>
      <sageshow:GetShowDescription var="description" show="${airing}"/>
      <sagemf:GetSegmentFiles var="sourceFiles" mediaFile="${sourceFile}"/>

      <div class="title">${jobTitle}</div>

      <div class="details">
         <c:if test="${!empty episode}"><p><b>Episode:</b> ${episode}</p></c:if>
         <c:if test="${!empty description}"><p><b>Description:</b> ${description}</p></c:if>
         <p><b>Format:</b> ${format}</p>
         <p><b>Format Details:</b> ${formatDetails}</p>
         <p><b>Replace Original Recording:</b> ${replaceOriginal}</p>

         <sagemf:GetMediaFileID var="sourceMediaFileId" mediaFile="${sourceFile}"/>
         <c:if test="${keepOriginal}">
            <c:if test="${!empty destFile}">
               <sagemf:GetMediaFileForFilePath var="destMediaFile" filePath="${destFile}"/>
               <c:if test="${!empty destMediaFile}">
                  <sagemf:GetMediaFileID var="destMediaFileId" mediaFile="${destMediaFile}"/>
               </c:if>
            </c:if>
         </c:if>
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
                     <p><b>File:</b> Removed</p>
                  </c:when>
                  <c:otherwise>
                     <p><b>File: </b><a href="${originalDetailUrl}">[Details]</a></p>
                  </c:otherwise>
               </c:choose>
            </c:if>
            <c:if test="${keepOriginal}">
               <c:choose>
                  <c:when test="${empty sourceFile}">
                     <p><b>Original File: </b>Removed</p>
                  </c:when>
                  <c:otherwise>
                     <p><b>Original File: </b><a href="${originalDetailUrl}">[Details]</a></p>
                  </c:otherwise>
               </c:choose>
               <c:choose>
                  <c:when test="${empty destFile or empty destMediaFile}">
                     <p><b>Converted File:</b> Removed</p>
                  </c:when>
                  <c:otherwise>
                     <p><b>Converted File: </b><a href="${convertedDetailUrl}">[Details]</a></p>
                  </c:otherwise>
               </c:choose>
            </c:if>
         </c:if>
         <c:if test="${jobStatus == 'TRANSCODING' or jobStatus == 'WAITING TO START'}">
            <c:if test="${!keepOriginal}">
               <p><b>Original File: </b><a href="${originalDetailUrl}">[Details]</a></p>
               <p>Replacing Original</p>
            </c:if>
            <c:if test="${keepOriginal}">
               <p><b>Original File: </b><a href="${originalDetailUrl}">[Details]</a></p>
               <p>Creating New File</p>
            </c:if>
         </c:if>

         <sageconvfn:FormatJobStart var="jobStartFmt" job="${param.JobId}"/>
         <p><b>Start:</b> ${jobStartFmt}</p>
         <sageconvfn:FormatJobDuration var="jobDurationFmt" job="${param.JobId}"/>
         <p><b>Duration:</b> ${jobDurationFmt}</p>
         <sageconvfn:FormatJobStatus var="jobStatusFmt" job="${param.JobId}"/>
         <p><b>Status:</b> ${jobStatusFmt}</p>
         <p><b>Internal details:</b> TranscodeJobID=${param.JobId}</p>
      </div> <%-- details --%>

      <div class="optionstitle">Options</div>
      <div class="optionsbody">
         <table>
            <tr>
               <td>
                  <form method="post" action="${cp}/m/Command">
                     <input type="hidden" name="command" value="CancelConversion"/>
                     <input type="hidden" name="JobId" value="${param.JobId}"/>
                     <input type="hidden" name="returnto" value="${cp}/m/conversions.jsp"/>
                     <c:if test="${jobStatus == 'COMPLETED'}">
                     <button type="submit" value="Cancel Conversion">Clear This Completed Conversion</button> 
                     </c:if> 
                     <c:if test="${jobStatus != 'COMPLETED'}">
                     <button type="submit" value="Cancel Conversion">Cancel This Conversion</button>
                     </c:if> 
                  </form>
               </td>
            </tr>
         </table>
      </div>
   </div> <%-- content --%>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
