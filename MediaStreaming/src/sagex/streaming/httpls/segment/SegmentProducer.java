package sagex.streaming.httpls.segment;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;

import org.mortbay.log.Log;

import sagex.api.MediaFileAPI;

/**
 * Encapsulates the state of an HTTP Live Streaming stream and the SegmenterProcess that
 * creates that stream.
 * Calling code should always do so within a block that synchronizes
 * on this object.  If it also calls SegmentManager and needs to hold locks on
 * both objects, it should acquire the lock on SegmentManager first to avoid deadlock.
 */
public class SegmentProducer
{
    private SegmenterState state;
    private SegmenterProcess segmenterProcess;
//    private TranscoderProcess transcoderProcess;
    private String userAgent = "";
    private long lastActivity = 0;

    public SegmentProducer(String conversionId, String userAgent)
    {
        this.state = new SegmenterState(conversionId);
        this.userAgent = userAgent;
        this.lastActivity = System.currentTimeMillis();
    }
    
    public void reset() throws IOException
    {
        Log.debug("Resetting segment producer");

        if (segmenterProcess != null)
        {
            Log.debug("Killing segmenter process");
            segmenterProcess.stopProcess();
        }

        Object mediaFile = MediaFileAPI.GetMediaFileForID(state.getMediaFileId());
        int sageSegment = state.getMediaFileSegment();
        File f = MediaFileAPI.GetFileForSegment(mediaFile, sageSegment);
        
        Log.debug("Creating new segmenter process");
        segmenterProcess = new SegmenterProcess();
      
        segmenterProcess.startProcess(f, userAgent, state.getQuality(), state.getSegment());
        
        lastActivity = System.currentTimeMillis();
    }

    // TODO private
    public boolean nextState(int segmentIndex, String quality, int sageObjectId, int mediaFileSegment)
    {
        boolean val = false;
        
        try
        {
            val = state.nextState(segmentIndex, quality, sageObjectId, mediaFileSegment);
        }
        finally
        {
            lastActivity = System.currentTimeMillis();
        }

        return val;
    }
    
    public long getNextSegmentLength()
    {
        return segmenterProcess.getNextSegmentLength();
    }
    
    public void streamNextSegment(OutputStream os)
    {
        lastActivity = System.currentTimeMillis();
        try
        {
            segmenterProcess.streamNextSegment(os);
        }
        catch (Throwable t)
        {
            Log.warn(t.getMessage(), t);
            this.state.reset();
        }
        finally
        {
            lastActivity = System.currentTimeMillis();
        }
    }
    
    public void stop()
    {
        if (segmenterProcess != null)
        {
            segmenterProcess.stopProcess();
        }
    }

    public long getLastActivity()
    {
        return lastActivity;
    }
}
