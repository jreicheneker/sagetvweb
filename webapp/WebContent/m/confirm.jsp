<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sagefav" tagdir="/WEB-INF/tags/sage/api/favorite" %> 
<%@ taglib prefix="sageair" tagdir="/WEB-INF/tags/sage/api/airing" %> 
<%@ taglib prefix="sagemf" tagdir="/WEB-INF/tags/sage/api/mediafile" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <c:set var="pageTitle" value="Confirm"/>
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

   <c:forEach items="${paramValues.MediaFileId}" var="mediaFileId">
      <c:set var="mediaFileIdValues" value="${fn:split(mediaFileId, ',')}" />
      <c:forEach items="${mediaFileIdValues}" var="mediaFileIdValue">
         <sagemf:GetMediaFileForID var="mediaFile" id="${mediaFileIdValue}"/>
         <sagedb:DataUnion var="items" dataSet1="${items}" dataSet2="${mediaFile}"/>
      </c:forEach>
   </c:forEach>

   <c:forEach items="${paramValues.AiringId}" var="airingId">
      <sageair:GetAiringForID var="airing" airingID="${airingId}"/>
      <sagedb:DataUnion var="items" dataSet1="${items}" dataSet2="${airing}"/>
   </c:forEach>

   <c:forEach items="${paramValues.FavoriteId}" var="favoriteId">
      <sagefav:GetFavoriteForID var="favorite" favoriteID="${favoriteId}"/>
      <sagedb:DataUnion var="items" dataSet1="${items}" dataSet2="${favorite}"/>
   </c:forEach>

   <sageutil:Size var="numItems" data="${items}" />

   <c:if test="${numItems == 0}">
      <div class="content">
         <div class="simplemessage">
            No shows have been specified.
         </div>
      </div>
   </c:if>
   <c:if test="${numItems != 0}">

      <div class="subheader">
         Attempting to perform command '${param.command}' on ${numItems} show<c:if test="${numItems != 1}">s</c:if> requires confirmation.
      </div>
      <div class="content">
         <c:set var="airingList" scope="request" value="${items}"/>
         <jsp:include page="/WEB-INF/jspf/m/airinglist.jspf"/>

         <div class="optionstitle">Confirmation Options</div>
         <div class="optionsbody">

            Do you want to perform this command?

            <form method="post" action="${cp}/m/Command">
               <input type="hidden" name="command" value="${param.command}"/>
               <c:forEach items="${paramValues.MediaFileId}" var="mediaFileId">
                  <input type="hidden" name="MediaFileId" value="${mediaFileId}"/>
               </c:forEach>
               <c:forEach items="${paramValues.AiringId}" var="airingId">
                  <input type="hidden" name="AiringId" value="${airingId}"/>
               </c:forEach>
               <c:forEach items="${paramValues.FavoriteId}" var="favoriteId">
                  <input type="hidden" name="FavoriteId" value="${favoriteId}"/>
               </c:forEach>
               <c:if test="${not empty param.returnto}">
                  <input type="hidden" name="returnto" value="${param.returnto}"/>
               </c:if>
               <table>
                  <tr>
                     <td>
                        <button type="submit" name="confirmed" value="Yes">Yes</button>
                     </td>
                  </tr>
                  <tr>
                     <td> 
                        <button type="submit" name="confirmed" value="No">No</button> 
                     </td>
                  </tr>
               </table>
            </form>
         </div>
      </div>
   </c:if>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
