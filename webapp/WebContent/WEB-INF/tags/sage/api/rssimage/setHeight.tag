<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSImage.html#setHeight(java.lang.String)'>RSSImage.setHeight</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="height" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object heightAttr = jspContext.getAttribute("height");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setHeight", new Object[] {heightAttr});
}
else
{
    sage.SageTV.api("setHeight", new Object[] {heightAttr});
}
%>
