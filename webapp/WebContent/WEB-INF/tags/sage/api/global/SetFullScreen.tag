<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#SetFullScreen(boolean)'>Global.SetFullScreen</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="fullScreen" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object fullScreenAttr = jspContext.getAttribute("fullScreen");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetFullScreen", new Object[] {fullScreenAttr});
}
else
{
    sage.SageTV.api("SetFullScreen", new Object[] {fullScreenAttr});
}
%>
