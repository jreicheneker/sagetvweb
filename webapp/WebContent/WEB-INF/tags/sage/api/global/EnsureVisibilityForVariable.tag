<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#EnsureVisibilityForVariable(java.lang.String, java.lang.Object, int)'>Global.EnsureVisibilityForVariable</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>
<%@ attribute name="displayIndex" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object nameAttr = jspContext.getAttribute("name");
Object valueAttr = jspContext.getAttribute("value");
Object displayIndexAttr = jspContext.getAttribute("displayIndex");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "EnsureVisibilityForVariable", new Object[] {nameAttr, valueAttr, displayIndexAttr});
}
else
{
    returnVal = sage.SageTV.api("EnsureVisibilityForVariable", new Object[] {nameAttr, valueAttr, displayIndexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
