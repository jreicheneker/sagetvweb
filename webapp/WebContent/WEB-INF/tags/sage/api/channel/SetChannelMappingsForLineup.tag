<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ChannelAPI.html#SetChannelMappingsForLineup(sage.Channel, java.lang.String, java.lang.String[])'>ChannelAPI.SetChannelMappingsForLineup</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="channel" required="true" type="java.lang.Object" %>
<%@ attribute name="lineup" required="true" type="java.lang.String" %>
<%@ attribute name="newNumbers" required="true" type="java.lang.String[]" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object channelAttr = jspContext.getAttribute("channel");
Object lineupAttr = jspContext.getAttribute("lineup");
Object newNumbersAttr = jspContext.getAttribute("newNumbers");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetChannelMappingsForLineup", new Object[] {channelAttr, lineupAttr, newNumbersAttr});
}
else
{
    sage.SageTV.api("SetChannelMappingsForLineup", new Object[] {channelAttr, lineupAttr, newNumbersAttr});
}
%>
