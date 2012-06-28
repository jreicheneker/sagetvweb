<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagech" tagdir="/WEB-INF/tags/sage/api/channel" %> 
<%@ taglib prefix="sagedatefn" tagdir="/WEB-INF/tags/sage/functions/date" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sageshow" tagdir="/WEB-INF/tags/sage/api/show" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 
<%@ taglib prefix="sagecollfn" tagdir="/WEB-INF/tags/sage/functions/collections" %> 
<%@ taglib prefix="sagecapdevfn" tagdir="/WEB-INF/tags/sage/functions/capturedevice" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <sageutil:Time var="now"/>
   <sageutilfn:LongToDate var="nowDate" value="${now}"/>
   <c:choose>
      <c:when test="${empty param.StartHour}">
         <sageutilfn:SimpleDateFormat var="startHour" date="${nowDate}" format="H"/>
      </c:when>
      <c:otherwise>
         <c:set var="startHour" value="${param.StartHour}"/>
      </c:otherwise>
   </c:choose>
   <sageutilfn:ParseDate var="date" date="${param.StartDate}" hour="${startHour}"/>
   <c:choose>
      <c:when test="${empty param.TimeSpan}">
         <c:set var="timeSpan" value="1"/>
      </c:when>
      <c:otherwise>
         <c:set var="timeSpan" value="${param.TimeSpan}"/>
      </c:otherwise>
   </c:choose>
   <sageutilfn:DateToLong var="dateLong" value="${date}"/>
   <c:set var="periodStart" value="${dateLong - (dateLong % 3600000)}"/>
   <c:set var="periodEnd" value="${periodStart + 3600000 * timeSpan}"/>
   <sageutilfn:LongToDate var="startDate" value="${periodStart}"/>
   <sageutilfn:LongToDate var="endDate" value="${periodEnd}"/>
   <sageutil:DateFormat var="dayFmt" date="${date}" format="EEE, MMM d"/>
   <sageutil:PrintTimeShort var="periodStartFmt" time="${periodStart}"/>
   <sageutil:PrintTimeShort var="periodEndFmt" time="${periodEnd}"/>
   <title><c:if test="${!empty param.OnlyHDTV and param.OnlyHDTV}">HD </c:if>Listings - ${dayFmt}, ${periodStartFmt}</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>
   <c:choose>
      <c:when test="${!empty param.Category}">
         <jsp:include page="/WEB-INF/jspf/m/header.jspf">
            <jsp:param name="pageTitle" value="Category Listings" />
         </jsp:include>
      </c:when>
      <c:when test="${param.OnlyHDTV}">
         <jsp:include page="/WEB-INF/jspf/m/header.jspf">
            <jsp:param name="pageTitle" value="HD Listings" />
         </jsp:include>
      </c:when>
      <c:otherwise>
         <jsp:include page="/WEB-INF/jspf/m/header.jspf">
            <jsp:param name="pageTitle" value="Listings" />
         </jsp:include>
      </c:otherwise>
   </c:choose>
   
   <div class="subheader">
      ${dayFmt}<br/>${periodStartFmt} - ${periodEndFmt}
   </div>
<%--
TODO playing, recording, favorite that will record, and conflict icons<br/>
TODO bobphoenix's channel favorites<br/>
--%>
   <div class="content">
   <div class="listings">
   <table cellspacing="0" cellpadding="0">
      <tr>
         <td>
            <div class="optionstitle">Options</div>
         </td>
      </tr>
      <tr>
         <td>
            <div class="optionsbody">
            <form action="${cp}/m/listings.jsp" method="get">
                <table cellspacing="2">
                   <tr>
                      <td>
                         <select name="StartDate">
                            <sagedatefn:GetDayOfYear var="startDateDayOfYear" date="${startDate}"/>
                            <c:set var="dropDownDate" value="${nowDate}"/>
                            <sageutilfn:AddDayToDate var="dropDownDate" date="${dropDownDate}" days="-1"/>
                            <sageutil:DateFormat var="dropDownDateFmt" date="${dropDownDate}" format="EEE, MMM d"/>
                            <sageutilfn:SimpleDateFormat var="dropDownDateParamFmt" date="${dropDownDate}" format="yyyy/MM/dd"/>
                            <sagedatefn:GetDayOfYear var="dropDownDateDayOfYear" date="${dropDownDate}"/>
                            <option value="${dropDownDateParamFmt}" <c:if test="${startDateDayOfYear == dropDownDateDayOfYear}">selected="selected" style="font-weight: bold;"</c:if>>
                               Yesterday, ${dropDownDateFmt}
                            </option>
                            <sageutilfn:AddDayToDate var="dropDownDate" date="${dropDownDate}" days="1"/>
                            <sageutil:DateFormat var="dropDownDateFmt" date="${dropDownDate}" format="EEE, MMM d"/>
                            <sageutilfn:SimpleDateFormat var="dropDownDateParamFmt" date="${dropDownDate}" format="yyyy/MM/dd"/>
                            <sagedatefn:GetDayOfYear var="dropDownDateDayOfYear" date="${dropDownDate}"/>
                            <option value="${dropDownDateParamFmt}" <c:if test="${startDateDayOfYear == dropDownDateDayOfYear}">selected="selected" style="font-weight: bold;"</c:if>>
                               Today, ${dropDownDateFmt}
                            </option>
                            <sageutilfn:AddDayToDate var="dropDownDate" date="${dropDownDate}" days="1"/>
                            <sageutil:DateFormat var="dropDownDateFmt" date="${dropDownDate}" format="EEE, MMM d"/>
                            <sageutilfn:SimpleDateFormat var="dropDownDateParamFmt" date="${dropDownDate}" format="yyyy/MM/dd"/>
                            <sagedatefn:GetDayOfYear var="dropDownDateDayOfYear" date="${dropDownDate}"/>
                            <option value="${dropDownDateParamFmt}" <c:if test="${startDateDayOfYear == dropDownDateDayOfYear}">selected="selected" style="font-weight: bold;"</c:if>>
                               Tomorrow, ${dropDownDateFmt}
                            </option>
                            <c:forEach begin="1" end="11">
                               <sageutilfn:AddDayToDate var="dropDownDate" date="${dropDownDate}" days="1"/>
                               <sageutil:DateFormat var="dropDownDateFmt" date="${dropDownDate}" format="EEE, MMM d"/>
                               <sageutilfn:SimpleDateFormat var="dropDownDateParamFmt" date="${dropDownDate}" format="yyyy/MM/dd"/>
                               <sagedatefn:GetDayOfYear var="dropDownDateDayOfYear" date="${dropDownDate}"/>
                               <option value="${dropDownDateParamFmt}" <c:if test="${startDateDayOfYear == dropDownDateDayOfYear}">selected="selected" style="font-weight: bold;"</c:if>>
                                  ${dropDownDateFmt}
                               </option>
                            </c:forEach>
                         </select>
                      </td>
                   </tr>
                   <tr>
                      <td>
                         <select name="StartHour">
                            <sageutilfn:SimpleDateFormat var="nowHour" date="${nowDate}" format="H"/>
                            <c:forEach begin="0" end="23" varStatus="varStatus">
                               <sagedatefn:GetDate var="hourOfDay" hour="${varStatus.index}" minute="0" second="0" millisecond="0"/>
                               <sageutilfn:DateToLong var="hourOfDayLong" value="${hourOfDay}"/>
                               <sageutil:PrintTimeShort var="hourOfDayFmt" time="${hourOfDayLong}"/>
                               <option value="${varStatus.index}" <c:if test="${varStatus.index == startHour}">selected="selected" style="font-weight: bold;"</c:if>>
                                  <c:if test="${varStatus.index == nowHour}">Now, </c:if>${hourOfDayFmt}
                               </option>
                            </c:forEach>
                         </select>
                      </td>
                   </tr>
                   <tr>
                      <td>
                         <select name="TimeSpan">
                            <c:set var="maxTimeSpan" value="${24}"/><%-- coerce to a number --%>
                            <c:if test="${timeSpan > maxTimeSpan}">
                               <c:set var="maxTimeSpan" value="${timeSpan}"/>
                            </c:if>
                            <c:forEach begin="1" end="${maxTimeSpan}" varStatus="varStatus">
                               <option value="${varStatus.index}" <c:if test="${varStatus.index == timeSpan}">selected="selected" style="font-weight: bold;"</c:if>>
                                  ${varStatus.index} hour<c:if test="${varStatus.index != 1}">s</c:if>
                               </option>
                            </c:forEach>
                         </select>
                      </td>
                   </tr>
                   <c:if test="${param.CategoryFilter == 'yes'}">
                   <tr>	
                      <td>
                         <sagedb:GetAllCategories var="categories" /> <!-- TODO call API with media mask -->
                         <sagedb:Sort var="categories" data="${categories}" descending="false" sortTechnique="Natural"/>
                         <select name="Category" size="5" multiple="multiple">
                            <sagecollfn:ArrayToList var="categoryList" array="${paramValues.Category}"/>
                            <!--option value="Any" <c:if test="${empty categoryList}">selected="selected" style="font-weight: bold;"</c:if>>
                               Any
                            </option-->
                            <c:forEach items="${categories}" var="category">
                               <sagecollfn:ListContains var="isCategorySelected" list="${categoryList}" value="${category}"/>
                               <option value="${category}" <c:if test="${isCategorySelected}">selected="selected" style="font-weight: bold;"</c:if>>
                                  ${category}
                               </option>
                            </c:forEach>
                         </select>
                      </td>
                   </tr>
                   </c:if>
                   <tr>
                      <td>
                         <c:if test="${!empty param.OnlyHDTV}">
                            <input type="hidden" name="OnlyHDTV" value="${param.OnlyHDTV}"/>
                         </c:if>
                         <c:if test="${!empty param.CategoryFilter}">
                            <input type="hidden" name="CategoryFilter" value="${param.CategoryFilter}"/>
                         </c:if>
                         <button type="submit" value="Change Date">Update</button>
                      </td>
                   </tr>
                </table>
            </form>
            </div>
         </td>
      </tr>

      <tr>
         <td colspan="2">
            <div class="optionstitle">Listings</div>
         </td>
      </tr>
<%-- TODO Try to filter earlier so a "No airings found" message can be shown --%>
      <sagedb:GetAiringsOnViewableChannelsAtTime var="airings" startTime="${periodStart}" endTime="${periodEnd}" mustStartDuringTime="false"/>

      <sagech:GetAllChannels var="channels" />
      <sagedb:FilterByBoolMethod var="channels" data="${channels}" matchValue="true" method="IsChannelViewable"/>
      <sagedb:Sort var="channels" data="${channels}" descending="false" sortTechnique="ChannelNumber"/>

      <tr>
         <td>
            <table cellspacing="0" cellpadding="2" width="100%">
               <c:forEach var="channel" items="${channels}">
                  <sagedb:GetAiringsOnChannelAtTime var="airings" channel="${channel}" startTime="${periodStart}" endTime="${periodEnd}" mustStartDuringTime="false"/>
                  <c:if test="${param.OnlyHDTV}">
                     <sagedb:FilterByBoolMethod var="airings" data="${airings}" matchValue="true" method="IsAiringHDTV"/>
                  </c:if>

                  <c:if test="${not empty paramValues.Category}">                  
                     <c:forEach items="${paramValues.Category}" var="currentCategory">
                        <%--sagedb:DataUnion var="currentCategoryAirings" dataSet1="${searchResults}" dataSet2=""/--%>
                        <sagedb:FilterByMethod var="filteredCategory" data="${airings}" method="GetShowCategory" matchValue="${currentCategory}" matchedPasses="true"/>
                        <sagedb:FilterByMethod var="filteredSubCategory" data="${airings}" method="GetShowSubCategory" matchValue="${currentCategory}" matchedPasses="true"/>
                        <sagedb:DataUnion var="allFiltered" dataSet1="${allFiltered}" dataSet2="${filteredCategory}"/>
                        <sagedb:DataUnion var="allFiltered" dataSet1="${allFiltered}" dataSet2="${filteredSubCategory}"/>
                     </c:forEach>
                     <c:set var="airings" value="${allFiltered}"/>
                     <c:remove var="allFiltered"/>
                  </c:if>

                  <sageutil:Size var="airingCount" data="${airings}"/>
                  <%--allConflicts=SageApi.Api("GetAiringsThatWontBeRecorded",new Object[]{Boolean.FALSE});
                  unresolvedConflicts=SageApi.Api("GetAiringsThatWontBeRecorded",new Object[]{Boolean.TRUE});--%>
                  <sagech:GetChannelName var="channelName" channel="${channel}" />
                  <sagech:GetChannelNumber var="channelNumber" channel="${channel}" />

                  <c:if test="${airingCount == 0}">
                     <%-- No airings found --%>
                  </c:if>
                  <c:if test="${airingCount > 0}">
                     <c:forEach var="airing" items="${airings}" varStatus="varStatus">
                     <%-- listingcell.jspf --%>
                        <sageair:GetAiringID var="airingId" airing="${airing}"/>
                        <sageair:GetAiringTitle var="airingTitle" airing="${airing}"/>
                        <sageshow:GetShowEpisode var="episode" show="${airing}"/>
                        <sageshow:GetShowCategory var="category" show="${airing}"/>
                        <sageshow:GetShowSubCategory var="subcategory" show="${airing}"/>
                        <sageshow:GetShowExternalID var="showId" show="${airing}"/>

                        <c:set var="categoryclass" value=""/>
                        <c:set var="subcategoryclass" value=""/>
                        <c:if test="${!empty category && showId != 'NoShow'}">
                           <c:set var="categoryclass" value="category_${fn:toLowerCase(category)}"/>
                           <c:set var="categoryclass" value="${fn:replace(categoryclass, ' ', '')}"/>
                           <c:set var="categoryclass" value="${fn:replace(categoryclass, '-', '')}"/>
                           <c:if test="${!empty subcategory}">
                              <c:set var="subcategoryclass" value="${fn:toLowerCase(subcategory)}"/>
                              <c:set var="subcategoryclass" value="${fn:replace(subcategoryclass, ' ', '')}"/>
                              <c:set var="subcategoryclass" value="${fn:replace(subcategoryclass, ' ', '-')}"/>
                              <c:set var="subcategoryclass" value="${categoryclass}-${subcategoryclass}"/>
                           </c:if>
                        </c:if>
                        <sageair:IsWatched var="isWatched" airing="${airing}"/>
                        <sageair:GetMediaFileForAiring var="mediaFile" airing="${airing}"/>
                        <sageair:GetAiringStartTime var="airingStartTime" airing="${airing}"/>
                        <sageair:GetAiringEndTime var="airingEndTime" airing="${airing}"/>
                        <sageutil:PrintTimeShort var="airingStartTimeFmt" time="${airingStartTime}"/>
                        <sageutil:PrintTimeShort var="airingEndTimeFmt" time="${airingEndTime}"/>
                        <c:url var="detailUrl" value="details.jsp">
                           <c:param name="AiringId" value="${airingId}"></c:param>
                        </c:url>
                        <tr>
                           <c:if test="${varStatus.index == 0}">
                           <td class="channelcell" rowspan="${airingCount}">
                              ${channelNumber}<br/>${channelName}
                           </td>
                           </c:if>
                           <td class="showcell category_other ${categoryclass} ${subcategoryclass}">
                           <%--td class="category_other ${categoryclass} ${subcategoryclass}" style="border: 1px solid #FFFFFF; color: #6E91B4;"--%>
                              <div class="title<c:if test="${isWatched}"> watched</c:if>"><a href="${detailUrl}">${airingTitle}</a></div>
                              <c:if test="${!empty mediaFile}">
                                 <sagemf:IsFileCurrentlyRecording var="isFileRecording" mediaFile="${mediaFile}"/>
                                 <c:if test="${isFileRecording}">
                                    <img src="${cp}/images/RecordingNowMobile.png" alt="This show is currently recording." title="This show is currently recording."/>
                                 </c:if>
                              </c:if>
                              <c:if test="${!empty episode}"><p style="margin: 0px;">${episode}</p></c:if>
                              <p style="margin: 0px;"><%@ include file="/WEB-INF/jspf/m/markers.jspf" %></p>
                              <p style="margin: 0px;">${airingStartTimeFmt} - ${airingEndTimeFmt}</p>
                              <sagecapdevfn:GetScheduledEncoder var="scheduledEncoder" airing="${airing}"/>
                              <c:if test="${!empty scheduledEncoder}"><p>${scheduledEncoder}</p></c:if>
                           </td>
                        </tr>
                     </c:forEach>
                  </c:if>
               </c:forEach>
            </table>
         </td>
      </tr>
   </table>
   </div> <%-- listings --%>
   </div> <%-- content --%>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
