package sagex.jetty.lifecycle;

import java.io.File;
import java.io.FilenameFilter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mortbay.component.LifeCycle;
import org.mortbay.jetty.webapp.WebAppContext;
import org.mortbay.log.Log;
import org.mortbay.util.IO;

public class WebAppContextLifeCycleListener implements LifeCycle.Listener
{
    private static File TEMP_WEBAPP_DIR = new File(System.getProperty("user.dir"), "jetty/webapps");

    public void lifeCycleFailure(LifeCycle event, Throwable cause)
    {
        printUnavailableFailure(event);
    }

    public void lifeCycleStarted(LifeCycle event)
    {
        if (event instanceof WebAppContext)
        {
            WebAppContext context = (WebAppContext) event;

            Log.debug("Started web app: " + context);
            Log.debug("Web app class loader after app started: " + context.getClassLoader() + 
                    "@" + Integer.toHexString(context.getClassLoader().hashCode()));
        }

        printUnavailableFailure(event);
    }

    public void lifeCycleStarting(LifeCycle event)
    {
        if (event instanceof WebAppContext)
        {
            WebAppContext context = (WebAppContext) event;

            Log.debug("Starting web app: " + context);
            Log.debug("Web app class loader before app started: " + context.getClassLoader() +
                    ((context.getClassLoader() == null) ? "" : "@" + Integer.toHexString(context.getClassLoader().hashCode())));
            
            File tempDir = context.getTempDirectory();
            // only delete dirs from the webapps dir as a sanity check
            if ((context.isExtractWAR()) && (tempDir != null) && (isTempDirInWebappsDir(tempDir)))
            {
                removeTempDirectory(context, tempDir);
                setTempDirectory(context, tempDir);
            }
        }
    }

    public void lifeCycleStopped(LifeCycle event)
    {
    }

    public void lifeCycleStopping(LifeCycle event)
    {
    }
    
    /**
     * Print the exception that occurred if the web application failed to start
     */
    private void printUnavailableFailure(LifeCycle event)
    {
        if (event instanceof WebAppContext)
        {
            WebAppContext context = (WebAppContext) event;
            if (!context.isStarted())
            {
                Throwable t = context.getUnavailableException();
                if (t != null)
                {
                    Log.warn("UnavailableException: " + t.getMessage(), t);
                }
            }
        }
    }

    /**
     * Attempt to remove the default web app temp directory as well as any temp
     * directories created by this class.  The directories might be left behind
     * when they were locked during a previous run of SageTV.
     */
    private void removeTempDirectory(WebAppContext context, File tempDir)
    {
        TempDirFilter filter = new TempDirFilter(tempDir.getName());
        File[] tempDirs = tempDir.getParentFile().listFiles(filter);
        for (File currentTempDir : tempDirs)
        {
            Log.debug("Delete temporary web app directory: " + currentTempDir.getAbsolutePath());
            boolean deleteResult = IO.delete(currentTempDir);
            
            if (deleteResult)
            {
                Log.debug("Successfully deleted temporary web app directory: " + currentTempDir.getAbsolutePath());
            }
            else
            {
                Log.debug("Failed to delete temporary web app directory: " + currentTempDir.getAbsolutePath());
            }
        }
    }

    /**
     * First attempt to set the temp directory to the default.  It's the value
     * specified by the developer in the context file.  This is necessary to set
     * the internal state of Jetty's WebAppContext class.
     *
     * If the directory already exists then find the first directory name that doesn't
     * exist when appending sequential numbers to the default directory's name.
     */
    private void setTempDirectory(WebAppContext context, File tempDir)
    {
        File defaultTempDir = tempDir;
        
        int i = 1;
        while (tempDir.exists())
        {
            tempDir = new File(defaultTempDir.getAbsolutePath() + "_" + i++);
        }

        Log.debug("Setting temporary web app directory: " + tempDir.getAbsolutePath());
        context.setTempDirectory(tempDir);
    }

    private boolean isTempDirInWebappsDir(File tempDir)
    {
        return (tempDir.getParentFile().equals(TEMP_WEBAPP_DIR));
    }

    /**
     * Filename filter to get the list of directories to delete
     */
    private class TempDirFilter implements FilenameFilter
    {
        private Pattern p = null;
        
        public TempDirFilter(String name)
        {
            p = Pattern.compile(name + "(_\\d+)?");
        }
        
        public boolean accept(File dir, String name)
        {
            Matcher m = p.matcher(name);
            return m.matches();
        }
    }
}
