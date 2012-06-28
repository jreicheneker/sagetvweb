<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
// Get Music Files
Object mediaFiles = SageTV.api("GetMediaFiles", null);
mediaFiles = SageTV.api("FilterByBoolMethod", new Object[] {mediaFiles, "IsMusicFile", true});
mediaFiles = SageTV.api("FilterByBoolMethod", new Object[] {mediaFiles, "IsLibraryFile", true});

// Group music files into albums
Object albumGrouping = SageTV.api("GroupByMethod", new Object[] {mediaFiles, "GetAlbumForFile"});

Object albums = albumGrouping;
%>

<c:set var="varLocal" value="<%= albums %>"/>
