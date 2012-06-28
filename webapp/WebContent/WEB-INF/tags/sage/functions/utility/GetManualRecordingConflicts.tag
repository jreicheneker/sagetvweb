<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="airing" required="true" type="java.lang.Object" %>
<%@ attribute name="startpadding" required="false" type="java.lang.Long" %>
<%@ attribute name="endpadding" required="false" type="java.lang.Long" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
Object airing = jspContext.getAttribute("airing");
Long startPadding = (Long) jspContext.getAttribute("startpadding");
Long endPadding = (Long) jspContext.getAttribute("endpadding");

Long airingStart = (Long) SageTV.api("GetAiringStartTime", new Object[] {airing});
Long airingEnd = (Long) SageTV.api("GetAiringEndTime", new Object[] {airing});
Long scheduledStart = airingStart;
Long scheduledEnd = airingEnd;

if (startPadding != null)
{
    scheduledStart = airingStart + startPadding * 60 * 1000;
}

if (endPadding != null)
{
    scheduledEnd = airingEnd + endPadding * 60 * 1000;
}

Object channel = SageTV.api("GetChannel", new Object[] {airing});

Object conflicts = null;

Object inputs = SageTV.api("GetConfiguredCaptureDeviceInputs", null);
//for each input
for (int inputnum = 0; inputnum < (Integer) SageTV.api("Size", new Object[] {inputs}); inputnum++)
{
    Object input = SageTV.api("GetElement", new Object[] {inputs, inputnum});
    Object lineup = SageTV.api("GetLineupForCaptureDeviceInput", new Object[] {input});
    if ((Boolean) SageTV.api("IsChannelViewableOnLineup", new Object[] {channel, lineup}))
    {
        Object captureDevice = SageTV.api("GetCaptureDeviceForInput", new Object[] {input});
        Object overlaps = SageTV.api("GetScheduledRecordingsForDeviceForTime", new Object[] {
                captureDevice, scheduledStart, scheduledEnd});
        overlaps = SageTV.api("FilterByBoolMethod", new Object[] {overlaps,"IsManualRecord", Boolean.TRUE});
        if ((Integer) SageTV.api("Size", new Object[] {overlaps}) == 0)
        {
            conflicts = null;
            break;
        }
        conflicts = SageTV.api("DataUnion", new Object[] {conflicts, overlaps});
    }
}

if (conflicts != null)
{
    if ((Integer) SageTV.api("FindElementIndex", new Object[] {conflicts, airing}) >= 0)
    {
        conflicts = SageTV.api("RemoveElement", new Object[] {conflicts, airing});
    }
}
%>

<c:set var="varLocal" value="<%= conflicts %>"/>

<%--

        //Object channel = SageApi.Api("GetChannel", new Object[] {getSageObject()});
        //Object conflicts = getManualRecordConflicts(scheduledStart.longValue(), scheduledEnd.longValue(), channel);
        if (SageApi.IntApi("FindElementIndex", new Object[] {conflicts, getSageObject()}) >= 0)
        {
            conflicts = SageApi.Api("RemoveElement", new Object[] {conflicts, getSageObject()});
        }

        if (SageApi.Size(conflicts) > 0)
        {
            scheduledStart = airingStart;
            scheduledEnd = airingEnd;
        }
        conflicts = getManualRecordConflicts(scheduledStart.longValue(), scheduledEnd.longValue(), channel);
        if (SageApi.IntApi("FindElementIndex", new Object[] {conflicts, getSageObject()}) >= 0)
        {
            conflicts = SageApi.Api("RemoveElement", new Object[] {conflicts, getSageObject()});
        }


        Object rv = null;

        Object inputs = SageApi.Api("GetConfiguredCaptureDeviceInputs");
        //for each input
        for (int inputnum = 0; inputnum < SageApi.Size(inputs); inputnum++)
        {
            Object input = SageApi.GetElement(inputs, inputnum);
            Object lineup = SageApi.Api("GetLineupForCaptureDeviceInput", new Object[] {input});
            if (SageApi.booleanApi("IsChannelViewableOnLineup", new Object[] {channel, lineup}))
            {
                Object capdev = SageApi.Api("GetCaptureDeviceForInput", new Object[] {input});
                Object overlaps = SageApi.Api("GetScheduledRecordingsForDeviceForTime", new Object[] {
                        capdev, new Long(startmillis), new Long(stopmillis)});
                overlaps = SageApi.Api("FilterByBoolMethod", new Object[] {overlaps,"IsManualRecord", Boolean.TRUE});
                if (SageApi.Size(overlaps) == 0)
                {
                    return null;
                }
                rv = SageApi.Api("DataUnion", new Object[] {rv, overlaps});
            }
        }

        return rv;
--%>
