<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#RenameCommandForInfraredTuningPlugin(java.lang.String, int, java.lang.String, java.lang.String, java.lang.String)'>Configuration.RenameCommandForInfraredTuningPlugin</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="pluginName" required="true" type="java.lang.String" %>
<%@ attribute name="pluginPortNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteName" required="true" type="java.lang.String" %>
<%@ attribute name="oldCommandName" required="true" type="java.lang.String" %>
<%@ attribute name="newCommandName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginNameAttr = jspContext.getAttribute("pluginName");
Object pluginPortNumberAttr = jspContext.getAttribute("pluginPortNumber");
Object remoteNameAttr = jspContext.getAttribute("remoteName");
Object oldCommandNameAttr = jspContext.getAttribute("oldCommandName");
Object newCommandNameAttr = jspContext.getAttribute("newCommandName");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RenameCommandForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr, oldCommandNameAttr, newCommandNameAttr});
}
else
{
    sage.SageTV.api("RenameCommandForInfraredTuningPlugin", new Object[] {pluginNameAttr, pluginPortNumberAttr, remoteNameAttr, oldCommandNameAttr, newCommandNameAttr});
}
%>
