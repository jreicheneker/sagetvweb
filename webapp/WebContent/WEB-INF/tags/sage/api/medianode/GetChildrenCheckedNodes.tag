<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#GetChildrenCheckedNodes(sage.vfs.MediaNode, boolean)'>MediaNodeAPI.GetChildrenCheckedNodes</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaNode" required="true" type="java.lang.Object" %>
<%@ attribute name="state" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaNodeAttr = jspContext.getAttribute("mediaNode");
Object stateAttr = jspContext.getAttribute("state");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetChildrenCheckedNodes", new Object[] {mediaNodeAttr, stateAttr});
}
else
{
    returnVal = sage.SageTV.api("GetChildrenCheckedNodes", new Object[] {mediaNodeAttr, stateAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
