package sagex.webserver.command;

import sage.SageTV;

public class RecordingErrorCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        Boolean isMediaFile = (Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()});
        
        if (isMediaFile)
        {
            Boolean result = (Boolean) SageTV.api("DeleteFileWithoutPrejudice", new Object[] {getSageObject()});
            if (result == null || result == false)
            {
                String description = (String) SageTV.api("PrintAiringShort", new Object[] {getSageObject()});
                // TODO logging
                System.out.println("Failed to delete file " + description);
            }
        }
    }
}
