package sagex.webserver.command;

public class CancelRecordCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        super.doCommand();
        Thread.sleep(200);
    }
}
