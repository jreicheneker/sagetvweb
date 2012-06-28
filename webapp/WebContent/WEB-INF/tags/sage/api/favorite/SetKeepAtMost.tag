<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#SetKeepAtMost(sage.Favorite, int)'>FavoriteAPI.SetKeepAtMost</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="numberToKeep" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");
Object numberToKeepAttr = jspContext.getAttribute("numberToKeep");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetKeepAtMost", new Object[] {favoriteAttr, numberToKeepAttr});
}
else
{
    sage.SageTV.api("SetKeepAtMost", new Object[] {favoriteAttr, numberToKeepAttr});
}
%>
