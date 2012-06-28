<%@ tag body-content="empty"%>
<%@ tag import="java.text.DecimalFormat" %>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="recordingquality" required="true" type="java.lang.String" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String recordingQuality = (String) jspContext.getAttribute("recordingquality");
Object format = (String) SageTV.api("GetRecordingQualityFormat", new Object[] {recordingQuality});

// getGigabytesPerHour
long rawBitrate = (Long) SageTV.api("GetRecordingQualityBitrate", new Object[] {recordingQuality}); // bits per second
double bitrate = rawBitrate * 3600; // bits per hour
bitrate /= 8; // Bytes per hour
bitrate /= 1000000000; // Gigabytes per hour
String formattedBitrate = new DecimalFormat("0.0").format(bitrate);

String description = recordingQuality + " - " + format + " @ " + formattedBitrate + " GB/hr";
%>

<c:set var="varLocal" value="<%= description %>"/>
