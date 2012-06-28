<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#FilterByMethodRegex(java.lang.Object, java.lang.String, java.util.regex.Pattern, boolean, boolean)'>Database.FilterByMethodRegex</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>
<%@ attribute name="method" required="true" type="java.lang.String" %>
<%@ attribute name="regexPattern" required="true" type="java.util.regex.Pattern" %>
<%@ attribute name="matchedPasses" required="true" type="java.lang.Boolean" %>
<%@ attribute name="completeMatch" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataAttr = jspContext.getAttribute("data");
Object methodAttr = jspContext.getAttribute("method");
Object regexPatternAttr = jspContext.getAttribute("regexPattern");
Object matchedPassesAttr = jspContext.getAttribute("matchedPasses");
Object completeMatchAttr = jspContext.getAttribute("completeMatch");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "FilterByMethodRegex", new Object[] {dataAttr, methodAttr, regexPatternAttr, matchedPassesAttr, completeMatchAttr});
}
else
{
    returnVal = sage.SageTV.api("FilterByMethodRegex", new Object[] {dataAttr, methodAttr, regexPatternAttr, matchedPassesAttr, completeMatchAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
