<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#StartBackgroundFileDownload(java.lang.String, java.lang.String, java.io.File, java.util.Properties)'>Global.StartBackgroundFileDownload</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="serverAddress" required="true" type="java.lang.String" %>
<%@ attribute name="sourceFile" required="true" type="java.lang.String" %>
<%@ attribute name="destFile" required="true" type="java.io.File" %>
<%@ attribute name="requestProperties" required="true" type="java.util.Properties" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object serverAddressAttr = jspContext.getAttribute("serverAddress");
Object sourceFileAttr = jspContext.getAttribute("sourceFile");
Object destFileAttr = jspContext.getAttribute("destFile");
Object requestPropertiesAttr = jspContext.getAttribute("requestProperties");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "StartBackgroundFileDownload", new Object[] {serverAddressAttr, sourceFileAttr, destFileAttr, requestPropertiesAttr});
}
else
{
    returnVal = sage.SageTV.api("StartBackgroundFileDownload", new Object[] {serverAddressAttr, sourceFileAttr, destFileAttr, requestPropertiesAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
