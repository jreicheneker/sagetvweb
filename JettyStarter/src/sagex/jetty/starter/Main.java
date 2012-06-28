package sagex.jetty.starter;

import org.mortbay.log.Log;

import sagex.jetty.log.JettyStarterLogger;
import sagex.jetty.properties.JettyStarterPropertiesImpl;

public class Main implements Runnable
{
    static
    {
        // Handle all logging for Jetty and Jetty Starter
        JettyStarterLogger.init();

        Log.info("Jetty Starter plugin version " + Main.class.getPackage().getImplementationVersion());
    }
    
    /**
     * Called by SageTV 6 or earlier to start the Jetty application server
     */
    public void run()
    {
        Thread.currentThread().setName("Jetty Starter");

        try
        {
            JettyInstance.getInstance().setPropertyProvider(JettyStarterPropertiesImpl.class);
            JettyInstance.getInstance().start();
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
}
