<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#TransmitCommandUsingInfraredTuningPlugin(java.lang.String, int, java.lang.String, java.lang.String, int)'>Global.TransmitCommandUsingInfraredTuningPlugin</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="tuningPlugin" required="true" type="java.lang.String" %>
<%@ attribute name="tuningPluginPort" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteName" required="true" type="java.lang.String" %>
<%@ attribute name="commandName" required="true" type="java.lang.String" %>
<%@ attribute name="repeatFactor" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object tuningPluginAttr = jspContext.getAttribute("tuningPlugin");
Object tuningPluginPortAttr = jspContext.getAttribute("tuningPluginPort");
Object remoteNameAttr = jspContext.getAttribute("remoteName");
Object commandNameAttr = jspContext.getAttribute("commandName");
Object repeatFactorAttr = jspContext.getAttribute("repeatFactor");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "TransmitCommandUsingInfraredTuningPlugin", new Object[] {tuningPluginAttr, tuningPluginPortAttr, remoteNameAttr, commandNameAttr, repeatFactorAttr});
}
else
{
    sage.SageTV.api("TransmitCommandUsingInfraredTuningPlugin", new Object[] {tuningPluginAttr, tuningPluginPortAttr, remoteNameAttr, commandNameAttr, repeatFactorAttr});
}
%>
