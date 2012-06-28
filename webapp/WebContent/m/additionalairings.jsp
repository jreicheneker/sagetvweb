<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sagedatefn" tagdir="/WEB-INF/tags/sage/functions/date" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <c:choose>
      <c:when test="${param.Period == 'future'}">
         <sageutil:Time var="startTime"/>
         <sagedatefn:GetEndOfTime var="endTime"/>
         <c:set var="periodDesc" value="Future"/>
      </c:when>
      <c:when test="${param.Period == 'past'}">
         <sagedatefn:GetBeginningOfTime var="startTime"/>
         <sageutil:Time var="endTime"/>
         <c:set var="periodDesc" value="Past"/>
      </c:when>
      <c:when test="${param.Period == 'recorded'}">
         <sagedatefn:GetBeginningOfTime var="startTime"/>
         <sageutil:Time var="endTime"/>
         <c:set var="periodDesc" value="Recorded"/>
      </c:when>
      <c:otherwise>
         <sagedatefn:GetBeginningOfTime var="startTime"/>
         <sagedatefn:GetEndOfTime var="endTime"/>
         <c:set var="periodDesc" value="All"/>
      </c:otherwise>
   </c:choose>
   <c:if test="${!empty param.Title}">
      <c:set var="pageTitle" value="${periodDesc} Airings of &quot;${param.Title}&quot;"/>
   </c:if>
   <c:if test="${!empty param.FavoriteId}">
      <sagefav:GetFavoriteForID var="favorite" favoriteID="${param.FavoriteId}"/>
      <sagefav:GetFavoriteDescription var="favoriteDescription" favorite="${favorite}"/>
      <c:set var="pageTitle" value="${periodDesc} Airings of &quot;${favoriteDescription}&quot;"/>
   </c:if>
   <title>${pageTitle}</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="${pageTitle}" />
   </jsp:include>

   <c:if test="${!empty param.Title}">
      <sagedb:SearchByTitle var="airings" searchString="${param.Title}"/>
   </c:if>
   <c:if test="${!empty param.FavoriteId}">
      <sagefav:GetFavoriteAirings var="airings" favorite="${favorite}"/>
   </c:if>

   <c:if test="${!empty airings}">
      <c:if test="${param.Period == 'recorded'}">
         <sagedb:FilterByBoolMethod var="airings" data="${airings}" method="IsTVFile" matchValue="true"/>
      </c:if>
      <%--sagedb:FilterByBoolMethod var="airings" data="${airings}" method="IsCompleteRecording|IsManualRecord" matchValue="true"/--%>
      <sagedb:FilterByRange var="airings" data="${airings}" method="GetAiringEndTime" lowerBoundInclusive="${startTime}" upperBoundExclusive="${endTime}" keepWithinBounds="true"/>
      <sagedb:Sort var="airings" data="${airings}" descending="false" sortTechnique="GetAiringStartTime"/> 
   </c:if>

   <c:if test="${empty airings}">
      <div class="content">
         <div class="simplemessage">
            There are no <c:if test="${!empty param.Period}">${periodDesc}</c:if> airings of 
            <c:if test="${!empty param.Title}">
               ${param.Title}
            </c:if>
            <c:if test="${!empty param.FavoriteId}">
               ${favoriteDescription}
            </c:if>
         </div>
      </div>
   </c:if>

   <c:if test="${!empty airings}">
      <form method="post" action="${cp}/m/Command">
         <input type="hidden" name="returnto" value="${cp}/m/additionalairings.jsp?${pageContext.request.queryString}"/>
         <c:set var="airingList" scope="request" value="${airings}"/>
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
   </c:if>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
