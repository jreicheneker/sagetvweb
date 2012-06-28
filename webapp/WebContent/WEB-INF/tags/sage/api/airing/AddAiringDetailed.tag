<%--
  -- Unofficial SageTV Generated File - Never Edit
  -- Generated Date/Time: 7/17/10 8:25 AM
  -- See Official Sage Documentation at <a href='http://download.sage.tv/api/sage/api/AiringAPI.html#AddAiringDetailed(java.lang.String, int, long, long, int, int, java.lang.String, boolean, boolean, boolean, boolean, boolean, java.lang.String)'>AiringAPI.AddAiringDetailed</a>
  -- This Generated API is not Affiliated with SageTV.  It is user contributed.
  --%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>
<%@ attribute name="context" required="false" type="java.lang.String" %>
<%@ attribute name="showExternalID" required="true" type="java.lang.String" %>
<%@ attribute name="stationID" required="true" type="java.lang.Integer" %>
<%@ attribute name="startTime" required="true" type="java.lang.Long" %>
<%@ attribute name="duration" required="true" type="java.lang.Long" %>
<%@ attribute name="partNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="totalParts" required="true" type="java.lang.Integer" %>
<%@ attribute name="parentalRating" required="true" type="java.lang.String" %>
<%@ attribute name="hDTV" required="true" type="java.lang.Boolean" %>
<%@ attribute name="stereo" required="true" type="java.lang.Boolean" %>
<%@ attribute name="closedCaptioning" required="true" type="java.lang.Boolean" %>
<%@ attribute name="sAP" required="true" type="java.lang.Boolean" %>
<%@ attribute name="subtitled" required="true" type="java.lang.Boolean" %>
<%@ attribute name="premierFinale" required="true" type="java.lang.String" %>

<%
String contextAttr = (String) jspContext.getAttribute("context");
Object showExternalIDAttr = jspContext.getAttribute("showExternalID");
Object stationIDAttr = jspContext.getAttribute("stationID");
Object startTimeAttr = jspContext.getAttribute("startTime");
Object durationAttr = jspContext.getAttribute("duration");
Object partNumberAttr = jspContext.getAttribute("partNumber");
Object totalPartsAttr = jspContext.getAttribute("totalParts");
Object parentalRatingAttr = jspContext.getAttribute("parentalRating");
Object hDTVAttr = jspContext.getAttribute("hDTV");
Object stereoAttr = jspContext.getAttribute("stereo");
Object closedCaptioningAttr = jspContext.getAttribute("closedCaptioning");
Object sAPAttr = jspContext.getAttribute("sAP");
Object subtitledAttr = jspContext.getAttribute("subtitled");
Object premierFinaleAttr = jspContext.getAttribute("premierFinale");

Object returnVal = null;

if ((context != null) && (context.trim().length() > 0))
{
    returnVal = sage.SageTV.apiUI(context, "AddAiringDetailed", new Object[] {showExternalIDAttr, stationIDAttr, startTimeAttr, durationAttr, partNumberAttr, totalPartsAttr, parentalRatingAttr, hDTVAttr, stereoAttr, closedCaptioningAttr, sAPAttr, subtitledAttr, premierFinaleAttr});
}
else
{
    returnVal = sage.SageTV.api("AddAiringDetailed", new Object[] {showExternalIDAttr, stationIDAttr, startTimeAttr, durationAttr, partNumberAttr, totalPartsAttr, parentalRatingAttr, hDTVAttr, stereoAttr, closedCaptioningAttr, sAPAttr, subtitledAttr, premierFinaleAttr});
}
%>

<c:set var="varLocal" value="<%= returnVal %>"/>
