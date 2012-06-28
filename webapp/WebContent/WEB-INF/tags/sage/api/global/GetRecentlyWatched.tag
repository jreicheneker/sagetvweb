<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#GetRecentlyWatched(long)'>Global.GetRecentlyWatched</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="durationToLookBack" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object durationToLookBackAttr = jspContext.getAttribute("durationToLookBack");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetRecentlyWatched", new Object[] {durationToLookBackAttr});
}
else
{
    returnVal = sage.SageTV.api("GetRecentlyWatched", new Object[] {durationToLookBackAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
