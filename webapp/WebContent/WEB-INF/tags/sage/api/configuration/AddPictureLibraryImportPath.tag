<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#AddPictureLibraryImportPath(java.lang.String)'>Configuration.AddPictureLibraryImportPath</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="newPath" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object newPathAttr = jspContext.getAttribute("newPath");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "AddPictureLibraryImportPath", new Object[] {newPathAttr});
}
else
{
    sage.SageTV.api("AddPictureLibraryImportPath", new Object[] {newPathAttr});
}
%>
