<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/PluginAPI.html#SetPluginConfigValue(sage.Plugin, java.lang.String, java.lang.String)'>PluginAPI.SetPluginConfigValue</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="plugin" required="true" type="java.lang.Object" %>
<%@ attribute name="settingName" required="true" type="java.lang.String" %>
<%@ attribute name="settingValue" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object pluginAttr = jspContext.getAttribute("plugin");
Object settingNameAttr = jspContext.getAttribute("settingName");
Object settingValueAttr = jspContext.getAttribute("settingValue");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SetPluginConfigValue", new Object[] {pluginAttr, settingNameAttr, settingValueAttr});
}
else
{
    returnVal = sage.SageTV.api("SetPluginConfigValue", new Object[] {pluginAttr, settingNameAttr, settingValueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
