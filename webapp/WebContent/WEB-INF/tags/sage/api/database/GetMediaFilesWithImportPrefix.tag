<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Database.html#GetMediaFilesWithImportPrefix(java.lang.Object, java.lang.String, boolean, boolean, boolean)'>Database.GetMediaFilesWithImportPrefix</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaData" required="true" type="java.lang.Object" %>
<%@ attribute name="importPrefix" required="true" type="java.lang.String" %>
<%@ attribute name="includeFiles" required="true" type="java.lang.Boolean" %>
<%@ attribute name="includeFolders" required="true" type="java.lang.Boolean" %>
<%@ attribute name="groupFolders" required="true" type="java.lang.Boolean" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaDataAttr = jspContext.getAttribute("mediaData");
Object importPrefixAttr = jspContext.getAttribute("importPrefix");
Object includeFilesAttr = jspContext.getAttribute("includeFiles");
Object includeFoldersAttr = jspContext.getAttribute("includeFolders");
Object groupFoldersAttr = jspContext.getAttribute("groupFolders");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetMediaFilesWithImportPrefix", new Object[] {mediaDataAttr, importPrefixAttr, includeFilesAttr, includeFoldersAttr, groupFoldersAttr});
}
else
{
    returnVal = sage.SageTV.api("GetMediaFilesWithImportPrefix", new Object[] {mediaDataAttr, importPrefixAttr, includeFilesAttr, includeFoldersAttr, groupFoldersAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
