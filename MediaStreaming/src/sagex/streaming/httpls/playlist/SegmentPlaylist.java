package sagex.streaming.httpls.playlist;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mortbay.log.Log;

import sagex.api.MediaFileAPI;

public class SegmentPlaylist
{
    public static final int TARGET_DURATION = 10;
    private static final String LINE_TERM = "\r\n";

    private HttpServletRequest req;
    private Object mediaFile;
    private int mediaFileId;
    private List<Segment> segmentList;
    private String conversionId;
    private String quality;
    private boolean isFileCurrentlyRecording;

    public SegmentPlaylist(HttpServletRequest req, Object mediaFile, String conversionId, String quality)
    {
        this.req = req;
        this.mediaFile = mediaFile;
        this.mediaFileId = MediaFileAPI.GetMediaFileID(mediaFile);
        this.segmentList = new ArrayList<Segment>();
        this.conversionId = conversionId;
        this.quality = quality;
        this.isFileCurrentlyRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);

        if (!this.isFileCurrentlyRecording)
        {
            createPlaylist();
        }
        else
        {
            // retry until there's at least one full segment recorded
            while (this.isFileCurrentlyRecording && segmentList.size() <= 1)
            {
                this.segmentList.clear();
    
                createPlaylist();
                
                long mediaFileSegmentDurationInMillis = MediaFileAPI.GetDurationForSegment(mediaFile, 0);
                long mediaFileSegmentDurationInSeconds = mediaFileSegmentDurationInMillis / 1000; // milliseconds to seconds
    
                if (this.isFileCurrentlyRecording && (mediaFileSegmentDurationInSeconds < SegmentPlaylist.TARGET_DURATION))
                {
                    try
                    {
                        // wait until we'll have a full first segment to return
                        Thread.sleep((SegmentPlaylist.TARGET_DURATION - mediaFileSegmentDurationInSeconds + 1) * 1000);
                    }
                    catch (InterruptedException e)
                    {
                        Log.warn(e.getMessage());
                    }
                }
    
                this.isFileCurrentlyRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);
            }
        }
    }

    private void createPlaylist()
    {
        String showName = MediaFileAPI.GetMediaTitle(mediaFile);
        int numberOfMediaFileSegments = MediaFileAPI.GetNumberOfSegments(mediaFile);
        Log.debug("Number of media file segments: " + numberOfMediaFileSegments);

        for (int i = 0; i < numberOfMediaFileSegments; i++)
        {
            // get length of current media file segment
            long mediaFileSegmentDurationInMillis = MediaFileAPI.GetDurationForSegment(mediaFile, i);
            long mediaFileSegmentDurationInSeconds = mediaFileSegmentDurationInMillis / 1000; // milliseconds to seconds
            Log.debug("mediaFileSegmentDurationInMillis (" + i + "): " + mediaFileSegmentDurationInMillis);
            Log.debug("mediaFileSegmentDurationInSeconds (" + i + "): " + mediaFileSegmentDurationInSeconds);
            
            int sequence = 0;
            for (int j = 0; j < mediaFileSegmentDurationInSeconds; j += SegmentPlaylist.TARGET_DURATION)
            {
                long currentDuration = Math.min(SegmentPlaylist.TARGET_DURATION, mediaFileSegmentDurationInSeconds - j);
                
                Segment newSegment = new Segment(currentDuration, sequence, i, showName);
                
                segmentList.add(newSegment);
                
                sequence++;
            }
        }
        if (segmentList != null)
        {
            Log.debug("segmentList size: " + segmentList.size());
        }
    }
    
    public List<Segment> getSegments()
    {
        return segmentList;
    }
    
    public String toString()
    {
        StringBuilder sb = new StringBuilder();

        String showName = MediaFileAPI.GetMediaTitle(mediaFile);
        int numberOfMediaFileSegments = MediaFileAPI.GetNumberOfSegments(mediaFile);
        int segmentCount = (isFileCurrentlyRecording) ? segmentList.size() - 1 : segmentList.size();
        Log.debug("Show: " + showName);
        Log.debug("MediaFileId: " + mediaFileId);
        Log.debug("Number Of MediaFile segments: " + numberOfMediaFileSegments);
        Log.debug("Is file currently recording: " + isFileCurrentlyRecording);
        Log.debug("Number of playlist segments: " + segmentCount);
        
        sb.append("#EXTM3U" + LINE_TERM);
        Log.debug("#EXTM3U");
        sb.append("#EXT-X-TARGETDURATION:" + TARGET_DURATION + LINE_TERM);
        Log.debug("#EXT-X-TARGETDURATION:" + SegmentPlaylist.TARGET_DURATION);
//        sb.append("#EXT-X-MEDIA-SEQUENCE:1" + LINE_TERM);
//        Log.debug("#EXT-X-MEDIA-SEQUENCE:1");

        for (int i = 0; i < segmentCount; i++)
        {
            Segment currentSegment = segmentList.get(i);
            Segment previousSegment = (i == 0) ? null : segmentList.get(i - 1);
            Segment nextSegment = (i == segmentCount - 1) ? null : segmentList.get(i + 1);
            String str = currentSegment.toString();
            sb.append(str);

            // first or last playlist segment for each media file segment
            // printing the whole playlist makes the log harder to read
            if ((previousSegment == null) ||
                (nextSegment == null) ||
                (previousSegment.mediaFileSegment != currentSegment.mediaFileSegment) ||
                (currentSegment.mediaFileSegment != nextSegment.mediaFileSegment)
               )                    
            {
                Log.debug(str);
            }
        }
        
//      #EXT-X-MEDIA-SEQUENCE:<number>
//      #EXT-X-PROGRAM-DATE-TIME:<YYYY-MM-DDThh:mm:ssZ>
//      #EXT-X-ALLOW-CACHE:<YES|NO>
//      #EXT-X-STREAM-INF

        if (!isFileCurrentlyRecording)
        {
            sb.append("#EXT-X-ENDLIST" + LINE_TERM);
            Log.debug("#EXT-X-ENDLIST");
        }
        return sb.toString();
    }

    public class Segment
    {
        private long segmentDuration;
        private int segmentSequence;
        private int mediaFileSegment;
        private String showName;
        
        public Segment(long segmentDuration, int segmentSequence, int mediaFileSegment, String showName)
        {
            this.segmentDuration = segmentDuration;
            this.segmentSequence = segmentSequence;
            this.mediaFileSegment = mediaFileSegment;
            this.showName = showName;
        }

        public String toString()
        {
            StringBuilder sb = new StringBuilder();
            
            sb.append("#EXTINF:" + segmentDuration + "," + showName + LINE_TERM);

            String url = req.getRequestURL().toString().replace(req.getRequestURI(), "") +
                         req.getContextPath() +
                         "/HTTPLiveStreamingSegment" +
                         "?Sequence=" + segmentSequence +
                         "&MediaFileId=" + mediaFileId +
                         "&ConversionId=" + conversionId +
                         "&Quality=" + quality +
                         "&MediaFileSegment=" + mediaFileSegment;
            sb.append(url + LINE_TERM);

            return sb.toString();
        }
    }
}
