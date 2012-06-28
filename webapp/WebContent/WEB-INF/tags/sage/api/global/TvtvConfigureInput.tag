<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#TvtvConfigureInput(java.lang.String, java.lang.String, java.lang.String)'>Global.TvtvConfigureInput</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="captureDeviceInput" required="true" type="java.lang.String" %>
<%@ attribute name="username" required="true" type="java.lang.String" %>
<%@ attribute name="password" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object captureDeviceInputAttr = jspContext.getAttribute("captureDeviceInput");
Object usernameAttr = jspContext.getAttribute("username");
Object passwordAttr = jspContext.getAttribute("password");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "TvtvConfigureInput", new Object[] {captureDeviceInputAttr, usernameAttr, passwordAttr});
}
else
{
    returnVal = sage.SageTV.api("TvtvConfigureInput", new Object[] {captureDeviceInputAttr, usernameAttr, passwordAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
