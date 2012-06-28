<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetConfirmCommandForInfraredTuningPlugin(java.lang.String, int, java.lang.String, java.lang.String)'>Configuration.SetConfirmCommandForInfraredTuningPlugin</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="pluginName" required="true" type="java.lang.String" %>
<%@ attribute name="pluginPortNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteName" required="true" type="java.lang.String" %>
<%@ attribute name="command" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginNameAttr = jspContext.getAttribute("pluginName");
Object pluginPortNumberAttr = jspContext.getAttribute("pluginPortNumber");
Object remoteNameAttr = jspContext.getAttribute("remoteName");
Object commandAttr = jspContext.getAttribute("command");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetConfirmCommandForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr, commandAttr});
}
else
{
    sage.SageTV.api("SetConfirmCommandForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr, commandAttr});
}
%>
