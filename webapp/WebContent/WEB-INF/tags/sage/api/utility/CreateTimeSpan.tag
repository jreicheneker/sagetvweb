<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/Utility.html#CreateTimeSpan(long, long)'>Utility.CreateTimeSpan</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="startTime" required="true" type="java.lang.Long" %>
<%@ attribute name="endTime" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object startTimeAttr = jspContext.getAttribute("startTime");
Object endTimeAttr = jspContext.getAttribute("endTime");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "CreateTimeSpan", new Object[] {startTimeAttr, endTimeAttr});
}
else
{
    returnVal = sage.SageTV.api("CreateTimeSpan", new Object[] {startTimeAttr, endTimeAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
