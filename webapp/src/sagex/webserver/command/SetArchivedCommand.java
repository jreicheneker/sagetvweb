package sagex.webserver.command;

import sage.SageTV;

public class SetArchivedCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        Boolean isMediaFile = (Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()});
        
        if (isMediaFile)
        {
            SageTV.api("MoveFileToLibrary", new Object[] {getSageObject()});
        }
    }
}
