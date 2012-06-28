<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#Substring(java.lang.String, int, int)'>Utility.Substring</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="string" required="true" type="java.lang.String" %>
<%@ attribute name="startIndex" required="true" type="java.lang.Integer" %>
<%@ attribute name="endIndex" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object stringAttr = jspContext.getAttribute("string");
Object startIndexAttr = jspContext.getAttribute("startIndex");
Object endIndexAttr = jspContext.getAttribute("endIndex");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "Substring", new Object[] {stringAttr, startIndexAttr, endIndexAttr});
}
else
{
    returnVal = sage.SageTV.api("Substring", new Object[] {stringAttr, startIndexAttr, endIndexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
