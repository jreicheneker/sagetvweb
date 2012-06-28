package sagex.webserver.command;

import sage.SageTV;

public abstract class AbstractRecordCommand extends AbstractCommand
{
    protected Object getManualRecordConflicts(long startmillis, long stopmillis, Object channel)
        throws Exception
    {
        Object rv = null;

        String[] inputs = (String []) SageTV.api("GetConfiguredCaptureDeviceInputs", null);
        // for each input
        for (int inputnum = 0; inputnum < (Integer) SageTV.api("Size", new Object[] {inputs}); inputnum++)
        {
            String input = (String) SageTV.api("GetElement", new Object[] {inputs, inputnum});
            String lineup = (String) SageTV.api("GetLineupForCaptureDeviceInput", new Object[] {input});
            if ((Boolean) SageTV.api("IsChannelViewableOnLineup", new Object[] {channel, lineup}))
            {
                String capdev = (String) SageTV.api("GetCaptureDeviceForInput", new Object[] {input});
                Object overlaps = SageTV.api("GetScheduledRecordingsForDeviceForTime", new Object[] {capdev, new Long(startmillis), new Long(stopmillis)});
                overlaps = SageTV.api("FilterByBoolMethod", new Object[] {overlaps, "IsManualRecord", Boolean.TRUE});
                if ((Integer) SageTV.api("Size", new Object[] {overlaps}) == 0)
                {
                    return null;
                }
                rv = SageTV.api("DataUnion", new Object[] {rv, overlaps});
            }
        }

        return rv;
    }

    protected void setRecordTimes(Long scheduledStart, Long scheduledEnd)
        throws Exception
    {
//        String[] uiContexts = getUIContextNames();

        // if setting of record is successful...
        if ((Boolean) SageTV.api("IsManualRecord", new Object[] {getSageObject()}))
        {
//            if ((uiContexts == null) || (uiContexts.length == 0))
//            {
                SageTV.api("SetRecordingTimes", new Object[] {getSageObject(), scheduledStart, scheduledEnd});
//            }
//            else
//            {
//                // TODO context necessary?
//                AiringAPI.setrApiUI(uiContexts[0], "SetRecordingTimes", new Object[] {getSageObject(), scheduledStart, scheduledEnd});
//            }
        }
    }
}
