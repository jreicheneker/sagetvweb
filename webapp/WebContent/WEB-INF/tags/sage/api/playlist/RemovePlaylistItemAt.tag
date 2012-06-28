<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/PlaylistAPI.html#RemovePlaylistItemAt(sage.Playlist, int)'>PlaylistAPI.RemovePlaylistItemAt</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="playlist" required="true" type="java.lang.Object" %>
<%@ attribute name="itemIndex" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object playlistAttr = jspContext.getAttribute("playlist");
Object itemIndexAttr = jspContext.getAttribute("itemIndex");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemovePlaylistItemAt", new Object[] {playlistAttr, itemIndexAttr});
}
else
{
    sage.SageTV.api("RemovePlaylistItemAt", new Object[] {playlistAttr, itemIndexAttr});
}
%>
