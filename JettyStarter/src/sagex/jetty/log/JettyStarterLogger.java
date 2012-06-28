package sagex.jetty.log;

import org.mortbay.log.Log;
import org.mortbay.log.Logger;

public class JettyStarterLogger implements Logger
{
    private Logger logger = null;

    public static void init()
    {
        // Handle all logging for Jetty and Jetty Starter
        // EXCEPTION, DEBUG, VERBOSE, IGNORED
        System.setProperty("org.mortbay.log.class", JettyStarterLogger.class.getName());
        
        // Initialize Jetty's logging through Log's static initializer.  By setting the
        // property "org.mortbay.log.class" to this class, all logging will be routed
        // through this class.
        Log.getLog();
        
        // Attempt to load log4j logger.  If log4j is not in the classpath, log to stderr
        // via Jetty's implementation.
        // TODO Log4j, load config file
//        try
//        {
//            Class<Logger> loggerClass = Loader.loadClass(Logger.class, "sagex.jetty.log.Log4jLog");
//            logger = loggerClass.newInstance().getLogger("sagex.jetty");// = (Logger) loggerClass.newInstance();
//            Log.info("Jetty logging: Log4j");
//        }
//        catch (Throwable e)
//        {
//            logger = new StdErrLog();
//            Log.info("Jetty logging: Java StdErr");
//        }
    }
    
//    public JettyStarterLogger() throws Exception
//    {
//        this("org.mortbay.log");
//    }
//    
//    public JettyStarterLogger(String name)
//    {
//        logger = org.slf4j.LoggerFactory.getLogger( name );
//    }

    public JettyStarterLogger()
    {
        logger = new SageStdOutLog();
    }

    public void debug(String msg, Throwable ex)
    {
        if (msg == null) msg = "Null Message";
        logger.debug(msg, ex);
    }

    public void debug(String msg, Object arg1, Object arg2)
    {
        if (msg == null) msg = "Null Message";
        logger.debug(msg, arg1, arg2);
    }

    public Logger getLogger(String name)
    {
        return this;
    }

    public void info(String msg, Object arg1, Object arg2)
    {
        if (msg == null) msg = "Null Message";
        logger.info(msg, arg1, arg2);
    }

    public boolean isDebugEnabled()
    {
        return logger.isDebugEnabled();
    }

    public void setDebugEnabled(boolean enabled)
    {
        logger.setDebugEnabled(enabled);
    }

    public void warn(String msg, Throwable ex)
    {
        if (msg == null) msg = "Null Message";
        logger.warn(msg, ex);
    }

    public void warn(String msg, Object arg1, Object arg2)
    {
        if (msg == null) msg = "Null Message";
        logger.warn(msg, arg1, arg2);
    }
}
