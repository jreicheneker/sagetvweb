package sagex.streaming.servlet;

import java.io.File;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.SocketException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.jetty.EofException;
import org.mortbay.log.Log;

import sagex.api.AiringAPI;
import sagex.api.MediaFileAPI;

/**
 * Copied from nielm's web server to eliminate dependency.  It has been modified
 * (e.g. throttling removed) to get the core functionality working.
 */
public class MediaFileServlet extends SageServlet
{
    public MediaFileServlet()
    {
        super();
    }

    /* (non-Javadoc)
     * @see net.sf.sageplugins.webserver.SageServlet#doServletGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    protected void doServletGet(HttpServletRequest req, HttpServletResponse res)
        throws Exception
    {
        try
        {
            Log.debug("----------- MediaFileServlet begin request Headers ---------------");

            Enumeration<?> headers = req.getHeaderNames();
            while (headers.hasMoreElements())
            {
                String headerName = (String) headers.nextElement();
                if ((headerName != null) && (!headerName.equals("Host")) && (!headerName.equals("Authorization")))
                {
                    Log.debug(headerName + ": " + req.getHeader(headerName));
                }
            }
            Log.debug("----------- MediaFileServlet end request Headers ---------------");
            Object mediaFile = super.getMediaFile(req);
            if (mediaFile == null)
            {
                throw new IllegalArgumentException("no MediaFileID passed");
            }
            File files[] = (File[]) MediaFileAPI.GetSegmentFiles(mediaFile);
            int filenum = 0;
            if (files.length > 1)
            {
                String filenum_str=req.getParameter("Segment");
                if (filenum_str == null)
                {
                    throw new IllegalArgumentException("Segmented file: requires Segment Number");
                }
                try
                { 
                    filenum = Integer.parseInt(filenum_str);
                    if ( filenum < 0 || filenum > files.length)
                    {
                        throw new NumberFormatException();
                    }
                }
                catch (NumberFormatException e)
                {
                    throw new IllegalArgumentException("Invalid Segment Number: "+filenum_str);
                }
            }
            File file=files[filenum];
            if (!file.exists())
            {
                throw new IllegalArgumentException("File does not exist: "+files[filenum]);
            }
            if (!file.canRead())
            {
                throw new IllegalArgumentException("File can not be read: "+files[filenum]);
            }

            boolean headOnly=false;
    		if (req.getMethod().equalsIgnoreCase("get"))
    		{
    		    headOnly = false;
    		}
    		else if (!req.getMethod().equalsIgnoreCase("head"))
    		{
    		    headOnly = true;
    		}
    		else
    		{
    			res.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED);
    			return;
    		}
    		res.setStatus(HttpServletResponse.SC_OK);
    		
            boolean isRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);
            
            // Handle Connection: close
//            if ("close".equals(req.getHeader("Connection")))
//            {
//                res.setHeader("Connection", "close");
//            }
            
    		// Handle If-Modified-Since.
    		long lastMod = file.lastModified();
    		try
    		{
    		    if (!super.CheckIfModifiedSince(req,lastMod))
    		    {
    		        res.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
    		        headOnly = true;
    		    }
    		}
    		catch (IllegalArgumentException e)
    		{
    		    log(e.toString());
    		}

            res.setContentType(getServletContext().getMimeType(file.getName()));

            long fileLength = file.length();
    		if (fileLength < Integer.MAX_VALUE)
    		{
    		    res.setContentLength((int) fileLength);
            }
            else
    		{
    			res.setHeader("Content-Length", Long.toString(fileLength));
    		}
    		res.setDateHeader("Last-modified", lastMod);

    		if (headOnly)
    		{
//    		    Log.debug("Headers only");
    		    res.flushBuffer();
    		}
    		else
    		{
    		    res.setHeader("Accept-Ranges", "bytes");
    		    			    
    		    // check range request
    		    long start = 0;
                long stop = fileLength - 1;
                //  if currently recording file, handle length specially:
                if (isRecording && filenum == files.length - 1)
                {
                    // estimate file size of scheduled recording
                    //
                    long startTime = MediaFileAPI.GetStartForSegment(mediaFile, filenum);
                    long endTime = AiringAPI.GetScheduleEndTime(mediaFile);
//                    long startTime=((Long)SageTV.api("GetStartForSegment",new Object[]{mediaFile,new Integer(filenum)})).longValue();
//                    long endTime=((Long)SageTV.api("GetScheduleEndTime",new Object[]{mediaFile})).longValue();
                    long currTime = System.currentTimeMillis();
                    long byterate = (fileLength)/(currTime-startTime);
                    fileLength = ((endTime-startTime) * 105 / 100) * byterate;
                    stop = fileLength - 1;
                    Log.debug("MediaFileServlet: Currently recording file: start="+startTime+" curr="+currTime+" end="+endTime+" est filesize="+fileLength+ " est byterate="+byterate);
                }
                
    	        String range = req.getHeader("Range");
    		    if (range != null && range.trim().startsWith("bytes="))
    		    {
    		        Log.debug("MediaFileServlet: Requested Range = " + range + " File length =" + fileLength);
    		        range = range.trim().substring(6);
    		        String ranges[] = range.split(",");
    		        if (ranges.length > 0)
    		        {
    			        String startstop[] = ranges[0].split("-");
    			        if (startstop.length > 0 && startstop[0].trim().length() > 0)
    			        {
    			            try
    			            {
    			                start = Long.parseLong(startstop[0].trim());
    			            }
    			            catch (NumberFormatException e)
    			            {
    			                log("invalid range specifyer (start)"+range,e);
    			            }
    			        }
    			        if (startstop.length > 1 && startstop[1].trim().length() > 0)
    			        {
    			            try
    			            {
    			                stop = Long.parseLong(startstop[1].trim());
    			            }
    			            catch (NumberFormatException e)
    			            {
    			                log("invalid range specifyer (stop)"+range,e);
    			            }
    			        }
                        
                        // if currently recording file, handle range request specially:
    		            if (isRecording && filenum == files.length - 1)
    		            {
                            // check start point
                            if (start > fileLength)
                            {
                                start = fileLength;
                            }
                        } 
                        
                        // check ranges
                        if (start > stop || start < 0 || stop >= fileLength)
                        {
                            Log.debug("MediaFileServlet: request range is out of range.");
                            res.setStatus(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
                            return;
                        }
                        res.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
    		        }
    		    } 
//                Log.debug("MediaFileServlet: Supplying range bytes "+Long.toString(start)+"-"+Long.toString(stop)+"/"+Long.toString(fileLength));
//                Log.debug("MediaFileServlet: Debug enabled = " + Log.getLog().isDebugEnabled());
//                Log.debug("MediaFileServlet: Log class = " + Log.getLog().getClass().getName());
    		    Log.debug("MediaFileServlet: Supplying range bytes "+Long.toString(start)+"-"+Long.toString(stop)+"/"+Long.toString(fileLength));
    		    RandomAccessFile rfile = new RandomAccessFile(file, "r");
    		    res.setHeader("Content-Range", "bytes " + Long.toString(start) + "-" + Long.toString(stop) + "/" + Long.toString(fileLength));
    		    res.setHeader("Content-Length", Long.toString(stop-start+1));
                //res.setHeader("Content-Disposition","attachment; filename="+file.getName());
    		    OutputStream os = res.getOutputStream();

    		    try
    		    {
                    if (start > 0)
                    {
                        rfile.seek(start);
                    }

                    // copy stream stopping at 'stop' bytes, or at EOF if stop==fileLen-1
    		        long nextByte = start;
    		        int buflen = 1024;
    		        int readLen = -1;
    		        byte[] buf = new byte[buflen];
    		        while (stop == fileLength - 1 || nextByte <= stop)
    		        {
    		            readLen = rfile.read(buf, 0, buflen);
                        if (readLen == -1)
                        {
                            // EOF reached -- check if file is still being recorded.
                            isRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);
                            if (isRecording)
                            {
                                files = MediaFileAPI.GetSegmentFiles(mediaFile);
                                if (filenum == files.length - 1)
                                {
                                    // still recording this segment -- try reading again after a few 100ms
                                    Thread.sleep(500);
                                    readLen = rfile.read(buf, 0, buflen);
                                }
                            }
                        }
    		            if (readLen > 0)
    		            {
    		                long bytesRemaining = stop - nextByte + 1;
                            long writeLen = Math.min(readLen, bytesRemaining);
    		                try
    		                {// TODO retries
    		                    os.write(buf, 0, (int) writeLen);
    		                }
                            catch (EofException e)
                            {
                                throw e;
                            }
                            catch (Throwable t)
    		                {
                                t.printStackTrace();
    		                    throw t;
    		                }
                            nextByte += writeLen;
    		            }
    		            else
    		            {
    		                Log.debug("MediaFileServlet: EOF met");
    		                // end of file -- stop
    		                break;
    		            }   
    		        }

                }
    		    catch (SocketException e)
                {
                    /* assume socket has been closed -- ignore */
                }
                finally
                {
                    try
                    {
                        rfile.close();
                    }
                    catch (Exception e)
                    {
                        // ignore
                    }
                    try
                    {
                        os.close();
                    }
                    catch (Exception e)
                    {
                        // ignore
                    }
    		    }
    		}
        }
        catch (Throwable e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
}
