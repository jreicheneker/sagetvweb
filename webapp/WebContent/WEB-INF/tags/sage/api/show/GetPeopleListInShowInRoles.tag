<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ShowAPI.html#GetPeopleListInShowInRoles(sage.Show, java.lang.String[])'>ShowAPI.GetPeopleListInShowInRoles</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="show" required="true" type="java.lang.Object" %>
<%@ attribute name="roleList" required="true" type="java.lang.String[]" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showAttr = jspContext.getAttribute("show");
Object roleListAttr = jspContext.getAttribute("roleList");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetPeopleListInShowInRoles", new Object[] {showAttr, roleListAttr});
}
else
{
    returnVal = sage.SageTV.api("GetPeopleListInShowInRoles", new Object[] {showAttr, roleListAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
