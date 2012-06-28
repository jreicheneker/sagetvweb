package sagex.webserver.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class for Servlet: RtspServlet
 *
 */
// TODO http over rstp.  set up both client and server, forward input and output streams
 public class RtspServlet extends javax.servlet.GenericServlet implements javax.servlet.Servlet {

     PrintWriter pw = null;

    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public RtspServlet() {
		super();
	}

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
        super.destroy();
        pw.flush();
        pw.close();
        pw = null;
    }

    @Override
    public String getInitParameter(String name) {
        // TODO Auto-generated method stub
        return super.getInitParameter(name);
    }

    @Override
    public Enumeration getInitParameterNames() {
        // TODO Auto-generated method stub
        return super.getInitParameterNames();
    }

    @Override
    public ServletConfig getServletConfig() {
        // TODO Auto-generated method stub
        return super.getServletConfig();
    }

    @Override
    public ServletContext getServletContext() {
        // TODO Auto-generated method stub
        return super.getServletContext();
    }

    @Override
    public String getServletInfo() {
        // TODO Auto-generated method stub
        return super.getServletInfo();
    }

    @Override
    public String getServletName() {
        // TODO Auto-generated method stub
        return super.getServletName();
    }

    @Override
    public void init() throws ServletException {
        // TODO Auto-generated method stub
        super.init();
        initLog();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        super.init(config);
        initLog();
    }

    private void initLog()
    {
        try
        {
            File logFile = new File(System.getProperty("user.dir"), "rtsp.out");
            System.out.println("creating log file " + logFile.getAbsolutePath());
            pw = new PrintWriter(logFile);
        }
        catch (FileNotFoundException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public void log(String message, Throwable t) {
        // TODO Auto-generated method stub
        //super.log(message, t);
        pw.println("RtspServlet: " + message);
        t.printStackTrace(pw);
        pw.flush();
    }

    @Override
    public void log(String msg) {
        // TODO Auto-generated method stub
        //super.log(msg);
        pw.println("RtspServlet: " + msg);
        pw.flush();
    }

    @Override
    public void service(ServletRequest req, ServletResponse resp)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        log("CharacterEncoding: " + req.getCharacterEncoding());
        log("ContentLength: " + Integer.toString(req.getContentLength()));
        log("ContentType: " + req.getContentType());
        log("LocalAddr: " + req.getLocalAddr());
        log("LocalName: " + req.getLocalName());
        log("LocalPort: " + Integer.toString(req.getLocalPort()));
        log("Protocol: " + req.getProtocol());
        log("RealPath: " + req.getRealPath(""));
        log("RemoteAddr: " + req.getRemoteAddr());
        log("RemoteHost: " + req.getRemoteHost());
        log("RemotePort: " + Integer.toString(req.getRemotePort()));
        log("Scheme: " + req.getScheme());
        log("ServerName: " + req.getServerName());
        log("ServerPort: " + Integer.toString(req.getServerPort()));
        log("Attribute Names:");
        Enumeration<String> attributeNames = req.getAttributeNames();
        while (attributeNames.hasMoreElements())
        {
            String attributeName = attributeNames.nextElement();
            log("   " + attributeName + ": " + req.getAttribute(attributeName));
        }
        log("test");
        log("Parameter Names:");
        Enumeration<String> parameterNames = req.getParameterNames();
        while (parameterNames.hasMoreElements())
        {
            String parameterName = parameterNames.nextElement();
            log("   " + parameterName + ": " + req.getParameter(parameterName));
        }
        log("");
        log("Request reader:");
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null)
        {
            log(line);
        }
        HttpServletResponse httpResp = (HttpServletResponse) resp;
        httpResp.setStatus(200);
        //httpResp.setContentType("text/plain");
        //httpResp.getWriter().println("Hello");
        try
        {
            httpResp.setContentType("video/mpeg");
            File mpegFile = new File("/media/sda1/sagetv/recordings/XXIXSummerOlympics-SoccerBasketballEquestrianBeachVolleyballFencingContd-7140193-0.mpg");
            BufferedInputStream is = new BufferedInputStream(new FileInputStream(mpegFile));
            BufferedOutputStream os = new BufferedOutputStream(httpResp.getOutputStream());
            byte[] buffer = new byte[1024];
            int bufferLen = -1;
            while ((bufferLen = is.read(buffer)) != -1)
            {
                os.write(buffer, 0, bufferLen);
            }
            is.close();
            os.flush();
            os.close();
        }
        catch (Throwable t)
        {
            t.printStackTrace();
        }
    }   	 	  	  	    
}