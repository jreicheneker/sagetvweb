<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSParser.html#setValidate(boolean)'>RSSParser.setValidate</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="b" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object bAttr = jspContext.getAttribute("b");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setValidate", new Object[] {bAttr});
}
else
{
    sage.SageTV.api("setValidate", new Object[] {bAttr});
}
%>
