package sagex.webserver.command;

import sage.SageTV;

public class ResetAlertLevelCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        SageTV.api(getName(), null);
    }
}
