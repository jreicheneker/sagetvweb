<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sagech" tagdir="/WEB-INF/tags/sage/api/channel" %> 
<%@ taglib prefix="sagechfn" tagdir="/WEB-INF/tags/sage/functions/channel" %> 
<%@ taglib prefix="sagedb" tagdir="/WEB-INF/tags/sage/api/database" %> 
<%@ taglib prefix="sageutil" tagdir="/WEB-INF/tags/sage/api/utility" %> 
<%@ taglib prefix="sageutilfn" tagdir="/WEB-INF/tags/sage/functions/utility" %> 
<%@ taglib prefix="sagedatefn" tagdir="/WEB-INF/tags/sage/functions/date" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <%@ include file="/WEB-INF/jspf/m/cacheheaders.jspf" %>
   <%@ include file="/WEB-INF/jspf/m/contextpath.jspf"%>
   <title>Create Timed Recording</title>
   <%@ include file="/WEB-INF/jspf/m/htmlheaders.jspf"%>
</head>
<body>

   <jsp:include page="/WEB-INF/jspf/m/header.jspf">
      <jsp:param name="pageTitle" value="Create Timed Recording" />
   </jsp:include>

   <sageutil:Time var="startTime"/>
   <sageutil:Time var="stopTime"/>
   <c:set var="stopTime" value="${stopTime + 60*60*1000}"/>

   <sageutil:DateFormat var="startMonthNum" date="${startTime}" format="M"/>
   <sageutil:DateFormat var="startMonth" date="${startTime}" format="MMM"/>
   <sageutil:DateFormat var="startDay" date="${startTime}" format="d"/>
   <sageutil:DateFormat var="startYear" date="${startTime}" format="yyyy"/>
   <sageutil:DateFormat var="startHour" date="${startTime}" format="KK"/>
   <sageutil:DateFormat var="startMinute" date="${startTime}" format="mm"/>
   <sageutil:DateFormat var="startAMPM" date="${startTime}" format="a"/>

   <sageutil:DateFormat var="stopMonthNum" date="${stopTime}" format="M"/>
   <sageutil:DateFormat var="stopMonth" date="${stopTime}" format="MMM"/>
   <sageutil:DateFormat var="stopDay" date="${stopTime}" format="d"/>
   <sageutil:DateFormat var="stopYear" date="${stopTime}" format="yyyy"/>
   <sageutil:DateFormat var="stopHour" date="${stopTime}" format="KK"/>
   <sageutil:DateFormat var="stopMinute" date="${stopTime}" format="mm"/>
   <sageutil:DateFormat var="stopAMPM" date="${stopTime}" format="a"/>

   <div class="content">
      <div class="details">
      <form method="post" action="${cp}/m/Command">
         <div class="label">Channel:</div>
         <div class="value">
            <sagech:GetAllChannels var="channels"/>
		    <sagedb:FilterByBoolMethod var="channels" data="${channels}" method="IsChannelViewable" matchValue="true"/>
            <sagedb:Sort var="channels" data="${channels}" descending="false" sortTechnique="ChannelNumber"/>
            <select name="ChannelId">
               <%--option value="" <c:if test="${empty channel}">selected="selected" style="font-weight: bold;"</c:if>>Any</option--%>
               <c:forEach items="${channels}" var="currentChannel">
                  <sagech:GetStationID var="stationId" channel="${currentChannel}"/>
                  <sagech:GetChannelName var="channelName" channel="${currentChannel}"/>
                  <sagech:GetChannelNumber var="channelNumber" channel="${currentChannel}"/>
                  <sagech:GetChannelNetwork var="channelNetwork" channel="${currentChannel}"/>
                  <option value="${stationId}" <c:if test="${favoriteChannel == channelName}">selected="selected" style="font-weight: bold;"</c:if>>${channelNumber} -- ${channelName} -- ${channelNetwork}</option>
               </c:forEach>
            </select>
         </div>
         <div class="label">Start:</div>
         <div class="value">
            <select name="StartMonth">
               <c:forEach begin="1" end="12" var="currentMonth">
                  <sagedatefn:GetDate var="currentMonthDate" month="${currentMonth - 1}"/>
                  <sageutil:DateFormat var="currentMonthDateFmt" date="${currentMonthDate}" format="MMM"/>
                  <option value="${currentMonth}" <c:if test="${currentMonth == startMonthNum}">selected="selected" style="font-weight: bold;"</c:if>>${currentMonthDateFmt}</option>
               </c:forEach>
            </select>
            <select name="StartDay">
               <c:forEach begin="1" end="31" var="dayOfMonth">
                  <option value="${dayOfMonth}" <c:if test="${dayOfMonth == startDay}">selected="selected" style="font-weight: bold;"</c:if>>${dayOfMonth}</option>
               </c:forEach>
            </select>
            <sageutil:DateFormat var="startYear" date="${startTime}" format="yyyy"/>
            <select name="StartYear">
               <c:forEach begin="${startYear}" end="${startYear + 5}" var="currentYear">
                  <option value="${currentYear}" <c:if test="${currentYear == startYear}">selected="selected" style="font-weight: bold;"</c:if>>${currentYear}</option>
               </c:forEach>
            </select>
         </div>
         <div class="value">
            <select name="StartHour">
               <c:forEach begin="1" end="12" var="hourOfDay">
                  <sageutilfn:DecimalFormat var="hourOfDayFmt" value="${hourOfDay}" format="00"/>
                  <option value="${hourOfDayFmt}" <c:if test="${hourOfDayFmt == startHour}">selected="selected" style="font-weight: bold;"</c:if>>${hourOfDayFmt}</option>
               </c:forEach>
            </select> : 
            <select name="StartMinute">
               <c:forEach begin="0" end="59" var="minuteOfHour">
                  <sageutilfn:DecimalFormat var="minuteOfHourFmt" value="${minuteOfHour}" format="00"/>
                  <option value="${minuteOfHourFmt}" <c:if test="${minuteOfHourFmt == startMinute}">selected="selected" style="font-weight: bold;"</c:if>>${minuteOfHourFmt}</option>
               </c:forEach>
            </select>
            <select name="StartAMPM">
               <option value="AM" <c:if test="${'AM' == startAMPM}">selected="selected" style="font-weight: bold;"</c:if>>AM</option>
               <option value="PM" <c:if test="${'PM' == startAMPM}">selected="selected" style="font-weight: bold;"</c:if>>PM</option>
            </select>
         </div>
         <div class="label">Stop:</div>
         <div class="value">
            <select name="StopMonth">
               <c:forEach begin="1" end="12" var="currentMonth">
                  <sagedatefn:GetDate var="currentMonthDate" month="${currentMonth - 1}"/>
                  <sageutil:DateFormat var="currentMonthDateFmt" date="${currentMonthDate}" format="MMM"/>
                  <option value="${currentMonth}" <c:if test="${currentMonth == stopMonthNum}">selected="selected" style="font-weight: bold;"</c:if>>${currentMonthDateFmt}</option>
               </c:forEach>
            </select>
            <select name="StopDay">
               <c:forEach begin="1" end="31" var="dayOfMonth">
                  <option value="${dayOfMonth}" <c:if test="${dayOfMonth == stopDay}">selected="selected" style="font-weight: bold;"</c:if>>${dayOfMonth}</option>
               </c:forEach>
            </select>
            <sageutil:DateFormat var="stopYear" date="${stopTime}" format="yyyy"/>
            <select name="StopYear">
               <c:forEach begin="${stopYear}" end="${stopYear + 5}" var="currentYear">
                  <option value="${currentYear}" <c:if test="${currentYear == stopYear}">selected="selected" style="font-weight: bold;"</c:if>>${currentYear}</option>
               </c:forEach>
            </select>
         </div>
         <div class="value">
            <select name="StopHour">
               <c:forEach begin="1" end="12" var="hourOfDay">
                  <sageutilfn:DecimalFormat var="hourOfDayFmt" value="${hourOfDay}" format="00"/>
                  <option value="${hourOfDayFmt}" <c:if test="${hourOfDayFmt == stopHour}">selected="selected" style="font-weight: bold;"</c:if>>${hourOfDayFmt}</option>
               </c:forEach>
            </select> : 
            <select name="StopMinute">
               <c:forEach begin="0" end="59" var="minuteOfHour">
                  <sageutilfn:DecimalFormat var="minuteOfHourFmt" value="${minuteOfHour}" format="00"/>
                  <option value="${minuteOfHourFmt}" <c:if test="${minuteOfHourFmt == stopMinute}">selected="selected" style="font-weight: bold;"</c:if>>${minuteOfHourFmt}</option>
               </c:forEach>
            </select>
            <select name="StopAMPM">
               <option value="AM" <c:if test="${'AM' == stopAMPM}">selected="selected" style="font-weight: bold;"</c:if>>AM</option>
               <option value="PM" <c:if test="${'PM' == stopAMPM}">selected="selected" style="font-weight: bold;"</c:if>>PM</option>
            </select>
         </div>
         <div class="label">Recurrence:</div>
         <div class="value">
            <input type="radio" name="Recurrence" value="Once" checked="checked"/>Once
         </div>
         <div class="value">
            <input type="radio" name="Recurrence" value="Daily"/>Daily
         </div>
         <div class="value">
            <input type="radio" name="Recurrence" value="WeeklySpecificDays"/>Weekly (Specific Days)
            <div style="margin-left: 15px;">
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Su"/>Sunday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Mo"/>Monday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Tu"/>Tuesday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="We"/>Wednesday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Th"/>Thursday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Fr"/>Friday
               <input type="checkbox" name="RecurrenceWeeklyDay" value="Sa"/>Saturday
            </div>
         </div>
         <div class="value">
            <input type="radio" name="Recurrence" value="Weekly"/>Weekly
         </div>
         <input type="hidden" name="command" value="CreateTimedRecording"/>
         <input type="hidden" name="returnto" value="recordingschedule.jsp"/>
         <button value="Create">Create</button>
      </form>
      </div>
   </div>

   <jsp:include page="/WEB-INF/jspf/m/footer.jspf"/>

</body>
</html>
