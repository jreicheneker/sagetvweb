<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Object channelName = SageTV.api("GetAiringChannelName", new Object[] {airing});

Object allConflicts = SageTV.api("GetAiringsThatWontBeRecorded", new Object[] {Boolean.FALSE});
Object airingConflict = SageTV.api("DataIntersection", new Object[] {airing, allConflicts});
%>

<c:set var="varLocal" value="<%= airingConflict %>"/>
