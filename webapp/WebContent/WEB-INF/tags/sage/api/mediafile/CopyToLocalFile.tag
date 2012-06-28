<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#CopyToLocalFile(sage.MediaFile, java.io.File)'>MediaFileAPI.CopyToLocalFile</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="localFile" required="true" type="java.io.File" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");
Object localFileAttr = jspContext.getAttribute("localFile");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "CopyToLocalFile", new Object[] {mediaFileAttr, localFileAttr});
}
else
{
    sage.SageTV.api("CopyToLocalFile", new Object[] {mediaFileAttr, localFileAttr});
}
%>
