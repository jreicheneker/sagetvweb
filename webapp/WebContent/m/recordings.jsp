<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageseries" tagdir="/WEB-INF/tags/sage/api/seriesinfo" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sagegrpfn" tagdir="/WEB-INF/tags/sage/functions/grouping" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <c:set var="pageTitle" value="Recordings"/>
   <c:if test="${!empty param.title}">
      <c:set var="pageTitle" value="${pageTitle} of &quot;${param.title}&quot;"/>
   </c:if>
   <title>${pageTitle}</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>
   
   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="${pageTitle}" />
   </jsp:include>

   <sageglbl:GetCurrentlyRecordingMediaFiles var="currentRecordings" />
   <sagemf:GetMediaFiles var="recordings"/>
   <sagedb:FilterByBoolMethod var="recordings" data="${recordings}" method="IsTVFile" matchValue="true"/>
   <sagedb:FilterByBoolMethod var="recordings" data="${recordings}" method="IsCompleteRecording|IsManualRecord" matchValue="true"/>
   <sagedb:Sort var="recordings" data="${recordings}" descending="true" sortTechnique="GetAiringStartTime"/> 

   <sagedb:DataUnion var="recordings" dataSet1="${currentRecordings}" dataSet2="${recordings}"/>

   <%-- Subheader with series image --%>
   <c:if test="${!empty param.title}">
      <sagedb:FilterByMethod var="recordings" data="${recordings}" method="GetAiringTitle" matchValue="${param.title}" matchedPasses="true" />
      <c:if test="${!empty recordings}">
         <sageutil:GetElement index="0" var="firstRecording" data="${recordings}"/>
         <sageshow:GetShowSeriesInfo var="seriesInfo" show="${firstRecording}"/>
         <sageseries:HasSeriesImage var="hasSeriesImage" seriesInfo="${seriesInfo}"/>
         <c:if test="${hasSeriesImage}">
            <c:url var="seriesImageUrl" value="${cp}/MediaFileThumbnail">
               <c:param name="series" value="${param.title}"></c:param>
            </c:url>
            <div class="subheader">
               <img class="imgthumb" src="${seriesImageUrl}" width="150px"/>
            </div>
         </c:if>
      </c:if>
   </c:if>

   <c:if test="${empty recordings}">
      <div class="content">
         <div class="simplemessage">
            <c:if test="${empty param.Title}">
               There are no recordings.
            </c:if>
            <c:if test="${!empty param.Title}">
               There are no recordings of "${param.Title}".
            </c:if>
         </div>
      </div>
   </c:if>

   <c:if test="${!empty recordings}">
   <div class="content">
   <form method="post" action="${cp}/m/Command">
      <input type="hidden" name="returnto" value="${cp}/m/recordings.jsp?${pageContext.request.queryString}"/>
      <c:if test="${empty param.title}">
         <sagedb:GroupByMethod var="groupedRecordings" data="${recordings}" method="GetAiringTitle"/>
         <sagegrpfn:GetKeySet var="keyset" groups="${groupedRecordings}"/>
         <c:forEach items="${keyset}" var="current" varStatus="status">
            <sagegrpfn:GetGroup var="group" groups="${groupedRecordings}" groupKey="${current}"/>
            <sageutil:Size var="groupSize" data="${group}"/>
            <div class="listcell">
               <c:url var="recordingGroupUrl" value="recordings.jsp">
                  <c:param name="title" value="${current}"></c:param>  
               </c:url>
               <c:set var="mediaFileIdValue" value="" />
               <c:forEach items="${group}" var="groupItem">
                  <sagemf:GetMediaFileID var="groupItemId" mediaFile="${groupItem}"/>
                  <c:if test="${!empty mediaFileIdValue}">
                     <c:set var="mediaFileIdValue" value="${mediaFileIdValue}," />
                  </c:if>
                  <c:set var="mediaFileIdValue" value="${mediaFileIdValue}${groupItemId}" />
               </c:forEach>
               <div class="title">
                  <input type="checkbox" name="MediaFileId" value="${mediaFileIdValue}"/>${status.count}. <a href="${recordingGroupUrl}">${current} (${groupSize})</a>
               </div>
            </div>
         </c:forEach>
      </c:if>
      <c:if test="${!empty param.title}">
         <c:set var="airings" value="${recordings}"/>
         <%--@ include file="/WEB-INF/jspf/m/airinglist.jspf" --%>
         <c:set var="airingList" scope="request" value="${airings}"/>
         <c:set var="allowMultiSelect" scope="request" value="true"/>
         <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>
      </c:if>
      <div class="optionstitle">Selection Options</div>
      <div class="optionsbody">

         <table>
            <tr>
               <td>
                  <button type="submit" name="command" value="SetWatched">Set Watched</button> 
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="ClearWatched">Clear Watched</button> 
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="SetDontLike">Set Don't Like</button> 
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="ClearDontLike">Clear Don't Like</button> 
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="Archive">Set Archived</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="Unarchive">Clear Archived</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="SetManRecStatus">Set Manual Record Status</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="RemoveManRecStatus">Clear Manual Record Status</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="DeleteFile">Delete File</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="RecordingError">Delete File - Wrong Recording</button>
               </td>
            </tr>
            <tr>
               <td>
                  <button type="submit" name="command" value="Convert">Convert Media File</button>
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
