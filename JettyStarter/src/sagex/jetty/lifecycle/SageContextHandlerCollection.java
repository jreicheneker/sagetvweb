package sagex.jetty.lifecycle;

import org.mortbay.jetty.Handler;
import org.mortbay.jetty.handler.ContextHandlerCollection;

/**
 * Provides a hook into the deployment process (via jetty.xml) without requiring
 * modification of the context xml files (by subclassing WebAppContext).  When a
 * web app is started, try to delete the current temp directory.  If the delete
 * fails, create a new temp directory.
 * 
 * Another option is to subclass ContextDeployer (also in jetty.xml) but that's a lot more work.
 * 
 * WebAppContext does not delete temp directories when starting a web app.  If
 * the temp directory was not deleted last time the app was stopped, HTTP 404
 * and 503 errors are displayed to the user. 
 */
public class SageContextHandlerCollection extends ContextHandlerCollection
{
    private WebAppContextLifeCycleListener lifecycleListener = new WebAppContextLifeCycleListener();
    
    public SageContextHandlerCollection() throws Exception
    {
        super();
    }

    @Override
    public void setHandlers(Handler[] handlers)
    {
        super.setHandlers(handlers);
        
        for (Handler handler : handlers)
        {
            handler.addLifeCycleListener(lifecycleListener);
        }
    }

    @Override
    public void addHandler(Handler handler)
    {
        super.addHandler(handler);

        handler.addLifeCycleListener(lifecycleListener);
    }

    @Override
    public void removeHandler(Handler handler)
    {
        super.removeHandler(handler);

        handler.removeLifeCycleListener(lifecycleListener);
    }
}
