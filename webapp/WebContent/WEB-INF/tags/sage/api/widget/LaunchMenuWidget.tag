<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#LaunchMenuWidget(sage.Widget)'>WidgetAPI.LaunchMenuWidget</a>
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
    sage.SageTV.apiUI(context, "LaunchMenuWidget", new Object[] {widgetAttr});
}
else
{
    sage.SageTV.api("LaunchMenuWidget", new Object[] {widgetAttr});
}
%>
