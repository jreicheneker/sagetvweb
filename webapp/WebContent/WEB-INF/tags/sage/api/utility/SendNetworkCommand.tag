<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#SendNetworkCommand(java.lang.String, int, java.lang.Object)'>Utility.SendNetworkCommand</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="hostname" required="true" type="java.lang.String" %>
<%@ attribute name="port" required="true" type="java.lang.Integer" %>
<%@ attribute name="command" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object hostnameAttr = jspContext.getAttribute("hostname");
Object portAttr = jspContext.getAttribute("port");
Object commandAttr = jspContext.getAttribute("command");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SendNetworkCommand", new Object[] {hostnameAttr, portAttr, commandAttr});
}
else
{
    returnVal = sage.SageTV.api("SendNetworkCommand", new Object[] {hostnameAttr, portAttr, commandAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
