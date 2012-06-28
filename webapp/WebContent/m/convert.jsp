<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sageconf" tagdir="/WEB-INF/tags/sage/api/configuration" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagetc" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Convert Media File</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Convert Media File" />
   </jsp:include>

   <c:forEach items="${paramValues.MediaFileId}" var="mediaFileId">
      <c:set var="mediaFileIdValues" value="${fn:split(mediaFileId, ',')}" />
      <c:forEach items="${mediaFileIdValues}" var="mediaFileIdValue">
         <sagemf:GetMediaFileForID var="mediaFile" id="${mediaFileIdValue}"/>
         <sagedb:DataUnion var="airings" dataSet1="${airings}" dataSet2="${mediaFile}"/>
      </c:forEach>
   </c:forEach>
   <sageutil:Size var="airingsSize" data="${airings}"/>

   <div class="content">
      <c:set var="airingList" scope="request" value="${airings}"/>
      <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>

      <sageconf:GetProperty var="lastReplaceChoice" propertyName="transcoder/last_replace_choice" defaultValue="xKeepBoth"/>
      <sageconf:GetProperty var="lastFormatName"    propertyName="transcoder/last_format_name" defaultValue=""/>
      <sageconf:GetProperty var="lastFormatQuality" propertyName="transcoder/last_format_quality/${lastFormatName}" defaultValue=""/>
      <sageconf:GetProperty var="lastDestDir"       propertyName="transcoder/last_dest_dir" defaultValue=""/>

      <%-- last replace choice --%>
      <c:choose>
         <c:when test="${lastReplaceChoice == 'xKeepOnlyConversion'}">
            <c:set var="isReplaceOriginal" value="true"/>
         </c:when>
         <c:otherwise>
            <c:set var="isReplaceOriginal" value="false"/>
         </c:otherwise>
      </c:choose>

      <div class="optionstitle">Conversion Options</div>
      <div class="optionsbody">
         <form action="${cp}/m/Command" method="post">
            <div class="label">Format</div>
            <div class="value">
               <sagetc:GetTranscodeFormats var="formats"/>
               <sagedb:Sort var="formats" sortTechnique="Natural" data="${formats}" descending="false"/>
               <select name="Format">
                  <c:forEach items="${formats}" var="formatName" varStatus="status">
                     <%-- optgroups don't work on Opera mini 4.1.11320 --%>
                     <%--sageutilfn:SplitString var="splitName" value="${formatName}" token="-" limit="2" />
                     <c:if test="${splitName[0] != formatGroup}">
                        <c:if test="${!empty formatGroup}">
                           </optgroup>
                        </c:if>
                        <optgroup label="${splitName[0]}">
                        <c:set var="formatGroup" value="${splitName[0]}"/>
                     </c:if>
                     <option value="${formatName}">${splitName[1]}</option--%>
                     <option value="${formatName}"<c:if test="${(status.index == 0 and empty lastFormatQuality) or formatName == lastFormatQuality}"> selected="selected"</c:if>>${formatName}</option>
                  </c:forEach>
                  <%--c:if test="${!empty formatGroup}">
                     </optgroup>
                  </c:if--%>
               </select>
            </div>
            <div class="label"><input type="radio" name="ReplaceOriginal" value="yes"<c:if test="${isReplaceOriginal}"> checked="checked"</c:if>/>Replace Original File</div>
            <div class="label"><input type="radio" name="ReplaceOriginal" value="no"<c:if test="${not isReplaceOriginal}"> checked="checked"</c:if>/>Keep Original File</div>
            <div class="value">
               <input type="radio" name="Folder" value="Original"<c:if test="${empty lastDestDir}"> checked="checked"</c:if>/>Use Original Folder<br/>
               <input type="radio" name="Folder" value="Destination"<c:if test="${not empty lastDestDir}"> checked="checked"</c:if>/>Set Destination Folder<br/>
               <div class="value"><input type="text" name="DestinationFolder"/>${lastDestDir}</div>
               Set Destination File<br/>
<%--
TODO default name
DestFilename = GetFileNameFromPath( GetFileForSegment(MediaFile,0) )
DestFilename = Substring(DestFilename, 0, StringLastIndexOf(DestFilename, ".") )
--%>
               <div class="value"><input type="text" name="DestinationFile"/>${destinationFilename}</div>
            </div>
            <c:if test="${airingsSize == 1}">
               <div class="label">Start (seconds)</div>
               <div class="value"><input type="text" name="StartTime"/></div>
               <div class="label">Duration (seconds)</div>
               <div class="value"><input type="text" name="Duration"/></div>
            </c:if>
            <c:forEach items="${paramValues.MediaFileId}" var="mediaFileId">
               <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
            </c:forEach>
            <input type="hidden" name="returnto" value="${cp}/m/conversions.jsp"/>
            <input type="hidden" name="command" value="Convert"/> 
            <button type="submit" value="Convert">Convert Recording</button>
         </form>
      </div>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
