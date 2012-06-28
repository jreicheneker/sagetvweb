<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#InsertWidgetChild(sage.Widget, sage.Widget, int)'>WidgetAPI.InsertWidgetChild</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widgetParent" required="true" type="java.lang.Object" %>
<%@ attribute name="widgetChild" required="true" type="java.lang.Object" %>
<%@ attribute name="childIndex" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetParentAttr = jspContext.getAttribute("widgetParent");
Object widgetChildAttr = jspContext.getAttribute("widgetChild");
Object childIndexAttr = jspContext.getAttribute("childIndex");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "InsertWidgetChild", new Object[] {widgetParentAttr, widgetChildAttr, childIndexAttr});
}
else
{
    sage.SageTV.api("InsertWidgetChild", new Object[] {widgetParentAttr, widgetChildAttr, childIndexAttr});
}
%>
