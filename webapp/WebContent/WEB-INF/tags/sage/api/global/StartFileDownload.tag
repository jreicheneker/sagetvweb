<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#StartFileDownload(java.lang.String, java.lang.String, java.io.File)'>Global.StartFileDownload</a>
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

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object serverAddressAttr = jspContext.getAttribute("serverAddress");
Object sourceFileAttr = jspContext.getAttribute("sourceFile");
Object destFileAttr = jspContext.getAttribute("destFile");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "StartFileDownload", new Object[] {serverAddressAttr, sourceFileAttr, destFileAttr});
}
else
{
    returnVal = sage.SageTV.api("StartFileDownload", new Object[] {serverAddressAttr, sourceFileAttr, destFileAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
