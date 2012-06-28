<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Long startTime = (Long) SageTV.api("GetScheduleStartTime", new Object[] {airing});
Boolean isStartedAiring = startTime < System.currentTimeMillis();
%>

<c:set var="varLocal" value="<%= isStartedAiring %>"/>
