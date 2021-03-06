<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/TVEditorialAPI.html#GetEditorialAirDate(sage.TVEditorial)'>TVEditorialAPI.GetEditorialAirDate</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="tVEditorial" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object tVEditorialAttr = jspContext.getAttribute("tVEditorial");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetEditorialAirDate", new Object[] {tVEditorialAttr});
}
else
{
    returnVal = sage.SageTV.api("GetEditorialAirDate", new Object[] {tVEditorialAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
