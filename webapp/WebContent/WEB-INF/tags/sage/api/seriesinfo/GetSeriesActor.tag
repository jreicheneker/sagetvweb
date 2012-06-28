<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/SeriesInfoAPI.html#GetSeriesActor(sage.SeriesInfo, int)'>SeriesInfoAPI.GetSeriesActor</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="seriesInfo" required="true" type="java.lang.Object" %>
<%@ attribute name="index" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object seriesInfoAttr = jspContext.getAttribute("seriesInfo");
Object indexAttr = jspContext.getAttribute("index");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetSeriesActor", new Object[] {seriesInfoAttr, indexAttr});
}
else
{
    returnVal = sage.SageTV.api("GetSeriesActor", new Object[] {seriesInfoAttr, indexAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
