<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#DirectoryListing(java.io.File, java.lang.String)'>Utility.DirectoryListing</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="directoryPath" required="true" type="java.io.File" %>
<%@ attribute name="mediaMask" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object directoryPathAttr = jspContext.getAttribute("directoryPath");
Object mediaMaskAttr = jspContext.getAttribute("mediaMask");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "DirectoryListing", new Object[] {directoryPathAttr, mediaMaskAttr});
}
else
{
    returnVal = sage.SageTV.api("DirectoryListing", new Object[] {directoryPathAttr, mediaMaskAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
