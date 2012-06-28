<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#SetWatched(sage.Airing)'>AiringAPI.SetWatched</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airingAttr = jspContext.getAttribute("airing");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetWatched", new Object[] {airingAttr});
}
else
{
    sage.SageTV.api("SetWatched", new Object[] {airingAttr});
}
%>
