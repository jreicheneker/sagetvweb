package sagex.webserver.command;

import sage.SageTV;

public class SageCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        String context = getContext();

        // sage commands validated in CommandEnum
        if (context == null)
        {
            SageTV.api("SageCommand", new Object[] {getName()});
            
        }
        else
        {
            SageTV.apiUI(getContext(), "SageCommand", new Object[] {getName()});
        }
    }
    
    @Override
    public String getName()
    {
        return getParameter("command");
    }    
}
