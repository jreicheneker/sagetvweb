<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#RemoveLibraryImportPath(java.io.File)'>Configuration.RemoveLibraryImportPath</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="removePath" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object removePathAttr = jspContext.getAttribute("removePath");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "RemoveLibraryImportPath", new Object[] {removePathAttr});
}
else
{
    sage.SageTV.api("RemoveLibraryImportPath", new Object[] {removePathAttr});
}
%>
