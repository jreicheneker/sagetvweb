<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#DVDSubtitleChange(int)'>MediaPlayerAPI.DVDSubtitleChange</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="subtitleNum" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object subtitleNumAttr = jspContext.getAttribute("subtitleNum");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "DVDSubtitleChange", new Object[] {subtitleNumAttr});
}
else
{
    sage.SageTV.api("DVDSubtitleChange", new Object[] {subtitleNumAttr});
}
%>
