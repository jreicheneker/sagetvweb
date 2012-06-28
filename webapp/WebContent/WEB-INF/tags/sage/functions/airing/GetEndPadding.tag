<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Long airingEndTime = (Long) SageTV.api("GetAiringEndTime", new Object[] {airing});
Long scheduleEndTime = (Long) SageTV.api("GetScheduleEndTime", new Object[] {airing});
Long endPadding = -(airingEndTime - scheduleEndTime) / 60000; // in minutes
%>

<c:set var="varLocal" value="<%= endPadding %>"/>
