<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#SetMediaFileMetadata(sage.MediaFile, java.lang.String, java.lang.String)'>MediaFileAPI.SetMediaFileMetadata</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");
Object nameAttr = jspContext.getAttribute("name");
Object valueAttr = jspContext.getAttribute("value");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetMediaFileMetadata", new Object[] {mediaFileAttr, nameAttr, valueAttr});
}
else
{
    sage.SageTV.api("SetMediaFileMetadata", new Object[] {mediaFileAttr, nameAttr, valueAttr});
}
%>
