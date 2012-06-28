<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 6/8/11 2:47 PM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Global.html#CreateTimedRecording(sage.Channel, long, long, java.lang.String)'>Global.CreateTimedRecording</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="channel" required="true" type="java.lang.Object" %>
<%@ attribute name="startTime" required="true" type="java.lang.Long" %>
<%@ attribute name="stopTime" required="true" type="java.lang.Long" %>
<%@ attribute name="recurrence" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object channelAttr = jspContext.getAttribute("channel");
Object startTimeAttr = jspContext.getAttribute("startTime");
Object stopTimeAttr = jspContext.getAttribute("stopTime");
Object recurrenceAttr = jspContext.getAttribute("recurrence");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "CreateTimedRecording", new Object[] {channelAttr, startTimeAttr, stopTimeAttr, recurrenceAttr});
}
else
{
    returnVal = sage.SageTV.api("CreateTimedRecording", new Object[] {channelAttr, startTimeAttr, stopTimeAttr, recurrenceAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
