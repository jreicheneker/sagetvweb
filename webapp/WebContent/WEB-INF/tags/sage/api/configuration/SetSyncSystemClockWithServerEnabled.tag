<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetSyncSystemClockWithServerEnabled(boolean)'>Configuration.SetSyncSystemClockWithServerEnabled</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="enabled" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object enabledAttr = jspContext.getAttribute("enabled");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetSyncSystemClockWithServerEnabled", new Object[] {enabledAttr});
}
else
{
    sage.SageTV.api("SetSyncSystemClockWithServerEnabled", new Object[] {enabledAttr});
}
%>
