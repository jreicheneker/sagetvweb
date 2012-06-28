<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagecd" tagdir="/WEB-INF/tags/sage/api/capturedevice" %> 
<%@ taglib prefix="sagecdfn" tagdir="/WEB-INF/tags/sage/functions/capturedevice" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagemp" tagdir="/WEB-INF/tags/sage/api/mediaplayer" %> 
<%@ taglib prefix="sagemsg" tagdir="/WEB-INF/tags/sage/api/systemmessage" %> 
<%@ taglib prefix="sagemsgfn" tagdir="/WEB-INF/tags/sage/functions/systemmessage" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sagedatefn" tagdir="/WEB-INF/tags/sage/functions/date" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>SageTV Mobile Home</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Home" />
   </jsp:include>

   <div class="content">

      <%--
        -- Now Playing
        --%>
      <div class="section">Now Playing</div>
      <div class="sectionbody">
      <sageglbl:GetUIContextNames var="contexts"/>
      <sageglbl:GetConnectedClients var="connectedClients"/>
      <sageutilfn:SupportsClientApiUi var="supportsClientApiUi"/>
      <!--  TODO clients -->
      <c:if test="${!empty contexts or (!empty connectedClients and supportsClientApiUi)}">
         <%-- TODO local first --%>
         <c:forEach var="context" items="${contexts}">
            <%-- TODO sagecfg:GetProperty var="" name="sagex/extender|context/${context}/description"/--%>
            <div class="divider">
               <a href="extenderdetails.jsp?context=${context}">
                  <%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("context").toString(), "name") %>
               </a>
            </div>
            <div class="dividerbody">
            <div>
               <sagemp:GetCurrentMediaFile var="mediaFile" context="${context}"/>
               <sagemf:IsTVFile var="isTVFile" mediaFile="${mediaFile}"/>
               <c:choose>
                  <c:when test="${!empty mediaFile and isTVFile}">
                     <%@ include file="/WEB-INF/jspf/m/tvcell.jspf" %>
                     <div style="margin: 2px 0px 5px 0px;">
                     <form action="${cp}/m/Command" method="post">
                        <input type="hidden" name="context" value="${context}"/>
                        <input type="hidden" name="returnto" value="${cp}/m/home.jsp"/>
                        <input type="hidden" name="command" value="Stop"/>
                        <button type="submit" value="Stop Playback">Stop Playback</button>
                        <button type="button" onClick="location.href='webremote.jsp?context=${context}'">Web Remote</button>
                     </form>
                     </div>
                  </c:when>
                  <c:otherwise>
                     Nothing
                     <div style="margin: 2px 0px 5px 0px;">
                     <form action="${cp}/m/Command" method="post">
                        <input type="hidden" name="context" value="${context}"/>
                        <input type="hidden" name="returnto" value="${cp}/m/home.jsp"/>
                        <%--input type="hidden" name="command" value="Stop"/--%>
                        <%--button type="submit" value="Stop Playback">Stop Playback</button--%>
                        <button type="button" onClick="location.href='webremote.jsp?context=${context}'">Web Remote</button>
                     </form>
                     </div>
                  </c:otherwise>
               </c:choose>
            </div>
            </div>
         </c:forEach>
         <c:if test="${supportsClientApiUi}">
            <c:forEach var="client" items="${connectedClients}">
               <%--div style="padding-left: 0px">${client}</div--%>
               <div class="divider">
                  <a href="extenderdetails.jsp?context=${client}">
                     <%= sagex.webserver.UiContextProperties.getProperty(pageContext.getAttribute("client").toString(), "name") %>
                  </a>
               </div>
               <div class="dividerbody">
               <div>
                  <sagemp:GetCurrentMediaFile var="mediaFile" context="${context}"/>
                  <sagemf:IsTVFile var="isTVFile" mediaFile="${mediaFile}"/>
                  <c:choose>
                     <c:when test="${!empty mediaFile and isTVFile}">
                        <%@ include file="/WEB-INF/jspf/m/tvcell.jspf" %>
                        <div style="margin: 2px 0px 5px 0px;">
                        <form action="${cp}/m/Command" method="post">
                           <input type="hidden" name="context" value="${context}"/>
                           <input type="hidden" name="returnto" value="${cp}/m/home.jsp"/>
                           <input type="hidden" name="command" value="Stop"/>
                           <button type="submit" value="Stop Playback">Stop Playback</button>
                           <button type="button" onClick="location.href='webremote.jsp?context=${context}'">Web Remote</button>
                        </form>
                        </div>
                     </c:when>
                     <c:otherwise>
                        Nothing
                     </c:otherwise>
                  </c:choose>
               </div>
               </div>
            </c:forEach>
         </c:if>
      </c:if>
      <c:if test="${empty contexts and (not supportsClientApiUi or (empty connectedClients and supportsClientApiUi))}">
         Nothing
      </c:if>
      </div>
      <%--
        -- Currently Recording
        --%>
      <div class="section">Currently Recording</div>
      <div class="sectionbody">
      <sagecd:GetActiveCaptureDevices var="capturedevices"/>
      <c:if test="${!empty capturedevices}">
         <c:forEach var="capturedevice" items="${capturedevices}">
            <sagecd:GetCaptureDeviceCurrentRecordFile var="mediaFile" captureDevice="${capturedevice}"/>
            <div class="divider"><!--img src="../../images/DividerBgMobile.png" style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;"/-->${capturedevice}</div>
            <div class="dividerbody">
            <div>
            <c:if test="${!empty mediaFile}">
               <%@ include file="/WEB-INF/jspf/m/tvcell.jspf" %>
		    </c:if>
            <c:if test="${empty mediaFile}">
		       Nothing
		    </c:if>
		    </div>
		    </div>
         </c:forEach>
      </c:if>
      <c:if test="${empty capturedevices}">
         <div style="padding-left: 10px"><p>No Encoders Configured</p></div>
      </c:if>
      <%--/div--%>
      </div>
      <%--
        -- Next Upcoming Recordings
        --%>
      <div class="section">Next Upcoming Recordings</div>
      <div class="sectionbody">
      <sageglbl:GetScheduledRecordings var="scheduledRecordings"/>
      <sageglbl:GetAiringsThatWontBeRecorded var="allConflicts" onlyUnresolved="false"/>
      <sageglbl:GetAiringsThatWontBeRecorded var="unresolvedConflicts" onlyUnresolved="true"/>
      <c:if test="${!empty scheduledRecordings}">
         <sagedb:FilterByBoolMethod var="scheduledRecordings" method="IsFileCurrentlyRecording" data="${scheduledRecordings}" matchValue="false"/>
      </c:if>
      <c:choose>
         <c:when test="${!empty scheduledRecordings}">
            <sageutil:GetElement var="nextRecording" data="${scheduledRecordings}" index="0"/>
            <sageair:GetAiringStartTime var="nextRecordingDateMillis" airing="${nextRecording}"/>
            <sagedb:FilterByMethod var="scheduledRecordings" data="${scheduledRecordings}" method="GetAiringStartTime" matchValue="${nextRecordingDateMillis}" matchedPasses="true"/>
            <sagedatefn:IsToday var="isToday" dateMillis="${nextRecordingDateMillis}"/>
            <sagedatefn:IsTomorrow var="isTomorrow" dateMillis="${nextRecordingDateMillis}"/>
            <sageutilfn:LongToDate var="nextRecordingDate" value="${nextRecordingDateMillis}"/>
            <sageutil:DateFormat var="nextRecordingDateFmt" date="${nextRecordingDate}" format="EEE, MMM d, yyyy"/>
            <sageutil:PrintTimeShort var="nextRecordingTimeFmt" time="${nextRecordingDateMillis}"/>

            <c:choose>
               <c:when test="${isToday}">
                  <p>Today at ${nextRecordingTimeFmt}</p>
               </c:when>
               <c:when test="${isTomorrow}">
                  <p>Tomorrow at ${nextRecordingTimeFmt}</p>
               </c:when>
               <c:otherwise>
                  <p>${nextRecordingDateFmt} at ${nextRecordingTimeFmt}</p>
               </c:otherwise>
            </c:choose>

            <c:forEach var="airing" items="${scheduledRecordings}">
               <sagecdfn:GetScheduledEncoder var="encoder" airing="${airing}"/>
               <div class="divider">${encoder}</div>
               <div class="dividerbody">
                  <%@ include file="/WEB-INF/jspf/m/airingcell.jspf" %>
               </div>
            </c:forEach>
         </c:when>
         <c:otherwise>
            <p>No Upcoming Recordings</p>
         </c:otherwise>
      </c:choose>
      <%--/div--%>
      </div>
      <%--
        -- System Messages
        --%>
      <div class="section">System Messages</div>
      <div class="sectionbody">
         <sagemsgfn:SupportsSystemMessages var="supportsSystemMessages"/>
   
         <c:if test="${not supportsSystemMessages}">
            System messages require SageTV 6.5.17 or later.
         </c:if>

         <c:if test="${supportsSystemMessages}">
            <sagemsg:GetSystemAlertLevel var="alertLevel"/>
            <c:if test="${empty alertLevel}"><c:set var="alertLevel">0</c:set></c:if>
            <sagemsg:GetSystemMessages var="systemMessages"/>
            <sageutil:Size var="systemMessageCount" data="${systemMessages}"/>
            <c:choose>
               <c:when test="${alertLevel == 0}">
                  <c:set var="alertLevelDesc">Status</c:set>
               </c:when>
               <c:when test="${alertLevel == 1}">
                  <c:set var="alertLevelDesc">Information</c:set>
               </c:when>
               <c:when test="${alertLevel == 2}">
                  <c:set var="alertLevelDesc">Warning</c:set>
               </c:when>
               <c:when test="${alertLevel == 3}">
                  <c:set var="alertLevelDesc">Error</c:set>
               </c:when>
            </c:choose>

            <div class="divider">Alert Level</div>
            <c:if test="${alertLevel == 0}">
               <div class="dividerbody">No new system messages have been generated since the alert level was last reset.</div>
            </c:if>
            <c:if test="${alertLevel > 0}">
               <div class="dividerbody">
                  The system is currently at alert level ${alertLevel} - ${alertLevelDesc}
                  <img style="border: 0px none; width: 20px; height: 20px;" src="${cp}/images/MarkerSysAlert${alertLevel}.png" alt="Message Level ${alertLevel}" title="Message Level ${alertLevel}"/>
               </div>
            </c:if>
            <div class="divider">System Messages</div>
            <c:if test="${systemMessageCount == 1}">
               <div class="dividerbody">There is <a href="systemmessages.jsp">${systemMessageCount} system message</a></div>
            </c:if>
            <c:if test="${systemMessageCount != 1}">
               <div class="dividerbody">There are <a href="systemmessages.jsp">${systemMessageCount} system messages</a></div>
            </c:if>
         </c:if>
      </div>
      <%--
        -- Conflicts
        --%>
      <div class="section">Conflicts</div>
      <div class="sectionbody">
      <%@ include file="/WEB-INF/jspf/m/conflictstats.jspf" %>
      </div>
      <%--
        -- Connected Clients
        -- pre-Sage 7 display, preserve functionality for those users
        --%>
      <c:if test="${!empty connectedClients and !supportsClientApiUi}">
         <div class="section">Connected Clients</div>
         <div class="sectionbody">
         <c:forEach var="client" items="${connectedClients}">
            <div style="padding-left: 0px">${client}</div>
         </c:forEach>
         </div>
      </c:if>
      <%--
        -- Video Disk Space
        --%>
      <div class="section">Video Disk Space</div>
      <div class="sectionbody">
      <sageglbl:GetTotalDiskspaceAvailable var="diskavailable"/>
      <sageutilfn:DecimalFormat var="diskavailablefmt" value="${diskavailable / 1.0E9}" format="0.00"/>
      <sageglbl:GetUsedVideoDiskspace var="diskused"/>
      <sageutilfn:DecimalFormat var="diskusedfmt" value="${diskused / 1.0E9}" format="0.00"/>
      <div class="divider">Available</div>
      <div class="dividerbody">${diskavailablefmt} GB</div>
      <div class="divider">Used</div>
      <div class="dividerbody">${diskusedfmt} GB</div>
      <%--/div--%>
      </div>
<%-- =============================

		    int numpartials=0;
		    double partialsspace=0.0;
		    boolean partialsFree=SageApi.GetBooleanProperty("nielm/diskbar_partials_free",true);
		    if ( partialsFree )
		    {
		        Object mediafiles=SageApi.Api("GetMediaFiles");
		        mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsTVFile", Boolean.TRUE});
		        mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsLibraryFile", Boolean.FALSE});
		        mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsCompleteRecording", Boolean.FALSE});
		        mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsManualRecord", Boolean.FALSE});
		        numpartials=SageApi.Size(mediafiles);
		        for ( int num=0;num<numpartials;num++){
		            Object file=SageApi.GetElement(mediafiles,num);
		            partialsspace+=((Long)SageApi.Api("GetSize",new Object[]{file})).doubleValue();
		        }
		        partialsspace/= 1.0E9;
		    }
		    int diskusedpc=new Double(100.0*(diskused-partialsspace)/(diskavail+diskused)).intValue();
		    
		    int numautodelete=0;
		    double autodeletespace=0.0;
		    Object mediafiles=SageApi.Api("GetMediaFiles");
		    mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsTVFile", Boolean.TRUE}); // only count tv recordings
		    mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsLibraryFile", Boolean.FALSE}); // exclude archived files, they're never auto-deleted
		    mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsManualRecord", Boolean.FALSE}); // exclude manual recordings, they're never auto-deleted
            mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsCompleteRecording", Boolean.TRUE}); // exclude partials
		    mediafiles=SageApi.Api("FilterByBoolMethod",new Object[]{mediafiles,"IsFileCurrentlyRecording", Boolean.FALSE});
		    numautodelete=SageApi.Size(mediafiles);
		    for ( int num=0;num<SageApi.Size(mediafiles);num++){
		        Object mediafile=SageApi.GetElement(mediafiles,num);
		        Object sageFavorite=SageApi.Api("GetFavoriteForAiring", mediafile);
		        // if it's a favorite, check for auto-delete
		        // if not, it's an intelligent recording (assumption is valid because of previous filtering)
		        if ((sageFavorite == null) || (SageApi.booleanApi("IsAutoDelete", new Object[]{sageFavorite})))
		        {
		            autodeletespace+=((Long)SageApi.Api("GetSize",new Object[]{mediafile})).doubleValue();
		        }
		        else {
		            numautodelete--;
		        }
		    }
		    autodeletespace/= 1.0E9;
		    
		    long lookahead=((long)SageApi.GetIntProperty("nielm/diskbar_lookahead_hours", 48))*60*60*1000;
		    long now=new Date().getTime();
		    Object recordings=SageApi.Api("GetScheduledRecordings");
		    recordings=SageApi.Api("FilterByRange",new Object[]{recordings,"GetAiringEndTime", new Long(now), new Long(now+lookahead), Boolean.TRUE});
		    if (SageApi.GetBooleanProperty("nielm/diskbar_lookahead_only_requested",true)) {
		        //System.out.println("Filtering from "+SageApi.Size(recordings));
		        Object manrec=SageApi.Api("FilterByBoolMethod",new Object[]{recordings,"IsManualRecord", Boolean.TRUE});
		        Object faverec=SageApi.Api("FilterByBoolMethod",new Object[]{recordings,"IsFavorite", Boolean.TRUE});
		        recordings=SageApi.Api("DataUnion",new Object[]{manrec,faverec});
		        //System.out.println("Filtering to "+SageApi.Size(recordings));
		    }
		    double bytesneeded=0;
		    for (int num=0;num<SageApi.Size(recordings);num++)
		    {
		        Object sageAiring=SageApi.GetElement(recordings, num);
		        Object quality =SageApi.Api("GetRecordingQuality",new Object[]{sageAiring});
		        Long duration=(Long)SageApi.Api("GetScheduleDuration",new Object[]{sageAiring});
		        if ( SageApi.Size(quality)<=0)
		            quality =SageApi.Api("GetDefaultRecordingQuality");
		        Long bitrate=(Long)SageApi.Api("GetRecordingQualityBitrate",new Object[]{quality});
		        bytesneeded+= (bitrate.doubleValue()/8.0*duration.doubleValue()/1000.0);
		    }
		    double diskneeded=(bytesneeded/ 1.0E9);
		    int diskreqpc=new Double(100.0*diskneeded/(diskavail+diskused)).intValue();
		    
		    
		    out.println("<table style=\"border:2px groove\" cellpadding=\"0\" cellspacing=\"1\" border=\"0\" width=\"200px\"><tr>");
		    if ( diskusedpc>0 ){
		        if ( diskusedpc > SageApi.GetIntProperty("nielm/diskbar_used_space_warn", 90))
		            out.print("<td bgcolor=\"#ffaa00\" title=\"Disk space used\" style=\"background-color:#ffaa00\" width=\""+Integer.toString(diskusedpc)+"%\">");
		        else
		            out.print("<td bgcolor=\"#00aa00\" title=\"Disk space used\" style=\"background-color:#00aa00\" width=\""+Integer.toString(diskusedpc)+"%\">");
		        out.println("&nbsp;</td>");
		    }
		    if ( diskreqpc>0 ){
		        if ( (diskusedpc+diskreqpc) > SageApi.GetIntProperty("nielm/diskbar_needed_space_warn", 95))
		        {
		            if ((diskusedpc+diskreqpc)>100){
		                diskreqpc=100-diskusedpc;
		                out.print("<td bgcolor=\"#b00100\" title=\"Disk space required\"  style=\"background-color:#b00100\" width=\""+Integer.toString((diskreqpc))+"%\">");
		                out.println("&nbsp;</td>");
		            }
		            else {
		                out.print("<td bgcolor=\"#b00100\" title=\"Disk space required\" style=\"background-color:#b00100\" width=\""+Integer.toString((diskreqpc))+"%\">");
		                out.println("&nbsp;</td>\r\n<td>&nbsp;</td>");
		            }
		        }
		        else {
		            out.print("<td bgcolor=\"#ffff00\" title=\"Disk space required\" style=\"background-color:#ffff00\" width=\""+Integer.toString((diskreqpc))+"%\">");
		            out.println("&nbsp;</td>\r\n<td>&nbsp;</td>");
		        }
		    } else {
		        out.println("<td>&nbsp;</td>");
		    }
		    out.println("</tr></table>");
		    
		    out.println("<ul><li>Available: " + fmt.format(diskavail) + " GB</li>");
		    out.println("<li>Used: " + fmt.format(diskused) + " GB");
            if ( (partialsFree && numpartials>0) || numautodelete > 0){
                out.print("<ul>");
    		    if ( partialsFree && numpartials>0) {
    		        out.print("<li><a href=\"Search?SearchString=&amp;searchType=TVFiles&amp;grouping=GetAiringTitle&amp;partials=only&amp;autodelete=any&amp;sort1=airdate_asc&amp;pagelen=" + GetOption(req, "pagelen", Integer.toString(AiringList.DEF_NUM_ITEMS)) + "\" ");
    		        out.println("title=\"Click this to show the autodeletable recordings that are partially recorded.\">[Partial Recordings]</a>: "  + numpartials + " recording" + (numpartials == 1 ? "" : "s") + " using " + fmt.format(partialsspace) + " GB</li>");
    		    }
    		    if (numautodelete > 0) {
    		        out.print("<li><a href=\"Search?SearchString=&amp;searchType=TVFiles&amp;grouping=GetAiringTitle&amp;partials=none&amp;autodelete=set&amp;sort1=airdate_asc&amp;pagelen=" + GetOption(req, "pagelen", Integer.toString(AiringList.DEF_NUM_ITEMS)) + "\" ");
    		        out.println("title=\"Click this to show the complete recordings that can be automatically deleted if more space is needed.\">[Auto-Delete Recordings]</a>: " + numautodelete + " recording" + (numautodelete == 1 ? "" : "s") + " using " + fmt.format(autodeletespace) + " GB</li>");
    		    }
                out.println("</ul>");
            }
		    out.print("</li><li>Next "+Long.toString(lookahead/3600000)+"hrs has "+Integer.toString(SageApi.Size(recordings))+" upcoming ");
		    if (SageApi.GetBooleanProperty("nielm/diskbar_lookahead_only_requested",true))
		        out.print("requested ");	
		    out.println("recordings requiring: " + fmt.format(diskneeded) + " GB");
		    out.println("</li><li>Total Video Content: " + fmt.format(((Long)SageApi.Api("GetTotalVideoDuration",null)).doubleValue()/3600000.0)+"hrs</li></ul>");

============================= --%>
      <%--
        -- Program Guide
        --%>
      <div class="section">Program Guide</div>
      <div class="sectionbody">
      <sageglbl:GetLastEPGDownloadTime var="lastEPGDownloadTimeLong"/>
      <sageutilfn:LongToDate var="lastEPGDownloadTime" value="${lastEPGDownloadTimeLong}"/>
      <sageglbl:GetTimeUntilNextEPGDownload var="nextEPGDownloadTimeLong"/>
      <sageutilfn:DecimalFormat var="nextEPGDownloadTimeFmt" value="${nextEPGDownloadTimeLong / 3600000}" format="0.00"/>
      <div class="divider">Last EPG Update</div>
      <div class="dividerbody">
         ${lastEPGDownloadTime}
      </div>
      <div class="divider">Next EPG Update</div>
      <div class="dividerbody">
         ${nextEPGDownloadTimeFmt} hours
         <form action="${cp}/m/Command" method="post">
            <input type="hidden" name="command" value="ForceEpgUpdate"/>
            <input type="hidden" name="returnto" value="${cp}/m/home.jsp"/>
            <button type="submit" value="ForceEpgUpdate">Force EPG Update</button> 
         </form>
      </div>
      </div>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
