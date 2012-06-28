
package sagex.webserver.servlet;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sage.SageTV;

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
            charset = (String) SageTV.api("GetProperty", new Object[] {"nielm/webserver/charset", "UTF-8"});
        }
        catch (InvocationTargetException e)
        {
            System.out.println("Error getting charset:" + e.toString());
            System.out.println("caused:" + e.getCause().toString());
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
        catch (Exception e)
        {
            throw new ServletException(e.getMessage(), e);
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
                mediaFile = SageTV.api("GetMediaFileForID", new Object[] {id});
            }
            else
            {
                idStr = req.getParameter("AiringId");
                if (idStr != null && ! idStr.equals(""))
                {
                    Integer id = Integer.parseInt(idStr);
                    Object airing = SageTV.api("GetAiringForID", new Object[] {id});
                    if (airing != null)
                    {
                        mediaFile = SageTV.api("GetMediaFileForAiring", new Object[] {airing});
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
