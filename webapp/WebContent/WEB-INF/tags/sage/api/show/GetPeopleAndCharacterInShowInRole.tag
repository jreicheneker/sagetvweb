<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ShowAPI.html#GetPeopleAndCharacterInShowInRole(sage.Show, java.lang.String)'>ShowAPI.GetPeopleAndCharacterInShowInRole</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="show" required="true" type="java.lang.Object" %>
<%@ attribute name="role" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showAttr = jspContext.getAttribute("show");
Object roleAttr = jspContext.getAttribute("role");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetPeopleAndCharacterInShowInRole", new Object[] {showAttr, roleAttr});
}
else
{
    returnVal = sage.SageTV.api("GetPeopleAndCharacterInShowInRole", new Object[] {showAttr, roleAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
