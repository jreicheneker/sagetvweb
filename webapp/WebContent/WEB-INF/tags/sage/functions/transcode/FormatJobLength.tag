<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

               <c:choose>
                  <c:when test="${!empty startTime and !empty duration}">
                     <c:if test="${duration > 0}">
                        <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                        <sageutil:DurFormat var="endText" duration="${duration + startTime}" format="%h:%rm:%rs"/>
                        From ${startText} to ${endText}<%-- @ ${quality}--%>
                     </c:if>
                     <c:if test="${duration == 0}">
                        <c:if test="${startTime > 0}">
                           <c:set var="startTime" value="${startTime}"/>
                           <sageutil:DurFormat var="startText" duration="${startTime}" format="%h:%rm:%rs"/>
                           From ${startText} to End of Video<%-- @ ${quality}--%>
                        </c:if>
                        <c:if test="${startTime == 0}">
                           Entire Video<%-- @ ${quality}--%>
                        </c:if>
                     </c:if>
                  </c:when>
                  <c:otherwise>
                     Entire Video<%-- @ ${quality}--%>
                  </c:otherwise>
               </c:choose>

<%
String jobClipDurationFmt = "";
Integer job = (Integer) jspContext.getAttribute("job");
Long jobClipDuration = (Long) SageTV.api("GetTranscodeJobClipDuration", new Object[] {job});

if ((jobClipDuration != null) || (jobClipDuration > 0))
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
   <c:set var="varLocal" value="End of Video"/>
</c:otherwise>
</c:choose>
