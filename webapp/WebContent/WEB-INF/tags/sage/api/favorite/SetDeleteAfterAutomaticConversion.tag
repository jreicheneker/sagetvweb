<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#SetDeleteAfterAutomaticConversion(sage.Favorite, boolean)'>FavoriteAPI.SetDeleteAfterAutomaticConversion</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>
<%@ attribute name="deleteAfterAutomaticConversion" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");
Object deleteAfterAutomaticConversionAttr = jspContext.getAttribute("deleteAfterAutomaticConversion");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetDeleteAfterAutomaticConversion", new Object[] {favoriteAttr, deleteAfterAutomaticConversionAttr});
}
else
{
    sage.SageTV.api("SetDeleteAfterAutomaticConversion", new Object[] {favoriteAttr, deleteAfterAutomaticConversionAttr});
}
%>
