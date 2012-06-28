package sagex.jetty.properties.persistence;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import net.sbbi.upnp.devices.UPNPRootDevice;
import net.sbbi.upnp.impls.InternetGatewayDevice;

import org.mortbay.log.Log;

import sagex.api.Configuration;
import sagex.api.Global;
import sagex.api.Utility;
import sagex.jetty.starter.JettyPlugin;

/*
To get the mappings to the router immediately; you need to do what's done in
the STV for configuring the port. You shouldn't need all of the steps; but
you will need to set that 'active' property and then do the ones that relate
to doing the actual port mapping. Hopefully w/ some copy and paste it
shouldn't be that bad.  :) 

It's safe to assume that UPnP setup will be done in our UI; and you can
indicate that in the plugin config help text by changing it if UPnP is not
configured yet (this is the right property:
placeshifter_port_forward_method=xUPnP). Then I'd say just have a true/false
option in your config settings and then if they turn it on; do the property
setting and then force the port mapping to occur right then. 
*/

/*
The UPnP error you're getting below is router-specific. Some routers don't
allow assigning different internal/external ports for security reasons. 

The "placeshifter_port_forward_upnp_active" setting is for when the UI is
doing its placeshifter UPnP configuration. It sets that so the core knows
not to mess with it during that time period.

The "placeshifter_port_forward_method=xUPnP" indicates UPnP is in use; the
'x' is just for translation concerns in the STV.

"placeshifter_port_forward_upnp_udn" is for caching the router the user
selected in case there's more than one for some reason. This is the result
of what they selected in the UI. If it disappears; SageTV will automatically
select the new one if its available.
*/

/*
//The format is
upnp_port_forward_additional_mappings/svcName/portType/externalPort=internal
Port
// for example:
upnp_port_forward_additional_mappings/WebServer/TCP/8080=8080 
*/

/* what if user disables ps port forwarding but Jetty's is configured in Sage.properties */
// TODO what if user changes upnp device from detailed setup
/*
 * TODO Check Sage.properties.  If something isn't right then update it and update the router.
 */
// TODO performance
// TODO error reporting
public class UPnPConfiguration
{
    private static final String SAGE_PROP_NAME_PORT_FORWARD_ACTIVE        = "placeshifter_port_forward_upnp_active";
    private static final String SAGE_PROP_NAME_PORT_FORWARD_METHOD        = "placeshifter_port_forward_method";
    private static final String SAGE_PROP_NAME_PORT_FORWARD_ADDL_MAPPINGS = "upnp_port_forward_additional_mappings";
    private static final String SAGE_PROP_NAME_PORT_FORWARD_UDN           = "placeshifter_port_forward_upnp_udn";
    private static final String JETTY_HTTP_PORT_MAPPING_NAME  = "SageTVJettyHTTP";
    private static final String JETTY_HTTPS_PORT_MAPPING_NAME = "SageTVJettyHTTPS";

    private static Map<String, InternetGatewayDevice> devicesMap = new HashMap<String, InternetGatewayDevice>();
    
    static
    {
        // try to preload UPnP device
        Runnable r = new Runnable()
        {
            public void run()
            {
                getUPnPDevice();
            }
        };
        Thread t = new Thread(r);
        t.start();
    }

    /**
     * Has the user enabled Placeshifter port forwarding on the server?
     */
    public static boolean isUPnPEnabled()
    {
        if (Global.IsClient())
        {
            return false;
        }

        String portForwardMethod = Configuration.GetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_METHOD, "xManual");
        return ("xUPnP".equals(portForwardMethod));
    }
    
    public static boolean isJettyUPnPEnabled(JettyPlugin plugin)
    {
        if (Global.IsClient())
        {
            return false;
        }

        return ((JettyPlugin.UPNP_CHOICE_AUTO_CONFIGURATION.equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_UPNP))) ||
                (JettyPlugin.UPNP_CHOICE_ADVANCED_CONFIGURATION.equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_UPNP))));
    }

    public static boolean hasDefaultUsernameAndPassword(JettyPlugin plugin)
    {
        if (("sage".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_USER))) &&
            ("frey".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_PASSWORD))))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
//    public static void configureUPnP(JettyPlugin plugin)
//    {
//        Log.debug("UPNP: Entering UPnPConfiguration.configureUPnP(" + plugin.toString() + ")");
//        if (isUPnPEnabled() && !hasDefaultUsernameAndPassword(plugin))
//        {
//            Log.debug("UPNP: UPnPConfiguration.configureUPnP1");
//            // make sure everything is enabled
//            if (isJettyUPnPEnabled(plugin))
//            {
//                Log.debug("UPNP: UPnPConfiguration.configureUPnP2");
//                configureJettyUPnP(plugin);
//            }
//            else
//            {
//                // make sure everything is disabled
//                Log.debug("UPNP: UPnPConfiguration.configureUPnP3");
//                removeJettyUPnP(plugin);
//            }
//        }
//        else
//        {
//            // make sure everything is disabled
//            Log.debug("UPNP: UPnPConfiguration.configureUPnP4");
//            removeJettyUPnP(plugin);
//        }
//    }

    public static void configureUPnP(JettyPlugin plugin)
    {
        Log.debug("UPNP: Entering UPnPConfiguration.configureUPnP(" + plugin.toString() + ")");

        if (Global.IsClient())
        {
            Log.debug("UPNP: UPnP is not supported on a client");
            return;
        }

        if (!isUPnPEnabled() || !isJettyUPnPEnabled(plugin) || hasDefaultUsernameAndPassword(plugin))
        {
            Log.debug("UPNP: UPnP is not enabled and will not be configured");
            return;
        }

        // get internal and external HTTP ports
        String internalHttpPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_HTTP_PORT, "8080");
        String externalHttpPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTP_PORT, "8080");
        
        // get internal and external HTTPS ports
        String internalHttpsPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_HTTPS_PORT, "8443");
        String externalHttpsPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT, "8443");

        // if auto upnp configuration then the external and internal ports are the same
        if (JettyPlugin.UPNP_CHOICE_AUTO_CONFIGURATION.equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_UPNP)))
        {
            externalHttpPort = internalHttpPort;
            externalHttpsPort = internalHttpsPort;
        }

        validatePorts(plugin, internalHttpPort, externalHttpPort, internalHttpsPort, externalHttpsPort);
        
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: internalHttpPort=" + internalHttpPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: externalHttpPort=" + externalHttpPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: internalHttpsPort=" + internalHttpsPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: externalHttpsPort=" + externalHttpsPort);

        // let the core know that UPnP settings are being modified so it won't mess with it
        Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ACTIVE, "true");

        // set up Jetty HTTP UPnP mapping property
        Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ADDL_MAPPINGS + "/" + JETTY_HTTP_PORT_MAPPING_NAME + "/TCP/" +
                                        externalHttpPort, internalHttpPort);
        
        // set up Jetty HTTPS UPnP mapping property
        Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ADDL_MAPPINGS + "/" + JETTY_HTTPS_PORT_MAPPING_NAME + "/TCP/" +
                                        externalHttpsPort, internalHttpsPort);
        
        String localIP = Utility.GetLocalIPAddress();
        InternetGatewayDevice device = getUPnPDevice();

        try
        {
            if (device != null)
            {
                // configure router for HTTP mapping
                device.addPortMapping(JETTY_HTTP_PORT_MAPPING_NAME, null, Integer.parseInt(internalHttpPort), Integer.parseInt(externalHttpPort), localIP, 0, "TCP");

                // configure router for HTTPS mapping
                if ("true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE)))
                {
                    device.addPortMapping(JETTY_HTTPS_PORT_MAPPING_NAME, null, Integer.parseInt(internalHttpsPort), Integer.parseInt(externalHttpsPort), localIP, 0, "TCP");
                }
            }
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
        finally
        {
            Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ACTIVE, "false");
        }
    }

    /**
     * It's assumed that properties have not been changed yet so the old values are used
     * for removal.
     * It's also assumed that the port numbers Sage.properties match what is on the router.
     * 
     * Get the external ports from Sage.properties, remove the mappings from the
     * router, and delete the properties from Sage.properties.
     */
    public static void removeUPnP(JettyPlugin plugin)
    {
        Log.debug("UPNP: Entering UPnPConfiguration.removeUPnP(" + plugin + "))");

        if (Global.IsClient())
        {
            Log.debug("UPNP: UPnP is not supported on a client");
            return;
        }

        // let the core know that UPnP settings are being modified so it won't mess with it
        Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ACTIVE, "true");

        String internalHttpPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_HTTP_PORT, "8080");
        String externalHttpPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTP_PORT, "8080");
        
        // get internal and external HTTPS ports
        String internalHttpsPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_HTTPS_PORT, "8443");
        String externalHttpsPort = Configuration.GetProperty(JettyPlugin.PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT, "8443");

        // if auto upnp configuration then the external and internal ports are the same
        if (JettyPlugin.UPNP_CHOICE_AUTO_CONFIGURATION.equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_UPNP)))
        {
            externalHttpPort = internalHttpPort;
            externalHttpsPort = internalHttpsPort;
        }

        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: internalHttpPort=" + internalHttpPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: externalHttpPort=" + externalHttpPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: internalHttpsPort=" + internalHttpsPort);
        Log.debug("UPNP: UPnPConfiguration.configureJettyUPnP: externalHttpsPort=" + externalHttpsPort);

        // get current property values
        Configuration.RemoveServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ADDL_MAPPINGS + "/" + JETTY_HTTP_PORT_MAPPING_NAME + "/TCP/" + externalHttpPort);
        if ("true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE)))
        {
            Configuration.RemoveServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ADDL_MAPPINGS + "/" + JETTY_HTTPS_PORT_MAPPING_NAME + "/TCP/" + externalHttpsPort);
        }

        try
        {
            InternetGatewayDevice device = getUPnPDevice();

            if (device != null)
            {
                device.deletePortMapping(null, Integer.parseInt(externalHttpPort), "TCP");
                if ("true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE)))
                {
                    device.deletePortMapping(null, Integer.parseInt(externalHttpsPort), "TCP");
                }
            }
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
        finally
        {
            Configuration.SetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_ACTIVE, "false");
        }
    }

    private synchronized static InternetGatewayDevice getUPnPDevice()
    {
        Log.debug("UPNP: Entering UPnPConfiguration.getUPnPDevice())");

        String udn = Configuration.GetServerProperty(SAGE_PROP_NAME_PORT_FORWARD_UDN, null);
        Log.debug("UPNP: Current UPnP device UDN: " + udn);

        if (udn == null)
        {
            throw new IllegalStateException("No UPnP device selected.");
        }
        
        InternetGatewayDevice selectedDevice = devicesMap.get(udn);
        
        if (selectedDevice != null)
        {
            return selectedDevice;
        }

        InternetGatewayDevice[] devices = null;
        
        try
        {
            devices = InternetGatewayDevice.getDevices(5000);
            Log.debug("UPNP: Network devices: " + devices);
        }
        catch (IOException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
            return null;
        }
        
        if (devices != null)
        {
            Log.debug("UPNP: Searching for UPnP device: " + udn);
            for (InternetGatewayDevice device : devices)
            {
                UPNPRootDevice rootDevice = device.getIGDRootDevice();
                String currentUdn = rootDevice.getUDN();
                Log.debug("UPNP: Found a UPnP device with UDN: " + udn);

                if (currentUdn.equals(udn))
                {
                    Log.debug("UPNP: Successfully found configured UDN device: " + udn);
                    // cache the device because the getDevices API takes 5 seconds
                    devicesMap.put(udn, device);
                    return device;
                }
            }
        }
        
        return null;
    }

    private static void validatePorts(JettyPlugin plugin, String internalHttpPort, String externalHttpPort, String internalHttpsPort, String externalHttpsPort)
    {
        if (internalHttpPort == null)
        {
            throw new IllegalArgumentException("HTTP port is required.");
        }

        if (externalHttpPort == null)
        {
            throw new IllegalArgumentException("External HTTP port is required.");
        }

        if ("true".equals(plugin.getConfigValue(JettyPlugin.PROP_NAME_SSL_ENABLE)))
        {
            if (internalHttpsPort == null)
            {
                throw new IllegalArgumentException("HTTPS port is required.");
            }

            if (externalHttpsPort == null)
            {
                throw new IllegalArgumentException("External HTTPS port is required.");
            }
        }

        Integer internalHttpPortInteger = null;
        try
        {
            internalHttpPortInteger = Integer.valueOf(internalHttpPort);
        }
        catch (NumberFormatException e)
        {
            throw new IllegalArgumentException("HTTP port is not numeric.");
        }
      
        Integer externalHttpPortInteger = null;
        try
        {
            externalHttpPortInteger = Integer.valueOf(externalHttpPort);
        }
        catch (NumberFormatException e)
        {
            throw new IllegalArgumentException("External HTTP port is not numeric.");
        }

        Integer internalHttpsPortInteger = null;
        try
        {
            if (internalHttpsPort != null)
            {
                internalHttpsPortInteger = Integer.valueOf(internalHttpsPort);
            }
        }
        catch (NumberFormatException e)
        {
            throw new IllegalArgumentException("HTTPS port is not numeric.");
        }

        Integer externalHttpsPortInteger = null;
        try
        {
            if (externalHttpsPort != null)
            {
                externalHttpsPortInteger = Integer.valueOf(externalHttpsPort);
            }
        }
        catch (NumberFormatException e)
        {
            throw new IllegalArgumentException("External HTTPS port is not numeric.");
        }

        if (internalHttpPortInteger == internalHttpsPortInteger)
        {
            throw new IllegalArgumentException("HTTP and HTTPS ports must be different.");
        }

        if (externalHttpPortInteger == externalHttpsPortInteger)
        {
            throw new IllegalArgumentException("External HTTP and HTTPS ports must be different.");
        }

        if (internalHttpPortInteger < 1 || internalHttpPortInteger > 65535)
        {
            throw new IllegalArgumentException("HTTP port must be between 1 and 65535.");
        }
      
        if (externalHttpPortInteger < 1 || externalHttpPortInteger > 65535)
        {
            throw new IllegalArgumentException("External HTTP port must be between 1 and 65535.");
        }

        if (internalHttpsPort != null && (internalHttpsPortInteger < 1 || internalHttpsPortInteger > 65535))
        {
            throw new IllegalArgumentException("HTTPS port must be between 1 and 65535.");
        }

        if (externalHttpsPort != null && (externalHttpsPortInteger < 1 || externalHttpsPortInteger > 65535))
        {
            throw new IllegalArgumentException("External HTTPS port must be between 1 and 65535.");
        }
    }
}
