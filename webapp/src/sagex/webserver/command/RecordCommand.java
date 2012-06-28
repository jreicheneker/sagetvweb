package sagex.webserver.command;

import sage.SageTV;

public class RecordCommand extends AbstractRecordCommand
{
    @Override
    public void doCommand() throws Exception
    {
        // TODO check for conflict
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
            // don't support default padding for now (nielm webserver-only feature, not part of Sage core)
            //schedstart=new Long(airstart.longValue()-defstartpad);
        }
        if (getParameter("EndPadding")!= null)
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
            // don't support default padding for now (nielm webserver-only feature, not part of Sage core)
            //schedend=new Long(airend.longValue()+defendpad);
        }

        Object channel = SageTV.api("GetChannel", new Object[] {getSageObject()});
        Object conflicts = getManualRecordConflicts(scheduledStart.longValue(), scheduledEnd.longValue(), channel);
        if ((Integer) SageTV.api("FindElementIndex", new Object[] {conflicts, getSageObject()}) >= 0)
        {
            conflicts = SageTV.api("RemoveElement", new Object[] {conflicts, getSageObject()});
        }
        //System.out.println("Got  "+SageApi.Size(conflicts)+" overlaps excluding self, removing padding");
        if ((Integer) SageTV.api("Size", new Object[] {conflicts}) > 0)
        {
            scheduledStart = airingStart;
            scheduledEnd = airingEnd;
        }
        conflicts = getManualRecordConflicts(scheduledStart.longValue(), scheduledEnd.longValue(), channel);
        if ((Integer) SageTV.api("FindElementIndex", new Object[] {conflicts, getSageObject()}) >= 0)
        {
            conflicts = SageTV.api("RemoveElement", new Object[] {conflicts, getSageObject()});
        }

        // manual recording causes conflicts with other manual recordings, send user to info page
        if ((Integer) SageTV.api("Size", new Object[] {conflicts}) > 0)
        {
            // TODO forward/dispatch to preserve request parameters
            setRedirect("manualrecordconflicts.jsp?AiringId=" + getParameter("AiringId"));
            return;
        }

        // no conflicts, record it
        String[] uiContexts = getUIContextNames();

        if ((uiContexts == null) || (uiContexts.length == 0))
        {
            SageTV.api(getName(), new Object[] {getSageObject()});
        }
        else  
        {
            SageTV.apiUI(uiContexts[0], getName(), new Object[] {getSageObject()});
        }
        Thread.sleep(100);

        // if setting of record is successful...
        setRecordTimes(scheduledStart, scheduledEnd);
    }
}
