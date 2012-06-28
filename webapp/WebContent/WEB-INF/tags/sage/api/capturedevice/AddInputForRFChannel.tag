<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceAPI.html#AddInputForRFChannel(java.lang.String, int)'>CaptureDeviceAPI.AddInputForRFChannel</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDevice" required="true" type="java.lang.String" %>
<%@ attribute name="rFChannel" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceAttr = jspContext.getAttribute("captureDevice");
Object rFChannelAttr = jspContext.getAttribute("rFChannel");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddInputForRFChannel", new Object[] {captureDeviceAttr, rFChannelAttr});
}
else
{
    returnVal = sage.SageTV.api("AddInputForRFChannel", new Object[] {captureDeviceAttr, rFChannelAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
