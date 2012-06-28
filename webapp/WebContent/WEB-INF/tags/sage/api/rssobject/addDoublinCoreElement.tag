<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSObject.html#addDoublinCoreElement(java.lang.String, java.lang.String)'>RSSObject.addDoublinCoreElement</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="tag" required="true" type="java.lang.String" %>
<%@ attribute name="data" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object tagAttr = jspContext.getAttribute("tag");
Object dataAttr = jspContext.getAttribute("data");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "addDoublinCoreElement", new Object[] {tagAttr, dataAttr});
}
else
{
    sage.SageTV.api("addDoublinCoreElement", new Object[] {tagAttr, dataAttr});
}
%>
