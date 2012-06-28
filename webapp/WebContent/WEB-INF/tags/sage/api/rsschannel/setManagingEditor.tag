<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/RSSChannel.html#setManagingEditor(java.lang.String)'>RSSChannel.setManagingEditor</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="managingEditor" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object managingEditorAttr = jspContext.getAttribute("managingEditor");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "setManagingEditor", new Object[] {managingEditorAttr});
}
else
{
    sage.SageTV.api("setManagingEditor", new Object[] {managingEditorAttr});
}
%>
