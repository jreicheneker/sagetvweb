<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaPlayerAPI.html#Seek(long)'>MediaPlayerAPI.Seek</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="time" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object timeAttr = jspContext.getAttribute("time");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "Seek", new Object[] {timeAttr});
}
else
{
    sage.SageTV.api("Seek", new Object[] {timeAttr});
}
%>
