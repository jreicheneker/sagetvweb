<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/SystemMessageAPI.html#GetSystemMessageTypeName(sage.msg.SystemMessage)'>SystemMessageAPI.GetSystemMessageTypeName</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="message" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object messageAttr = jspContext.getAttribute("message");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetSystemMessageTypeName", new Object[] {messageAttr});
}
else
{
    returnVal = sage.SageTV.api("GetSystemMessageTypeName", new Object[] {messageAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
