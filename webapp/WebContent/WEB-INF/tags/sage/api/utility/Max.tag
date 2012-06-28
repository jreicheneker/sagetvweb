<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#Max(java.lang.Number, java.lang.Number)'>Utility.Max</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="value1" required="true" type="java.lang.Number" %>
<%@ attribute name="value2" required="true" type="java.lang.Number" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object value1Attr = jspContext.getAttribute("value1");
Object value2Attr = jspContext.getAttribute("value2");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "Max", new Object[] {value1Attr, value2Attr});
}
else
{
    returnVal = sage.SageTV.api("Max", new Object[] {value1Attr, value2Attr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
