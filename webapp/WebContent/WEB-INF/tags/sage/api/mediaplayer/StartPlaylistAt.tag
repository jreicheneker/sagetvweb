<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#StartPlaylistAt(sage.Playlist, int)'>MediaPlayerAPI.StartPlaylistAt</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="playlist" required="true" type="java.lang.Object" %>
<%@ attribute name="startIndex" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object playlistAttr = jspContext.getAttribute("playlist");
Object startIndexAttr = jspContext.getAttribute("startIndex");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "StartPlaylistAt", new Object[] {playlistAttr, startIndexAttr});
}
else
{
    returnVal = sage.SageTV.api("StartPlaylistAt", new Object[] {playlistAttr, startIndexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
