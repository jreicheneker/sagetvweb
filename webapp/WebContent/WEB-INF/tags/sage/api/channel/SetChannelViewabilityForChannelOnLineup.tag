<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ChannelAPI.html#SetChannelViewabilityForChannelOnLineup(sage.Channel, java.lang.String, boolean)'>ChannelAPI.SetChannelViewabilityForChannelOnLineup</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="channel" required="true" type="java.lang.Object" %>
<%@ attribute name="lineup" required="true" type="java.lang.String" %>
<%@ attribute name="viewable" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object channelAttr = jspContext.getAttribute("channel");
Object lineupAttr = jspContext.getAttribute("lineup");
Object viewableAttr = jspContext.getAttribute("viewable");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetChannelViewabilityForChannelOnLineup", new Object[] {channelAttr, lineupAttr, viewableAttr});
}
else
{
    sage.SageTV.api("SetChannelViewabilityForChannelOnLineup", new Object[] {channelAttr, lineupAttr, viewableAttr});
}
%>
