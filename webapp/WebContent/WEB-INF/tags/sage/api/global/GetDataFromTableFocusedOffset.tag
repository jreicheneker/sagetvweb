<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#GetDataFromTableFocusedOffset(java.lang.Object, int, boolean)'>Global.GetDataFromTableFocusedOffset</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="uIComponent" required="true" type="java.lang.Object" %>
<%@ attribute name="offset" required="true" type="java.lang.Integer" %>
<%@ attribute name="wrapIndex" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object uIComponentAttr = jspContext.getAttribute("uIComponent");
Object offsetAttr = jspContext.getAttribute("offset");
Object wrapIndexAttr = jspContext.getAttribute("wrapIndex");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetDataFromTableFocusedOffset", new Object[] {uIComponentAttr, offsetAttr, wrapIndexAttr});
}
else
{
    returnVal = sage.SageTV.api("GetDataFromTableFocusedOffset", new Object[] {uIComponentAttr, offsetAttr, wrapIndexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
