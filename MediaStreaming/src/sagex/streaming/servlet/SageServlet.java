
package sagex.streaming.servlet;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.log.Log;

import sagex.api.AiringAPI;
import sagex.api.Configuration;
import sagex.api.MediaFileAPI;

/**
 * Core sage servlet with helper functions
 */
public abstract class SageServlet extends HttpServlet
{
    public void log(String arg0)
    {
        if (!arg0.equals("init") && !arg0.equals("destroy"))
        {
            super.log(arg0);
        }
    }

    protected static String charset = null;

    protected SageServlet()
    {
    }
    
    @Override
    public void init() throws ServletException
    {
        super.init();

        try
        { 
            charset = Configuration.GetProperty("nielm/webserver/charset", "UTF-8");
        }
        catch (Exception e)
        {
            Log.debug("Error getting charset:" + e.toString());
            Log.debug("caused:" + e.getCause().toString());
            e.printStackTrace(System.out);
            charset = "UTF-8";
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        req.setCharacterEncoding(charset);
        try
        {
            doServletGet(req,resp);
        }
        catch (IllegalArgumentException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("text/plain");
            resp.getWriter().write(e.getMessage());
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("text/plain");
            resp.getWriter().write(e.getMessage());
        }
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        doGet(req, resp);
    }

    protected abstract void doServletGet(HttpServletRequest req, HttpServletResponse resp)
        throws Exception;

    protected Object getMediaFile(HttpServletRequest req)
    {
        Object mediaFile = null;
        try
        {
            String idStr = req.getParameter("MediaFileId");
            if (idStr != null && ! idStr.equals(""))
            {
                Integer id = Integer.parseInt(idStr);
                mediaFile =  MediaFileAPI.GetMediaFileForID(id);
            }
            else
            {
                idStr = req.getParameter("AiringId");
                if (idStr != null && ! idStr.equals(""))
                {
                    Integer id = Integer.parseInt(idStr);
                    Object airing = AiringAPI.GetAiringForID(id);
                    if (airing != null)
                    {
                        mediaFile = MediaFileAPI.GetMediaFileAiring(airing);
                    }
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return mediaFile;
    }

    /// Check If-Modified-Since header
    // returns True if header is older  than lastModified --
    // and file needs to be sent
    protected boolean CheckIfModifiedSince(HttpServletRequest req, long lastModified)
        throws IllegalArgumentException
    {
        long ifModSince = req.getDateHeader("If-Modified-Since");
        if (ifModSince != -1)
        {
            // headers are to nearest second, timestamps are 
            // often of a higher resolution...
            lastModified = (lastModified / 1000) * 1000;
            if (ifModSince >= lastModified)
            {
                return false;
            }
        }
        return true;
    }
}
