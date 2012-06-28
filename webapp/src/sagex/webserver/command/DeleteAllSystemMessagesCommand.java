package sagex.webserver.command;

import sage.SageTV;

public class DeleteAllSystemMessagesCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        SageTV.api(getName(), null);
    }
}
