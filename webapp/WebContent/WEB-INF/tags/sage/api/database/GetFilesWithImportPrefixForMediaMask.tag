<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/5/10 6:59 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#GetFilesWithImportPrefix(java.lang.String, java.lang.String, boolean, boolean, boolean)'>Database.GetFilesWithImportPrefix</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaMask" required="true" type="java.lang.String" %>
<%@ attribute name="importPrefix" required="true" type="java.lang.String" %>
<%@ attribute name="includeFiles" required="true" type="java.lang.Boolean" %>
<%@ attribute name="includeFolders" required="true" type="java.lang.Boolean" %>
<%@ attribute name="groupFolders" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaMaskAttr = jspContext.getAttribute("mediaMask");
Object importPrefixAttr = jspContext.getAttribute("importPrefix");
Object includeFilesAttr = jspContext.getAttribute("includeFiles");
Object includeFoldersAttr = jspContext.getAttribute("includeFolders");
Object groupFoldersAttr = jspContext.getAttribute("groupFolders");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetFilesWithImportPrefix", new Object[] {mediaMaskAttr, importPrefixAttr, includeFilesAttr, includeFoldersAttr, groupFoldersAttr});
}
else
{
    returnVal = sage.SageTV.api("GetFilesWithImportPrefix", new Object[] {mediaMaskAttr, importPrefixAttr, includeFilesAttr, includeFoldersAttr, groupFoldersAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
