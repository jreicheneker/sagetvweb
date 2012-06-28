<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sagech" tagdir="/WEB-INF/tags/sage/api/channel" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagetc" tagdir="/WEB-INF/tags/sage/api/transcode" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 
<%@ taglib prefix="sagecollfn" tagdir="/WEB-INF/tags/sage/functions/collections" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf" %>
   <title>Search Recordings</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Search Recordings" />
   </jsp:include>

   <%--jsp:useBean id="searchBean" class="sagex.apix.search.SearchRecordingsBean" scope="page"--%>
   <jsp:useBean id="searchBean" class="sagex.webserver.Search" scope="page">
      <jsp:setProperty name="searchBean" property="*" />
   </jsp:useBean>

   <%--c:set var="searchResults" value="${searchBean.searchResults}" scope="page"/--%>

   <c:if test="${param.searchString != null}">
   <%
      Object searchResults = searchBean.doSearch();
      pageContext.setAttribute("searchResults", searchResults);
   %>
   </c:if>

   <%-- build a link with only the parameters needed to reproduce this search --%>
   <c:url var="linkUrl" value="${cp}/m/searchrecordings.jsp">
      <c:forEach var="paramName" items="${pageContext.request.parameterNames}">
      <%-- TODO paramValues categories and channels --%>
         <c:if test="${paramName == 'searchString' or (not empty param[paramName] and param[paramName] != 'any' and param[paramName] != 'Any' and param[paramName] != '**Any**' and param[paramName] != '**ANY**' and param[paramName] != 'none')}">
            <c:param name="${paramName}">${param[paramName]}</c:param>
         </c:if>
      </c:forEach>
   </c:url>

   <a href="${linkUrl}">[Link]</a>

   <div class="content">

      <c:if test="${param.searchString != null}">
         <sageutil:Size var="numResults" data="${searchResults}"/>
         <c:if test="${numResults == 0}">
            <div class="section">Results</div>
            <div class="sectionbody">
               No results found.
            </div>
         </c:if>
         <c:if test="${numResults > 0}">
            <div class="section">${numResults} Result<c:if test="${numResults > 1}">s</c:if></div>
            <div class="sectionbody">
               <form method="post" action="${cp}/m/Command">
                  <input type="hidden" name="returnto" value="${cp}/m/searchairings.jsp?${pageContext.request.queryString}"/>
                  <c:set var="airingList" scope="request" value="${searchResults}"/>
                  <c:set var="allowMultiSelect" scope="request" value="true"/>
                  <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>
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
      </c:if>

      <div class="section">Criteria</div>
      <div class="sectionbody">
         <form method="get" action="${cp}/m/searchrecordings.jsp">
            <input type="hidden" name="searchType" value="TVFiles" />

            <div class="divider">Search</div>
            <div class="dividerbody">
               <div class="label">Search String</div>
               <div class="value">
                  <input tabindex="0" type="text" name="searchString" style="width: 10em;" value="${param.searchString}"/>
               </div>

               <div class="label">Fields</div>
               <div class="value">
                  <input type="checkbox" name="exactTitle" value="on" <c:if test="${param.exactTitle == 'on'}"> checked="checked"</c:if>/>Match Exact Title<br/>
                  <select name="fields" multiple="multiple" size="5">
                     <option value="title">Title</option>
                     <option value="episode">Episode</option>
                     <option value="desc">Description</option>
                     <option value="people">People</option>
                     <option value="category">Category</option>
                     <option value="rated">Rating</option>
                     <option value="extrated">Extended Rating</option>
                     <option value="year">Year</option>
                     <option value="misc">Misc</option>
                     <option value="**ALL**">All Fields</option>
                  </select>
               </div>

               <div class="label">File Name</div>
               <div class="value">
                  <input type="text" name="filename" style="width: 10em;" value="${param.filename}"/><br/>
                  <input type="checkbox" name="regex" value="on" <c:if test="${param.regex == 'on'}"> checked="checked"</c:if>/>Regular Expression<br/>
                  <input type="checkbox" name="caseSensitive" value="on" <c:if test="${param.caseSensitive == 'on'}"> checked="checked"</c:if>/>Case Sensitive
               </div>
            </div>

            <div class="divider">Filters</div>
            <div class="dividerbody">

               <div class="label">Categories</div>
               <div class="value">
                  <select name="categories" multiple="multiple" size="5">
                     <option value="**Any**"<c:if test="${empty paramValues.categories or paramValues.categories[0] == '**Any**'}"> selected="selected"</c:if>>Any</option>
                     <sagedb:GetAllCategories var="categories"/>
                     <%-- Case-insensitive or SortLexical --%>
                     <sagedb:Sort var="categories" data="${categories}" descending="false" sortTechnique="Natural"/>
                     <sagecollfn:ArrayToList var="categoryList" array="${paramValues.categories}"/>
                     <c:forEach var="category" items="${categories}" varStatus="varStatus">
                        <sagecollfn:ListContains var="isCategorySelected" list="${categoryList}" value="${category}"/>
                        <option value="${category}" <c:if test="${isCategorySelected}">selected="selected" style="font-weight: bold;"</c:if>>
                           ${category}
                        </option>
                     </c:forEach>
                  </select>
               </div>

               <div class="label">Channels</div>
               <div class="value">
                  <sagech:GetAllChannels var="channels"/>
                  <sagedb:Sort var="channels" data="${channels}" descending="false" sortTechnique="GetChannelNumber"/>
                  <select name="channels" multiple="multiple" size="5">
                     <option value="**Any**"<c:if test="${empty paramValues.channels or paramValues.channels[0] == '**Any**'}"> selected="selected"</c:if>>Any</option>
                     <sagecollfn:ArrayToList var="channelIdList" array="${paramValues.channels}"/>
                     <c:forEach items="${channels}" var="channel">
                        <sagech:IsChannelViewable var="isChannelViewable" channel="${channel}"/>
                        <c:if test="${isChannelViewable}">
                           <sagech:GetChannelName var="channelName" channel="${channel}"/>
                           <sagech:GetChannelNumber var="channelNumber" channel="${channel}"/>
                           <sagech:GetStationID var="stationID" channel="${channel}"/>
                           <sageutilfn:ToString var="stationIDString" value="${stationID}"/>
                           <sagecollfn:ListContains var="isChannelSelected" list="${channelIdList}" value="${stationIDString}"/>
                           <option value="${stationID}" <c:if test="${isChannelSelected}">selected="selected" style="font-weight: bold;"</c:if>>
                              ${channelNumber} -- ${channelName}
                           </option>
                        </c:if>
                     </c:forEach>
                  </select>
               </div>

               <div class="label">Watched</div>
               <div class="value">
                  <select name="watched">
                     <option value="any" <c:if test="${empty param.watched or param.watched == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.watched == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.watched == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>

               <div class="label">Don't Like</div>
               <div class="value">
                  <select name="dontlike">
                     <option value="any" <c:if test="${empty param.dontlike or param.dontlike == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.dontlike == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.dontlike == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>

               <div class="label">Favorite</div>
               <div class="value">
                  <select name="favorite">
                     <option value="any" <c:if test="${empty param.favorite or param.favorite == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.favorite == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.favorite == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>

               <div class="label">First Runs and Reruns</div>
               <div class="value">
                  <select name="firstRuns">
                     <option value="set" <c:if test="${param.firstRuns == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>First Runs</option>
                     <option value="cleared" <c:if test="${param.firstRuns == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>Reruns</option>
                     <option value="any" <c:if test="${empty param.firstRuns or param.firstRuns == 'any' or param.firstRuns == 'FirstRunsAndReruns'}">selected="selected" style="font-weight: bold;"</c:if>>First Runs and Reruns</option>
                  </select>
               </div>

               <div class="label">High Definition</div>
               <div class="value">
                  <select name="HDTV">
                     <option value="any" <c:if test="${empty param.HDTV or param.HDTV == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.HDTV == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.HDTV == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>

               <div class="label">Archived</div>
               <div class="value">
                  <select name="archived">
                     <option value="any" <c:if test="${empty param.archived or param.archived == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.archived == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.archived == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>

               <div class="label">Manual</div>
               <div class="value">
                  <select name="manRec">
                     <option value="any" <c:if test="${empty param.manRec or param.manRec == 'any'}">selected="selected" style="font-weight: bold;"</c:if>>Any</option>
                     <option value="set" <c:if test="${param.manRec == 'set'}">selected="selected" style="font-weight: bold;"</c:if>>Yes</option>
                     <option value="cleared" <c:if test="${param.manRec == 'cleared'}">selected="selected" style="font-weight: bold;"</c:if>>No</option>
                  </select>
               </div>
               <%-- TODO auto-delete, partials --%>
            </div>

            <div class="divider">Display</div>
            <div class="dividerbody">
               <div class="label">Primary Sorting</div>
               <div class="value">
                  <select name="sort1">
                     <option selected="selected" value="airdate_asc">Airing Date (earliest first)</option>
                     <option value="airdate_desc">Airing Date (latest first)</option>
                     <option value="title_asc">Show Title (a-z)</option>
                     <option value="title_desc">Show Title Reversed (z-a)</option>
                     <option value="episode_asc">Epsiode (a-z)</option>
                     <option value="episode_desc">Epsiode Reversed (z-a)</option>
                     <option value="people_asc">People(a-z)</option>
                     <option value="people_desc">People Reversed (z-a)</option>
                     <option value="none">No sorting</option>
                  </select>
               </div>

               <div class="label">Secondary Sorting</div>
               <div class="value">
                  <select name="sort2">
                     <option value="airdate_asc">Airing Date (earliest first)</option>
                     <option value="airdate_desc">Airing Date (latest first)</option>
                     <option value="title_asc">Show Title (a-z)</option>
                     <option value="title_desc">Show Title Reversed (z-a)</option>
                     <option value="episode_asc">Epsiode (a-z)</option>
                     <option value="episode_desc">Epsiode Reversed (z-a)</option>
                     <option value="people_asc">People(a-z)</option>
                     <option value="people_desc">People Reversed (z-a)</option>
                     <option selected="selected" value="none">No sorting</option>
                  </select>
               </div>

               <%--div class="label">Group By</div>
               <div class="value">
                  <select name="GroupBy">
                     < % - -option value="AiringDate">Airing Date</option>
                     <option value="Title">Title</option>
                     <option value="Episode">Episode</option>
                     <option value="People">People</option>
                     <option value="None">None</option- - % >
                  </select>
               </div--%>
            </div>

            <%--div class="section">Search</div>
            <div class="sectionbody"--%>
               <button type="submit" value="Search">Search Recordings</button>
            <%--/div--%>
         </form>
      </div>

   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>

<%--div id="options" class="options" style="display: block;"><form method="get" action="/sage/Search">
<table>
<tr><td>
Search in fields:
</td><td><table><tr><td>
<select name="search_fields" multiple="multiple" size="5">
   <option value="title"  selected="selected">Title / Album name</option>

   <option value="episode" >Episode / track Name</option>
   <option value="desc" >Description</option>
   <option value="people" >People / track Artist</option>
   <option value="category" >Category</option>
   <option value="rated" >Rating</option>
   <option value="extrated" >Extended Rating</option>

   <option value="year" >Year</option>
   <option value="misc" >Misc</option>
   <option value="**ALL**" >ALL fields</option>
</select>

<tr><td>Auto-Delete:</td><td><table><tr><td><select name="autodelete">
    <option value='any' selected="selected">Any</option>

    <option value='set'>Set</option>
    <option value='cleared'>Cleared</option>
</select>
</td><td>(Includes Intelligent Recordings and Favorites that have not been archived, marked to manually record, or are currently recording<br/>Ignored for non-TV files.)</td>
</tr></table></td></tr>
<tr><td>Show Partials:</td><td><table><tr><td><select name="partials">
    <option value='none' selected="selected">Only Complete Recordings</option>
    <option value='only'>Only Partials</option>

    <option value='both'>Partials and Complete Recordings</option>
</select>
</td><td>(Ignored for non-TV files)</td></tr></table></td></tr>
<tr><td>Group By:</td><td><select name="grouping">
    <option value='##AsSageTV##'>Same as SageTV</option>

    <option value='None' selected="selected">No Grouping</option>
    <option value='GetAiringTitle'>Title/Album Name</option>
    <option value='GetAiringChannelName'>Channel</option>
    <option value='GetShowCategory'>Category</option>
</select>
</td></tr>
<tr><td>Results per page:</td><td><select name="pagelen">
    <option value='10'>10</option>

    <option value='25'>25</option>
    <option value='50'>50</option>
    <option value='100'>100</option>
    <option value='200'>200</option>
    <option value='500'>500</option>
    <option value='inf' selected="selected">All</option>

</select>
</td></tr>
</table>
<p><input type="submit" value="Search"/></p></form>
</div--%>
