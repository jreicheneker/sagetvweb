<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#SetStartPadding(sage.Favorite, long)'>FavoriteAPI.SetStartPadding</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="startPadding" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");
Object startPaddingAttr = jspContext.getAttribute("startPadding");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetStartPadding", new Object[] {favoriteAttr, startPaddingAttr});
}
else
{
    sage.SageTV.api("SetStartPadding", new Object[] {favoriteAttr, startPaddingAttr});
}
%>
