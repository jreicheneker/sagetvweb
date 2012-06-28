package sagex.jetty.log;

import org.mortbay.log.Logger;
import org.mortbay.log.StdErrLog;

/**
 * Another plugin appears to be redirecting Sage's stderr and therefore
 * Jetty's debug logging is not written to Sage's log file.  Switch to
 * this logger which writes to stdout so the logging will always be
 * written and it's easier to troubleshoot issues.
 * Don't output the timestamp because Sage's logger already does.
 */
public class SageStdOutLog extends StdErrLog
{
    private static boolean debug = System.getProperty("DEBUG",null)!=null;
    private String name;
    
    public SageStdOutLog()
    {
        this(null);
    }
    
    public SageStdOutLog(String name)
    {    
        this.name=name==null?"":name;
    }
    
    public boolean isDebugEnabled()
    {
        return debug;
    }
    
    public void setDebugEnabled(boolean enabled)
    {
        debug=enabled;
    }
    
    public void info(String msg,Object arg0, Object arg1)
    {
        System.out.println(":"+name+":INFO:  "+format(msg,arg0,arg1));
    }
    
    public void debug(String msg,Throwable th)
    {
        if (debug)
        {
            System.out.println(":"+name+":DEBUG: "+msg);
            if (th!=null) th.printStackTrace();
        }
    }
    
    public void debug(String msg,Object arg0, Object arg1)
    {
        if (debug)
        {
            System.out.println(":"+name+":DEBUG: "+format(msg,arg0,arg1));
        }
    }
    
    public void warn(String msg,Object arg0, Object arg1)
    {
        System.out.println(":"+name+":WARN:  "+format(msg,arg0,arg1));
    }
    
    public void warn(String msg, Throwable th)
    {
        System.out.println(":"+name+":WARN:  "+msg);
        if (th!=null)
            th.printStackTrace();
    }

    private String format(String msg, Object arg0, Object arg1)
    {
        int i0=msg.indexOf("{}");
        int i1=i0<0?-1:msg.indexOf("{}",i0+2);
        
        if (arg1!=null && i1>=0)
            msg=msg.substring(0,i1)+arg1+msg.substring(i1+2);
        if (arg0!=null && i0>=0)
            msg=msg.substring(0,i0)+arg0+msg.substring(i0+2);
        return msg;
    }
    
    public Logger getLogger(String name)
    {
        if ((name==null && this.name==null) ||
            (name!=null && name.equals(this.name)))
            return this;
        return new SageStdOutLog(name);
    }
    
    public String toString()
    {
        return "STDOUT"+name;
    }
}
