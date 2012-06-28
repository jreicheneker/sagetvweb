package sagex.webserver.command;

import java.util.Map;

import sage.SageTV;

public class ForceEpgUpdateCommand extends AbstractCommand
{
    @Override
    @SuppressWarnings("unchecked") // SageApi is not typed
    public void doCommand() throws Exception
    {
        Object allInputs = SageTV.api("GetConfiguredCaptureDeviceInputs", null);

        if ((Integer) SageTV.api("Size", new Object[] {allInputs}) > 0)
        {
            Map lineupMap = (Map) SageTV.api("GroupByMethod",
                    new Object[] {allInputs, "GetLineupForCaptureDeviceInput"});

            for (Object lineup : lineupMap.keySet())
            {
                Object allChannels = SageTV.api("GetChannelsOnLineup", new Object[] {lineup});
                Object channel = SageTV.api("GetElement", new Object[] {allChannels, 0});
                Object channelNumbers = SageTV.api("GetChannelNumbersForLineup", new Object[] {channel, lineup});
                Object number = SageTV.api("GetElement", new Object[] {channelNumbers, 0});
                Boolean viewable = (Boolean) SageTV.api("IsChannelViewableOnNumberOnLineup", new Object[] {channel, number, lineup});
                SageTV.api("SetChannelViewabilityForChannelNumberOnLineup", new Object[] {channel, number, lineup, new Boolean(!viewable)});
                SageTV.api("SetChannelViewabilityForChannelNumberOnLineup", new Object[] {channel, number, lineup, new Boolean(viewable)});
            }
            // the following probably commits the changes and triggers an EPG update
            SageTV.api("RemoveUnusedLineups", null);
        }
    }
}
