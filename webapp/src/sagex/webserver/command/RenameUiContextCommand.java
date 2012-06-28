package sagex.webserver.command;

import org.mortbay.log.Log;

import sagex.webserver.UiContextProperties;

public class RenameUiContextCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        String context = getContext();
        
        if (context == null)
        {
            String msg = "No UI Context Specified.";
            Exception e = new Exception(msg);
            Log.info(msg);
            Log.ignore(e);
            throw e;
        }

        String contextName = getParameter("name");
        contextName = (contextName == null) ? "" : contextName;

        UiContextProperties.setProperty(context, "name", contextName);
    }
}
