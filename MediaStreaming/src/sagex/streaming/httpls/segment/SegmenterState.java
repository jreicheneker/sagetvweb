package sagex.streaming.httpls.segment;

import org.mortbay.log.Log;

public class SegmenterState
{
    private boolean isInitialState = true;
    private int segment = -1;
    private String quality;

    // other properties
    private int mediaFileId; // could be airingId (which could have multiple mediaFileIds) or mediaFileId
    private int mediaFileSegment = 0;

    public SegmenterState(String conversionId)
    {
        reset();
    }
    
    public void reset()
    {
        isInitialState = true;
        segment = -1;
        quality = null;

        mediaFileId = 0;
        mediaFileSegment = 0;
    }
    
    public boolean nextState(int segment, String quality, int mediaFileId, int mediaFileSegment)
    {
        if (quality == null)
        {
            throw new IllegalArgumentException("Quality argument is null");
        }
        
        Log.debug("nextState() old segment = " + this.segment + ", new segment = " + segment);
        Log.debug("nextState() old quality = " + this.quality + ", new quality = " + quality);
        
        boolean isNextStateSequential = (segment == this.segment + 1) &&
                                        quality.equals(this.quality) &&
                                        (mediaFileId == this.mediaFileId) &&
                                        (mediaFileSegment == this.mediaFileSegment);

        this.segment = segment;
        this.quality = quality;
        this.mediaFileId = mediaFileId;
        this.mediaFileSegment = mediaFileSegment;
        
        // Always start new process when in the initial state.
        // Otherwise reuse the existing process if the next segment of the same file is requested.
        boolean returnVal = !isInitialState && isNextStateSequential;
        isInitialState = false;
        
        Log.debug("SegmenterState.nextState() returns " + returnVal);
        
        return returnVal;
    }

    public int getSegment()
    {
        return segment;
    }

    public int getMediaFileId()
    {
        return mediaFileId;
    }

    public int getMediaFileSegment()
    {
        return mediaFileSegment;
    }
    
    public String getQuality()
    {
        return quality;
    }
}
