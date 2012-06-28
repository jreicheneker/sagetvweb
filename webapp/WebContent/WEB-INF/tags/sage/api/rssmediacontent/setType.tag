<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSMediaContent.html#setType(java.lang.String)'>RSSMediaContent.setType</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="type" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object typeAttr = jspContext.getAttribute("type");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setType", new Object[] {typeAttr});
}
else
{
    sage.SageTV.api("setType", new Object[] {typeAttr});
}
%>
