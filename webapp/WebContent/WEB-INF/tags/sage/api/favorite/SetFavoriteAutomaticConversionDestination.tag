<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#SetFavoriteAutomaticConversionDestination(sage.Favorite, java.io.File)'>FavoriteAPI.SetFavoriteAutomaticConversionDestination</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="folder" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");
Object folderAttr = jspContext.getAttribute("folder");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetFavoriteAutomaticConversionDestination", new Object[] {favoriteAttr, folderAttr});
}
else
{
    sage.SageTV.api("SetFavoriteAutomaticConversionDestination", new Object[] {favoriteAttr, folderAttr});
}
%>
