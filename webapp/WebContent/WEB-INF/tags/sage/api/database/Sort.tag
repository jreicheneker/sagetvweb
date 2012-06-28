<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#Sort(java.lang.Object, boolean, java.lang.Object)'>Database.Sort</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.Object" %>
<%@ attribute name="descending" required="true" type="java.lang.Boolean" %>
<%@ attribute name="sortTechnique" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object dataAttr = jspContext.getAttribute("data");
Object descendingAttr = jspContext.getAttribute("descending");
Object sortTechniqueAttr = jspContext.getAttribute("sortTechnique");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "Sort", new Object[] {dataAttr, descendingAttr, sortTechniqueAttr});
}
else
{
    returnVal = sage.SageTV.api("Sort", new Object[] {dataAttr, descendingAttr, sortTechniqueAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
