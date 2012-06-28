<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#RefreshAreaForVariable(java.lang.String, java.lang.Object)'>Global.RefreshAreaForVariable</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object nameAttr = jspContext.getAttribute("name");
Object valueAttr = jspContext.getAttribute("value");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RefreshAreaForVariable", new Object[] {nameAttr, valueAttr});
}
else
{
    sage.SageTV.api("RefreshAreaForVariable", new Object[] {nameAttr, valueAttr});
}
%>
