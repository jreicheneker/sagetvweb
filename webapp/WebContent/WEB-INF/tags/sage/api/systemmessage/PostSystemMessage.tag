<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/SystemMessageAPI.html#PostSystemMessage(int, int, java.lang.String, java.util.Properties)'>SystemMessageAPI.PostSystemMessage</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="messageCode" required="true" type="java.lang.Integer" %>
<%@ attribute name="messageLevel" required="true" type="java.lang.Integer" %>
<%@ attribute name="messageString" required="true" type="java.lang.String" %>
<%@ attribute name="messageVariables" required="true" type="java.util.Properties" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object messageCodeAttr = jspContext.getAttribute("messageCode");
Object messageLevelAttr = jspContext.getAttribute("messageLevel");
Object messageStringAttr = jspContext.getAttribute("messageString");
Object messageVariablesAttr = jspContext.getAttribute("messageVariables");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "PostSystemMessage", new Object[] {messageCodeAttr, messageLevelAttr, messageStringAttr, messageVariablesAttr});
}
else
{
    sage.SageTV.api("PostSystemMessage", new Object[] {messageCodeAttr, messageLevelAttr, messageStringAttr, messageVariablesAttr});
}
%>
