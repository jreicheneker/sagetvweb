<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#GetCarrierFrequencyForInfraredTuningPlugin(java.lang.String, int, java.lang.String)'>Configuration.GetCarrierFrequencyForInfraredTuningPlugin</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="pluginName" required="true" type="java.lang.String" %>
<%@ attribute name="pluginPortNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginNameAttr = jspContext.getAttribute("pluginName");
Object pluginPortNumberAttr = jspContext.getAttribute("pluginPortNumber");
Object remoteNameAttr = jspContext.getAttribute("remoteName");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetCarrierFrequencyForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr});
}
else
{
    returnVal = sage.SageTV.api("GetCarrierFrequencyForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
