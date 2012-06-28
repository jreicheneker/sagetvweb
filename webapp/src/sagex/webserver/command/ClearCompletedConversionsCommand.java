package sagex.webserver.command;

import sage.SageTV;

public class ClearCompletedConversionsCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        SageTV.api("ClearTranscodedJobs", null);
    }
}
