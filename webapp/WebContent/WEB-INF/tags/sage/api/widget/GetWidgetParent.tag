<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/WidgetAPI.html#GetWidgetParent(sage.Widget, java.lang.String, java.lang.String)'>WidgetAPI.GetWidgetParent</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="widget" required="true" type="java.lang.Object" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widgetAttr = jspContext.getAttribute("widget");
Object typeAttr = jspContext.getAttribute("type");
Object nameAttr = jspContext.getAttribute("name");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetWidgetParent", new Object[] {widgetAttr, typeAttr, nameAttr});
}
else
{
    returnVal = sage.SageTV.api("GetWidgetParent", new Object[] {widgetAttr, typeAttr, nameAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
