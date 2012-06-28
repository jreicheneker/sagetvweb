package sagex.jetty.properties.visibility;

import org.mortbay.log.Log;

import sagex.api.Global;
import sagex.jetty.properties.persistence.UPnPConfiguration;
import sagex.jetty.starter.JettyPlugin;
import sagex.plugin.IPropertyVisibility;

public class LocatorURLPropertyVisibility implements IPropertyVisibility
{
    private JettyPlugin plugin;
    private boolean ssl;

    public LocatorURLPropertyVisibility(JettyPlugin plugin, boolean ssl)
    {
        this.plugin = plugin;
        this.ssl = ssl;
    }

    public boolean isVisible()
    {
        Log.debug("Entering LocatorURLPropertyVisibility.isVisible()");
        boolean visible = true;

        if (ssl)
        {
            if (!"true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE)))
            {
                // don't show the https url if ssl is disabled
                visible = false;
            }
        }

//        if (Global.IsRemoteUI(UIContext.getCurrentContext()))
//        {
//            // extenders and placeshifters don't copy to the local clipboard
//            visible = false;
//        }
        
        // the client cannot set up UPnP so there's no way to give the user an
        // external port number
        if (Global.IsClient())
        {
            visible = false;
        }

        if (!UPnPConfiguration.isUPnPEnabled() || !UPnPConfiguration.isJettyUPnPEnabled(plugin))
        {
            // the external ports aren't known if the internet connection is not set up for UPnP
            visible = false;
        }

        return visible;
    }
}
