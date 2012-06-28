<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ChannelAPI.html#IsChannelViewableOnNumberOnLineup(sage.Channel, java.lang.String, java.lang.String)'>ChannelAPI.IsChannelViewableOnNumberOnLineup</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="channel" required="true" type="java.lang.Object" %>
<%@ attribute name="channelNumber" required="true" type="java.lang.String" %>
<%@ attribute name="lineup" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object channelAttr = jspContext.getAttribute("channel");
Object channelNumberAttr = jspContext.getAttribute("channelNumber");
Object lineupAttr = jspContext.getAttribute("lineup");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "IsChannelViewableOnNumberOnLineup", new Object[] {channelAttr, channelNumberAttr, lineupAttr});
}
else
{
    returnVal = sage.SageTV.api("IsChannelViewableOnNumberOnLineup", new Object[] {channelAttr, channelNumberAttr, lineupAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
