<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#ConfirmManualRecordOverFavoritePriority(sage.Airing, sage.Airing)'>FavoriteAPI.ConfirmManualRecordOverFavoritePriority</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="manualRecordAiring" required="true" type="java.lang.Object" %>
<%@ attribute name="favoriteAiring" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object manualRecordAiringAttr = jspContext.getAttribute("manualRecordAiring");
Object favoriteAiringAttr = jspContext.getAttribute("favoriteAiring");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "ConfirmManualRecordOverFavoritePriority", new Object[] {manualRecordAiringAttr, favoriteAiringAttr});
}
else
{
    sage.SageTV.api("ConfirmManualRecordOverFavoritePriority", new Object[] {manualRecordAiringAttr, favoriteAiringAttr});
}
%>
