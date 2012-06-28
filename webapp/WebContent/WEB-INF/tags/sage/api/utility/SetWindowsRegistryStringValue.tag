<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#SetWindowsRegistryStringValue(java.lang.String, java.lang.String, java.lang.String, java.lang.String)'>Utility.SetWindowsRegistryStringValue</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="root" required="true" type="java.lang.String" %>
<%@ attribute name="key" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object rootAttr = jspContext.getAttribute("root");
Object keyAttr = jspContext.getAttribute("key");
Object nameAttr = jspContext.getAttribute("name");
Object valueAttr = jspContext.getAttribute("value");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SetWindowsRegistryStringValue", new Object[] {rootAttr, keyAttr, nameAttr, valueAttr});
}
else
{
    returnVal = sage.SageTV.api("SetWindowsRegistryStringValue", new Object[] {rootAttr, keyAttr, nameAttr, valueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
