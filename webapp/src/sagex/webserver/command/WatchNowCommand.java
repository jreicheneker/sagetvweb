package sagex.webserver.command;

import java.util.Arrays;

import org.mortbay.log.Log;

import sage.SageTV;

public class WatchNowCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        String context = getContext();
        
        String[] uiContexts = super.getUIContextNames();

        if (context == null)
        {
            String msg = "No UI Context Specified.";
            Exception e = new Exception(msg);
            Log.info(msg);
            Log.ignore(e);
            throw e;
        }

        if (! Arrays.asList(uiContexts).contains(context))
        {
            String msg = "UI Context " + context + " is not active.";
            Exception e = new Exception(msg);
            Log.info(msg);
            Log.ignore(e);
            throw e;
        }
        
        long now = System.currentTimeMillis();
        long airingStartTime = (Long) SageTV.api("GetAiringStartTime", new Object[] {getSageObject()});
        long airingEndTime = (Long) SageTV.api("GetAiringEndTime", new Object[] {getSageObject()});
        boolean isAiring = (Boolean) SageTV.api("IsAiringObject", new Object[] {getSageObject()});
        boolean isMediaFile = (Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()});

        if (isMediaFile || 
            (isAiring &&
             (airingStartTime <= now) &&
             (airingEndTime >= now)
            )
           )
        {
            SageTV.apiUI(context, "Watch", new Object[] {getSageObject()});
            Thread.sleep(500);
            SageTV.apiUI(context, "SageCommand", new Object[] {"Home"});
            Thread.sleep(500);
            SageTV.apiUI(context, "SageCommand", new Object[] {"TV"});
        }
    }
}
