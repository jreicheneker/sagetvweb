package sagex.webserver.command;

import java.io.File;
import java.util.Arrays;

import sage.SageTV;

public class ConvertCommand extends AbstractCommand
{
    private String format = null;
    private File destFile = null;
    private File destDir = null;
    private long startTime = -1;
    private long duration = -1;

    @Override
    public void doBeforeCommand() throws Exception
    {
        String tmp;        

        tmp = getParameter("ReplaceOriginal");
        if ((tmp == null) || (!tmp.equals("yes") && !tmp.equals("no")))
        {
            throw new IllegalArgumentException("ReplaceOriginal is not valid");
        }

        if (!getReplaceOriginal())
        {
            tmp = getParameter("Folder");
            if ((tmp == null) || (!tmp.equals("Original") && !tmp.equals("Destination")))
            {
                throw new IllegalArgumentException("Folder is not valid");
            }
            if (tmp.equals("Destination"))
            {
                tmp = getParameter("DestinationFolder");
                if ((tmp == null) || (tmp.trim().length() == 0))
                {
                    throw new IllegalArgumentException("Destination Directory has not been specified");
                }

                destDir = new File(tmp);
                if (!destDir.isAbsolute())
                {
                    throw new IllegalArgumentException("Destination Directory " + tmp + " is not a full path");
                }
                if (!destDir.exists())
                {
                    throw new IllegalArgumentException("Destination Directory " + tmp + " does not exist");
                }
                if (!destDir.isDirectory())
                {
                    throw new IllegalArgumentException("Destination Directory " + tmp + " is not a directory");
                }
                if (!destDir.canWrite())
                {
                    throw new IllegalArgumentException("Destination Directory " + tmp + " is not writeable");
                }
                destFile = destDir.getAbsoluteFile();
            }

            if (getSageObjectList().size() == 1)
            {
                Object sageObject = getSageObjectList().get(0);
                tmp = getParameter("DestinationFile");
                if (tmp == null)
                {
                    throw new IllegalArgumentException("Destination Filename has not been specified");
                }
                tmp = tmp.trim();
                if (tmp.length() > 0)
                {
                    // filename specified
                    if (destFile == null)
                    {
                        // no directory specified yet
                        destFile= ((File) SageTV.api("GetFileForSegment", new Object[] {sageObject, new Integer(0)})).getParentFile();
                    } 
                    destFile=new File(destFile,tmp);
                }
                else
                {
                    // no filename specified - use path
                }
            }
        }
        
        if (getSageObjectList().size() == 1)
        {
            tmp = getParameter("StartTime");
            if ((tmp != null) && (tmp.trim().length() > 0))
            {
                try
                {
                    startTime = Long.parseLong(tmp);
                    if (startTime < 0)
                    {
                        throw new IllegalArgumentException("invalid startTime value " + startTime);
                    }
                }
                catch (NumberFormatException e)
                {
                    throw new IllegalArgumentException("invalid startTime value " + tmp, e);
                }
                tmp = getParameter("Duration");
                if ((tmp != null) && (tmp.trim().length() > 0))
                {
                    try
                    {
                        duration = Long.parseLong(tmp);
                        if (duration < 0)
                        {
                            throw new IllegalArgumentException("invalid duration value " + duration);
                        }
                    }
                    catch (NumberFormatException e)
                    {
                        throw new IllegalArgumentException("invalid duration value " + tmp, e);
                    }
                }
            }
        }
        
        String[] formats = (String[]) SageTV.api("GetTranscodeFormats", null);
        format = getParameter("Format");
        if (!Arrays.asList(formats).contains(format))
        {
            throw new IllegalArgumentException("unknown transcode format: " + format);
        }
    }

    @Override
    public void doCommand() throws Exception
    {
/*
        <select name="Format">
        <input type="radio" name="ReplaceOriginal" value="true" checked="checked"/>Replace Original File
        <input type="radio" name="ReplaceOriginal" value="false"/>Keep Original File
           <input type="radio" name="Folder" value="Original" checked="checked"/>Use Original Folder<br/>
           <input type="radio" name="Folder" value="Destination"/>Set Destination Folder<br/>
           <input type="text" name="DestinationFolder"/>
           <input type="text" name="DestinationFile"/>
        <c:if test="${airingsSize == 1}">
           <div class="label">Start (seconds)</div>
           <div class="value"><input type="text" name="StartTime"/></div>
           <div class="label">Duration (seconds)</div>
           <div class="value"><input type="text" name="Duration"/></div>
        </c:if>
        <c:forEach items="${paramValues.MediaFileId}" var="mediaFileId">
           <input type="hidden" name="MediaFileId" value="${MediaFileId}"/>
        </c:forEach>
*/
        
        if ((Boolean) SageTV.api("IsMediaFileObject", new Object[] {getSageObject()}) &&
            (Boolean) SageTV.api("CanFileBeTranscoded", new Object[] {getSageObject()}))
        {
            Integer jobID;
            if ((startTime == -1) || (duration == -1))
            {
                jobID = (Integer) SageTV.api("AddTranscodeJob", new Object[] {getSageObject(), format, destFile, getReplaceOriginal()});
            }
            else 
            {
                jobID = (Integer) SageTV.api("AddTranscodeJob", new Object[] {getSageObject(), format, destFile, getReplaceOriginal(), new Long(startTime), new Long(duration)});
            }
        }
    }

    @Override
    public void doAfterCommand() throws Exception
    {
        // set properties with defaults.
        SageTV.api("SetProperty" , new Object[] {"transcoder/last_replace_choice", (getReplaceOriginal() ? "xKeepOnlyConversion" : "xKeepBoth")});

        if (!getReplaceOriginal())
        {
            if (destDir == null)
            {
                SageTV.api("SetProperty", new Object[] {"transcoder/last_dest_dir", null});
            }
            else
            {
                SageTV.api("SetProperty", new Object[] {"transcoder/last_dest_dir", destDir.getAbsolutePath()});
            }
        }
        String[] formatArr = format.split("-", 2);
        SageTV.api("SetProperty", new Object[] {"transcoder/last_format_name", formatArr[0]});
        SageTV.api("SetProperty", new Object[] {"transcoder/last_format_quality/" + formatArr[0], format});
    }

    private boolean getReplaceOriginal()
    {
        return getParameter("ReplaceOriginal").equals("yes");
    }
}
