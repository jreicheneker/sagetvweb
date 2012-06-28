<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSHandler.html#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)'>RSSHandler.startElement</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="uri" required="true" type="java.lang.String" %>
<%@ attribute name="localName" required="true" type="java.lang.String" %>
<%@ attribute name="qName" required="true" type="java.lang.String" %>
<%@ attribute name="attributes" required="true" type="org.xml.sax.Attributes" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object uriAttr = jspContext.getAttribute("uri");
Object localNameAttr = jspContext.getAttribute("localName");
Object qNameAttr = jspContext.getAttribute("qName");
Object attributesAttr = jspContext.getAttribute("attributes");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "startElement", new Object[] {uriAttr, localNameAttr, qNameAttr, attributesAttr});
}
else
{
    sage.SageTV.api("startElement", new Object[] {uriAttr, localNameAttr, qNameAttr, attributesAttr});
}
%>
