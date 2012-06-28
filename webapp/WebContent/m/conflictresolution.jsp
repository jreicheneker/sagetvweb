<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagech" tagdir="/WEB-INF/tags/sage/api/channel" %> 
<%@ taglib prefix="sagecfg" tagdir="/WEB-INF/tags/sage/api/configuration" %> 
<%@ taglib prefix="sagetc" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sagecapdev" tagdir="/WEB-INF/tags/sage/api/capturedevice" %> 
<%@ taglib prefix="sagecapdevinp" tagdir="/WEB-INF/tags/sage/api/capturedeviceinput" %> 
<%@ taglib prefix="sageairfn" tagdir="/WEB-INF/tags/sage/functions/airing" %> 
<%@ taglib prefix="sagemffn" tagdir="/WEB-INF/tags/sage/functions/mediafile" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 
<%@ taglib prefix="sagecapdevfn" tagdir="/WEB-INF/tags/sage/functions/capturedevice" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <c:choose>
      <%-- Get airing, airingId, mediaFile, mediaFileId --%>
      <%-- TODO if invalid media file id --%>
      <c:when test="${!empty param.MediaFileId}">
         <sagemf:GetMediaFileForID var="mediaFile" id="${param.MediaFileId}"/>
         <c:set var="mediaFileId" value="${param.MediaFileId}" />
         <c:set var="airing" value="${mediaFile}" />
         <sageair:GetAiringID var="airingId" airing="${airing}"/>
      </c:when>
      <c:when test="${!empty param.AiringId}">
         <sageair:GetAiringForID var="airing" airingID="${param.AiringId}"/>
         <c:set var="airingId" value="${param.AiringId}" />
         <sageair:GetMediaFileForAiring var="mediaFile" airing="${airing}"/>
         <c:if test="${!empty mediaFile}">
            <c:set var="airing" value="${mediaFile}" />
            <sagemf:GetMediaFileID var="mediaFileId" mediaFile="${mediaFile}"/>
         </c:if>
      </c:when>
   </c:choose>
   <sageair:GetAiringTitle var="airingTitle" airing="${airing}"/>
   <sageair:PrintAiringShort var="airingFmt" airing="${airing}"/>
   <c:if test="${empty airing}">
      <title>Conflict Resolution</title>
   </c:if>
   <c:if test="${!empty airing}">
      <title>"${airingTitle}" Conflict Resolution</title>
   </c:if>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Conflict Resolution" />
   </jsp:include>

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
         <sageglbl:GetAiringsThatWontBeRecorded var="unresolvedConflicts" onlyUnresolved="true"/>
         <sageglbl:GetAiringsThatWontBeRecorded var="allConflicts" onlyUnresolved="false"/>
         <sagedb:DataIntersection var="thisConflict" dataSet1="${allConflicts}" dataSet2="${airing}"/>
         <%-- Size(DataIntersection(AllConflicts,MissedAiring)) > 0 --%>
         <c:if test="${empty thisConflict}">
            <div class="section">
               No Conflict
            </div>
            <div class="sectionbody">
               <sagedb:DataIntersection var="scheduledRecording" dataSet1="${scheduledRecordings}" dataSet2="${airing}"/>
               <div>
               The following airing is no longer in conflict<c:if test="${!empty scheduledRecording}"> and will be recorded</c:if>.
               </div>
               <hr/>
               <%--sageair:GetAiringForID var="airing" id="${airingId}"/--%>
               <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %> 
            </div>
         </c:if>
         <c:if test="${!empty thisConflict}">
            <div class="section">
               Missed Recording
            </div>
            <div class="sectionbody">
               <div>
               The following airing will not be recorded due to conflicts with other recordings.
               </div>
               <hr/>
               <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %> 
            </div>

            <%-- conflict logic copied from 6.3.10 default STV --%>
            <%-- get all conflicting airings --%>
            <sagefav:GetFavoriteForAiring var="missedFavorite" airing="${airing}"/>
            <sagefav:GetFavoriteID var="missedFavoriteId" favorite="${missedFavorite}"/>
            <sagefav:GetFavoriteDescription var="missedFavoriteDescription" favorite="${missedFavorite}"/>
            <sagecapdev:GetConfiguredCaptureDeviceInputs var="configuredInputs"/>
            <sageair:GetChannel var="targetChannel" airing="${airing}"/>

            <%-- look for capture devices that could record this airing's channel --%>
            <c:forEach items="${configuredInputs}" var="configuredInput">
               <sagecapdevinp:GetLineupForCaptureDeviceInput var="lineup" captureDeviceInput="${configuredInput}"/>
               <sagech:IsChannelViewableOnLineup var="viewable" channel="${targetChannel}" lineup="${lineup}"/>
               <c:if test="${viewable}">
                  <%-- get all scheduled recordings on this capture device during the time of the missed airing --%>
                  <sagecapdevinp:GetCaptureDeviceForInput var="captureDevice" captureDeviceInput="${configuredInput}"/>
                  <sageair:GetScheduleStartTime var="startTime" airing="${airing}"/>
                  <sageair:GetScheduleEndTime  var="endTime" airing="${airing}"/>
                  <sageglbl:GetScheduledRecordingsForDeviceForTime var="overlaps" captureDevice="${captureDevice}" startTime="${startTime}" stopTime="${endTime}"/>
                  <c:forEach items="${overlaps}" var="conflictingRecord">
                     <sageair:IsManualRecord var="isManual" airing="${conflictingRecord}"/>
                     <%--sagedb:DataUnion var="allOverlappingConflicts" dataSet1="${allOverlappingConflicts}" dataSet2="${conflictingRecord}"/--%>
                     <c:if test="${isManual}">
                        <sagedb:DataUnion var="conflictingManuals" dataSet1="${conflictingManuals}" dataSet2="${conflictingRecord}"/>
                     </c:if>
                     <sageair:IsFavorite var="isFavorite" airing="${conflictingRecord}"/>
                     <c:if test="${isFavorite and !isManual}">
                        <sagedb:DataUnion var="conflictingSingleFavorites" dataSet1="${conflictingSingleFavorites}" dataSet2="${conflictingRecord}"/>
                        <sagefav:GetFavoriteForAiring var="otherFavorite" airing="${conflictingRecord}"/>
                        <c:if test="${otherFavorite != missedFavorite}">
                           <sagedb:DataUnion var="conflictingFavorites" dataSet1="${conflictingFavorites}" dataSet2="${otherFavorite}"/>
                        </c:if>
                     </c:if>
                  </c:forEach>
                  <%-- get all conflicting recordings within the timerange of the missed airing that could be recorded on this capture device--%>
                  <%--c:forEach items="${allConflicts}" var="conflictingRecord">
                     <c:if test="${conflictingRecord != airing}">
                        <sageair:GetChannel var="channel" airing="${conflictingRecord}"/>
                        <sagech:IsChannelViewableOnLineup var="viewable" channel="${channel}" lineup="${lineup}"/>
                        <c:if test="${viewable}">
                           <sageair:GetScheduleStartTime var="conflictingRecordStartTime" airing="${conflictingRecord}"/>
                           <sageair:GetScheduleEndTime var="conflictingRecordEndTime" airing="${conflictingRecord}"/>
                           <sageair:GetScheduleStartTime var="missedAiringStartTime" airing="${airing}"/>
                           <sageair:GetScheduleEndTime var="missedAiringEndTime" airing="${airing}"/>
                           <c:if test="${conflictingRecordStartTime <= missedAiringEndTime and conflictingRecordEndTime >= missedAiringStartTime}">
                              <sagedb:DataUnion var="allOverlappingConflicts" dataSet1="${allOverlappingConflicts}" dataSet2="${conflictingRecord}"/>
                              < % - - sagefav:GetFavoriteForAiring var="otherFavorite" airing="${conflictingRecord}"/>
                              <c:if test="${otherFavorite != missedFavorite}">
                                 <sagedb:DataUnion var="conflictingFavorites" dataSet1="${conflictingFavorites}" dataSet2="${otherFavorite}"/>
                              </c:if - - % >
                           </c:if>
                        </c:if>
                     </c:if>
                  </c:forEach--%>
               </c:if>
            </c:forEach>
            <sagedb:DataUnion var="conflictingShows" dataSet1="${conflictingSingleFavorites}" dataSet2="${conflictingManuals}"/>
            <%--sagedb:DataUnion var="conflictingShows" dataSet1="${conflictingShows}" dataSet2="${allOverlappingConflicts}"/--%>
            <sagedb:Sort var="conflictingShows" data="${conflictingShows}" descending="false" sortTechnique="GetChannelNumber"/>
            <sagedb:Sort var="conflictingShows" data="${conflictingShows}" descending="false" sortTechnique="GetScheduleStartTime"/>

            <sageutil:Size var="conflictingShowsSize" data="${conflictingShows}"/>
            <div class="section">
               ${conflictingShowsSize} Conflicting Recording<c:if test="${conflictingShowsSize != 1}">s</c:if>
            </div>
            <div class="sectionbody">
               <c:set var="airingList" scope="request" value="${conflictingShows}"/>
               <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>
            </div>

            <sageutil:Size var="conflictingSingleFavoritesSize" data="${conflictingSingleFavorites}"/>
            <sageutil:Size var="conflictingFavoritesSize" data="${conflictingFavorites}"/>
            <sageair:IsManualRecord var="isManualRecord" airing="${airing}"/>
            <sageutil:Size var="conflictingManualsSize" data="${conflictingManuals}"/>
            <sageair:IsFavorite var="isFavorite" airing="${airing}"/>
            <%--sageutil:Size var="allOverlappingConflictsSize" data="${allOverlappingConflicts}"/--%>

            <div class="section">Conflict Resolution Options</div>
            <div class="sectionbody">
            <div class="optionsbody">
               <%--form action="${cp}/m/Command" method="post"--%>
                  <%--input type="hidden" name="command" value="ResolveConflict"/--%>
                  <table>
                     <%--c:set var="else" value="true"/--%>
                     <%-- 1. ConflictList = DataUnion(If( (Size(ConflictingSingleFavorites) == 0 && Size(ConflictingFavorites) == 0) || (IsManualRecord(MissedAiring) || (Size(ConflictingManuals)>0 && IsFavorite(MissedAiring)) ),"xIGNORE",null))--%>
                     <%--c:if test="${(conflictingSingleFavoritesSize == 0 and conflictingFavoritesSize == 0) or (isManualRecord or conflictingManualsSize > 0 and isFavorite)}">
                        <c:set var="else" value="false"/>
                        < % - - sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="xIGNORE"/ - - % >
                        <tr><td>
                           <button style="text-align: left;"><s>TODO <b>IGNORE</b> this conflict (DON'T USE)</s></button>
                        </td></tr>
                     </c:if--%>
                     <%-- 2. ConflictList = DataUnion(ConflictList,If((Size(ConflictingFavorites) > 0) && (!IsManualRecord(MissedAiring)),"xIGNOREFAVE",null))--%>
                     <%--c:if test="${conflictingFavoritesSize > 0 and !isManualRecord}">
                        <c:set var="else" value="false"/>
                        < % - - sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="xIGNOREFAVE"/ - - % >
                        <tr><td>
                           <button style="text-align: left;"><s>TODO <b>ALWAYS IGNORE</b> conflicts between these favorites (DON'T USE)</s></button>
                        </td></tr>
                     </c:if--%>
                     <%-- 3. ConflictList = DataUnion(ConflictList,ConflictingManuals)--%>
                     <%--sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="${conflictingManuals}"/--%>
                     <c:forEach items="${conflictingManuals}" var="conflictingManual">
                        <sageair:PrintAiringShort var="conflictingManualFmt" airing="${conflictingManual}"/>
                        <tr><td>
                           <%--button style="text-align: left;"><s>TODO <b>CANCEL</b> Manual Recording of<br/>${conflictingManualFmt} "Cancel the Manual Recording of ..."</s></button--%>
                           <form action="${cp}/m/Command" method="post">
                              <sageair:GetAiringID var="conflictingManualId" airing="${conflictingManual}"/>
                              <input type="hidden" name="command" value="CancelRecord"/>
                              <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                              <input type="hidden" name="AiringId" value="${conflictingManualId}"/>
                              <button style="text-align: left;">Cancel the Manual Recording of<br/>${conflictingManualFmt}</button>
                           </form>
                        </td></tr>
                     </c:forEach>

                     <%-- 4. ConflictList = DataUnion(ConflictList,If(Size(ConflictingSingleFavorites)>0,"xOVERRIDEFAVE",null))--%>
                     <c:if test="${conflictingSingleFavoritesSize > 0}">
                        <%--c:set var="else" value="false"/--%>
                        <%--sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="xOVERRIDEFAVE"/--%>
                        <c:choose>
                           <%--c:when test="${conflictingSingleFavoritesSize == 1 and allOverlappingConflictsSize == 0}"--%>
                           <c:when test="${conflictingSingleFavoritesSize == 1}">
                              <%-- Only one conflicting fave, override and acknowledge --%>
                              <%--sageutil:GetElement var="conflictingSingleFavorite" data="${conflictingSingleFavorites}" index="0"/>
                              <sageair:PrintAiringShort var="conflictingSingleFavoriteFmt" airing="${conflictingSingleFavorite}"/>
                              <tr><td>
                                 <button style="text-align: left;"><s>TODO <b>OVERRIDE</b> Favorite recording of<br/>${conflictingSingleFavoriteFmt} "Record blah instead of blah this one time?"</s></button>
                              </td></tr--%>
                           </c:when>
                           <c:otherwise>
                              <%-- Many conflicting faves, list Force option --%>
                              <c:if test="${!isManualRecord}">
                                 <tr><td>
                                    <form action="${cp}/m/Command" method="post">
                                       <%--button style="text-align: left;"><s>TODO <b>FORCE</b> recording of this show<br/>(this will cause other conflicts) (NOT IF MANUAL) "Force to Record (Same as 'Record instead of'?"</s></button--%>
                                       <input type="hidden" name="command" value="Record"/>
                                       <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                                       <input type="hidden" name="AiringId" value="${airingId}"/>
                                       <button style="text-align: left;">Force "${airingTitle}" to Record</button>
                                    </form>
                                 </td></tr>
                              </c:if>
                           </c:otherwise>
                        </c:choose>
                     </c:if>
                     <%-- 4.5 conflicting single favorites - never used in default stv? --%>
                     <c:forEach items="${conflictingSingleFavorites}" var="conflictingSingleFavorite">
                        <sagefav:GetFavoriteForAiring var="conflictingSingleFavoriteObject" airing="${conflictingSingleFavorite}" />
                        <sagefav:GetFavoriteID var="conflictingSingleFavoriteId" favorite="${conflictingSingleFavoriteObject}"/>
                        <sageair:PrintAiringShort var="conflictingSingleFavoriteFmt" airing="${conflictingSingleFavorite}"/>
                        <sageair:GetAiringTitle var="conflictingSingleFavoriteTitle" airing="${conflictingSingleFavorite}"/>
                        <sageair:IsManualRecord var="isConflictingSingleFavoriteManual" airing="${conflictingSingleFavorite}"/>
                        <tr><td>
                           <c:if test="${!isConflictingSingleFavoriteManual}">
                              <form action="${cp}/m/Command" method="post">
                                 <input type="hidden" name="command" value="RecordAndConfirm"/>
                                 <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                                 <input type="hidden" name="AiringId" value="${airingId}"/>
                                 <input type="hidden" name="FavoriteId" value="${conflictingSingleFavoriteId}"/>
                                 <%--button style="text-align: left;"><s>TODO <b>CANCEL</b> Favorite Recording of<br/>${conflictingSingleFavoriteFmt} (NOT IF IT'S MANUAL)?"</s></button--%>
                                 <button style="text-align: left;">Record ${airingTitle} instead of<br/>${conflictingSingleFavoriteFmt}<%-- ${conflictingSingleFavoriteTitle} this one time--%></button>
                              </form>
                           </c:if>
                        </td></tr>
                     </c:forEach>
                     <%-- 5. ConflictList = DataUnion(ConflictList,If((Size(ConflictingFavorites)>0) && (!IsManualRecord(MissedAiring)),"xFAVEPRIO",null))--%>
                     <%--c:if test="${conflictingFavoritesSize > 0 and !isManualRecord}"--%>
                     <c:if test="${conflictingFavoritesSize > 0}"><%-- no manual record check in SageMC --%>
                        <%--c:set var="else" value="false"/--%>
                        <%--sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="xFAVEPRIO"/--%>
                        <%--c:if test="${conflictingFavoritesSize == 1}"--%><%-- not in sagemc --%>
                        <c:forEach items="${conflictingFavorites}" var="conflictingFavorite">
                           <%--sageutil:GetElement var="conflictingFavorite" data="${conflictingFavorites}" index="0"/--%>
                           <sagefav:GetFavoriteID var="conflictingFavoriteId" favorite="${conflictingFavorite}"/>
                           <sagefav:GetFavoriteDescription var="conflictingFavoriteDescription" favorite="${conflictingFavorite}"/>
                           <sageutil:GetElement var="conflictingSingleFavorite" data="${conflictingSingleFavorites}" index="0"/>
                           <sageair:IsManualRecord var="isConflictingSingleFavoriteManual" airing="${conflictingSingleFavorite}"/>
                           <tr><td>
                              <%--c:if test="${!isConflictingSingleFavoriteManual}"--%>
                                 <form action="${cp}/m/Command" method="post">
                                    <input type="hidden" name="command" value="CreateFavoritePriority"/>
                                    <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                                    <input type="hidden" name="AiringId" value="${airingId}"/>
                                    <input type="hidden" name="higherFavoriteId" value="${missedFavoriteId}"/>
                                    <input type="hidden" name="lowerFavoriteId" value="${conflictingFavoriteId}"/>
                                    <%--button style="text-align: left;"><s>TODO <b>ALWAYS OVERRIDE</b> and record this favorite instead of<br/>Favorite: ${conflictingFavoriteDescription} (NOT DISPLAYED) (AND ANOTHER OPTION FOR VICE VERSA)</s></button--%>
                                    <button style="text-align: left;">Always Record ${missedFavoriteDescription} instead of ${conflictingFavoriteDescription}</button>
                                 </form>
                              <%--/c:if--%>
                           </td></tr>
                           <tr><td>
                              <%--c:if test="${!isConflictingSingleFavoriteManual}"--%>
                                 <form action="${cp}/m/Command" method="post">
                                    <input type="hidden" name="command" value="CreateFavoritePriority"/>
                                    <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                                    <input type="hidden" name="AiringId" value="${airingId}"/>
                                    <input type="hidden" name="higherFavoriteId" value="${conflictingFavoriteId}"/>
                                    <input type="hidden" name="lowerFavoriteId" value="${missedFavoriteId}"/>
                                    <%--button style="text-align: left;"><s>TODO <b>ALWAYS OVERRIDE</b> and record this favorite instead of<br/>Favorite: ${conflictingFavoriteDescription} (NOT DISPLAYED) (AND ANOTHER OPTION FOR VICE VERSA)</s></button--%>
                                    <button style="text-align: left;">Always Record ${conflictingFavoriteDescription} instead of ${missedFavoriteDescription}</button>
                                 </form>
                              <%--/c:if--%>
                           </td></tr>
                        </c:forEach>
                        <%--/c:if--%>
                        <c:if test="${conflictingFavoritesSize != 1}">
                           <tr><td>
                              <form action="${cp}/m/favorites.jsp" method="get">
                                 <button style="text-align: left;">Adjust Favorite Priorities</button>
                              </form>
                           </td></tr>
                        </c:if>
                     </c:if>
                     <%-- 6. ConflictList = DataUnion(ConflictList,If(IsManualRecord(MissedAiring),"xCANCELMR",null))--%>
                     <c:if test="${isManualRecord}">
                        <%--c:set var="else" value="false"/--%>
                        <%--sagedb:DataUnion var="conflictList" dataSet1="${conflictList}" dataSet2="xCANCELMR"/--%>
                        <tr><td>
                           <form action="${cp}/m/Command" method="post">
                              <input type="hidden" name="command" value="CancelRecord"/>
                              <input type="hidden" name="returnto" value="${cp}/m/conflictresolution.jsp?${pageContext.request.queryString}"/>
                              <input type="hidden" name="AiringId" value="${airingId}"/>
                              <!-- TODO input type="hidden" name="returnto" value=""/-->
                              <button style="text-align: left;">Cancel the Manual Recording of<br/>${airingFmt}</button>
                           </form>
                        </td></tr>
                     </c:if>
                  </table>
               <%--/form--%>
            </div>
            </div>
         </c:if>
      </c:if>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
