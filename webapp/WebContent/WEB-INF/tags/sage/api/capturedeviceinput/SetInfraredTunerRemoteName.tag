<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceInputAPI.html#SetInfraredTunerRemoteName(java.lang.String, java.lang.String)'>CaptureDeviceInputAPI.SetInfraredTunerRemoteName</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDeviceInput" required="true" type="java.lang.String" %>
<%@ attribute name="externalDeviceName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceInputAttr = jspContext.getAttribute("captureDeviceInput");
Object externalDeviceNameAttr = jspContext.getAttribute("externalDeviceName");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetInfraredTunerRemoteName", new Object[] {captureDeviceInputAttr, externalDeviceNameAttr});
}
else
{
    sage.SageTV.api("SetInfraredTunerRemoteName", new Object[] {captureDeviceInputAttr, externalDeviceNameAttr});
}
%>
