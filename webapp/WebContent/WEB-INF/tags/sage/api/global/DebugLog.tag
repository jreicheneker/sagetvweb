<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#DebugLog(java.lang.String)'>Global.DebugLog</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="debugString" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object debugStringAttr = jspContext.getAttribute("debugString");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "DebugLog", new Object[] {debugStringAttr});
}
else
{
    sage.SageTV.api("DebugLog", new Object[] {debugStringAttr});
}
%>
