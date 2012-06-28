<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceInputAPI.html#AutoScanChannelInfo(java.lang.String, java.lang.String)'>CaptureDeviceInputAPI.AutoScanChannelInfo</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDeviceInput" required="true" type="java.lang.String" %>
<%@ attribute name="channelNumber" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceInputAttr = jspContext.getAttribute("captureDeviceInput");
Object channelNumberAttr = jspContext.getAttribute("channelNumber");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AutoScanChannelInfo", new Object[] {captureDeviceInputAttr, channelNumberAttr});
}
else
{
    returnVal = sage.SageTV.api("AutoScanChannelInfo", new Object[] {captureDeviceInputAttr, channelNumberAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
