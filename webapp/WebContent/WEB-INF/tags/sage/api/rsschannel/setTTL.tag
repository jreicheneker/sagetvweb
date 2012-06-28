<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSChannel.html#setTTL(java.lang.String)'>RSSChannel.setTTL</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="ttl" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object ttlAttr = jspContext.getAttribute("ttl");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setTTL", new Object[] {ttlAttr});
}
else
{
    sage.SageTV.api("setTTL", new Object[] {ttlAttr});
}
%>
