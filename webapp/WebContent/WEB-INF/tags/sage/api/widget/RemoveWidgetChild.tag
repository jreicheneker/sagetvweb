<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#RemoveWidgetChild(sage.Widget, sage.Widget)'>WidgetAPI.RemoveWidgetChild</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widgetParent" required="true" type="java.lang.Object" %>
<%@ attribute name="widgetChild" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetParentAttr = jspContext.getAttribute("widgetParent");
Object widgetChildAttr = jspContext.getAttribute("widgetChild");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemoveWidgetChild", new Object[] {widgetParentAttr, widgetChildAttr});
}
else
{
    sage.SageTV.api("RemoveWidgetChild", new Object[] {widgetParentAttr, widgetChildAttr});
}
%>
