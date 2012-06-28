package sagex.streaming.listener;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.mortbay.log.Log;

import sagex.api.Global;
import sagex.streaming.httpls.segment.SegmentManager;
import sagex.streaming.httpls.segment.SegmentProducer;
import sagex.streaming.httpls.segment.SegmenterProcess;
import sagex.streaming.io.StreamGobbler;

public class AppContextListener implements ServletContextListener
{
    public static final String SEGMENT_MANAGER_ATTRIBUTE_NAME = "Sage Streaming Segment Manager";

    /**
     * Configure the location of the ffmpeg executable, which is under the WEB-INF directory.
     * Make sure ffmpeg has executable permissions on Linux and MacOS
     */
    public void contextInitialized(ServletContextEvent event)
    {
        // TODO Logging
//        System.out.println("Stdout: starting media streaming web app");
//        System.err.println("Stderr: starting media streaming web app");
//        System.out.println("Stderr class: " + System.err.getClass());

        setTranscoderLocation(event);
        setSegmenterLocation(event);

        event.getServletContext().setAttribute(SEGMENT_MANAGER_ATTRIBUTE_NAME, new SegmentManager());
    }

    /**
     * Make sure all ffmpeg processes are destroyed so they aren't left running and so
     * redeployments can overwrite the executable.
     */
    public void contextDestroyed(ServletContextEvent event)
    {
        SegmentManager sm = (SegmentManager) event.getServletContext().getAttribute(AppContextListener.SEGMENT_MANAGER_ATTRIBUTE_NAME);

        synchronized (sm)
        {
            List<SegmentProducer> segmentProducers = sm.removeSegmentProducers();
            
            Log.debug("Destroying " + segmentProducers.size() + " remaining ffmpeg processes.");
            
            for (SegmentProducer sp : segmentProducers)
            {
                synchronized(sp)
                {
                    try
                    {
                        sp.stop();
                    }
                    catch (Throwable t)
                    {
                        Log.info("Unexpected exception while cleaning up processes: " + t.getMessage());
                        Log.ignore(t);
                    }
                }
            }
            
            segmentProducers.clear();
        }
    }
    
    private void setTranscoderLocation(ServletContextEvent event)
    {
        String transcoderPath = "";
        File sagetvHome = new File(System.getProperty("user.dir"));
        if (Global.IsLinuxOS())
        {
            transcoderPath = "ffmpeg";
        }
        else if (Global.IsMacOS())
        {
            transcoderPath = "ffmpeg";
        }
        else if (Global.IsWindowsOS())
        {
            transcoderPath = "SageTVTranscoder.exe";
        }
        
        File transcoderFile = new File(sagetvHome, transcoderPath);
        Log.debug("HTTPLS transcoder executable location: " + transcoderFile.getAbsolutePath());
        SegmenterProcess.setTranscoderProcessLocation(transcoderFile);
    }

    private void setSegmenterLocation(ServletContextEvent event)
    {
        // the segmenter is delivered in the war file
        String segmenterPath = "";
        if (Global.IsLinuxOS())
        {
            segmenterPath = "/WEB-INF/bin/linux32/ffmpeg";
        }
        else if (Global.IsMacOS())
        {
            segmenterPath = "/WEB-INF/bin/macos/ffmpeg";
        }
        else if (Global.IsWindowsOS())
        {
            segmenterPath = "/WEB-INF/bin/win32/ffmpeg.exe";
        }
        
        File segmenterFile = null;
        try
        {
            URL segmenterUrl = event.getServletContext().getResource(segmenterPath);
            if (segmenterUrl != null)
            {
                // jump through hoops to deal with spaces in the path (mainly for Windows "Program Files" directory) 
                // http://weblogs.java.net/blog/2007/04/25/how-convert-javaneturl-javaiofile
                try
                {
                    // convert %20 to a space
                    segmenterFile = new File(segmenterUrl.toURI());
                }
                catch (URISyntaxException e)
                {
                    segmenterFile = new File(segmenterUrl.getPath());
                }
                Log.debug("HTTPLS segmenter executable location: " + segmenterFile.getAbsolutePath());
                SegmenterProcess.setSegmenterProcessLocation(segmenterFile);
            }
        }
        catch (MalformedURLException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
        catch (IllegalArgumentException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }

        // since this is expanded from the war file
        setFileExecutablePermission(segmenterFile);
    }
    
    private void setFileExecutablePermission(File file)
    {
        if (Global.IsLinuxOS() || Global.IsMacOS())
        {
            try
            {
                Process p = Runtime.getRuntime().exec("chmod +x " + file.getAbsolutePath());
                
                StreamGobbler stdoutGobbler = new StreamGobbler("chmod stdout", p.getInputStream(), null, true);
                StreamGobbler stderrGobbler = new StreamGobbler("chmod stderr", p.getErrorStream(), null, true);
                
                ExecutorService threadPool = Executors.newFixedThreadPool(2);
                Future<?> stdoutFuture = threadPool.submit(stdoutGobbler);
                Future<?> stderrFuture = threadPool.submit(stderrGobbler);
                
                p.waitFor();
    
                stdoutFuture.get();
                stderrFuture.get();
            }
            catch (Exception e)
            {
                Log.info(e.getMessage());
                Log.ignore(e);
            }
        }
    }
}
