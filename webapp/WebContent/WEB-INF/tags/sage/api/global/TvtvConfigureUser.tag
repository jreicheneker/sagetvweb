<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#TvtvConfigureUser(java.lang.String, java.lang.String, java.lang.String)'>Global.TvtvConfigureUser</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="username" required="true" type="java.lang.String" %>
<%@ attribute name="password" required="true" type="java.lang.String" %>
<%@ attribute name="host" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object usernameAttr = jspContext.getAttribute("username");
Object passwordAttr = jspContext.getAttribute("password");
Object hostAttr = jspContext.getAttribute("host");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "TvtvConfigureUser", new Object[] {usernameAttr, passwordAttr, hostAttr});
}
else
{
    sage.SageTV.api("TvtvConfigureUser", new Object[] {usernameAttr, passwordAttr, hostAttr});
}
%>
