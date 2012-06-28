package sagex.webserver.command;

import sage.SageTV;

public class CancelConversionCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        SageTV.api("CancelTranscodeJob", new Object[] {getSageObject()});
    }
}
