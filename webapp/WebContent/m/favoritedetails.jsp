<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sagefavfn" tagdir="/WEB-INF/tags/sage/functions/favorite" %> 
<%@ taglib prefix="sagech" tagdir="/WEB-INF/tags/sage/api/channel" %> 
<%@ taglib prefix="sagecollfn" tagdir="/WEB-INF/tags/sage/functions/collections" %> 
<%@ taglib prefix="sageconf" tagdir="/WEB-INF/tags/sage/api/configuration" %> 
<%@ taglib prefix="sageconffn" tagdir="/WEB-INF/tags/sage/functions/configuration" %> 
<%@ taglib prefix="sagechfn" tagdir="/WEB-INF/tags/sage/functions/channel" %> 
<%@ taglib prefix="sagetc" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <c:set var="isNew" value="${empty param.FavoriteId}"/>
   <c:if test="${isNew}">
      <c:choose>
         <c:when test="${param.AddCategory != null}">
            <c:set var="favoriteCategory" value="${param.AddCategory}"/>
         </c:when>
         <c:when test="${param.AddTitle != null}">
            <c:set var="favoriteTitle" value="${param.AddTitle}"/>
         </c:when>
         <c:when test="${param.AddKeyword != null}">
            <c:set var="favoriteKeyword" value="${param.AddKeyword}"/>
         </c:when>
         <c:when test="${param.AddPerson != null}">
            <c:set var="favoritePerson" value="${param.AddPerson}"/>
         </c:when>
         <c:otherwise>
         <%--
		                        out.println("<title>New Favorite</title></head>");
		                        out.println("<body>");
		                        printTitle(out,"Error");
		                        out.println("<div id=\"content\">");
		                        out.println("<h3>Category, title, keyword, or person required for new favorite.</h3>");
		                        out.println("</div>");
		                        printMenu(req,out);
		                        out.println("</body></html>");
		                        out.close();
		                        return;
		 --%>
         </c:otherwise>
      </c:choose>
      <c:set var="favoriteStartPadding" value="0"/>
      <c:set var="favoriteStopPadding" value="0"/>
      <c:set var="favoriteStartPaddingFmt" value="0"/>
      <c:set var="favoriteStopPaddingFmt" value="0"/>
      <title>New Favorite</title>
   </c:if>
   <c:if test="${!isNew}">
      <sagefav:GetFavoriteForID var="favorite" favoriteID="${param.FavoriteId}" />
      <sagefav:GetFavoriteDescription var="favoriteDescription" favorite="${favorite}" />
      <sagefav:GetFavoriteCategory var="favoriteCategory" favorite="${favorite}" />
      <sagefav:GetFavoriteTitle var="favoriteTitle" favorite="${favorite}" />
      <sagefav:GetFavoriteKeyword var="favoriteKeyword" favorite="${favorite}" />
      <sagefav:GetFavoritePerson var="favoritePerson" favorite="${favorite}" />
      <sagefav:IsFirstRunsOnly var="favoriteIsFirstRunsOnly" favorite="${favorite}" />
      <sagefav:IsReRunsOnly var="favoriteIsReRunsOnly" favorite="${favorite}" />
      <sagefav:GetFavoriteChannel var="favoriteChannel" favorite="${favorite}" />
      <sageutilfn:SplitString var="favoriteChannelList" value="${favoriteChannel}" token="[;,]" />
      <sagecollfn:ArrayToList var="favoriteChannelList" array="${favoriteChannelList}" />
      <sagefav:IsAutoDelete var="favoriteIsAutoDelete" favorite="${favorite}" />
      <sagefav:GetKeepAtMost var="favoriteKeepAtMost" favorite="${favorite}" />
      <sagefav:GetStartPadding var="favoriteStartPadding" favorite="${favorite}" />
      <sagefav:GetStopPadding var="favoriteStopPadding" favorite="${favorite}" />
      <sageutilfn:DecimalFormat var="favoriteStartPaddingFmt" value="${favoriteStartPadding / 60000}" format="###0"/>
      <sageutilfn:DecimalFormat var="favoriteStopPaddingFmt" value="${favoriteStopPadding / 60000}" format="###0"/>
      <c:if test="${favoriteStartPaddingFmt < 0}">
         <c:set var="favoriteStartPaddingFmt" value="${-favoriteStartPaddingFmt}"/>
      </c:if>
      <c:if test="${favoriteStopPaddingFmt < 0}">
         <c:set var="favoriteStopPaddingFmt" value="${-favoriteStopPaddingFmt}"/>
      </c:if>
      <sagefav:GetFavoriteQuality var="favoriteQuality" favorite="${favorite}" />
      <sagefavfn:SupportsFavoriteAutoConversion var="supportsFavoriteAutoConversion"/>
      <c:if test="${supportsFavoriteAutoConversion}">
         <sagefav:IsDeleteAfterAutomaticConversion var="isDeleteAfterFavoriteAutomaticConversion" favorite="${favorite}"/>
         <sagefav:GetFavoriteAutomaticConversionFormat var="favoriteAutomaticConversionFormat" favorite="${favorite}"/>
         <sagefav:GetFavoriteAutomaticConversionDestination var="favoriteAutomaticConversionDestination" favorite="${favorite}"/>
         <sageutilfn:ToString var="favoriteAutomaticConversionDestinationString" value="${favoriteAutomaticConversionDestination}"/>
      </c:if>
      <sagefav:GetFavoriteParentalRating var="favoriteParentalRating" favorite="${favorite}" />
      <sagefav:GetFavoriteRated var="favoriteRated" favorite="${favorite}" />
      <sagefav:GetFavoriteTimeslot var="favoriteTimeslot" favorite="${favorite}" />
      <title>"${favoriteDescription}" Favorite Details</title>
   </c:if>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <c:if test="${isNew}">
      <jsp:include page="/WEB-INF/jspf/m/header.jspf">
         <jsp:param name="pageTitle" value="New Favorite" />
      </jsp:include>
   </c:if>
   <c:if test="${!isNew}">
      <jsp:include page="/WEB-INF/jspf/m/header.jspf">
         <jsp:param name="pageTitle" value="Favorite Details" />
      </jsp:include>
   </c:if>

   <div class="content">
   <form method="post" action="${cp}/m/Command">
      <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
      <c:if test="${isNew}">
         <input type="hidden" name="command" value="AddFavorite"/>
         <input type="hidden" name="returnto" value="${cp}/m/favorites.jsp"/>
      </c:if>
      <c:if test="${!isNew}">
         <input type="hidden" name="command" value="UpdateFavorite"/>
         <input type="hidden" name="returnto" value="${cp}/m/favoritedetails.jsp?${pageContext.request.queryString}"/>
      </c:if>
      <c:if test="${isNew}">
         <div class="title">New Favorite</div>
      </c:if>
      <c:if test="${!isNew}">
         <div class="title">Favorite: ${favoriteDescription}</div>
      </c:if>

      <div class="details">
      <c:choose>
         <%--
           -- Category - read-only if favorite exists
           -- New Favorite: Category will be non-null if it is the type being added
           -- Existing Favorite: Category must be non-null and not "" if it's a Category favorite
         --%>
         <c:when test="${isNew and favoriteCategory != null or !isNew and !empty favoriteCategory}">
            <div class="label">Category:<c:if test="${!isNew}"> ${favoriteCategory}</c:if></div>
            <div class="value">
               <c:if test="${isNew}">
                  <sagedb:GetAllCategories var="categories"/>
                  <%-- see the DataUnion workaround for titles, not sure if it applies here... but just in case --%>
                  <sagedb:DataUnion var="categories" dataSet1="${category}" dataSet2="${categories}"/>
                  <sagedb:Sort var="categories" data="${categories}" descending="false" sortTechnique="CaseInsensitive"/>
                  <select name="Category">
                     <c:forEach items="${categories}" var="currentCategory">
                        <option value="${currentCategory}" <c:if test="${currentCategory == favoriteCategory}">selected="selected" style="font-weight: bold;"</c:if>>${currentCategory}</option>
                     </c:forEach>
                  </select>
               </c:if>
               <c:if test="${!isNew}">
                  <input type="hidden" name="Category" value="${favoriteCategory}"/>
               </c:if>
            </div>
         </c:when>
         <%--
           -- Title - read-only if favorite exists
           -- New Favorite: Title will be non-null if it is the type being added
           -- Existing Favorite: Title must be non-null and not "" if it's a Title favorite
           --%>
         <c:when test="${isNew and favoriteTitle != null or !isNew and !empty favoriteTitle}">
            <div class="label">Title:</div>
            <div class="value">
               <c:if test="${!isNew}">
                  ${favoriteTitle}
                  <input type="hidden" name="Title" value="${favoriteTitle}"/>
               </c:if>
               <c:if test="${isNew}">
                  <sagedb:SearchForTitles var="titles" searchString=""/><%-- does not return all titles --%>
                  <sagedb:DataUnion var="titles" dataSet1="${favoriteTitle}" dataSet2="${titles}"/><%-- make sure the title is in the list in case "SearchForTitles" does not return it --%>
                  <sagedb:Sort var="titles" data="${titles}" descending="false" sortTechnique="CaseInsensitive"/>
                  <select name="Title">
                     <c:forEach items="${titles}" var="currentTitle">
                        <option value="${currentTitle}" <c:if test="${favoriteTitle == currentTitle}">selected="selected" style="font-weight: bold;"</c:if>>${currentTitle}</option>
                     </c:forEach>
                  </select>
               </c:if>
            </div>
         </c:when>
         <%--
		   -- Keyword - updateable for new or existing favorite
		   -- New Favorite: Keyword will be non-null if it is the type being added
		   -- Existing Favorite: Keyword must be non-null and not "" if it's a Keyword favorite
		 --%>
         <c:when test="${isNew and favoriteKeyword != null or !isNew and !empty favoriteKeyword}">
            <div class="label">Keyword:</div>
		    <div class="value">
               <input type="text" size="30" name="Keyword" value="${favoriteKeyword}"/>
		    </div>
         </c:when>
         <%--
           -- Person (Actor) - read-only if favorite exists
           -- New Favorite: Person will be non-null if it is the type being added
           -- Existing Favorite: Person must be non-null and not "" if it's a Person favorite
           --%>
         <c:when test="${isNew and favoritePerson != null or !isNew and !empty favoritePerson}">
            <div class="label">Person: ${favoritePerson}</div>
            <div class="value">
               <c:if test="${!isNew}">
                  ${favoritePerson}
                  <input type="hidden" name="Person" value="${favoritePerson}"/>
               </c:if>
               <c:if test="${isNew}">
                  <sagedb:SearchForPeople var="people" searchString=""/>
                  <sagedb:DataUnion var="people" dataSet1="${person}" dataSet2="${people}"/><%-- see the DataUnion workaround for titles, not sure if it applies here... but just in case --%>
                  <sagedb:Sort var="people" data="${people}" descending="false" sortTechnique="CaseInsensitive"/>
                  <select name="Person">
                     <c:forEach items="${people}" var="currentPerson">
                        <option value="${currentPerson}" <c:if test="${favoritePerson == currentPerson}">selected="selected" style="font-weight: bold;"</c:if>>${currentPerson}</option>
                     </c:forEach>
                  </select>
               </c:if>
   	        </div>
         </c:when>
      </c:choose>
      <div class="label">First Runs and ReRuns:</div>
      <div class="value">
         <select name="Run">
            <option value="First Runs" <c:if test="${favoriteIsFirstRunsOnly and !favoriteIsReRunsOnly}">selected="selected" style="font-weight: bold;"</c:if>>First Runs</option>
            <option value="ReRuns" <c:if test="${!favoriteIsFirstRunsOnly and favoriteIsReRunsOnly}">selected="selected" style="font-weight: bold;"</c:if>>ReRuns</option>
            <option value="First Runs and ReRuns" <c:if test="${!favoriteIsFirstRunsOnly and !favoriteIsReRunsOnly}">selected="selected" style="font-weight: bold;"</c:if>>First Runs and ReRuns</option>
         </select>
      </div>
      <div class="label">Channels:</div>
      <div class="value">
         <sagech:GetAllChannels var="channels"/>
         <sagedb:Sort var="channels" data="${channels}" descending="false" sortTechnique="ChannelNumber"/>
         <select name="ChannelId" multiple="multiple" size="10">
            <option value="" <c:if test="${empty favoriteChannelList}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
            <c:forEach items="${channels}" var="currentChannel">
               <sagech:IsChannelViewable var="isChannelViewable" channel="${currentChannel}"/>
               <c:if test="${isChannelViewable}">
                  <sagech:GetStationID var="stationId" channel="${currentChannel}"/>
                  <sagech:GetChannelName var="channelName" channel="${currentChannel}"/>
                  <sagech:GetChannelNumber var="channelNumber" channel="${currentChannel}"/>
                  <sagech:GetChannelNetwork var="channelNetwork" channel="${currentChannel}"/>
                  <sagecollfn:ListContains var="isFavoriteChannel" value="${channelName}" list="${favoriteChannelList}"/>
                  <option value="${stationId}" <c:if test="${isFavoriteChannel}">selected="selected" style="font-weight: bold;"</c:if>>${channelNumber} -- ${channelName} -- ${channelNetwork}</option>
               </c:if>
            </c:forEach>
         </select>
      </div>
      <div class="label">Auto Delete:</div>
      <div class="value">
         <select name="AutoDelete">
            <option value="true" <c:if test="${favoriteIsAutoDelete}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
            <option value="false" <c:if test="${!favoriteIsAutoDelete}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
         </select>
      </div>
      <div class="label">Keep At Most:</div>
      <div class="value">
         <select name="KeepAtMost">
            <option value="0" <c:if test="${favoriteKeepAtMost == 0}">selected="selected" style="font-weight: bold;"</c:if>>All</option>
            <c:forEach begin="1" end="63" varStatus="varStatus">
               <option value="${varStatus.index}" <c:if test="${favoriteKeepAtMost == varStatus.index}">selected="selected" style="font-weight: bold;"</c:if>>${varStatus.index}</option>
            </c:forEach>
         </select>
      </div>
      <div class="label">Start Padding:</div>
      <div class="value">
         <input type="text" size="3" name="StartPadding" value="${favoriteStartPaddingFmt}"/> minutes
      </div>
      <div class="value">
         <select name="StartPaddingOffsetType">
		    <option value="Earlier" <c:if test="${favoriteStartPadding >= 0}">selected="selected" style="font-weight: bold;"</c:if>>Earlier</option>
		    <option value="Later" <c:if test="${favoriteStartPadding < 0}">selected="selected" style="font-weight: bold;"</c:if>>Later</option>
         </select>
      </div>
      <div class="label">End Padding:</div>
      <div class="value">
         <input type="text" size="3" name="StopPadding" value="${favoriteStopPaddingFmt}"/> minutes
      </div>
      <div class="value">
         <select name="StopPaddingOffsetType">
		    <option value="Earlier" <c:if test="${favoriteStopPadding < 0}">selected="selected" style="font-weight: bold;"</c:if>>Earlier</option>
		    <option value="Later" <c:if test="${favoriteStopPadding >= 0}">selected="selected" style="font-weight: bold;"</c:if>>Later</option>
         </select>
      </div>
      <div class="label">Quality:</div>
      <div class="value">
         <sageconf:GetRecordingQualities var="recordingQualities"/>
         <sageconf:GetDefaultRecordingQuality var="defaultQuality"/>
         <select name="Quality">
            <option value="Default" <c:if test="${empty favoriteQuality or favoriteQuality == 'Default'}">selected="selected" style="font-weight: bold;"</c:if>>
               <sageconffn:GetRecordingQualityDescription var="qualityDescription" recordingquality="${defaultQuality}"/>
               Default: ${qualityDescription}
            </option>
            <c:forEach items="${recordingQualities}" var="recordingQuality">
               <option value="recordingQuality" <c:if test="${recordingQuality == favoriteQuality}">selected="selected" style="font-weight: bold;"</c:if>>
                  <sageconffn:GetRecordingQualityDescription var="qualityDescription" recordingquality="${recordingQuality}"/>
                  ${qualityDescription}
               </option>
            </c:forEach>
         </select>
      </div>
      <c:if test="${supportsFavoriteAutoConversion}">
      <c:set var="isAutomaticConversion" value="${not empty favoriteAutomaticConversionFormat}"/>
      <sageconf:GetProperty var="lastReplaceChoice" propertyName="transcoder/last_replace_choice" defaultValue="xKeepBoth"/>
      <sageconf:GetProperty var="lastFormatName"    propertyName="transcoder/last_format_name" defaultValue="<%= null %>"/>
      <sageconf:GetProperty var="lastFormatQuality" propertyName="transcoder/last_format_quality/${lastFormatName}" defaultValue="<%= null %>"/>
      <sageconf:GetProperty var="lastDestDir"       propertyName="transcoder/last_dest_dir" defaultValue="<%= null %>"/>
      <%--sageconf:GetProperty var="sortingOrder"      propertyName="transcoder/sorting_order" defaultValue="iPod;iPhone;DVD;MPEG4;MPEG4 HDTV;AppleTV;PSP;Razr"/--%>

      <c:if test="${!isAutomaticConversion}">
         <%-- last format quality --%>
         <c:set var="favoriteAutomaticConversionFormat" value="${lastFormatQuality}"/>

         <%-- last replace choice --%>
         <c:choose>
            <c:when test="${lastReplaceChoice == 'xKeepOnlyConversion'}">
               <c:set var="isDeleteAfterFavoriteAutomaticConversion" value="true"/>
            </c:when>
            <c:otherwise>
               <c:set var="isDeleteAfterFavoriteAutomaticConversion" value="false"/>
            </c:otherwise>
         </c:choose>

         <%-- last dest dir --%>
         <c:set var="favoriteAutomaticConversionDestinationString" value="${lastDestDir}"/>
      </c:if>

      <div class="label">Automatic Conversion:</div>
      <div class="value">
         <select name="AutoConvert">
            <option value="true"<c:if test="${isAutomaticConversion}"> selected="selected"</c:if>>Yes</option>
            <option value="false"<c:if test="${!isAutomaticConversion}"> selected="selected"</c:if>>No</option>
         </select>
         <div class="label">Format:</div>
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
                  <option value="${formatName}"<c:if test="${(status.index == 0 and empty favoriteAutomaticConversionFormat) or formatName == favoriteAutomaticConversionFormat}"> selected="selected"</c:if>>${formatName}</option>
               </c:forEach>
               <%--c:if test="${!empty formatGroup}">
                  </optgroup>
               </c:if--%>
            </select>
         </div>
         <div class="label">Original File:</div>
         <div class="value">
            <input type="radio" name="DeleteOriginal" value="yes"<c:if test="${isDeleteAfterFavoriteAutomaticConversion}"> checked="checked"</c:if>>Delete Original File<br/>
            <input type="radio" name="DeleteOriginal" value="no" id="NoDeleteOriginal"<c:if test="${!isDeleteAfterFavoriteAutomaticConversion}"> checked="checked"</c:if>>Keep Original File
         </div>
         <div class="label">Destination Folder:</div>
         <div class="value">
            <input type="radio" name="Folder" value="Original"<c:if test="${favoriteAutomaticConversionDestinationString == null}"> checked="checked"</c:if>/>Use Original Folder<br/>
            <input type="radio" name="Folder" value="Destination"<c:if test="${favoriteAutomaticConversionDestinationString != null}"> checked="checked"</c:if>/>Set Destination Folder<br/>
            <div class="value"><input type="text" name="DestinationFolder" value="<c:if test="${favoriteAutomaticConversionDestinationString != null}">${favoriteAutomaticConversionDestinationString}</c:if>"/></div>
         </div>
      </div>
      </c:if>
      <div class="label">Parental Rating:</div>
      <div class="value">
         <select name="ParentalRating">
            <option value="" <c:if test="${empty favoriteParentalRating}">selected="selected" style="font-weight: bold;"</c:if>>
               Any
            </option>
		    <sagefavfn:GetParentalRatings var="parentalRatings"/>
		    <c:forEach items="${parentalRatings}" var="currentParentalRating">
               <option value="${currentParentalRating}" <c:if test="${currentParentalRating == favoriteParentalRating}">selected="selected" style="font-weight: bold;"</c:if>>${currentParentalRating}</option>
		    </c:forEach>
         </select>
      </div>
      <div class="label">Rated:</div>
      <div class="value">
         <select name="MovieRating">
            <option value="" <c:if test="${empty favoriteRated}">selected="selected" style="font-weight: bold;"</c:if>>
               Any
            </option>
		    <sagefavfn:GetMovieRatings var="movieRatings"/>
		    <c:forEach items="${movieRatings}" var="currentMovieRating">
               <option value="${currentMovieRating}" <c:if test="${currentMovieRating == favoriteRated}">selected="selected" style="font-weight: bold;"</c:if>>${currentMovieRating}</option>
		    </c:forEach>
         </select>
      </div>
      <div class="label">Time Slot:</div>
      <div class="value">
         Day:
         <sagefavfn:GetDaysOfWeek var="daysOfWeek"/>
         <c:forEach items="${daysOfWeek}" var="dayOfWeek">
            <c:if test="${fn:containsIgnoreCase(favoriteTimeslot, dayOfWeek)}">
               <c:set var="favoriteDay" value="${dayOfWeek}"/>
            </c:if>
         </c:forEach>
         <select name="Day">
            <option value="" <c:if test="${empty favoriteDay}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
            <c:forEach items="${daysOfWeek}" var="dayOfWeek">
               <option value="${dayOfWeek}" <c:if test="${favoriteDay == dayOfWeek}">selected="selected" style="font-weight: bold;"</c:if>>${dayOfWeek}</option>
            </c:forEach>
         </select>
      </div>
      <div class="value">
         Time:
         <c:choose>
            <c:when test="${fn:contains(favoriteTimeslot, ':')}">
               <sagefavfn:GetTimes24 var="times"/>
            </c:when>
            <c:otherwise>
               <sagefavfn:GetTimesAMPM var="times"/>
            </c:otherwise>
         </c:choose>
         <c:forEach items="${times}" var="time">
            <c:if test="${fn:containsIgnoreCase(favoriteTimeslot, time)}">
               <c:set var="favoriteTime" value="${time}"/>
            </c:if>
         </c:forEach>
         <select name="Time">
            <option value="" <c:if test="${empty favoriteTime}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
            <c:forEach items="${times}" var="time">
               <option value="${time}" <c:if test="${favoriteTime == time}">selected="selected" style="font-weight: bold;"</c:if>>${time}</option>
            </c:forEach>
         </select>
      </div>
      <sagefav:GetFavorites var="favorites"/>
      <sagedb:Sort var="favorites" data="${favorites}" descending="false" sortTechnique="FavoritePriority"/>
      <sageutil:Size var="favoritesSize" data="${favorites}"/>
      <c:if test="${favoritesSize > 0}">
         <sageutil:GetElement var="firstFavorite" data="${favorites}" index="${0}"/>
         <sagefav:GetFavoriteID var="firstFavoriteId" favorite="${firstFavorite}"/>
         <sageutil:GetElement var="lastFavorite" data="${favorites}" index="${favoritesSize - 1}"/>
         <sagefav:GetFavoriteID var="lastFavoriteId" favorite="${lastFavorite}"/>
      </c:if>
      <c:set var="isLastFavorite" value="${!empty favorite and !empty lastFavorite and param.FavoriteId == lastFavoriteId}"/>
      <%-- if there are favorites and this is not the only favorite --%>
      <c:if test="${((favoritesSize > 0) and !((favoritesSize == 1) and favorite != null and param.FavoriteId == firstFavoriteId))}">
         <c:if test="${!empty favorite}">
            <sagefavfn:GetFavoritePriority var="favoritePriority" favorite="${favorite}"/>
         </c:if>
         <div class="label">Priority:</div>
         <div class="value">
            <select name="FavoritePriorityRelation">
               <c:if test="${isNew}">
                  <option value="default" selected="selected">Default</option>
               </c:if>
               <option value="Above" <c:if test="${!isNew and !isLastFavorite}">selected="selected" style="font-weight: bold;"</c:if>>Above</option>
               <option value="Below" <c:if test="${!isNew and isLastFavorite}">selected="selected" style="font-weight: bold;"</c:if>>Below</option>
            </select>
         </div>
         <div class="value">
            <select name="RelativeFavoriteId">
               <c:if test="${isNew}"><option value="-1" selected="selected"></option></c:if>
               <c:forEach items="${favorites}" var="currentFavorite" varStatus="varStatus">
                  <sagefav:GetFavoriteID var="currentFavoriteId" favorite="${currentFavorite}"/>
		          <%-- don't put this favorite in the list --%>
		          <c:if test="${empty favorite or param.FavoriteId != currentFavoriteId}">
		             <sagefav:GetFavoriteDescription var="favoriteDescription" favorite="${currentFavorite}"/>
		             <%-- select the current priority if it's after the selected priority or 
		                 select the current priority if the selected priority is the lowest and the current one is just before it --%>
                     <option value="${currentFavoriteId}" <c:if test="${!isNew and (varStatus.index == favoritePriority) or (isLastFavorite and (varStatus.index == favoritesSize - 2))}">selected="selected" style="font-weight: bold;"</c:if>>${varStatus.index + 1}. ${favoriteDescription}</option>
                  </c:if>
               </c:forEach>
            </select>
         </div>
      </c:if>
      <c:if test="${!empty param.FavoriteId}">
         <div class="label">Internal details:</div>
         <div class="value">
            FavoriteID=${param.FavoriteId}
         </div>
      </c:if>
      <c:if test="${!empty param.FavoriteId}">
         <p><button type="submit" value="Save Favorite">Save Favorite</button></p>
      </c:if>
      <c:if test="${empty param.FavoriteId}">
         <p><button type="submit" value="Add Favorite">Add Favorite</button></p>
      </c:if>
      </div> <%-- details --%>
   </form>

   <c:if test="${!empty param.FavoriteId}">
      <div class="optionstitle">Options</div>
      <div class="optionsbody">
         <table>
            <tr>
               <td>
                  <form action="additionalairings.jsp" method="get">
                     <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
                     <input type="hidden" name="Period" value=""/>
                     <button type="submit" value="Additional Airings">All Airings</button>
                  </form>
               </td>
            </tr>
            <tr>
               <td>
                  <form action="additionalairings.jsp" method="get">
                     <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
                     <input type="hidden" name="Period" value="past"/>
                     <button type="submit" value="Past Airings">Past Airings</button>
                  </form>
               </td>
            </tr>
            <tr>
               <td>
                  <form action="additionalairings.jsp" method="get">
                     <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
                     <input type="hidden" name="Period" value="future"/>
                     <button type="submit" value="Future Airings">Future Airings</button>
                  </form>
               </td>
            </tr>
            <tr>
               <td>
                  <form action="additionalairings.jsp" method="get">
                     <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
                     <input type="hidden" name="Period" value="recorded"/>
                     <button type="submit" value="Recorded Airings">Recorded Airings</button>
                  </form>
               </td>
            </tr>
            <tr>
               <td>
                  <form action="${cp}/m/confirm.jsp" method="get">
                     <input type="hidden" name="command" value="RemoveFavorite"/>
                     <input type="hidden" name="FavoriteId" value="${param.FavoriteId}"/>
                     <input type="hidden" name="returnto" value="${cp}/m/favorites.jsp"/>
                     <button type="submit" value="Remove Favorite">Remove Favorite</button>
                  </form>
               </td>
            </tr>
         </table>
      </div>
   </c:if>
   </div> <%-- content --%>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
