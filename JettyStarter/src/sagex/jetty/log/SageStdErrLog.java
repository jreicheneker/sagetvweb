package sagex.jetty.log;

import org.mortbay.log.Logger;
import org.mortbay.log.StdErrLog;

/**
 * Don't output the timestamp because Sage's logger already does.
 * Otherwise this is the same as Jetty's StdErrLog.
 */
public class SageStdErrLog extends StdErrLog
{
    private static boolean debug = System.getProperty("DEBUG",null)!=null;
    private String name;
    
    public SageStdErrLog()
    {
        this(null);
    }
    
    public SageStdErrLog(String name)
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
        System.err.println(":"+name+":INFO:  "+format(msg,arg0,arg1));
    }
    
    public void debug(String msg,Throwable th)
    {
        if (debug)
        {
            System.err.println(":"+name+":DEBUG: "+msg);
            if (th!=null) th.printStackTrace();
        }
    }
    
    public void debug(String msg,Object arg0, Object arg1)
    {
        if (debug)
        {
            System.err.println(":"+name+":DEBUG: "+format(msg,arg0,arg1));
        }
    }
    
    public void warn(String msg,Object arg0, Object arg1)
    {
        System.err.println(":"+name+":WARN:  "+format(msg,arg0,arg1));
    }
    
    public void warn(String msg, Throwable th)
    {
        System.err.println(":"+name+":WARN:  "+msg);
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
        return new SageStdErrLog(name);
    }
    
    public String toString()
    {
        return "STDERR"+name;
    }
}
