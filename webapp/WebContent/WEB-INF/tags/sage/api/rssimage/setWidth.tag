<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSImage.html#setWidth(java.lang.String)'>RSSImage.setWidth</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="width" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object widthAttr = jspContext.getAttribute("width");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setWidth", new Object[] {widthAttr});
}
else
{
    sage.SageTV.api("setWidth", new Object[] {widthAttr});
}
%>
