<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceInputAPI.html#SetCaptureBrightness(java.lang.String, int)'>CaptureDeviceInputAPI.SetCaptureBrightness</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDeviceInput" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceInputAttr = jspContext.getAttribute("captureDeviceInput");
Object valueAttr = jspContext.getAttribute("value");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetCaptureBrightness", new Object[] {captureDeviceInputAttr, valueAttr});
}
else
{
    sage.SageTV.api("SetCaptureBrightness", new Object[] {captureDeviceInputAttr, valueAttr});
}
%>
