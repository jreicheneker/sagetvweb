package sagex.webserver.command;

import sage.SageTV;

public class SetRecordingQualityCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        String qualityParam = getParameter("Quality");

        if ((qualityParam != null) && (qualityParam.length() > 0))
        {
            Object qualities = SageTV.api("GetRecordingQualities", null);

            int i = 0;
            for (i = 0; i < (Integer) SageTV.api("Size", new Object[] {qualities}); i++)
            {
                if (SageTV.api("GetElement", new Object[] {qualities, i}).toString().equals(qualityParam))
                {
                    break;
                }
            }

            if (i < (Integer) SageTV.api("Size", new Object[] {qualities}))
            {
                Object quality = SageTV.api("GetElement", new Object[] {qualities, i});
                SageTV.api("SetRecordingQuality", new Object[] {getSageObject(), quality});
            }
            else if (qualityParam.equals("Default"))
            {
                SageTV.api("SetRecordingQuality", new Object[] {getSageObject(), qualityParam});
            }
            else
            {
                throw new Exception("Invalid recording quality '" + qualityParam + "'");
            }
        }
    }
}
