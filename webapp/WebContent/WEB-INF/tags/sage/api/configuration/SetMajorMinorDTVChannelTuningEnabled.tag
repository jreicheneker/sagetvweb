<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetMajorMinorDTVChannelTuningEnabled(boolean)'>Configuration.SetMajorMinorDTVChannelTuningEnabled</a>
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
    sage.SageTV.apiUI(context, "SetMajorMinorDTVChannelTuningEnabled", new Object[] {enabledAttr});
}
else
{
    sage.SageTV.api("SetMajorMinorDTVChannelTuningEnabled", new Object[] {enabledAttr});
}
%>
