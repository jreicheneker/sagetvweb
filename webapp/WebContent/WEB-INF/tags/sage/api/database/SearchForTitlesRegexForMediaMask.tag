<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#SearchForTitlesRegex(java.util.regex.Pattern, java.lang.String)'>Database.SearchForTitlesRegex</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="regexPattern" required="true" type="java.util.regex.Pattern" %>
<%@ attribute name="mediaMask" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object regexPatternAttr = jspContext.getAttribute("regexPattern");
Object mediaMaskAttr = jspContext.getAttribute("mediaMask");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SearchForTitlesRegex", new Object[] {regexPatternAttr, mediaMaskAttr});
}
else
{
    returnVal = sage.SageTV.api("SearchForTitlesRegex", new Object[] {regexPatternAttr, mediaMaskAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
