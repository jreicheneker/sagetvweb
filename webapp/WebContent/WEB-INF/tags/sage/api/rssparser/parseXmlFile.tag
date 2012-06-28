<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSParser.html#parseXmlFile(java.net.URL, org.xml.sax.helpers.DefaultHandler, boolean)'>RSSParser.parseXmlFile</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="remote_url" required="true" type="java.net.URL" %>
<%@ attribute name="handler" required="true" type="org.xml.sax.helpers.DefaultHandler" %>
<%@ attribute name="validating" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object remote_urlAttr = jspContext.getAttribute("remote_url");
Object handlerAttr = jspContext.getAttribute("handler");
Object validatingAttr = jspContext.getAttribute("validating");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "parseXmlFile", new Object[] {remote_urlAttr, handlerAttr, validatingAttr});
}
else
{
    sage.SageTV.api("parseXmlFile", new Object[] {remote_urlAttr, handlerAttr, validatingAttr});
}
%>
