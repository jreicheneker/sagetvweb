package sagex.streaming.servlet;

import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.log.Log;

import sagex.streaming.httpls.segment.SegmentManager;
import sagex.streaming.httpls.segment.SegmentProducer;
import sagex.streaming.listener.AppContextListener;

@SuppressWarnings("serial")
public class HTTPLiveStreamingSegmentServlet extends SageServlet
{
    @Override
    protected void doServletGet(HttpServletRequest req, HttpServletResponse resp)
            throws Exception
    {
        // remove servlet URL from thread name so the SageTV log is easier to read
        String threadName = Thread.currentThread().getName();
        int i = threadName.indexOf("/stream");
        if (i >= 1) // the request URL is not part of the thread name when the log level is INFO
        {
            Thread.currentThread().setName(threadName.substring(0, i));
        }

        Log.debug("HTTPLiveStreamingSegmentServlet: Request started");
        Object mediaFile = super.getMediaFile(req);
        if (mediaFile == null)
        {
            throw new IllegalArgumentException("No MediaFileId passed");
        }

        Log.debug("----------- HTTPLiveStreamingSegmentServlet begin request Headers ---------------");
        Enumeration<?> headers = req.getHeaderNames();
        while (headers.hasMoreElements())
        {
            String headerName = (String) headers.nextElement();
            if ((headerName != null) && (!headerName.equals("Host")) && (!headerName.equals("Authorization")))
            {
                Log.debug(headerName + ": " + req.getHeader(headerName));
            }
        }
        Log.debug("----------- HTTPLiveStreamingSegmentServlet end request Headers ---------------");
        
//        File file = MediaFileAPI.GetFileForSegment(mediaFile, 0); // TODO media file segment

        resp.setHeader("Accept-Ranges", "none");
//        resp.setHeader("Content-Length", String.valueOf(Long.MAX_VALUE));

        String range = req.getHeader("Range");
        if (range != null && range.equals("bytes=0-1".trim()))
        {
            resp.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
            resp.setHeader("Content-Range", "bytes 0-1/2000000");
            resp.setHeader("Content-Length", "2");
            resp.getOutputStream().write(0);
            resp.getOutputStream().write(0);
            resp.getOutputStream().flush();
        }
        else
        {
            String conversionId = req.getParameter("ConversionId");
            if ((conversionId == null) || (conversionId.trim().length() == 0))
            {
                Log.info("ConversionId request parameter is required");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // look for command to stop transcoder and segmenter
            String commandString = req.getParameter("Command");
            if (commandString != null)
            {
                if (commandString.toLowerCase().equals("stop"))
                {
                    ServletContext sc = getServletContext();
                    SegmentManager sm = (SegmentManager) sc.getAttribute(AppContextListener.SEGMENT_MANAGER_ATTRIBUTE_NAME);
                    SegmentProducer segmentProducer = null;

                    synchronized (sm)
                    {
                        segmentProducer = sm.removeSegmentProducer(conversionId);
                        
                        if (segmentProducer != null)
                        {
                            synchronized (segmentProducer)
                            {
                                Log.debug("Client has sent a command to stop the transcoding for conversion id " + conversionId);
                                segmentProducer.stop();
                            }
                        }
                    }
                }
                else
                {
                    Log.info("Invalid command request parameter");
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                return; // don't go any further if a command string was sent
            }

            String sequenceString = req.getParameter("Sequence");
            String qualityString = req.getParameter("Quality");
            String mediaFileIdString = req.getParameter("MediaFileId");
            String mediaFileSegmentString = req.getParameter("MediaFileSegment"); // optional, default is zero
            int sequence = 0;
            int mediaFileId = 0;
            int mediaFileSegment = 0;

            try
            {
                sequence = Integer.parseInt(sequenceString);
            }
            catch (NumberFormatException e)
            {
                Log.info("Sequence request parameter is invalid");
                Log.info(e.getMessage());
                Log.ignore(e);
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            try
            {
                mediaFileId = Integer.parseInt(mediaFileIdString);
            }
            catch (NumberFormatException e)
            {
                Log.info("MediaFileId or AiringId request parameter is invalid");
                Log.info(e.getMessage());
                Log.ignore(e);
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            try
            {
                if (mediaFileSegmentString == null)
                {
                    mediaFileSegment = 0;
                }
                else
                {
                    mediaFileSegment = Integer.parseInt(mediaFileSegmentString);
                }
            }
            catch (NumberFormatException e)
            {
                Log.info("MediaFileId or AiringId request parameter is invalid");
                Log.info(e.getMessage());
                Log.ignore(e);
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.setContentType("video/MP2T");

            ServletContext sc = getServletContext();
            SegmentManager sm = (SegmentManager) sc.getAttribute(AppContextListener.SEGMENT_MANAGER_ATTRIBUTE_NAME);
            SegmentProducer segmentProducer = null;

            synchronized (sm)
            {
                segmentProducer = sm.getSegmentProducer(conversionId);
                
                if (segmentProducer == null)
                {
                    segmentProducer = new SegmentProducer(conversionId, req.getHeader("User-Agent"));
                    sm.addSegmentProducer(conversionId, segmentProducer);
                }
            }
            
            synchronized (segmentProducer)
            {
                try
                {
                    // TODO only call stream next segment, encapsulate the rest
                    if (!segmentProducer.nextState(sequence, qualityString, mediaFileId, mediaFileSegment) /*|| (sp == null)*/)
                    {
                        segmentProducer.reset();
                    }
    
                    long len = segmentProducer.getNextSegmentLength();
                    Log.debug("Content-Length: " + len);
                    resp.setHeader("Content-Length", Long.toString(len));
                    segmentProducer.streamNextSegment(resp.getOutputStream());
                }
                catch (IllegalArgumentException e)
                {
                    throw e;
                }
                catch (Throwable t)
                {
                    // explicitly print the stack trace here at any log level to try to help fix bugs
                    Log.warn(t.getMessage(), t);
                    // Error on the following line: Response already committed
                    //resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    return;
                }
            }
        }
        resp.flushBuffer();
        Log.debug("Request ended");
        Thread.currentThread().setName(threadName);
    }
    // choose transcoder
    // transcode file
    // use time range
}
