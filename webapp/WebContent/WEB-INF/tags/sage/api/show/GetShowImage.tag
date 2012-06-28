<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ShowAPI.html#GetShowImage(sage.Show, java.lang.String, int, int)'>ShowAPI.GetShowImage</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="show" required="true" type="java.lang.Object" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>
<%@ attribute name="index" required="true" type="java.lang.Integer" %>
<%@ attribute name="fallback" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showAttr = jspContext.getAttribute("show");
Object typeAttr = jspContext.getAttribute("type");
Object indexAttr = jspContext.getAttribute("index");
Object fallbackAttr = jspContext.getAttribute("fallback");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetShowImage", new Object[] {showAttr, typeAttr, indexAttr, fallbackAttr});
}
else
{
    returnVal = sage.SageTV.api("GetShowImage", new Object[] {showAttr, typeAttr, indexAttr, fallbackAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
