package sagex.jetty.properties.visibility;

import sagex.api.Global;
import sagex.jetty.properties.persistence.UPnPConfiguration;
import sagex.jetty.starter.JettyPlugin;
import sagex.plugin.IPropertyVisibility;
import sagex.plugin.PluginProperty;

public class UPnPPropertyVisibility implements IPropertyVisibility
{
    private JettyPlugin plugin;
    private PluginProperty upnpProperty;
    private boolean ifAvailable;

    public UPnPPropertyVisibility(JettyPlugin plugin, PluginProperty upnpProperty, boolean ifAvailable)
    {
        this.plugin = plugin;
        this.upnpProperty = upnpProperty;
        this.ifAvailable = ifAvailable;
    }

    public boolean isVisible()
    {
//        boolean visible = false;

        // see the STV for this criteria
//        if ((Global.IsServerUI() ||
//                // TODO allow client UI?
//            (!Global.IsDesktopUI() && Global.IsRemoteUI()) ||
//            (Global.IsLinuxOS() && "true".equals(Configuration.GetServerProperty("linux/enable_nas", "false")))) &&
//            Configuration.IsSageTVServerEnabled())
//        {
//            if ("true".equals(Configuration.GetServerProperty("enable_media_extender_server", "true")))
//            {
//                visible = true;
//            }
//        }
        
        // Clients cannot use UPnP because the Sage Client core does not recognize the
        // upnp_port_forward_additional_mappings property.  The Client will not configure
        // UPnP mappings in the router when it starts and when it exits.  If these entries
        // are put in the server's properties file then the router's mappings point to the
        // server and that will not work.
        if (Global.IsClient())
        {
            return false;
        }

        boolean visible = true;

        if (visible)
        {
            if (ifAvailable)
            {
                // if this is the 'available' upnp property
                visible = UPnPConfiguration.isUPnPEnabled() && !UPnPConfiguration.hasDefaultUsernameAndPassword(plugin);

                // show advanced upnp properties for custom external port selection
                if ((JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTP_PORT.equals(upnpProperty.getSetting())) ||
                    (JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT.equals(upnpProperty.getSetting())))
                {
                    visible = visible && (JettyPlugin.UPNP_CHOICE_ADVANCED_CONFIGURATION.equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_UPNP)));
                }
                
                // only show external https port if ssl is enabled
                if (JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT.equals(upnpProperty.getSetting()))
                {
                    visible = visible && "true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE));
                }
            }
            else
            {
                // if this is the 'unavailable' upnp property
                visible = !UPnPConfiguration.isUPnPEnabled() || UPnPConfiguration.hasDefaultUsernameAndPassword(plugin);
            }
        }

        return visible;
    }
}
