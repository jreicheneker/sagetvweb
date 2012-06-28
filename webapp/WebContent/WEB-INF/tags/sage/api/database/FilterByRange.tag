<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#FilterByRange(java.lang.Object, java.lang.String, java.lang.Comparable, java.lang.Comparable, boolean)'>Database.FilterByRange</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>
<%@ attribute name="method" required="true" type="java.lang.String" %>
<%@ attribute name="lowerBoundInclusive" required="true" type="java.lang.Comparable" %>
<%@ attribute name="upperBoundExclusive" required="true" type="java.lang.Comparable" %>
<%@ attribute name="keepWithinBounds" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataAttr = jspContext.getAttribute("data");
Object methodAttr = jspContext.getAttribute("method");
Object lowerBoundInclusiveAttr = jspContext.getAttribute("lowerBoundInclusive");
Object upperBoundExclusiveAttr = jspContext.getAttribute("upperBoundExclusive");
Object keepWithinBoundsAttr = jspContext.getAttribute("keepWithinBounds");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "FilterByRange", new Object[] {dataAttr, methodAttr, lowerBoundInclusiveAttr, upperBoundExclusiveAttr, keepWithinBoundsAttr});
}
else
{
    returnVal = sage.SageTV.api("FilterByRange", new Object[] {dataAttr, methodAttr, lowerBoundInclusiveAttr, upperBoundExclusiveAttr, keepWithinBoundsAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
