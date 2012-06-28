<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagemsg" tagdir="/WEB-INF/tags/sage/api/systemmessage" %> 
<%@ taglib prefix="sagemsgfn" tagdir="/WEB-INF/tags/sage/functions/systemmessage" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>System Messages</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="System Messages" />
   </jsp:include>

   <div class="content">
   <sagemsgfn:SupportsSystemMessages var="supportsSystemMessages"/>
   
   <c:if test="${not supportsSystemMessages}">
      System messages require SageTV 6.5.17 or later.
   </c:if>

   <c:if test="${supportsSystemMessages}">
      <sagemsg:GetSystemMessages var="messages"/>

      <sageutil:Size var="numMessages" data="${messages}" />

      <c:if test="${numMessages == 0}">
         There are no system messages.
      </c:if>
      <c:if test="${numMessages != 0}">
         <sagedb:Sort var="messages" data="${messages}" descending="true" sortTechnique="GetSystemMessageTime"/>

         <sagemsg:GetSystemAlertLevel var="alertLevel"/>

         <form method="post" action="${cp}/m/Command">
            <input type="hidden" name="returnto" value="${cp}/m/systemmessages.jsp"/>

            <c:forEach items="${messages}" var="message" varStatus="status">

               <sagemsg:GetSystemMessageTypeCode var="messageTypeCode" message="${message}"/>
               <sagemsg:GetSystemMessageTypeName var="messageTypeName" message="${message}"/>
               <sagemsg:GetSystemMessageLevel var="messageLevel" message="${message}"/>
               <sagemsg:GetSystemMessageString var="messageString" message="${message}"/>
               <sagemsg:GetSystemMessageVariable var="messageVariable" message="${message}" varName="${messageString}"/>
               <sagemsg:GetSystemMessageRepeatCount var="messageRepeatCount" message="${message}"/>
               <sagemsg:GetSystemMessageTime var="messageTime" message="${message}"/>
               <sagemsg:GetSystemMessageEndTime var="messageEndTime" message="${message}"/>

               <div class="listcell">
                  <div class="title">
                     <input type="checkbox" value="${messageLevel}-${messageTypeCode}-${messageTime}" name="SystemMessage"/><b>${status.count}. ${messageTypeName}</b>
                  </div>
                  <p>
                     <c:if test="${messageLevel > 0}">
                        <img style="border: 0px none; width: 20px; height: 20px;" src="${cp}/images/MarkerSysAlert${messageLevel}.png" alt="Message Level ${messageLevel}" title="Message Level ${messageLevel}"/>
                     </c:if>
                     <c:choose >
                        <c:when test="${messageLevel == 0}">
                           Status Message
                        </c:when>
                        <c:when test="${messageLevel == 1}">
                           Information Message
                        </c:when>
                        <c:when test="${messageLevel == 2}">
                           Warning Message
                        </c:when>
                        <c:when test="${messageLevel == 3}">
                           Error Message
                        </c:when>
                     </c:choose>
                  </p>
                  <div class="systemmessagetext">
                     <p>
                        ${messageString}
                     </p>
                     <p>
                        ${messageVariable}
                     </p>
                  </div>
                  <c:if test="${messageRepeatCount > 1}">
                     <p>
                        ${messageRepeatCount} Messages
                     </p>
                  </c:if>
                  <p>
                     <sageutil:PrintDateLong date="${messageTime}" var="messageDateFmt"/>
                     <sageutil:PrintTime time="${messageTime}" var="messageTimeFmt"/>
                     <c:if test="${messageRepeatCount > 1}">First Occurrence: </c:if>${messageDateFmt} ${messageTimeFmt}
                  </p>
                  <c:if test="${messageRepeatCount > 1}">
                     <p>
                        <sageutil:PrintDateLong date="${messageEndTime}" var="messageEndDateFmt"/>
                        <sageutil:PrintTime time="${messageEndTime}" var="messageEndTimeFmt"/>
                        Last Occurrence: ${messageEndDateFmt} ${messageEndTimeFmt}
                     </p>
                  </c:if>
               </div>

            </c:forEach>

            <div class="optionstitle">Options</div>
            <div class="optionsbody">
               <table>
                  <tr>
                     <td>
                        <button type="submit" value="ResetSystemAlertLevel" name="command">Reset Alert Level</button>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <button type="submit" value="DeleteSystemMessage" name="command">Delete Selected Messages</button>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <button type="submit" value="DeleteAllSystemMessages" name="command">Delete All Messages</button>
                     </td>
                  </tr>
               </table>
            </div>
         </form>
      </c:if>
   </c:if>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
