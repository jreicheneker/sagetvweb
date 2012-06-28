<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#RenameFilePath(java.io.File, java.io.File)'>Utility.RenameFilePath</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="originalFilePath" required="true" type="java.io.File" %>
<%@ attribute name="newFilePath" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object originalFilePathAttr = jspContext.getAttribute("originalFilePath");
Object newFilePathAttr = jspContext.getAttribute("newFilePath");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "RenameFilePath", new Object[] {originalFilePathAttr, newFilePathAttr});
}
else
{
    returnVal = sage.SageTV.api("RenameFilePath", new Object[] {originalFilePathAttr, newFilePathAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
