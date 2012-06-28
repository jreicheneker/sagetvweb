package sagex.webserver.command;

import sage.SageTV;

public class ClearArchivedCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        boolean isMediaFile = (Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()});
        boolean isTVFile = (Boolean) SageTV.api("IsTVFile", new Object[] {getSageObject()});
        
        if (isMediaFile && isTVFile)
        {
//          // TODO context necessary?
//            String[] uiContexts = getUIContextNames();
//
//            if (uiContexts == null || uiContexts.length == 0)
//            {
                SageTV.api("Record", new Object[] {getSageObject()});
//            }
//            else
//            {  
//                SageApi.ApiUI(uiContexts[0], "Record", getSageObject());
//            }
            SageTV.api("MoveTVFileOutOfLibrary", new Object[] {getSageObject()});
        }
    }
}
