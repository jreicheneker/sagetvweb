<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagecfg" tagdir="/WEB-INF/tags/sage/api/configuration" %> 
<%@ taglib prefix="sagetc" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageairfn" tagdir="/WEB-INF/tags/sage/functions/airing" %> 
<%@ taglib prefix="sageshowfn" tagdir="/WEB-INF/tags/sage/functions/show" %> 
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
         <%--c:set var="idArg" value="MediaFileId=${param.MediaFileId}"/--%>
         <sagemf:GetMediaFileForID var="mediaFile" id="${param.MediaFileId}"/>
         <c:set var="mediaFileId" value="${param.MediaFileId}" />
         <c:set var="airing" value="${mediaFile}" />
         <sageair:GetAiringID var="airingId" airing="${airing}"/>
      </c:when>
      <c:when test="${!empty param.AiringId}">
         <%--c:set var="idArg" value="AiringId=${param.AiringId}"/--%>
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
   <title>"${airingTitle}" Details</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
   
   <sageair:GetLatestWatchedTime var="latestWatchedTime" airing="${airing}"/>
   <sageair:GetScheduleStartTime var="scheduleStartTime" airing="${airing}"/>
   <c:if test="${isSafari}">
   <script src="../js/sagevideo.js" type="text/javascript" charset="utf-8"></script>
   <script type="text/javascript">
      var sageVideo;
      $(document).ready(function() {
         // do stuff when DOM is ready
         sageVideo = new SageVideo('myVideo', ${airingId});
         sageVideo.setCurrentTime(${latestWatchedTime - scheduleStartTime});
      });
   </script>
   </c:if>
</head>
<body>
   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Details" />
   </jsp:include>
<%-- error in GetScheduledEncoder --%>
   <div class="content">
      <sageair:GetShow var="show" airing="${airing}"/>
      <sageshow:GetShowEpisode var="episode" show="${show}"/>
      <sageshow:GetShowDescription var="description" show="${show}"/>
      <sageshow:GetShowCategory var="category" show="${show}"/>
      <sageshow:GetShowSubCategory var="subcategory" show="${show}"/>
      <sageshow:GetShowYear var="year" show="${show}"/>
      <sagemf:GetMediaFileEncoding var="encoding" mediaFile="${airing}"/>
      <sageair:IsManualRecord var="isManualRecord" airing="${airing}"/>
      <sagemf:IsMediaFileObject var="isMediaFileObject" object="${airing}"/>
      <%-- 6.0 only API --%>
      <c:catch> 
      <sagemf:GetMediaFileFormatDescription var="formatDescription" mediaFile="${airing}"/>
      </c:catch>
      <div class="title">${airingTitle}
         <sagemf:IsFileCurrentlyRecording var="isFileRecording" mediaFile="${airing}"/>
         <c:if test="${isFileRecording}">
            <img src="${cp}/m/images/RecordingNowMobile.png" alt="This show is currently recording." title="This show is currently recording."/>
         </c:if>
      </div>
      <div class="details">
      <c:if test="${(isDesktopSafari or isIPad or isIPhone) and isMediaFileObject}">
          <sagemf:GetMediaFileMetadata var="videoWidth" mediaFile="${mediaFile}" name="Format.Video.Width"/>
          <sagemf:GetMediaFileMetadata var="videoHeight" mediaFile="${mediaFile}" name="Format.Video.Height"/>
          <sagemf:GetMediaFileMetadata var="videoAspect" mediaFile="${mediaFile}" name="Format.Video.Aspect"/>
          <sageutilfn:SplitString var="videoAspectArray" value="${videoAspect}" token=":"/>
          <c:choose>
             <c:when test="${isIPhone or isIPod}">
                <c:set var="videoElementHeight" value="120"/>
             </c:when>
             <c:otherwise>
                <c:set var="videoElementHeight" value="240"/>
             </c:otherwise>
          </c:choose>
          <c:set var="videoElementWidth" value="${videoElementHeight * videoAspectArray[0] / videoAspectArray[1]}"/>
          <%--div id="status" class="progress button hidden"></div--%>
          <%--img id="overlay" src="/stream/MediaFileThumbnailServlet?MediaFileId=${mediaFileId}" width="${videoElementWidth}" height="${videoElementHeight}"--%>
          <video id="myVideo" class="videothumb" preload="none" src="/stream/HTTPLiveStreamingPlaylist?MediaFileId=${mediaFileId}" poster="/stream/MediaFileThumbnailServlet?MediaFileId=${mediaFileId}" controls="controls" width="${videoElementWidth}" height="${videoElementHeight}">
          </video>
          <%--div style="content: url(images/spinner.gif);"></div>
          <img src="images/spinner.gif"></img><br /--%>
          <div id="log"></div>
      </c:if>
      <div class="dividerbody">
      <sageairfn:GetAiringConflict var="airingConflict" airing="${airing}"/>
      <%@ include file="/WEB-INF/jspf/m/conflictmarkers.jspf" %>
      <c:if test="${!empty episode}"><p><b>Episode:</b> ${episode}</p></c:if>
      <c:if test="${!empty description}"><p><b>Description:</b> ${description}</p></c:if>
      <p><%@ include file="/WEB-INF/jspf/m/markers.jspf" %></p>
      <p><%@ include file="/WEB-INF/jspf/m/ratings.jspf" %></p>
      <sageairfn:IsPastAiring var="isPastAiring" airing="${airing}"/>
      <sageairfn:IsStartedAiring var="isStartedAiring" airing="${airing}"/>
      <sagemf:IsFileCurrentlyRecording var="isFileCurrentlyRecording" mediaFile="${airing}"/>
      <p>
      <c:if test="${isPastAiring}"><b>Aired:</b></c:if>
      <c:if test="${!isPastAiring}"><b>Airing:</b></c:if>
      <sageair:GetAiringStartTime var="airingStartTime" airing="${airing}" />
      <sageair:GetAiringEndTime var="airingEndTime" airing="${airing}" />
      <sageutil:DateFormat var="airingDate" date="${airingStartTime}" format="EEE, MMM d"/>
      <sageutil:PrintTimeShort var="airingStartTime" time="${airingStartTime}"/>
      <sageutil:PrintTimeShort var="airingEndTime" time="${airingEndTime}"/>
      ${airingDate}, ${airingStartTime} - ${airingEndTime}
      <sagemf:IsLibraryFile var="isLibraryFile" mediaFile="${airing}"/>
      <sagemf:IsTVFile var="isTVFile" mediaFile="${airing}"/>
      <c:if test="${isMediaFileObject and isLibraryFile and isTVFile}"> - Archived</c:if>
      </p>
      <sageairfn:PrintDuration var="duration" airing="${airing}"/>
      <c:if test="${!empty duration}"><p><b>Duration:</b> ${duration}</p></c:if>
      <sageair:GetAiringChannelName var="channelName" airing="${airing}" />
      <sageair:GetAiringChannelNumber var="channelNumber" airing="${airing}" />
      <c:if test="${!empty channelNumber}"><p><b>Channel:</b> ${channelNumber}-${channelName}</p></c:if>
      <%--
        -- Recording/Recorded/Scheduled to Record time
        --%>
      <sageair:GetScheduleStartTime var="scheduleStartTime" airing="${airing}" />
      <sageair:GetScheduleEndTime var="scheduleEndTime" airing="${airing}" />
      <sagemf:GetFileStartTime var="fileStartTime" mediaFile="${airing}" />
      <sagemf:GetFileEndTime var="fileEndTime" mediaFile="${airing}" />
      <sageutil:PrintTimeShort var="scheduleStartTime" time="${scheduleStartTime}"/>
      <sageutil:PrintTimeShort var="scheduleEndTime" time="${scheduleEndTime}"/>
      <sageutil:PrintTimeShort var="fileStartTime" time="${fileStartTime}"/>
      <sageutil:PrintTimeShort var="fileEndTime" time="${fileEndTime}"/>
      <sageglbl:GetScheduledRecordings var="scheduledRecordings"/>
      <sagedb:DataIntersection var="scheduledRecording" dataSet1="${scheduledRecordings}" dataSet2="${airing}"/>
      <c:choose>
         <c:when test="${isFileCurrentlyRecording}">
            <p><b>Recording:</b> ${fileStartTime} - ${scheduleEndTime}</p>
         </c:when>
         <c:when test="${isPastAiring and !empty mediaFile}">
            <p><b>Recorded:</b> ${fileStartTime} - ${fileEndTime}</p>
         </c:when>
         <c:when test="${!isStartedAiring and !empty scheduledRecording}">
            <p><b>Scheduled to Record:</b> ${scheduleStartTime} - ${scheduleEndTime}</p>
         </c:when>
      </c:choose>
      <c:if test="${!isMediaFileObject}">
         <sagecapdevfn:GetScheduledEncoder var="scheduledEncoder" airing="${airing}"/>
         <c:if test="${!empty scheduledEncoder}"><p><b>Scheduled Encoder:</b> ${scheduledEncoder}</p></c:if>
      </c:if>
      </div>
      <sageshow:GetOriginalAiringDate var="originalAiringLong" show="${show}"/>
      <div class="divider">Show Details</div>
      <div class="dividerbody">
      
      <sageair:GetParentalRating var="rating" airing="${airing}"/>
      <sageshow:GetShowRated var="rated" show="${show}"/>
      <sageshow:GetShowExpandedRatings var="expandedRatings" show="${show}"/>   
      <c:if test="${!empty rating}"><p><b>Rating:</b> ${rating}<c:if test="${!empty expandedRatings}"> for ${expandedRatings}</c:if></p></c:if>
      <c:if test="${!empty rated}"><p><b>Rated:</b> ${rated}<c:if test="${!empty expandedRatings}"> for ${expandedRatings}</c:if></p></c:if>
      <c:if test="${!empty category}">
         <p><b>Category:</b> ${category}<c:if test="${!empty subcategory}">/${subcategory}</c:if>
         <c:if test="${!empty originalAiringLong and originalAiringLong != 0}">
         <sageshow:IsShowFirstRun var="isShowFirstRun" airing="${show}"/>
         <c:if test="${isShowFirstRun}">
            - First Run
         </c:if>
         <c:if test="${!isShowFirstRun}">
            - ReRun
         </c:if>
         </c:if>
         <c:if test="${!empty year}">
            - ${year}
         </c:if>
         </p>
      </c:if>
      <sageshow:GetShowDuration var="showDuration" show="${show}"/>
      <c:if test="${!empty showDuration and showDuration > 0}">
         <sageutil:PrintDuration var="formattedDuration" duration="${showDuration}"/>
         <p><b>Run Time:</b> ${formattedDuration}</p>
      </c:if>
      <c:if test="${!empty originalAiringLong and originalAiringLong != 0}">
      <sageutilfn:LongToDate var="originalAiringDate" value="${originalAiringLong}"/>
      <sageutil:DateFormat var="originalAiringDate" date="${originalAiringDate}" format="EEE, MMM d, yyyy"/>
      <p><b>Original Air Date:</b> ${originalAiringDate}</p>
      </c:if>
      <sageshowfn:SupportsSeasonAndEpisode var="supportsSeasonAndEpisode" show="${show}"/>
      <c:if test="${supportsSeasonAndEpisode}">
         <sageshow:GetShowSeasonNumber var="seasonNumber" show="${show}"/>
         <sageshow:GetShowEpisodeNumber var="episodeNumber" show="${show}"/>
         <c:if test="${seasonNumber > 0 or episodeNumber > 0}">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;
               <c:if test="${seasonNumber > 0}">
                  Season ${seasonNumber}<c:if test="${episodeNumber > 0}">, </c:if>
               </c:if>
               <c:if test="${episodeNumber > 0}">
                  Episode ${episodeNumber}
               </c:if>
            </p>
         </c:if>
      </c:if>
      <sageair:GetExtraAiringDetails var="extraDetails" airing="${airing}"/>
      <c:if test="${!empty extraDetails}"><p>${extraDetails}</p></c:if>
      <sageshow:GetShowMisc var="showMisc" show="${show}"/>
      <c:if test="${!empty showMisc}"><p>${showMisc}</p></c:if>
      <sageshow:GetShowLanguage var="showLanguage" show="${show}"/>
      <c:if test="${!empty showLanguage}"><p><b>Language:</b> ${showLanguage}</p></c:if>
      <sageshow:GetShowExternalID var="showId" show="${show}"/>
      <c:if test="${!empty showId}"><p><b>Show ID:</b> ${showId}</p></c:if>
      <%-- People --%>
      <sageshow:GetPeopleListInShowInRoles var="starring" show="${show}" roleList="${fn:split('Actor;LeadActor;Actress;LeadActress', ';')}"/>
      <c:if test="${!empty starring}">
      <sageutilfn:JoinString var="starring" value="${starring}" />
      <p><b>Starring:</b> ${starring}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="costarring" show="${show}" roleList="${fn:split('Supporting Actor;Supporting Actress', ';')}"/>
      <c:if test="${!empty costarring}">
      <sageutilfn:JoinString var="costarring" value="${costarring}" />
      <p><b>Co-Starring:</b> ${costarring}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="gueststars" show="${show}" roleList="${fn:split('Guest;Guest Star', ';')}"/>
      <c:if test="${!empty gueststars}">
      <sageutilfn:JoinString var="gueststars" value="${gueststars}" />
      <p><b>Guest Stars:</b> ${gueststars}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="director" show="${show}" roleList="${fn:split('Director', ';')}"/>
      <c:if test="${!empty director}">
      <sageutilfn:JoinString var="director" value="${director}" />
      <p><b>Director:</b> ${director}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="producer" show="${show}" roleList="${fn:split('Producer', ';')}"/>
      <c:if test="${!empty producer}">
      <sageutilfn:JoinString var="producer" value="${producer}" />
      <p><b>Producer:</b> ${producer}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="writer" show="${show}" roleList="${fn:split('Writer', ';')}"/>
      <c:if test="${!empty writer}">
      <sageutilfn:JoinString var="writer" value="${writer}" />
      <p><b>Writer:</b> ${writer}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="choreographer" show="${show}" roleList="${fn:split('Choreographer', ';')}"/>
      <c:if test="${!empty choreographer}">
      <sageutilfn:JoinString var="choreographer" value="${choreographer}" />
      <p><b>Choreographer:</b> ${choreographer}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="sportsfigure" show="${show}" roleList="${fn:split('Sports Figure', ';')}"/>
      <c:if test="${!empty sportsfigure}">
      <sageutilfn:JoinString var="sportsfigure" value="${sportsfigure}" />
      <p><b>Sports Figure:</b> ${sportsfigure}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="coach" show="${show}" roleList="${fn:split('Coach', ';')}"/>
      <c:if test="${!empty coach}">
      <sageutilfn:JoinString var="coach" value="${coach}" />
      <p><b>Coach:</b> ${coach}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="host" show="${show}" roleList="${fn:split('Host', ';')}"/>
      <c:if test="${!empty host}">
      <sageutilfn:JoinString var="host" value="${host}" />
      <p><b>Host:</b> ${host}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="executiveproducer" show="${show}" roleList="${fn:split('Executive Producer', ';')}"/>
      <c:if test="${!empty executiveproducer}">
      <sageutilfn:JoinString var="executiveproducer" value="${executiveproducer}" />
      <p><b>Executive Producer:</b> ${executiveproducer}</p>
      </c:if>
      <sageshow:GetPeopleListInShowInRoles var="artist" show="${show}" roleList="${fn:split('Artist', ';')}"/>
      <c:if test="${!empty artist}">
      <sageutilfn:JoinString var="artist" value="${artist}" />
      <p><b>Artist:</b> ${artist}</p>
      </c:if>
      </div>

      <c:if test="${isMediaFileObject}">
         <div class="divider">Media File Details</div>
         <div class="dividerbody">
            <c:if test="${!empty encoding}">
               <p><b>Encoded by:</b> ${encoding}</p>
            </c:if>
            <sagemf:GetSegmentFiles var="segmentFiles" mediaFile="${airing}"/>
            <c:if test="${!empty segmentFiles}">
               <p><b>Files:</b><br/>
               <c:forEach var="file" items="${segmentFiles}" varStatus="status">
                  <c:url var="fileSegmentUrl" value="../MediaFile">
                     <c:param name="MediaFileId" value="${mediaFileId}"></c:param>
                     <c:param name="Segment" value="${status.index}"></c:param>  
                  </c:url>
                  &nbsp;&nbsp;&nbsp;<a href="${fileSegmentUrl}">${file}</a><br/>
               </c:forEach>
               </p>
            </c:if>
            <%-- 6.0 only API --%> 
            <c:if test="${!empty formatDescription}"><p><b>Format:</b> ${formatDescription}</p></c:if>
            <sagemf:GetSize var="size" mediaFile="${airing}"/>
            <c:set var="size" value="${size / 1000000}"/>
            <c:if test="${size > 1000}">
               <sageutil:NumberFormat var="formattedSize" format="0.00" number="${size / 1000}"/>
               <p><b>Size:</b> ${formattedSize} GB</p>
            </c:if>
            <c:if test="${size <= 1000}">
               <sageutil:NumberFormat var="formattedSize" format="0.00" number="${size}"/>
               <p><b>Size:</b> ${formattedSize} MB</p>
            </c:if>
         </div>
      </c:if>

      <div class="divider">Internal Details</div>
      <div class="dividerbody">
         <c:if test="${!empty mediaFileId}"><p><b>MediaFileID:</b> ${mediaFileId}</p></c:if>
         <p><b>AiringID:</b> ${airingId}</p>
      </div>

      </div> <%-- details --%>

   <c:if test="${!isPastAiring and isManualRecord}">
      <%-- Airing is in the future or is currently recording --%>
      <div class="optionstitle">Recording Options</div>
      <div class="optionsbody">
         <div class="label">Padding (minutes)</div>
         <div class="value">
            <table>
               <%-- Padding --%>
               <tr>
                  <td>
                     <div class="paddingbody">
                     <form method="post" action="${cp}/m/Command">
                        <c:if test="${!empty param.MediaFileId}">
                           <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                        </c:if>
                        <c:if test="${!empty param.AiringId}">
                           <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                        </c:if>
                        <%-- ${pageContext.request.requestURL} does not work with reverse proxy --%>
                        <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                        <sageairfn:GetStartPadding var="startPadding" airing="${airing}"/>
                        <sageairfn:GetEndPadding var="endPadding" airing="${airing}"/>
                        <c:if test="${!isStartedAiring}">
                           <%-- TODO vertical-align: middle --%>Start Pad:
                           <input type="text" size="3" name="StartPadding" value="<%= Math.abs((Long)pageContext.getAttribute("startPadding")) %>"/> minutes  
                           <select name="StartPaddingOffsetType">
                              <option value="earlier" <c:if test="${startPadding <= 0}">selected="selected" style="font-weight: bold;"</c:if>>Earlier</option>
                              <option value="later" <c:if test="${startPadding > 0}">selected="selected" style="font-weight: bold;"</c:if>>Later</option>
                           </select><br/>
                        </c:if>
                        End Pad:
                        <input type="text" size="3" name="EndPadding" value="<%= Math.abs((Long)pageContext.getAttribute("endPadding")) %>"/> minutes
                        <select name="EndPaddingOffsetType">
                           <option value="earlier" <c:if test="${endPadding < 0}">selected="selected" style="font-weight: bold;"</c:if>>Earlier</option>
                           <option value="later" <c:if test="${endPadding >= 0}">selected="selected" style="font-weight: bold;"</c:if>>Later</option>
                        </select><br/>
                        <%-- TODO doesn't jump to conflicts page--%>
                        <button style="margin-top: 4px;" type="submit" name="command" value="SetRecPad">Set Padding</button>
                     </form>
                     </div>
                  </td>
               </tr>
            </table>
         </div>         
         <%-- Quality --%>
         <%-- Don't allow modification of recording quality if recording has started or if it's HD --%> 
         <sageair:IsAiringHDTV var="isHDTV" airing="${airing}"/>
         <c:if test="${!isStartedAiring and !isHDTV}">
            <div class="label">Quality</div>
            <div class="value">
               <table>
                  <tr>
                     <td>
                        <div class="qualitybody">
                        <form method="post" action="${cp}/m/Command">
                           <c:if test="${!empty param.MediaFileId}">
                              <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                           </c:if>
                           <c:if test="${!empty param.AiringId}">
                              <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                           </c:if>
                           <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                           <sagecfg:GetRecordingQualities var="recordingQualities"/>
                           <sagecfg:GetDefaultRecordingQuality var="defaultQuality"/>
                           <sageair:GetRecordingQuality var="quality" airing="${airing}"/>
                           <%--Quality:<br/>--%>
                           <select name="Quality">
                              <option value="Default" <c:if test="${empty quality or quality == 'Default'}">selected="selected" style="font-weight: bold;"</c:if>>Default: ${defaultQuality}</option>
                              <c:forEach var="currentQuality" items="${recordingQualities}">
                                 <option value="${currentQuality}" <c:if test="${quality == currentQuality}">selected="selected" style="font-weight: bold;"</c:if>>${currentQuality}</option>
                              </c:forEach> 
                           </select>
                           <%--div style="padding-top: 2px;"></div--%>
                           <button style="margin-top: 4px;" type="submit" name="command" value="SetRecQual">Set Quality</button>
                        </form>
                        </div>
                     </td>
                  </tr>
               </table>
            </div>
         </c:if>
      </div>
   </c:if>

   <sageglbl:GetUIContextNames var="contexts"/>
   <sageglbl:GetConnectedClients var="connectedClients"/>
   <sageairfn:IsStartedAiring var="isStartedAiring" airing="${airing}"/>
   <sageairfn:IsPastAiring var="isPastAiring" airing="${airing}"/>

   <%--c:if test="${(!empty contexts or !empty connectedClients or isSafari) and (isMediaFileObject or (isStartedAiring and not isPastAiring))}"--%>
   <c:if test="${(!empty contexts or !empty connectedClients or isSafari) and (isMediaFileObject)}">
      <div class="optionstitle">Watch Now</div>
      <div class="optionsbody">
         <table>
            <c:if test="${(isDesktopSafari or isIPad or isIPhone) and isMediaFileObject}">
               <tr>
                  <td>
                     <button onclick="sageVideo.playPause();">On This Page</button> 
                  </td>
               </tr>
            </c:if>
            <c:forEach var="context" items="${contexts}">
               <tr>
                  <td>
                     <c:set var="formId" value="${context}WatchNowForm"/>
                     <form id="${formId}" method="post" action="${cp}/m/Command">
                        <c:set var="contextName" value="<%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("context").toString(), "name") %>"/>
                        <input type="hidden" name="context" value="${context}"/>
                        <c:if test="${isMediaFileObject}">
                           <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                        </c:if>
                        <c:if test="${!isMediaFileObject}">
                           <input type="hidden" name="AiringId" value="${airingId}"/>
                        </c:if>
                        <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                        <button type="submit" name="command" value="WatchNow">${contextName}</button> 
                        <%--button type="button" onClick="location.href='webremote.jsp?context=${context}'">${contextName} Web Remote</button--%>
                     </form>
                     <script language="JavaScript">
                     <!--
                        $('#${formId}').ajaxForm();
                     //-->
                     </script>
                  </td>
               </tr>
            </c:forEach>
            <c:forEach var="client" items="${connectedClients}">
               <tr>
                  <td>
                     <c:set var="formId" value="${client}WatchNowForm"/>
                     <form id="${formId}" method="post" action="${cp}/m/Command">
                        <input type="hidden" name="context" value="${client}"/>
                        <c:set var="clientName" value="<%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("client").toString(), "name") %>"/>
                        <c:if test="${isMediaFileObject}">
                           <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                        </c:if>
                        <c:if test="${!isMediaFileObject}">
                           <input type="hidden" name="AiringId" value="${airingId}"/>
                        </c:if>
                        <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                        <button type="submit" name="command" value="WatchNow">${clientName}</button> 
                        <%--button type="button" onClick="location.href='webremote.jsp?context=${client}'">${clientName} Web Remote</button--%>
                     </form>
                     <script language="JavaScript">
                     <!--
                        $('#${formId}').ajaxForm();
                     //-->
                     </script>
                  </td>
               </tr>
            </c:forEach>
         </table>
      </div>
   </c:if>

   <div class="optionstitle">Options</div>
   <div class="optionsbody">
      <table>
         <%--tr>
            <td>
               <form action="ManualRecord" method="post">
                  TODO call a servlet which starts a vlc transcode and returns an sdp file which points to the stream
                  <button type="submit" value="Watch Now">Watch Now</button>
               </form>
            </td>
         </tr--%>
         <%--tr>
            <td>
               <form action="ManualRecord" method="post">
                  <button type="submit" value="Watch Now on &lt;Extender&gt;">Watch Now on &lt;Extender&gt;</button>
               </form>
            </td>
         </tr>
         <tr>
            <td>
               <form action="ManualRecord" method="post">
                  <button type="submit" value="Watch Now on &lt;Extender&gt;">Watch Now on &lt;Extender&gt;</button>
               </form>
            </td>
         </tr--%>
         <%--tr>
            <td>
               <form action="MediaFile" method="post">
                  <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                  <button type="submit" value="Download Video">Download Video</button>
               </form>
            </td>
         </tr--%>
         <%-- Recording Options --%>
         <c:choose>
            <c:when test="${!isPastAiring}">
               <%-- Airing is in the future or is currently recording --%>
               <c:choose>
                  <c:when test="${isManualRecord}">
                     <%-- Cancel Recording --%>
                     <tr>
                        <td>
                           <form method="post" action="${cp}/m/Command">
                              <c:if test="${!empty param.MediaFileId}">
                                 <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                              </c:if>
                              <c:if test="${!empty param.AiringId}">
                                 <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                              </c:if>
                              <%--if (! airing.getTitle().startsWith("Timed Record"))
                              <c:if test=""--%>
                                 <input type="hidden" name="returnto" value="${cp}/m/details.jsp?AiringId=${airingId}"/>
                              <%--/c:if--%>
                              <button type="submit" name="command" value="CancelRecord">Cancel Recording</button> 
                           </form>
                        </td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <tr>
                        <td>
                           <form method="post" action="${cp}/m/Command">
                              <c:if test="${!empty param.MediaFileId}">
                                 <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                              </c:if>
                              <c:if test="${!empty param.AiringId}">
                                 <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                              </c:if>
                              <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                              <button type="submit" name="command" value="Record">Record</button>
                           </form>
                        </td>
                     </tr>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
               <%-- Airing is in the past --%>
               <c:if test="${isMediaFileObject}">
               <%--c:if test="${isStartedAiring}"--%>
               <%--c:if test="${!empty mediaFile and isPastAiring}"--%>
               <c:choose>
                  <c:when test="${isManualRecord}">
                     <tr>
                        <td>
                           <form method="post" action="${cp}/m/Command">
                              <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                              <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                              <button type="submit" name="command" value="RemoveManRecStatus">Clear Manual</button> 
                           </form>
                        </td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <tr>
                        <td>
                           <form method="post" action="${cp}/m/Command">
                              <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                              <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                              <button type="submit" name="command" value="SetManRecStatus">Set Manual</button> 
                           </form>
                        </td>
                     </tr>
                  </c:otherwise>
               </c:choose>
               </c:if>
            </c:otherwise>
         </c:choose>
         <%--tr>
            <td>
               <form action="ManualRecord" method="post">
                  <button type="submit" value="View Series Information">View Series Information</button>
               </form>
            </td>
         </tr--%>
         <c:if test="${!empty mediaFile and isPastAiring}">
         <tr>
            <td>
               <form action="${cp}/m/Command" method="get">
                  <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                  <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                  <button type="submit" name="command" value="DeleteFile">Delete this Recording</button>
               </form>
            </td>
         </tr>
         </c:if>
         <tr>
            <td>
               <sagefav:GetFavoriteForAiring var="favorite" airing="${airing}"/>
               <form action="favoritedetails.jsp" method="get">
                  <c:if test="${empty favorite}">
                     <input type="hidden" name="AddTitle" value="${airingTitle}"/>
                     <button type="submit" value="Add Favorite">Add Favorite</button>
                  </c:if>
                  <c:if test="${!empty favorite}">
                     <sagefav:GetFavoriteID var="favoriteId" favorite="${favorite}"/>
                     <input type="hidden" name="FavoriteId" value="${favoriteId}"/>
                     <button type="submit" value="Favorite Options">Favorite Options</button>
               </c:if>
               </form>
            </td>
         </tr>
         <c:if test="${!empty airingConflict}"><%-- airing is an unresolved conflict --%>
         <tr>
            <td>
               <form action="conflictresolution.jsp" method="get">
                  <input type="hidden" name="AiringId" value="${airingId}"/>
                  <button type="submit" value="Past Airings">Resolve Conflicts</button>
               </form>
            </td>
         </tr>
         </c:if>
         <tr>
            <td>
               <form action="additionalairings.jsp" method="get">
                  <input type="hidden" name="Title" value="${airingTitle}"/>
                  <input type="hidden" name="Period" value=""/>
                  <button type="submit" value="Additional Airings">All Airings</button>
               </form>
            </td>
         </tr>
         <tr>
            <td>
               <form action="additionalairings.jsp" method="get">
                  <input type="hidden" name="Title" value="${airingTitle}"/>
                  <input type="hidden" name="Period" value="past"/>
                  <button type="submit" value="Past Airings">Past Airings</button>
               </form>
            </td>
         </tr>
         <tr>
            <td>
               <form action="additionalairings.jsp" method="get">
                  <input type="hidden" name="Title" value="${airingTitle}"/>
                  <input type="hidden" name="Period" value="future"/>
                  <button type="submit" value="Future Airings">Future Airings</button>
               </form>
            </td>
         </tr>
         <%--tr>
            <td>
               <form action="ManualRecord" method="post">
                  <button type="submit" value="Add to Playlist...">Add to Playlist...</button>
               </form>
            </td>
         </tr>
         <tr>
            <td>
               <form action="ManualRecord" method="post">
                  <button type="submit" value="Play a Playlist...">Play a Playlist...</button>
               </form>
            </td>
         </tr--%>
         <sageair:IsWatched var="isWatched" airing="${airing}"/>
         <sageair:IsDontLike var="isDontLike" airing="${airing}"/>
         <sagemf:IsLibraryFile var="isLibraryFile" mediaFile="${airing}"/>
         <tr>
            <td><%--
               <%= request.getHeader("HOST") %><br/>
               ${pageContext.request.requestURL}<br/>
               ${pageContext.request.requestURI}<br/>
               ${pageContext.request.scheme}://${pageContext.request.localName}:${pageContext.request.localPort}${cp}${pageContext.request.servletPath}${pageContext.request.pathTranslated}<br/>
               ${pageContext.request.scheme}://${pageContext.request.localName}:${pageContext.request.localPort}${pageContext.request.requestURI}
               --%><!--form action="${cp}/MediaFileCommand" method="post"-->
               <form method="post" action="${cp}/m/Command">
                  <c:if test="${!empty param.MediaFileId}">
                  <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                  </c:if>
                  <c:if test="${!empty param.AiringId}">
                  <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                  </c:if>
                  <%-- TODO redirect doesn't work through reverse proxy --%>
                  <%-- TODO need jsessionid --%>
                  <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                  <%--input type="hidden" name="returnto" value="${pageContext.request.requestURL}?${pageContext.request.queryString}"/--%>
                  <%--input type="hidden" name="returnto" value="${pageContext.request.scheme}://${pageContext.request.localName}:${pageContext.request.localPort}${pageContext.request.requestURI}?${pageContext.request.queryString}"/--%>
                  <c:if test="${isDontLike}">
                     <button type="submit" name="command" value="ClearDontLike">Clear Don't Like</button>
                  </c:if>
                  <c:if test="${!isDontLike}">
                     <button type="submit" name="command" value="SetDontLike">Set Don't Like</button>
                  </c:if>
               </form>
            </td>
         </tr>
         <tr>
            <td>
               <form method="post" action="${cp}/m/Command">
                  <c:if test="${!empty param.MediaFileId}">
                  <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                  </c:if>
                  <c:if test="${!empty param.AiringId}">
                  <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                  </c:if>
                  <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                  <c:if test="${isWatched}">
                     <button type="submit" name="command" value="ClearWatched">Clear Watched</button>
                  </c:if>
                  <c:if test="${!isWatched}">
                     <button type="submit" name="command" value="SetWatched">Set Watched</button>
                  </c:if>
               </form>
            </td>
         </tr>
         <c:if test="${isTVFile and !isFileCurrentlyRecording}">
         <tr>
            <td>
                <form action="${cp}/m/Command" method="post">
                  <c:if test="${!empty param.MediaFileId}">
                  <input type="hidden" name="MediaFileId" value="${param.MediaFileId}"/>
                  </c:if>
                  <c:if test="${!empty param.AiringId}">
                  <input type="hidden" name="AiringId" value="${param.AiringId}"/>
                  </c:if>
                  <input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/>
                  <c:if test="${isLibraryFile}">
                     <button type="submit" name="command" value="Unarchive">Clear Archived</button>
                  </c:if>
                  <c:if test="${!isLibraryFile}">
                     <button type="submit" name="command" value="Archive">Set Archived</button>
                  </c:if>
               </form>
            </td>
         </tr>
         </c:if>
         <%-- 5.1 only API --%>
         <%--
            try {
                if ( airing.idType==Airing.ID_TYPE_MEDIAFILE
                     && !SageApi.booleanApi("IsDVD",new Object[]{airing.sageAiring})
                     && SageApi.booleanApi("IsVideoFile",new Object[]{airing.sageAiring})
                     && !SageApi.booleanApi("IsFileCurrentlyRecording",new Object[]{airing.sageAiring})
                     && SageApi.booleanApi("CanFileBeTranscoded",new Object[]{airing.sageAiring})){
                    out.println("<li>");
                    out.println("  <a href=\"ConversionDetails?"+airing.getIdArg()+"\">");
                    out.println("      Convert");
                    out.println("   </a>" +
                                "</li>");
                }
            } catch (InvocationTargetException e) {
                // transcoding not supported prior to V6
            }
         --%>
         <c:catch>
         <c:if test="${!empty mediaFile}">
            <sagetc:CanFileBeTranscoded var="canFileBeTranscoded" mediaFile="${mediaFile}" />
            <sagemf:IsVideoFile var="isVideoFile" mediaFile="${mediaFile}"/>
            <c:if test="${isVideoFile and !isFileCurrentlyRecording and canFileBeTranscoded}">
            <tr>
               <td>
                  <%--form action="${cp}/m/convert.jsp" method="get"--%>
                  <form action="${cp}/m/Command" method="post">
                     <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
                     <!--input type="hidden" name="returnto" value="${cp}/m/details.jsp?${pageContext.request.queryString}"/-->
                     <button type="submit" name="command" value="Convert">Convert</button>
                  </form>
               </td>
            </tr>
            </c:if>
         </c:if>
         </c:catch>
      </table>
   </div> <%-- options body --%>
   </div> <%-- content --%>

   <%@ include file="/WEB-INF/jspf/m/footer.jspf" %>

</body>
</html>
