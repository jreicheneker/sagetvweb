<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#UnlinkKeystrokeFromSageCommands(java.lang.String)'>Configuration.UnlinkKeystrokeFromSageCommands</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="keystroke" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object keystrokeAttr = jspContext.getAttribute("keystroke");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "UnlinkKeystrokeFromSageCommands", new Object[] {keystrokeAttr});
}
else
{
    sage.SageTV.api("UnlinkKeystrokeFromSageCommands", new Object[] {keystrokeAttr});
}
%>
