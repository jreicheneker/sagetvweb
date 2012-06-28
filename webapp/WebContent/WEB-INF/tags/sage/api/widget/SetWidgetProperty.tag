<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#SetWidgetProperty(sage.Widget, java.lang.String, java.lang.String)'>WidgetAPI.SetWidgetProperty</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widget" required="true" type="java.lang.Object" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>
<%@ attribute name="propertyValue" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetAttr = jspContext.getAttribute("widget");
Object propertyNameAttr = jspContext.getAttribute("propertyName");
Object propertyValueAttr = jspContext.getAttribute("propertyValue");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetWidgetProperty", new Object[] {widgetAttr, propertyNameAttr, propertyValueAttr});
}
else
{
    sage.SageTV.api("SetWidgetProperty", new Object[] {widgetAttr, propertyNameAttr, propertyValueAttr});
}
%>
