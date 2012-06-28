<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetVideoBackgroundColor(java.awt.Color)'>Configuration.SetVideoBackgroundColor</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="color" required="true" type="java.awt.Color" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object colorAttr = jspContext.getAttribute("color");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetVideoBackgroundColor", new Object[] {colorAttr});
}
else
{
    sage.SageTV.api("SetVideoBackgroundColor", new Object[] {colorAttr});
}
%>
