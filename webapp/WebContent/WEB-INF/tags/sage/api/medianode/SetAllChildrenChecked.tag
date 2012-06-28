<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#SetAllChildrenChecked(sage.vfs.MediaNode, boolean)'>MediaNodeAPI.SetAllChildrenChecked</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaNode" required="true" type="java.lang.Object" %>
<%@ attribute name="state" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaNodeAttr = jspContext.getAttribute("mediaNode");
Object stateAttr = jspContext.getAttribute("state");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetAllChildrenChecked", new Object[] {mediaNodeAttr, stateAttr});
}
else
{
    sage.SageTV.api("SetAllChildrenChecked", new Object[] {mediaNodeAttr, stateAttr});
}
%>
