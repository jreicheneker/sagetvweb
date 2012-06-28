<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/PluginAPI.html#GetPluginDemoVideos(sage.Plugin)'>PluginAPI.GetPluginDemoVideos</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="plugin" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginAttr = jspContext.getAttribute("plugin");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetPluginDemoVideos", new Object[] {pluginAttr});
}
else
{
    returnVal = sage.SageTV.api("GetPluginDemoVideos", new Object[] {pluginAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
