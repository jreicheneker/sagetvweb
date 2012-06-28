<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/PlaylistAPI.html#RemovePlaylistItem(sage.Playlist, java.lang.Object)'>PlaylistAPI.RemovePlaylistItem</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="playlist" required="true" type="java.lang.Object" %>
<%@ attribute name="item" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object playlistAttr = jspContext.getAttribute("playlist");
Object itemAttr = jspContext.getAttribute("item");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemovePlaylistItem", new Object[] {playlistAttr, itemAttr});
}
else
{
    sage.SageTV.api("RemovePlaylistItem", new Object[] {playlistAttr, itemAttr});
}
%>
