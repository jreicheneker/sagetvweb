<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#SetNodeSort(sage.vfs.MediaNode, java.lang.String, boolean)'>MediaNodeAPI.SetNodeSort</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaNode" required="true" type="java.lang.Object" %>
<%@ attribute name="technique" required="true" type="java.lang.String" %>
<%@ attribute name="ascending" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaNodeAttr = jspContext.getAttribute("mediaNode");
Object techniqueAttr = jspContext.getAttribute("technique");
Object ascendingAttr = jspContext.getAttribute("ascending");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetNodeSort", new Object[] {mediaNodeAttr, techniqueAttr, ascendingAttr});
}
else
{
    sage.SageTV.api("SetNodeSort", new Object[] {mediaNodeAttr, techniqueAttr, ascendingAttr});
}
%>
