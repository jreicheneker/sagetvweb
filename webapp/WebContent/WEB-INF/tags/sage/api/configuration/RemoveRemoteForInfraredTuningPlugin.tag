<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#RemoveRemoteForInfraredTuningPlugin(java.lang.String, int, java.lang.String)'>Configuration.RemoveRemoteForInfraredTuningPlugin</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="pluginName" required="true" type="java.lang.String" %>
<%@ attribute name="pluginPortNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginNameAttr = jspContext.getAttribute("pluginName");
Object pluginPortNumberAttr = jspContext.getAttribute("pluginPortNumber");
Object remoteNameAttr = jspContext.getAttribute("remoteName");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemoveRemoteForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr});
}
else
{
    sage.SageTV.api("RemoveRemoteForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr});
}
%>
