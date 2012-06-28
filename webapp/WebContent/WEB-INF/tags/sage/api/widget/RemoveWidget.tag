<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#RemoveWidget(sage.Widget)'>WidgetAPI.RemoveWidget</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widget" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetAttr = jspContext.getAttribute("widget");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemoveWidget", new Object[] {widgetAttr});
}
else
{
    sage.SageTV.api("RemoveWidget", new Object[] {widgetAttr});
}
%>
