<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <sageair:GetAiringForID var="airing" airingID="${param.AiringId}"/>
   <sageair:GetAiringTitle var="airingTitle" airing="${airing}"/>
   <c:if test="${empty airing}">
      <title>Manual Recording Conflicts</title>
   </c:if>
   <c:if test="${!empty airing}">
      <title>"${airingTitle}" Manual Recording Conflicts</title>
   </c:if>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Manual Recording Conflicts" />
   </jsp:include>

<%-- TODO padding conflicts --%>

   <div class="content">
       <c:if test="${empty airing}">
         <div class="section">
            Unknown Airing
         </div>
         <div class="sectionbody">
            The specified airing does not exist.
         </div>
      </c:if>
      <c:if test="${!empty airing}">
         <sageglbl:GetScheduledRecordings var="scheduledRecordings"/>
         <sageutilfn:GetManualRecordingConflicts var="conflicts" airing="${airing}" startpadding="${param.StartPadding}" endpadding="${param.EndPadding}"/>

         <c:if test="${empty conflicts}">
            <div class="section">
               No Conflict
            </div>
            <div class="sectionbody">
               <sagedb:DataIntersection var="scheduledRecording" dataSet1="${scheduledRecordings}" dataSet2="${airing}"/>
               The following airing is no longer in conflict<c:if test="${!empty scheduledRecording}"> and will be recorded</c:if>.
               <hr/>
               <%--sageair:GetAiringForID var="airing" id="${airingId}"/--%>
               <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %> 
            </div>
         </c:if>

         <c:if test="${!empty conflicts}">
            <div class="section">
               Requested Recording
            </div>
            <div class="sectionbody">
                <p>The following airing will not be recorded due to conflicts with other manual recordings.</p> 
                <p>You must cancel one of the conflicting recordings and schedule this manual recording again.</p>
                <hr/>
                <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %> 
            </div>

            <sageutil:Size var="conflictingShowsSize" data="${conflicts}"/>
            <div class="section">
               ${conflictingShowsSize} Conflicting Recording<c:if test="${conflictingShowsSize != 1}">s</c:if>
            </div>
            <div class="sectionbody">
               <c:set var="airingList" scope="request" value="${conflicts}"/>
               <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>
            </div>
         </c:if>

      </c:if>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
