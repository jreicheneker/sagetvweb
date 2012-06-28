<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Integer job = (Integer) jspContext.getAttribute("job");
Object jobStatus = SageTV.api("GetTranscodeJobStatus", new Object[] {job});
int percentComplete = new Float(((Float) SageTV.api("GetTranscodeJobCompletePercent", new Object[] {job})) * 100.0).intValue();
jspContext.setAttribute("jobStatus", jobStatus);
jspContext.setAttribute("percentComplete", percentComplete);
%>

<c:choose>
   <c:when test="${jobStatus == 'COMPLETED'}">
      <c:set var="varLocal" value="Converted"/>
   </c:when>
   <c:when test="${jobStatus == 'TRANSCODING'}">
      <c:set var="varLocal" value="Converting - ${percentComplete}%"/>
   </c:when>
   <c:when test="${jobStatus == 'WAITING TO START'}">
      <c:set var="varLocal" value="Waiting"/>
   </c:when>
   <c:when test="${jobStatus == 'FAILED'}">
      <c:set var="varLocal" value="Failed"/>
   </c:when>
   <c:otherwise>
      <c:set var="varLocal" value="Unknown Status - ${jobStatus}"/>
   </c:otherwise>
</c:choose>
