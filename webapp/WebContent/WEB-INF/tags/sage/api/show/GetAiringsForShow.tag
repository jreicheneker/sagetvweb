<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/ShowAPI.html#GetAiringsForShow(sage.Show, long)'>ShowAPI.GetAiringsForShow</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="show" required="true" type="java.lang.Object" %>
<%@ attribute name="startingAfterTime" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showAttr = jspContext.getAttribute("show");
Object startingAfterTimeAttr = jspContext.getAttribute("startingAfterTime");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetAiringsForShow", new Object[] {showAttr, startingAfterTimeAttr});
}
else
{
    returnVal = sage.SageTV.api("GetAiringsForShow", new Object[] {showAttr, startingAfterTimeAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
