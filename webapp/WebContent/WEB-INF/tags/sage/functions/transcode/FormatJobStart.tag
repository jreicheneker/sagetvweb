<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String jobClipStartFmt = "";
Integer job = (Integer) jspContext.getAttribute("job");
Long jobClipStart = (Long) SageTV.api("GetTranscodeJobClipStart", new Object[] {job});
if (jobClipStart != null && jobClipStart > 0)
{
   jobClipStartFmt = (String) SageTV.api("DurFormat", new Object[] {"%h:%rm:%rs", jobClipStart});
}
jspContext.setAttribute("jobClipStartFmt", jobClipStartFmt);
%>

<c:choose>
<c:when test="${!empty jobClipStartFmt}">
   <c:set var="varLocal" value="${jobClipStartFmt}"/>
</c:when>
<c:otherwise>
   <c:set var="varLocal" value="Beginning"/>
</c:otherwise>
</c:choose>
