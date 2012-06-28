<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/FavoriteAPI.html#GetFavoriteProperties(sage.Favorite)'>FavoriteAPI.GetFavoriteProperties</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="favorite" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object favoriteAttr = jspContext.getAttribute("favorite");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetFavoriteProperties", new Object[] {favoriteAttr});
}
else
{
    returnVal = sage.SageTV.api("GetFavoriteProperties", new Object[] {favoriteAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
