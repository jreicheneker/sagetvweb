<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceAPI.html#SetCaptureDeviceAudioSource(java.lang.String, java.lang.String)'>CaptureDeviceAPI.SetCaptureDeviceAudioSource</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDevice" required="true" type="java.lang.String" %>
<%@ attribute name="audioSource" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceAttr = jspContext.getAttribute("captureDevice");
Object audioSourceAttr = jspContext.getAttribute("audioSource");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetCaptureDeviceAudioSource", new Object[] {captureDeviceAttr, audioSourceAttr});
}
else
{
    sage.SageTV.api("SetCaptureDeviceAudioSource", new Object[] {captureDeviceAttr, audioSourceAttr});
}
%>
