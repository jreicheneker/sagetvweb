<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#DVDChapterSet(int)'>MediaPlayerAPI.DVDChapterSet</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="chapterNumber" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object chapterNumberAttr = jspContext.getAttribute("chapterNumber");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "DVDChapterSet", new Object[] {chapterNumberAttr});
}
else
{
    sage.SageTV.api("DVDChapterSet", new Object[] {chapterNumberAttr});
}
%>
