package sagex.webserver.command;

import sage.SageTV;

public class SetRecordingPaddingCommand extends AbstractRecordCommand
{
    @Override
    public void doCommand() throws Exception
    {
        // TODO check for conflicts, share logic with RecordCommand

        Long airingStart = ((Long) SageTV.api("GetAiringStartTime", new Object[] {getSageObject()}));
        Long airingEnd = ((Long) SageTV.api("GetAiringEndTime", new Object[] {getSageObject()}));
        Long scheduledStart = airingStart;
        Long scheduledEnd = airingEnd;
        
        // get Padding
        if (getParameter("StartPadding") != null)
        {
            int startPadding = Integer.parseInt(getParameter("StartPadding"));
            if (getParameter("StartPaddingOffsetType").equalsIgnoreCase("Earlier"))
            {
                startPadding = -startPadding;
            }
            scheduledStart = new Long(airingStart.longValue() + startPadding * 60 * 1000);
        }
        else
        {
            //schedstart=new Long(airstart.longValue()-defstartpad);
        }
        if (getParameter("EndPadding") != null)
        {
            int endPadding = Integer.parseInt(getParameter("EndPadding"));
            if (getParameter("EndPaddingOffsetType").equalsIgnoreCase("Earlier"))
            {
                endPadding = -endPadding;
            }
            scheduledEnd = new Long(airingEnd.longValue() + endPadding * 60 * 1000);
        }
        else
        {
            //schedend=new Long(airend.longValue()+defendpad);
        }

        Object channel = SageTV.api("GetChannel", new Object[] {getSageObject()});
        Object conflicts = getManualRecordConflicts(scheduledStart.longValue(), scheduledEnd.longValue(), channel);
        int index = (Integer) SageTV.api("FindElementIndex", new Object[] {conflicts, getSageObject()});
        if (index >= 0)
        {
            // TODO removes all objects from 'conflicts' and doesn't prompt user to resolve
            //conflicts = SageApi.Api("RemoveElement", new Object[] {conflicts, getSageObject()});
            conflicts = SageTV.api("RemoveElementAtIndex", new Object[] {conflicts, index});
        }

        // manual recording causes conflicts with other manual recordings, send user to info page
        if ((Integer) SageTV.api("Size", new Object[] {conflicts}) > 0)
        {
            // TODO forward/dispatch to preserve request parameters
            setRedirect("manualrecordconflicts.jsp?AiringId=" + getParameter("AiringId"));
            return;
        }

        // no conflicts, set padding
        setRecordTimes(scheduledStart, scheduledEnd);
    }
}
