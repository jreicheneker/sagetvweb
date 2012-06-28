<%@ tag body-content="empty"%>
<%@ tag import="java.lang.Integer" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String jobClipDurationFmt = "";
Integer job = (Integer) jspContext.getAttribute("job");
Long jobClipDuration = (Long) SageTV.api("GetTranscodeJobClipDuration", new Object[] {job});

if ((jobClipDuration != null) && (jobClipDuration > 0))
{
    jobClipDurationFmt = (String) SageTV.api("DurFormat", new Object[] {"%h:%rm:%rs", jobClipDuration});
}
jspContext.setAttribute("jobClipDurationFmt", jobClipDurationFmt);
%>

<c:choose>
<c:when test="${!empty jobClipDurationFmt}">
   <c:set var="varLocal" value="${jobClipDurationFmt}"/>
</c:when>
<c:otherwise>
   <c:set var="varLocal" value="Entire Video"/>
</c:otherwise>
</c:choose>
