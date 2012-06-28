<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#GetSubpropertiesThatAreLeaves(java.lang.String)'>Configuration.GetSubpropertiesThatAreLeaves</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object propertyNameAttr = jspContext.getAttribute("propertyName");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetSubpropertiesThatAreLeaves", new Object[] {propertyNameAttr});
}
else
{
    returnVal = sage.SageTV.api("GetSubpropertiesThatAreLeaves", new Object[] {propertyNameAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
