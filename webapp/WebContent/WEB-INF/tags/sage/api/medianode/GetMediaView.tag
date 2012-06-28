<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#GetMediaView(java.lang.String, java.lang.Object)'>MediaNodeAPI.GetMediaView</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object nameAttr = jspContext.getAttribute("name");
Object dataAttr = jspContext.getAttribute("data");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetMediaView", new Object[] {nameAttr, dataAttr});
}
else
{
    returnVal = sage.SageTV.api("GetMediaView", new Object[] {nameAttr, dataAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
