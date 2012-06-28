<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#AddToGrouping(java.util.Map, java.lang.Object, java.lang.Object)'>Utility.AddToGrouping</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="grouping" required="true" type="java.util.Map" %>
<%@ attribute name="key" required="true" type="java.lang.Object" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object groupingAttr = jspContext.getAttribute("grouping");
Object keyAttr = jspContext.getAttribute("key");
Object valueAttr = jspContext.getAttribute("value");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddToGrouping", new Object[] {groupingAttr, keyAttr, valueAttr});
}
else
{
    returnVal = sage.SageTV.api("AddToGrouping", new Object[] {groupingAttr, keyAttr, valueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
