<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSParser.html#setXmlResource(java.net.URL)'>RSSParser.setXmlResource</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="ur" required="true" type="java.net.URL" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object urAttr = jspContext.getAttribute("ur");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setXmlResource", new Object[] {urAttr});
}
else
{
    sage.SageTV.api("setXmlResource", new Object[] {urAttr});
}
%>
