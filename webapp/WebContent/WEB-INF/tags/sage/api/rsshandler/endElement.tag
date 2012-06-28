<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSHandler.html#endElement(java.lang.String, java.lang.String, java.lang.String)'>RSSHandler.endElement</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="uri" required="true" type="java.lang.String" %>
<%@ attribute name="localName" required="true" type="java.lang.String" %>
<%@ attribute name="qName" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object uriAttr = jspContext.getAttribute("uri");
Object localNameAttr = jspContext.getAttribute("localName");
Object qNameAttr = jspContext.getAttribute("qName");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "endElement", new Object[] {uriAttr, localNameAttr, qNameAttr});
}
else
{
    sage.SageTV.api("endElement", new Object[] {uriAttr, localNameAttr, qNameAttr});
}
%>
