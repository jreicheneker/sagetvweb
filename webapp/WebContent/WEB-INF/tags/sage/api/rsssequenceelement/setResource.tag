<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSSequenceElement.html#setResource(java.lang.String)'>RSSSequenceElement.setResource</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="res" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object resAttr = jspContext.getAttribute("res");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setResource", new Object[] {resAttr});
}
else
{
    sage.SageTV.api("setResource", new Object[] {resAttr});
}
%>
