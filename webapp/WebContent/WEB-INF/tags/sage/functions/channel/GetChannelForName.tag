<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="channelname" required="true" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String channelName = (String) jspContext.getAttribute("channelname");
Object channel = null;
Object channels = SageTV.api("GetAllChannels", null);
channels = SageTV.api("Sort", new Object[] {channels, Boolean.FALSE, "ChannelNumber"});

for (int i = 0; i < (Integer) SageTV.api("Size", new Object[] {channels}); i++)
{
    Object currentChannel = SageTV.api("GetElement", new Object[] {channels, i});
    if ((Boolean) SageTV.api("IsChannelViewable", new Object[] {currentChannel}))
    {
        String currentChannelName = (String) SageTV.api("GetChannelName", new Object[] {currentChannel});
        if (currentChannelName.equals(channelName))
        {
            channel = currentChannel;
        }
    }
}
%>

<c:set var="varLocal" value="<%= channel %>"/>
