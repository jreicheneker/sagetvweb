package sagex.webserver.command;

import java.util.Calendar;
import java.util.GregorianCalendar;

import sage.SageTV;

public class CreateTimedRecordingCommand extends AbstractRecordCommand
{
    @Override
    public void doCommand() throws Exception
    {
        Object channel = SageTV.api("GetChannelForStationID", new Object[] {getParameter("ChannelId")});

        Calendar startCal = new GregorianCalendar();
        startCal.clear();
        startCal.set(Integer.parseInt(getParameter("StartYear")),
                Integer.parseInt(getParameter("StartMonth")) - 1,
                Integer.parseInt(getParameter("StartDay")),
                (getParameter("StartAMPM").equals("AM")) ? Integer.parseInt(getParameter("StartHour")) : Integer.parseInt(getParameter("StartHour")) + 12,
                Integer.parseInt(getParameter("StartMinute")));
        long startTime = startCal.getTimeInMillis();

        Calendar stopCal = new GregorianCalendar();
        stopCal.clear();
        stopCal.set(Integer.parseInt(getParameter("StopYear")),
                Integer.parseInt(getParameter("StopMonth")) - 1,
                Integer.parseInt(getParameter("StopDay")),
                (getParameter("StopAMPM").equals("AM")) ? Integer.parseInt(getParameter("StopHour")) : Integer.parseInt(getParameter("StopHour")) + 12,
                Integer.parseInt(getParameter("StopMinute")));
        long stopTime = stopCal.getTimeInMillis();
        
        String recurrence = getParameter("Recurrence");
        if (recurrence == null)
        {
            throw new IllegalArgumentException("Recurrence is required");
        }

        if (recurrence.equals("WeeklySpecificDays"))
        {
            recurrence = "";
            String[] days = getParameterValues("RecurrenceWeeklyDay");
            if (days == null)
            {
                throw new IllegalArgumentException("Recurrence days are required");
            }

            for (String day : days)
            {
                recurrence += day;
            }
        }

        Object conflicts = getManualRecordConflicts(startTime, stopTime, channel);
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

        SageTV.api("CreateTimedRecording", new Object[] {channel, startTime, stopTime, recurrence});
    }
}
