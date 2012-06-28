<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#SetWatchedTimes(sage.Airing, long, long)'>AiringAPI.SetWatchedTimes</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="watchedEndTime" required="true" type="java.lang.Long" %>
<%@ attribute name="realStartTime" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airingAttr = jspContext.getAttribute("airing");
Object watchedEndTimeAttr = jspContext.getAttribute("watchedEndTime");
Object realStartTimeAttr = jspContext.getAttribute("realStartTime");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetWatchedTimes", new Object[] {airingAttr, watchedEndTimeAttr, realStartTimeAttr});
}
else
{
    sage.SageTV.api("SetWatchedTimes", new Object[] {airingAttr, watchedEndTimeAttr, realStartTimeAttr});
}
%>
