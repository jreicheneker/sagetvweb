<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#SetSubtitleDelay(long)'>MediaPlayerAPI.SetSubtitleDelay</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="delayMsec" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object delayMsecAttr = jspContext.getAttribute("delayMsec");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetSubtitleDelay", new Object[] {delayMsecAttr});
}
else
{
    sage.SageTV.api("SetSubtitleDelay", new Object[] {delayMsecAttr});
}
%>
