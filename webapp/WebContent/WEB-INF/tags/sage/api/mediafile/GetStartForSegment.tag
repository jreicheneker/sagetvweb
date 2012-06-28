<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/MediaFileAPI.html#GetStartForSegment(sage.MediaFile, int)'>MediaFileAPI.GetStartForSegment</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="mediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="segmentNumber" required="true" type="java.lang.Integer" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object mediaFileAttr = jspContext.getAttribute("mediaFile");
Object segmentNumberAttr = jspContext.getAttribute("segmentNumber");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "GetStartForSegment", new Object[] {mediaFileAttr, segmentNumberAttr});
}
else
{
    returnVal = sage.SageTV.api("GetStartForSegment", new Object[] {mediaFileAttr, segmentNumberAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
