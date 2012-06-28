<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Integer airingId = (Integer) SageTV.api("GetAiringID", new Object[] {airing});
Long airingStartTime = (Long) SageTV.api("GetAiringStartTime", new Object[] {airing});
Long airingEndTime = (Long) SageTV.api("GetAiringEndTime", new Object[] {airing});

Object encoders = SageTV.api("GetActiveCaptureDevices", null);
for (int i = 0; i < (Integer) SageTV.api("Size", new Object[] {encoders}); i++)
{
   Object encoder = SageTV.api("GetElement", new Object[] {encoders, i});
   Object airings = SageTV.api("GetScheduledRecordingsForDeviceForTime",
      new Object[] {encoder, airingStartTime, airingEndTime});
   if (airings != null)
   {
      for (int j = 0; j < (Integer) SageTV.api("Size", new Object[] {airings}); j++)
      {
         Object encoderAiring = SageTV.api("GetElement", new Object[] {airings, j});
         int encoderAiringId = (Integer) SageTV.api("GetAiringID", new Object[] {encoderAiring});
         if (airingId == encoderAiringId)
         {
            jspContext.setAttribute("varLocal", encoder);
            break;
         }
      }
   }
}
%>
