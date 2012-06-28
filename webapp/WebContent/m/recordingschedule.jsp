<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sageglbl" tagdir="/WEB-INF/tags/sage/api/global" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf"%>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Recording Schedule</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Recording Schedule" />
   </jsp:include>

   <sageglbl:GetScheduledRecordings var="airings"/>

<%-- TODO unknown tag and compression filter produce garbage --%>
   <sageutil:Size var="numRecordings" data="${airings}" />

   <div class="content">
   <c:if test="${numRecordings == 0}">
      There are no scheduled recordings.
   </c:if>
   <c:if test="${numRecordings != 0}">

      <form method="post" action="${cp}/m/Command">
         <input type="hidden" name="returnto" value="${cp}/m/recordingschedule.jsp?${pageContext.request.queryString}"/>
         <%--@ include file="/WEB-INF/jspf/m/airinglist.jspf" --%>
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
            </table>
         </div>
      </form>
   </c:if>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
