package sagex.webserver.command;

import java.util.Date;

import sage.SageTV;

public class SetLatestWatchedTimeCommand extends AbstractRecordCommand
{
    @Override
    public void doCommand() throws Exception
    {
        Long realWatchedStartTime = ((Long) SageTV.api("GetRealWatchedStartTime", new Object[] {getSageObject()}));
        Long scheduleStartTime = ((Long) SageTV.api("GetScheduleStartTime", new Object[] {getSageObject()}));
        String latestWatchedTimeString = getParameter("LatestWatchedTime");
        Long latestWatchedTime = 0L;
                
        if ((realWatchedStartTime == null) || (realWatchedStartTime.longValue() == 0))
        {
            realWatchedStartTime = new Date().getTime();
        }
        
        if (latestWatchedTimeString != null)
        {
            Double d = Double.parseDouble(latestWatchedTimeString);
            latestWatchedTime = d.longValue();
        }

        SageTV.api("SetWatchedTimes", new Object[] {getSageObject(), scheduleStartTime + latestWatchedTime * 1000, realWatchedStartTime});
    }
}
