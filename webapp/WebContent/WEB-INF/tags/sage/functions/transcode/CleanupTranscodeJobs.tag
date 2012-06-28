<%@ tag body-content="empty"%>
<%@ tag import="sage.SageTV" %>

<%
Object jobs = SageTV.api("GetTranscodeJobs", null);
int i = 0;
while (i < (Integer) SageTV.api("Size", new Object[] {jobs}))
{
    Object currentJob = SageTV.api("GetElement", new Object[] {jobs, i});
    Object jobSource = SageTV.api("GetTranscodeJobSourceFile", new Object[] {currentJob});
    if (jobSource == null)
    {
        SageTV.api("CancelTranscodeJob", new Object[] {currentJob});
    }
    else
    {
        Object currentFile = SageTV.api("GetFileForSegment", new Object[] {jobSource, new Integer(0)});
        if (currentFile == null)
        {
        	SageTV.api("CancelTranscodeJob", new Object[] {currentJob});
        }
    }
    i++;
}
%>
