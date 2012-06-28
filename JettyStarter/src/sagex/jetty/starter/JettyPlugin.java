package sagex.jetty.starter;

import java.awt.GraphicsEnvironment;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mortbay.log.Log;

import sage.SageTVPlugin;
import sage.SageTVPluginRegistry;
import sagex.UIContext;
import sagex.api.Configuration;
import sagex.api.Global;
import sagex.jetty.log.JettyStarterLogger;
import sagex.jetty.properties.JettyProperties;
import sagex.jetty.properties.SagePropertiesImpl;
import sagex.jetty.properties.persistence.SslEnabledPersistence;
import sagex.jetty.properties.persistence.UPnPConfiguration;
import sagex.jetty.properties.persistence.UserRealmPersistence;
import sagex.jetty.properties.visibility.LocatorURLPropertyVisibility;
import sagex.jetty.properties.visibility.UPnPPropertyVisibility;
import sagex.plugin.AbstractPlugin;
import sagex.plugin.ButtonClickHandler;
import sagex.plugin.PluginProperty;

public class JettyPlugin extends AbstractPlugin
{
    public static final String PROP_NAME_RESTART    = "jetty/restart";
    public static final String PROP_NAME_USER       = "jetty/user";
    public static final String PROP_NAME_PASSWORD   = "jetty/password";
    public static final String PROP_NAME_HTTP_PORT  = "jetty/" + JettyProperties.JETTY_PORT_PROPERTY;
    public static final String PROP_NAME_SSL_ENABLE = "jetty/ssl.enable";
    public static final String PROP_NAME_HTTPS_PORT = "jetty/" + JettyProperties.JETTY_SSL_PORT_PROPERTY;
    public static final String PROP_NAME_LOG_LEVEL  = "jetty/" + JettyProperties.JETTY_LOG_LEVEL;
    public static final String PROP_NAME_UPNP       = "jetty/upnp";
    public static final String PROP_NAME_UPNP_EXTERNAL_HTTP_PORT  = "jetty/upnp.external.http";
    public static final String PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT = "jetty/upnp.external.https";
    public static final String PROP_NAME_UPNP_UNAVAILABLE = "jetty/upnp.unavailable";
    public static final String PROP_NAME_LOCATOR_HTTP_URL  = "jetty/locator.http.url";
    public static final String PROP_NAME_LOCATOR_HTTPS_URL = "jetty/locator.https.url";

    private static final List<String> PROP_RESTART_REQUIRED = new ArrayList<String>();

    // TODO resources file
    public static final String PROP_HELP_UPNP_DEFAULT  = "Choose whether to automatically or manually configure your router or firewall to allow access to SageTV's web server from outside your home network.";
    public static final String PROP_HELP_UPNP_DISABLED_DEFAULT_LOGIN = "UPnP cannot be configured for Jetty when using the default user name or password.";
    public static final String PROP_HELP_UPNP_DISABLED_PLACESHIFTER_UPNP_DISABLED = "Placeshifter UPnP must first be configured in Detailed Setup.";
    
    public static final String UPNP_CHOICE_UNAVAILABLE              = "Unavailable";
    public static final String UPNP_CHOICE_MANUAL_CONFIGURATION     = "Manual Configuration";
    public static final String UPNP_CHOICE_AUTO_CONFIGURATION       = "Automatic UPnP Configuration";
    public static final String UPNP_CHOICE_ADVANCED_CONFIGURATION   = "Advanced UPnP Configuration with Port Selection";

    public static final String LOGLEVEL_CHOICE_INFO    = "INFO";
    public static final String LOGLEVEL_CHOICE_DEBUG   = "DEBUG";
    public static final String LOGLEVEL_CHOICE_VERBOSE = "VERBOSE";

    //    private boolean restartNeeded = false;// *property name
    private Map<String, String> modifiedProperties = new HashMap<String, String>();

    static
    {
        // Handle all logging for Jetty and Jetty Starter
        JettyStarterLogger.init();

        Log.info("Jetty Starter plugin version " + JettyPlugin.class.getPackage().getImplementationVersion());
        
        PROP_RESTART_REQUIRED.add(PROP_NAME_USER);
        PROP_RESTART_REQUIRED.add(PROP_NAME_PASSWORD);
        PROP_RESTART_REQUIRED.add(PROP_NAME_HTTP_PORT);
        PROP_RESTART_REQUIRED.add(PROP_NAME_SSL_ENABLE);
        PROP_RESTART_REQUIRED.add(PROP_NAME_HTTPS_PORT);
        PROP_RESTART_REQUIRED.add(PROP_NAME_LOG_LEVEL);
    }
    
    public JettyPlugin(SageTVPluginRegistry registry)
    {
        super(registry);
        Log.debug("Entering JettyPlugin.<init>(" + registry + ")");

        addProperty(SageTVPlugin.CONFIG_BUTTON,
                    PROP_NAME_RESTART,
                    "Restart Web Server",
                    "Restart Web Server",
                    "Click to restart the SageTV web server after changing its settings. Properties marked with '*' have been modified and require the web server to be restarted.");

        addProperty(SageTVPlugin.CONFIG_TEXT,
                    PROP_NAME_USER,
                    "sage",
                    "User",
                    "The user name for logging in to web applications.")
                    .setPersistence(new UserRealmPersistence());
    
        addProperty(SageTVPlugin.CONFIG_PASSWORD,
                    PROP_NAME_PASSWORD,
                    "frey",
                    "Password",
                    "The user's password.  The default password is 'frey'.")
                    .setPersistence(new UserRealmPersistence());

        addProperty(SageTVPlugin.CONFIG_BOOL,
                    PROP_NAME_SSL_ENABLE,
                    "false",
                    "Enable SSL",
                    "Enable an encrypted HTTPS connection.  Keystore must be set up manually.  See http://tools.assembla.com/sageplugins/wiki/JettyPluginSSL.")
//                    "Enable use of an encrypted HTTPS connection.  See http://tools.assembla.com/sageplugins/wiki/JettySSL.")
                    .setPersistence(new SslEnabledPersistence());

        addProperty(SageTVPlugin.CONFIG_INTEGER,
                    PROP_NAME_HTTP_PORT,
                    "8080",
                    "HTTP Port",
                    "The web server's HTTP port.");// TODO .setValidationProvider(new JettyPortValidator());

        addProperty(SageTVPlugin.CONFIG_INTEGER,
                    PROP_NAME_HTTPS_PORT,
                    "8443",
                    "HTTPS Port",
                    "The web server's HTTPS port.")
                    .setVisibleOnSetting(this, PROP_NAME_SSL_ENABLE);// TODO .setValidationProvider(new JettyPortValidator());

        addProperty(SageTVPlugin.CONFIG_BUTTON,
                    PROP_NAME_LOCATOR_HTTP_URL,
                    "",
                    "Web Server Address",
                    "")//"The URL to access SageTV's web server outside your home network.\nhttp://locator.sagetv.com/locator.php?p=8080&id=d814-66bc-a6c1-11de&r=/sage")
                    .setVisibility(new LocatorURLPropertyVisibility(this, false));

        addProperty(SageTVPlugin.CONFIG_BUTTON,
                    PROP_NAME_LOCATOR_HTTPS_URL,
                    "",
                    "Encrypted Web Server Address",
                    "")//"The encrypted URL to access SageTV's web server outside your home network.\nhttp://locator.sagetv.com/locator.php?p=8080&id=d814-66bc-a6c1-11de&r=/sage&ssl=")
                    .setVisibility(new LocatorURLPropertyVisibility(this, true));//                .setVisibleOnSetting(this, PROP_NAME_SSL_ENABLE);// TODO .setValidationProvider(new JettyPortValidator());
                
//        addProperty(SageTVPlugin.CONFIG_DIRECTORY,
//                    "jetty/createkeystore",///*"jetty/https/port",*/ JettyStarterProperties.JETTY_SSL_PORT_PROPERTY,
//                    "Create...",
//                    "Create Keystore",
//                    "Create a keystore and SSL certificate.")
//                    .setVisibleOnSetting(this, PROP_NAME_SSL_ENABLE);// TODO .setValidationProvider(new JettyPortValidator());
//
//        addProperty(SageTVPlugin.CONFIG_FILE,
//                    "jetty/selectkeystore",///*"jetty/https/port",*/ JettyStarterProperties.JETTY_SSL_PORT_PROPERTY,
//                    "Select...",
//                    "Select Keystore",
//                    "Select an existing keystore.")
//                    .setVisibleOnSetting(this, PROP_NAME_SSL_ENABLE);// TODO .setValidationProvider(new JettyPortValidator());

        if (!Global.IsClient())
        {
            PluginProperty upnpProperty =
                addProperty(SageTVPlugin.CONFIG_CHOICE,
                        PROP_NAME_UPNP,
                        "Manual Configuration",
                        "Internet Connection",
                        "Automatically or manually configure your router or firewall for accessing the web server outside your home network.",
                        new String[] {JettyPlugin.UPNP_CHOICE_AUTO_CONFIGURATION,
                                      JettyPlugin.UPNP_CHOICE_ADVANCED_CONFIGURATION,
                                      JettyPlugin.UPNP_CHOICE_MANUAL_CONFIGURATION});
            upnpProperty.setVisibility(new UPnPPropertyVisibility(this, upnpProperty, true));
    
            PluginProperty externalHttpPortProperty =
                addProperty(SageTVPlugin.CONFIG_INTEGER,
                        PROP_NAME_UPNP_EXTERNAL_HTTP_PORT,
                        "8080",
                        "External HTTP Port",
                        "The router's external HTTP port.");
            externalHttpPortProperty.setVisibility(new UPnPPropertyVisibility(this, externalHttpPortProperty, true));
    
            PluginProperty externalHttpsPortProperty =
                addProperty(SageTVPlugin.CONFIG_INTEGER,
                        PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT,
                        "8443",
                        "External HTTPS Port",
                        "The router's external HTTPS port.");
            externalHttpsPortProperty.setVisibility(new UPnPPropertyVisibility(this, externalHttpsPortProperty, true));
    
            PluginProperty upnpUnavailableProperty =
                addProperty(SageTVPlugin.CONFIG_BUTTON,
                        PROP_NAME_UPNP_UNAVAILABLE,
                        UPNP_CHOICE_UNAVAILABLE,
                        "Internet Connection",
                        "UPnP router configuration is currently unavailable because....");
            upnpUnavailableProperty.setVisibility(new UPnPPropertyVisibility(this, upnpUnavailableProperty, false));
        }
        
        addProperty(SageTVPlugin.CONFIG_CHOICE,
                    PROP_NAME_LOG_LEVEL,
                    LOGLEVEL_CHOICE_INFO,
                    "Log Level",
                    "Choose the level of detail for Jetty messages written to SageTV's log file.",
                    new String[] {LOGLEVEL_CHOICE_INFO, LOGLEVEL_CHOICE_DEBUG, LOGLEVEL_CHOICE_VERBOSE});
    }

    /**
     * Called by SageTV 7 or later to start the Jetty application server
     */
    public synchronized void start()
    {
        super.start();
        Log.debug("Entering JettyPlugin.start()");

        try
        {
            cleanRunnableClasses();
            migrateProperties();
            createDefaultProperties();
            JettyInstance.getInstance().setPropertyProvider(SagePropertiesImpl.class);
            JettyInstance.getInstance().start();
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }

    /**
     * Called by SageTV 7 or later to stop the Jetty application server
     */
    public synchronized void stop()
    {
        super.stop();
        Log.debug("Entering JettyPlugin.stop()");
        
        try
        {
            JettyInstance.getInstance().stop();
            modifiedProperties.clear();
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }

    public String getConfigHelpText(String setting)
    {
        Log.debug("Entering JettyPlugin.getConfigHelpText(" + setting + "))");

        String help = null;

        if (PROP_NAME_UPNP_UNAVAILABLE.equals(setting))
        {
            help = JettyPlugin.PROP_HELP_UPNP_DEFAULT;

            if (!UPnPConfiguration.isUPnPEnabled())
            {
                help = JettyPlugin.PROP_HELP_UPNP_DISABLED_PLACESHIFTER_UPNP_DISABLED;
            }

            if (UPnPConfiguration.hasDefaultUsernameAndPassword(this))
            {
                help = JettyPlugin.PROP_HELP_UPNP_DISABLED_DEFAULT_LOGIN;
            }
        }
        else if (PROP_NAME_LOCATOR_HTTP_URL.equals(setting))
        {
            help = getLocatorHttpUrl();
        }
        else if (PROP_NAME_LOCATOR_HTTPS_URL.equals(setting))
        {
            help = getLocatorHttpsUrl();
        }

        if (help == null)
        {
            help = super.getConfigHelpText(setting);
        }

        return help;
    }

    @Override
    public String getConfigLabel(String setting)
    {
        String label = super.getConfigLabel(setting);

        if (modifiedProperties.containsKey(setting))
        {
            label += " *";
        }

        return label;
    }

    @Override
    public String getConfigValue(String setting)
    {
        Log.debug("Entering JettyPlugin.getConfigValue(" + setting + "))");
        Log.debug("Global.GetUIContextName() " + Global.GetUIContextName());
        Log.debug("UIContext.getCurrentContext() " + UIContext.getCurrentContext());
        Log.debug("thread name " + Thread.currentThread().getName());
        Log.debug("Global.IsRemoteUI(UIContext.getCurrentContext()) " + Global.IsRemoteUI(UIContext.getCurrentContext()));
        Log.debug("Global.IsServerUI(UIContext.getCurrentContext()) " + Global.IsServerUI(UIContext.getCurrentContext()));
        Log.debug("Global.IsDesktopUI(UIContext.getCurrentContext()) " + Global.IsDesktopUI(UIContext.getCurrentContext()));
        Log.debug("Global.IsClientUI(UIContext.getCurrentContext()) " + Global.IsClient(UIContext.getCurrentContext()));
        
        String configValue = null;

        if ((PROP_NAME_LOCATOR_HTTP_URL.equals(setting)) ||
            (PROP_NAME_LOCATOR_HTTPS_URL.equals(setting)))
        {
            // extender or placeshifter
            if (Global.IsRemoteUI(new UIContext(Global.GetUIContextName())))
            {
                // not running on the server
                if (!Global.IsServerUI(new UIContext(Global.GetUIContextName())))
                {
                    // remote placeshifter
                    if (Global.IsDesktopUI(new UIContext(Global.GetUIContextName())))
                    {
                        configValue = "Clipboard Unavailable on Remote Placeshifters";
                    }
                    // extender
                    else
                    {
                        configValue = "Clipboard Unavailable on Extenders";
                    }
                }
                else
                {
                    if (GraphicsEnvironment.isHeadless())
                    {
                        // local placeshifter on the server in headless mode
                        configValue = "Clipboard Unavailable in Headless Mode";
                    }
                    else
                    {
                        // local placeshifter on the server
                        configValue = "Copy Link to Clipboard";
                    }
                }
            }
            // SageTV Client
            else
            {
                // ui not running on the server
                if (!Global.IsServerUI(new UIContext(Global.GetUIContextName())))
                {
                    // plugin is running on the client
                    if (Global.IsClient())
                    {
                        configValue = "Copy Link to Clipboard";
                    }
                    // plugin is running on the server
                    else
                    {
                        configValue = "Clipboard Unavailable for Server Plugins";
                    }
                }
                else
                {
                    if (GraphicsEnvironment.isHeadless())
                    {
                        // local client on the server in headless mode
                        configValue = "Clipboard Unavailable in Headless Mode";
                    }
                    else
                    {
                        // local client on the server
                        configValue = "Copy Link to Clipboard";
                    }
                }
            }
        }

        if (configValue == null)
        {
            configValue = super.getConfigValue(setting);
        }

        return configValue;
    }

    public void setConfigValue(String setting, String value)
    {
        Log.debug("Entering JettyPlugin.setConfigValue(" + setting + ", " + value + "))");
        String originalValue = getConfigValue(setting);
        
        // remove the current UPnP settings and router mappings before changing the property values
        if (!Global.IsClient())
        {
            try
            {
                UPnPConfiguration.removeUPnP(this);
            }
            catch (Throwable t)
            {
                Log.info(t.getMessage());
                Log.ignore(t);
            }
        }

        // call AbstractPlugin
        super.setConfigValue(setting, value);
        
        if (!Global.IsClient())
        {
            UPnPConfiguration.configureUPnP(this);
        }
        
        if (PROP_RESTART_REQUIRED.contains(setting))
        {
            String savedValue = modifiedProperties.get(setting);
            
            // if both are null or if they are equal then undo the modified indicator
            if (((savedValue == null) && (value == null)) ||
                ((savedValue != null) && savedValue.equals(value)))
            {
                modifiedProperties.remove(setting);
            }
            else
            {
                if (!modifiedProperties.containsKey(setting))
                {
                    modifiedProperties.put(setting, originalValue);
                }
            }
        }
    }

    private String getLocatorHttpUrl()
    {
        String locatorId = Configuration.GetServerProperty("locator/id", null);
        String port = getConfigValue(PROP_NAME_HTTP_PORT);
        if (JettyPlugin.UPNP_CHOICE_ADVANCED_CONFIGURATION.equals(getConfigValue(JettyPlugin.PROP_NAME_UPNP)))
        {
            port = getConfigValue(PROP_NAME_UPNP_EXTERNAL_HTTP_PORT);
        }
        String urlFormat = "http://locator.sagetv.com/locator.php?id=%s&p=%s&r=/apps";
        String url = String.format(urlFormat, locatorId, port);
        return url;
    }

    private String getLocatorHttpsUrl()
    {
        String locatorId = Configuration.GetServerProperty("locator/id", null);
        String port = getConfigValue(PROP_NAME_HTTPS_PORT);
        if (JettyPlugin.UPNP_CHOICE_ADVANCED_CONFIGURATION.equals(getConfigValue(JettyPlugin.PROP_NAME_UPNP)))
        {
            port = getConfigValue(PROP_NAME_UPNP_EXTERNAL_HTTPS_PORT);
        }
        String urlFormat = "https://locator.sagetv.com/locator.php?id=%s&p=%s&r=/apps&ssl=";
        String url = String.format(urlFormat, locatorId, port);
        return url;
    }

    /**
     * Strip sagex.jetty.starter.Main from load_at_startup_runnable_classes in Sage.properties.
     * The SageTV 7 plugin architecture will start Jetty via the start() method on the SageTVPlugin interface.
     */
    private void cleanRunnableClasses()
    {
        String prop = Configuration.GetProperty("load_at_startup_runnable_classes", "");
        String[] propArray = prop.split(";");
        
        if (propArray != null)
        {
            List<String> propList = Arrays.asList(propArray);
            // the List implementation returned by Arrays.asList does not support remove.  Create a list that does.
            propList = new ArrayList<String>(propList);
            StringBuilder sb = new StringBuilder();

            // remove all occurrences of Jetty's runnable
            while (propList.remove("sagex.jetty.starter.Main")); // Jetty plugin 1.4 - 1.6
            while (propList.remove("net.sf.sageplugins.jetty.starter.Main")); // Jetty plugin 1.3 and earlier

            if (propList.size() > 0)
            {
                sb.append(propList.get(0));
            }
            for (int i = 1; i < propList.size(); i++)
            {
                sb.append(";").append(propList.get(i));
            }
            prop = sb.toString();

            Configuration.SetProperty("load_at_startup_runnable_classes", prop);
        }
    }

    /**
     * Migrate properties from JettyStarter.properties to Sage.properties when upgrading to version 7.
     * Remove the JettyStarter.properties file.
     */
    private void migrateProperties()
    {
        String configFiles = Configuration.GetProperty("jetty/" + JettyProperties.JETTY_CONFIG_FILES_PROPERTY, null);
        if (configFiles != null)
        {
            // properties have already been copied from JettyStarter.properties to Sage.properties
            return;
        }
    
        Log.debug("Moving Jetty plugin properties from JettyStarter.properties to Sage.properties");
        File propertiesFile = JettyStarterProperties.getPropertiesFile();
        if (propertiesFile.exists())
        {
            JettyStarterProperties properties = new JettyStarterProperties();
            migrateProperty(properties, JettyProperties.JETTY_HOME_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_CONFIG_FILES_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_LOGS_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_HOST_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_PORT_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_PORT_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_KEYSTORE_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_PASSWORD_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_KEYPASSWORD_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_TRUSTSTORE_PROPERTY);
            migrateProperty(properties, JettyProperties.JETTY_SSL_TRUSTPASSWORD_PROPERTY);
            
            propertiesFile.delete();
        }
    }
    
    private void migrateProperty(JettyStarterProperties properties, String propertyName)
    {
        String propertyValue = properties.getProperty(propertyName);
        if (propertyValue != null)
        {
            Configuration.SetProperty("jetty/" + propertyName, propertyValue);
        }
    }

    private void createDefaultProperties()
    {
        // set up defaults if they don't exist (same defaults as the deprecated JettyStarter.properties file
        String jettyHome = Configuration.GetProperty("jetty/" + JettyProperties.JETTY_HOME_PROPERTY, null);
        if (jettyHome == null)
        {
            jettyHome = new File(System.getProperty("user.dir"), "jetty").getAbsolutePath();
            Configuration.SetProperty("jetty/" + JettyProperties.JETTY_HOME_PROPERTY, jettyHome);
        }

        String configFiles = Configuration.GetProperty("jetty/" + JettyProperties.JETTY_CONFIG_FILES_PROPERTY, null);
        if (configFiles == null)
        {
            configFiles = new File(jettyHome, "etc/jetty.xml").getAbsolutePath();
            Configuration.SetProperty("jetty/" + JettyProperties.JETTY_CONFIG_FILES_PROPERTY, "\"" + configFiles + "\"");
        }
        
        String logs = Configuration.GetProperty("jetty/" + JettyProperties.JETTY_LOGS_PROPERTY, null);
        if (logs == null)
        {
            logs = new File(jettyHome, "logs").getAbsolutePath();
            Configuration.SetProperty("jetty/" + JettyProperties.JETTY_LOGS_PROPERTY, logs);
        }
    }

    private boolean isClipboardAvailable()
    {
        boolean isClipboardAvailable = true;

        // extender or placeshifter
        if (Global.IsRemoteUI(new UIContext(Global.GetUIContextName())))
        {
            // not running on the server
            if (!Global.IsServerUI(new UIContext(Global.GetUIContextName())))
            {
                // placeshifter
                if (Global.IsDesktopUI(new UIContext(Global.GetUIContextName())))
                {
                    isClipboardAvailable = false;
                }
                // extender
                else
                {
                    isClipboardAvailable = false;
                }
            }
            else
            {
                if (GraphicsEnvironment.isHeadless())
                {
                    // running on the server in headless mode
                    isClipboardAvailable = false;
                }
                else
                {
                    isClipboardAvailable = true;
                }
            }
        }
        else
        {
            // not running on the server
            if (!Global.IsServerUI(new UIContext(Global.GetUIContextName())))
            {
                if (Global.IsClient())
                {
                    isClipboardAvailable = true;
                }
                else
                {
                    isClipboardAvailable = false;
                }
            }
            else
            {
                if (GraphicsEnvironment.isHeadless())
                {
                    // local client on the server in headless mode
                    isClipboardAvailable = false;
                }
                else
                {
                    // local client on the server
                    isClipboardAvailable = true;
                }
            }
        }
        
        return isClipboardAvailable;
    }

    @ButtonClickHandler(value=PROP_NAME_RESTART)
    public synchronized void onRestartButtonClicked(String setting, String value)
    {
        Log.debug("Entering JettyPlugin.onRestartButtonClicked(" + setting + ", " + value + ")");
        stop();
        start();
    }

    @ButtonClickHandler(value=PROP_NAME_LOCATOR_HTTP_URL)
    public void onLocatorHttpUrlButtonClicked(String setting, String value)
    {
        Log.debug("Entering JettyPlugin.onLocatorHttpUrlButtonClicked(" + setting + ", " + value + ")");

        if (isClipboardAvailable())
        {
            String url = getLocatorHttpUrl();
            Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
            StringSelection urlSelection = new StringSelection(url);
            clipboard.setContents(urlSelection, urlSelection);
        }
    }

    @ButtonClickHandler(value=PROP_NAME_LOCATOR_HTTPS_URL)
    public void onLocatorHttpsUrlButtonClicked(String setting, String value)
    {
        Log.debug("Entering JettyPlugin.onLocatorHttpsUrlButtonClicked(" + setting + ", " + value + ")");

        if (isClipboardAvailable())
        {
            String url = getLocatorHttpsUrl();
            Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
            StringSelection urlSelection = new StringSelection(url);
            clipboard.setContents(urlSelection, urlSelection);
        }
    }
}
