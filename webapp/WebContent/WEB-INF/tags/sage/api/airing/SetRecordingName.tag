<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#SetRecordingName(sage.Airing, java.lang.String)'>AiringAPI.SetRecordingName</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object airingAttr = jspContext.getAttribute("airing");
Object nameAttr = jspContext.getAttribute("name");

if ((context != null) && (context.trim().length() > 0))
{
    sage.SageTV.apiUI(context, "SetRecordingName", new Object[] {airingAttr, nameAttr});
}
else
{
    sage.SageTV.api("SetRecordingName", new Object[] {airingAttr, nameAttr});
}
%>
