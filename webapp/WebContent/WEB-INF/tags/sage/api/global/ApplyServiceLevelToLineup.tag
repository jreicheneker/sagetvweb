<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#ApplyServiceLevelToLineup(java.lang.String, int)'>Global.ApplyServiceLevelToLineup</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="lineup" required="true" type="java.lang.String" %>
<%@ attribute name="serviceLevel" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object lineupAttr = jspContext.getAttribute("lineup");
Object serviceLevelAttr = jspContext.getAttribute("serviceLevel");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "ApplyServiceLevelToLineup", new Object[] {lineupAttr, serviceLevelAttr});
}
else
{
    sage.SageTV.api("ApplyServiceLevelToLineup", new Object[] {lineupAttr, serviceLevelAttr});
}
%>
