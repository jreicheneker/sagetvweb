<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceAPI.html#SetCaptureDeviceDefaultQuality(java.lang.String, java.lang.String)'>CaptureDeviceAPI.SetCaptureDeviceDefaultQuality</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDevice" required="true" type="java.lang.String" %>
<%@ attribute name="quality" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceAttr = jspContext.getAttribute("captureDevice");
Object qualityAttr = jspContext.getAttribute("quality");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetCaptureDeviceDefaultQuality", new Object[] {captureDeviceAttr, qualityAttr});
}
else
{
    sage.SageTV.api("SetCaptureDeviceDefaultQuality", new Object[] {captureDeviceAttr, qualityAttr});
}
%>
