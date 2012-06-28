<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/TranscodeAPI.html#AddTranscodeJob(sage.MediaFile, java.lang.String, java.io.File, boolean, long, long)'>TranscodeAPI.AddTranscodeJob</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="sourceMediaFile" required="true" type="java.lang.Object" %>
<%@ attribute name="formatName" required="true" type="java.lang.String" %>
<%@ attribute name="destinationFile" required="true" type="java.io.File" %>
<%@ attribute name="deleteSourceAfterTranscode" required="true" type="java.lang.Boolean" %>
<%@ attribute name="clipTimeStart" required="true" type="java.lang.Long" %>
<%@ attribute name="clipDuration" required="true" type="java.lang.Long" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object sourceMediaFileAttr = jspContext.getAttribute("sourceMediaFile");
Object formatNameAttr = jspContext.getAttribute("formatName");
Object destinationFileAttr = jspContext.getAttribute("destinationFile");
Object deleteSourceAfterTranscodeAttr = jspContext.getAttribute("deleteSourceAfterTranscode");
Object clipTimeStartAttr = jspContext.getAttribute("clipTimeStart");
Object clipDurationAttr = jspContext.getAttribute("clipDuration");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddTranscodeJob", new Object[] {sourceMediaFileAttr, formatNameAttr, destinationFileAttr, deleteSourceAfterTranscodeAttr, clipTimeStartAttr, clipDurationAttr});
}
else
{
    returnVal = sage.SageTV.api("AddTranscodeJob", new Object[] {sourceMediaFileAttr, formatNameAttr, destinationFileAttr, deleteSourceAfterTranscodeAttr, clipTimeStartAttr, clipDurationAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
