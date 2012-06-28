<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#GetUIComponentForVariable(java.lang.String, java.lang.Object)'>Global.GetUIComponentForVariable</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="matchName" required="true" type="java.lang.String" %>
<%@ attribute name="matchValue" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object matchNameAttr = jspContext.getAttribute("matchName");
Object matchValueAttr = jspContext.getAttribute("matchValue");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetUIComponentForVariable", new Object[] {matchNameAttr, matchValueAttr});
}
else
{
    returnVal = sage.SageTV.api("GetUIComponentForVariable", new Object[] {matchNameAttr, matchValueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
