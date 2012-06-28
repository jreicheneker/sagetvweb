<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#CreateFavoritePriority(sage.Favorite, sage.Favorite)'>FavoriteAPI.CreateFavoritePriority</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="higherPriorityFavorite" required="true" type="java.lang.Object" %>
<%@ attribute name="lowerPriorityFavorite" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object higherPriorityFavoriteAttr = jspContext.getAttribute("higherPriorityFavorite");
Object lowerPriorityFavoriteAttr = jspContext.getAttribute("lowerPriorityFavorite");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "CreateFavoritePriority", new Object[] {higherPriorityFavoriteAttr, lowerPriorityFavoriteAttr});
}
else
{
    sage.SageTV.api("CreateFavoritePriority", new Object[] {higherPriorityFavoriteAttr, lowerPriorityFavoriteAttr});
}
%>
