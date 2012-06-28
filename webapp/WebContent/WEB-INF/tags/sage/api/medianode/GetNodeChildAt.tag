<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaNodeAPI.html#GetNodeChildAt(sage.vfs.MediaNode, int)'>MediaNodeAPI.GetNodeChildAt</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaNode" required="true" type="java.lang.Object" %>
<%@ attribute name="index" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaNodeAttr = jspContext.getAttribute("mediaNode");
Object indexAttr = jspContext.getAttribute("index");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetNodeChildAt", new Object[] {mediaNodeAttr, indexAttr});
}
else
{
    returnVal = sage.SageTV.api("GetNodeChildAt", new Object[] {mediaNodeAttr, indexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
