<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceAPI.html#SetCaptureDeviceDTVStandard(java.lang.String, java.lang.String)'>CaptureDeviceAPI.SetCaptureDeviceDTVStandard</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDevice" required="true" type="java.lang.String" %>
<%@ attribute name="dTVStandard" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceAttr = jspContext.getAttribute("captureDevice");
Object dTVStandardAttr = jspContext.getAttribute("dTVStandard");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetCaptureDeviceDTVStandard", new Object[] {captureDeviceAttr, dTVStandardAttr});
}
else
{
    sage.SageTV.api("SetCaptureDeviceDTVStandard", new Object[] {captureDeviceAttr, dTVStandardAttr});
}
%>
