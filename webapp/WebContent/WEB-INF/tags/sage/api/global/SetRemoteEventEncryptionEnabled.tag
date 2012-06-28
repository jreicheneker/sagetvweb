<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#SetRemoteEventEncryptionEnabled(boolean)'>Global.SetRemoteEventEncryptionEnabled</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="enableEncryption" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object enableEncryptionAttr = jspContext.getAttribute("enableEncryption");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "SetRemoteEventEncryptionEnabled", new Object[] {enableEncryptionAttr});
}
else
{
    returnVal = sage.SageTV.api("SetRemoteEventEncryptionEnabled", new Object[] {enableEncryptionAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
