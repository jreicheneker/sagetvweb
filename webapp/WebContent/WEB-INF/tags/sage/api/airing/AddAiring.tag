<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#AddAiring(java.lang.String, int, long, long)'>AiringAPI.AddAiring</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="showExternalID" required="true" type="java.lang.String" %>
<%@ attribute name="stationID" required="true" type="java.lang.Integer" %>
<%@ attribute name="startTime" required="true" type="java.lang.Long" %>
<%@ attribute name="duration" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showExternalIDAttr = jspContext.getAttribute("showExternalID");
Object stationIDAttr = jspContext.getAttribute("stationID");
Object startTimeAttr = jspContext.getAttribute("startTime");
Object durationAttr = jspContext.getAttribute("duration");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddAiring", new Object[] {showExternalIDAttr, stationIDAttr, startTimeAttr, durationAttr});
}
else
{
    returnVal = sage.SageTV.api("AddAiring", new Object[] {showExternalIDAttr, stationIDAttr, startTimeAttr, durationAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
