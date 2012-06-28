<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="job" required="true" type="java.lang.Integer" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ variable name-from-attribute="var" alias="varLocal" scope="AT_END" %>

<%
String jobTitle = "";
Integer job = (Integer) jspContext.getAttribute("job");
Object mediaFile = SageTV.api("GetTranscodeJobSourceFile", new Object[] {job});
Object airing = SageTV.api("GetMediaFileAiring", new Object[] {mediaFile});
Boolean isLibraryFile = (Boolean) SageTV.api("IsLibraryFile", new Object[] {mediaFile});
Boolean isTVFile = (Boolean) SageTV.api("IsTVFile", new Object[] {mediaFile});

if (isLibraryFile && !isTVFile)
{
    jobTitle = (String) SageTV.api("GetShowEpisode", new Object[] {mediaFile});
}
else
{
    jobTitle = (String) SageTV.api("GetAiringTitle", new Object[] {airing});
    //String episode = (String) SageApi.Api("GetShowEpisode", airing);
    //if ((episode != null) && (episode.trim().length() > 0))
    //{
    //    jobTitle += " - " + episode;
    //}
}
%>

<c:set var="varLocal" value="<%= jobTitle %>"/>
