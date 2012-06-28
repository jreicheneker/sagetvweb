<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#SortLexical(java.lang.Object, boolean, java.lang.String)'>Database.SortLexical</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>
<%@ attribute name="descending" required="true" type="java.lang.Boolean" %>
<%@ attribute name="sortByMethod" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataAttr = jspContext.getAttribute("data");
Object descendingAttr = jspContext.getAttribute("descending");
Object sortByMethodAttr = jspContext.getAttribute("sortByMethod");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SortLexical", new Object[] {dataAttr, descendingAttr, sortByMethodAttr});
}
else
{
    returnVal = sage.SageTV.api("SortLexical", new Object[] {dataAttr, descendingAttr, sortByMethodAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
