<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#StringIndexOf(java.lang.String, java.lang.String)'>Utility.StringIndexOf</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="fullString" required="true" type="java.lang.String" %>
<%@ attribute name="matchString" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object fullStringAttr = jspContext.getAttribute("fullString");
Object matchStringAttr = jspContext.getAttribute("matchString");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "StringIndexOf", new Object[] {fullStringAttr, matchStringAttr});
}
else
{
    returnVal = sage.SageTV.api("StringIndexOf", new Object[] {fullStringAttr, matchStringAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
