<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#GetScheduledRecordingsForDeviceForTime(java.lang.String, long, long)'>Global.GetScheduledRecordingsForDeviceForTime</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDevice" required="true" type="java.lang.String" %>
<%@ attribute name="startTime" required="true" type="java.lang.Long" %>
<%@ attribute name="stopTime" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceAttr = jspContext.getAttribute("captureDevice");
Object startTimeAttr = jspContext.getAttribute("startTime");
Object stopTimeAttr = jspContext.getAttribute("stopTime");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetScheduledRecordingsForDeviceForTime", new Object[] {captureDeviceAttr, startTimeAttr, stopTimeAttr});
}
else
{
    returnVal = sage.SageTV.api("GetScheduledRecordingsForDeviceForTime", new Object[] {captureDeviceAttr, startTimeAttr, stopTimeAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
