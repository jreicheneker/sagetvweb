<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#FindComparativeElement(java.lang.Object, java.lang.Comparable, java.lang.String)'>Utility.FindComparativeElement</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>
<%@ attribute name="criteria" required="true" type="java.lang.Comparable" %>
<%@ attribute name="method" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataAttr = jspContext.getAttribute("data");
Object criteriaAttr = jspContext.getAttribute("criteria");
Object methodAttr = jspContext.getAttribute("method");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "FindComparativeElement", new Object[] {dataAttr, criteriaAttr, methodAttr});
}
else
{
    returnVal = sage.SageTV.api("FindComparativeElement", new Object[] {dataAttr, criteriaAttr, methodAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
