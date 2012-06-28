<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Configuration.html#SetAudioDelay(int)'>Configuration.SetAudioDelay</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="delay" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object delayAttr = jspContext.getAttribute("delay");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetAudioDelay", new Object[] {delayAttr});
}
else
{
    sage.SageTV.api("SetAudioDelay", new Object[] {delayAttr});
}
%>
