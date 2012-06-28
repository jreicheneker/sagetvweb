package sagex.streaming.httpls.playlist;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.mortbay.log.Log;

public class VariantPlaylist
{
    public static String[] VARIANT_PLAYLIST_BITRATES = {"150", "1240", "1840", "840", "640", "440", "240"};
    private static final String LINE_TERM = "\r\n";

    private HttpServletRequest req;
    private int mediaFileId;
    private String defaultBitrate;
    private String playlist;

    public VariantPlaylist(HttpServletRequest req, int mediaFileId, String defaultBitrate)
    {
        if ((defaultBitrate != null) &&
            (defaultBitrate.trim().length() > 0) &&
            !isValidBitrate(defaultBitrate))
        {
            throw new IllegalArgumentException("Bitrate");
        }
        
        this.req = req;
        this.mediaFileId = mediaFileId;
        this.defaultBitrate = defaultBitrate;
        this.playlist = createPlaylist();
    }

    private boolean isValidBitrate(String defaultBitrate)
    {
        for (String bitrate : VARIANT_PLAYLIST_BITRATES)
        {
            if (bitrate.equals(defaultBitrate))
            {
                return true;
            }
        }
        return false;
    }

    private String createPlaylist()
    {
        StringBuilder sb = new StringBuilder();
    
        String conversionId = UUID.randomUUID().toString();

        // Header
        sb.append("#EXTM3U" + LINE_TERM);
        Log.debug("#EXTM3U");

        // Body
        if ((defaultBitrate != null) &&
            (defaultBitrate.trim().length() > 0))
        {
            sb.append(createPlaylistEntry(conversionId, defaultBitrate));
        }

        for (String bitrate : VARIANT_PLAYLIST_BITRATES)
        {
            if (!bitrate.equals(defaultBitrate))
            {
                sb.append(createPlaylistEntry(conversionId, bitrate));
            }
        }

        return sb.toString();
    }

    private String createPlaylistEntry(String conversionId, String bitrate)
    {
        String header = "#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=" + bitrate + "000";
        Log.debug(header);

        String url = req.getRequestURL().toString().replace(req.getRequestURI(), "") +
                     req.getContextPath() +
                     "/HTTPLiveStreamingPlaylist" +
//                     req.getPathInfo() +
                     "?MediaFileId=" + mediaFileId +
                     "&ConversionId=" + conversionId +
                     "&Quality=" + bitrate;
        Log.debug(url);

        return header + LINE_TERM + url + LINE_TERM;
    }
    
    public String toString()
    {
        return this.playlist;
    }
}
