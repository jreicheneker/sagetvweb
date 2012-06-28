package sagex.webserver.command;

import sage.SageTV;

public class ClearManualCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        Boolean isMediaFile = (Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()});
        Boolean isManualRecord = (Boolean) SageTV.api("IsManualRecord", new Object[] {getSageObject()});

        if (isMediaFile && isManualRecord)
        {
            SageTV.api("CancelRecord", new Object[] {getSageObject()});
        }
    }
}
