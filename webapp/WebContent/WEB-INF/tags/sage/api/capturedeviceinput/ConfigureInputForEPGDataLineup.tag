<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/CaptureDeviceInputAPI.html#ConfigureInputForEPGDataLineup(java.lang.String, java.lang.String)'>CaptureDeviceInputAPI.ConfigureInputForEPGDataLineup</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDeviceInput" required="true" type="java.lang.String" %>
<%@ attribute name="lineup" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceInputAttr = jspContext.getAttribute("captureDeviceInput");
Object lineupAttr = jspContext.getAttribute("lineup");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "ConfigureInputForEPGDataLineup", new Object[] {captureDeviceInputAttr, lineupAttr});
}
else
{
    returnVal = sage.SageTV.api("ConfigureInputForEPGDataLineup", new Object[] {captureDeviceInputAttr, lineupAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
