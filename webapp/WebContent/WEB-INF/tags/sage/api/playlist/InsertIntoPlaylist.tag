<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/PlaylistAPI.html#InsertIntoPlaylist(sage.Playlist, int, java.lang.Object)'>PlaylistAPI.InsertIntoPlaylist</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="playlist" required="true" type="java.lang.Object" %>
<%@ attribute name="insertIndex" required="true" type="java.lang.Integer" %>
<%@ attribute name="newItem" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object playlistAttr = jspContext.getAttribute("playlist");
Object insertIndexAttr = jspContext.getAttribute("insertIndex");
Object newItemAttr = jspContext.getAttribute("newItem");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "InsertIntoPlaylist", new Object[] {playlistAttr, insertIndexAttr, newItemAttr});
}
else
{
    sage.SageTV.api("InsertIntoPlaylist", new Object[] {playlistAttr, insertIndexAttr, newItemAttr});
}
%>
