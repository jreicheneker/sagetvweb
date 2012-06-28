<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#SetFavoriteAutomaticConversionFormat(sage.Favorite, java.lang.String)'>FavoriteAPI.SetFavoriteAutomaticConversionFormat</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="format" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");
Object formatAttr = jspContext.getAttribute("format");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetFavoriteAutomaticConversionFormat", new Object[] {favoriteAttr, formatAttr});
}
else
{
    sage.SageTV.api("SetFavoriteAutomaticConversionFormat", new Object[] {favoriteAttr, formatAttr});
}
%>
