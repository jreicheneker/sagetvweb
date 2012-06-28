<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ChannelAPI.html#GetChannelLogo(sage.Channel, java.lang.String, int, boolean)'>ChannelAPI.GetChannelLogo</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="channel" required="true" type="java.lang.Object" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ attribute name="index" required="true" type="java.lang.Integer" %>
<%@ attribute name="fallback" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object channelAttr = jspContext.getAttribute("channel");
Object typeAttr = jspContext.getAttribute("type");
Object indexAttr = jspContext.getAttribute("index");
Object fallbackAttr = jspContext.getAttribute("fallback");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetChannelLogo", new Object[] {channelAttr, typeAttr, indexAttr, fallbackAttr});
}
else
{
    returnVal = sage.SageTV.api("GetChannelLogo", new Object[] {channelAttr, typeAttr, indexAttr, fallbackAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
