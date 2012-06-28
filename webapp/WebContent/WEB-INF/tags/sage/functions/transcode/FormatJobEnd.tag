<%@ tag body-content="empty"%>
<%@ tag import="java.lang.Integer" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%--
TODO
               <c:choose>
                  <c:when test="${!empty startTime and !empty duration}">
                     <c:if test="${duration > 0}">
                        <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                        <sageutil:DurFormat var="endText" duration="${duration + startTime}" format="%h:%rm:%rs"/>
                        From ${startText} to ${endText}< % - - @ ${quality}- - % >
                     </c:if>
                     <c:if test="${duration == 0}">
                        <c:if test="${startTime > 0}">
                           <c:set var="startTime" value="${startTime}"/>
                           <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                           From ${startText} to End of Video< % - - @ ${quality}- - % >
                        </c:if>
                        <c:if test="${startTime == 0}">
                           Entire Video< % - - @ ${quality}- - % >
                        </c:if>
                     </c:if>
                  </c:when>
                  <c:otherwise>
                     Entire Video< % - - @ ${quality}- - % >
                  </c:otherwise>
               </c:choose>

<%
String durationFmt = "";
Integer job = (Integer) jspContext.getAttribute("job");
Long start = (Long) SageApi.Api("GetTranscodeJobClipStart", job);
Long duration = (Long) SageApi.Api("GetTranscodeJobClipDuration", job);

if (start != null && duration != null)
{
    if (duration == 0)
    {
        
    }
    else
    {
        durationFmt = "End of Video";
    }
}
else
{
    durationFmt = "End of Video";
}
Object airing = SageApi.Api("GetMediaFileAiring", mediaFile);
Boolean isLibraryFile = (Boolean) SageApi.Api("IsLibraryFile", mediaFile);
%>

<c:set var="varLocal" value="<%= durationFmt %>"/>




















<%@ tag body-content="empty"%>
<%@ tag import="java.lang.Integer" %>
<%@ tag import="net.sf.sageplugins.sageutils.SageApi" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String jobClipStartFmt = "";
Integer job = (Integer) jspContext.getAttribute("job");
Long jobClipStart = (Long) SageApi.Api("GetTranscodeJobClipStart", job);
if (jobClipStart != null && jobClipStart > 0)
{
   jobClipStartFmt = (String) SageApi.Api("DurFormat", new Object[] {"%h:%rm:%rs", jobClipStart});
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
--%>
