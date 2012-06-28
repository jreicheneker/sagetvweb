<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#DirectPlaybackControl(int, long, long)'>MediaPlayerAPI.DirectPlaybackControl</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="code" required="true" type="java.lang.Integer" %>
<%@ attribute name="param1" required="true" type="java.lang.Long" %>
<%@ attribute name="param2" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object codeAttr = jspContext.getAttribute("code");
Object param1Attr = jspContext.getAttribute("param1");
Object param2Attr = jspContext.getAttribute("param2");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "DirectPlaybackControl", new Object[] {codeAttr, param1Attr, param2Attr});
}
else
{
    sage.SageTV.api("DirectPlaybackControl", new Object[] {codeAttr, param1Attr, param2Attr});
}
%>
