<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#MoveFileToLibrary(sage.MediaFile)'>MediaFileAPI.MoveFileToLibrary</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "MoveFileToLibrary", new Object[] {mediaFileAttr});
}
else
{
    sage.SageTV.api("MoveFileToLibrary", new Object[] {mediaFileAttr});
}
%>
