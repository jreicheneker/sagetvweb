package sagex.jetty.properties.persistence;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ListIterator;

import org.mortbay.log.Log;

import sagex.api.Configuration;
import sagex.jetty.properties.JettyProperties;
import sagex.jetty.starter.JettyPlugin;
import sagex.plugin.IPropertyPersistence;

public class SslEnabledPersistence implements IPropertyPersistence
{
    /**
     * SSL is enabled if the config files property has the jetty-ssl.xml file in it.
     */
    public String get(String property, String defaultValue)
    {
        String result = "false";

        if (!property.equals(JettyPlugin.PROP_NAME_SSL_ENABLE))
        {
            return result;
        }

        String prop = Configuration.GetProperty("jetty/jetty.configfiles", defaultValue);
        if ((prop != null) && (prop.contains("jetty-ssl.xml")))
        {
            result = "true";
        }

        return result;
    }

    /**
     * Add jetty-ssl.xml to the config files property when it's enabled.  Remove it when it's disabled.
     */
    public void set(String property, String value)
    {
        Log.debug("Entering SslEnabledPersistence.set(" + property + ", " + value + ")");

        if (!property.equals(JettyPlugin.PROP_NAME_SSL_ENABLE))
        {
            return;
        }

        String configFiles = Configuration.GetProperty("jetty/jetty.configfiles", "");
        Log.debug("Current config files property: " + configFiles);
        String[] configFileArray = JettyProperties.parseConfigFilesSetting(configFiles);
        for (int i = 0; i < configFileArray.length; i++)
        {
            String configFile = configFileArray[i];
            Log.debug("Config file [" + i + "] = " + configFile);
        }
        // create a modifiable list
        List<String> configFileList = new ArrayList<String>(Arrays.asList(configFileArray));
        for (int i = 0; i < configFileList.size(); i++)
        {
            String configFile = configFileList.get(i);
            Log.debug("Config file (" + i + ") = " + configFile);
        }
        
        boolean isSslEnabled = get(property, "").equals("true");
        Log.debug("isSslEnabled " + isSslEnabled);

        if ((value == null) || (value.toLowerCase().equals("false")))
        {
            // disable SSL
            if (isSslEnabled)
            {
                Log.debug("Disabling SSL");
                ListIterator<String> iter = configFileList.listIterator();
                while (iter.hasNext())
                {
                    String configFile = iter.next();
                    Log.debug("Config file iterator element " + configFile);
                    if (configFile.contains("jetty-ssl.xml"))
                    {
                        try
                        {
                            Log.debug("Removing element");
                            iter.remove();
                            Log.debug("Element removed");
                        }
                        catch (Throwable t)
                        {
                            Log.info(t.getMessage());
                            Log.ignore(t);
                        }
                    }
                    else
                    {
                        Log.debug("Not removing element");
                    }
                }
            }
        }
        else if (value.toLowerCase().equals("true"))
        {
            // enable SSL
            if (!isSslEnabled)
            {
                Log.debug("Enabling SSL");
                File jettySslFile = new File("jetty/etc/jetty-ssl.xml");
                configFileList.add(jettySslFile.getAbsolutePath());
            }
            
        }
        
        StringBuilder sb = new StringBuilder();

        Log.debug("Building new config file list");
        for (int i = 0; i < configFileList.size(); i++)
        {
            if (i > 0)
            {
                sb.append(" ");
            }
            sb.append("\"" + configFileList.get(i) + "\"");
        }
        
        Log.debug("Setting Jetty config files property to: " + sb.toString());

        Configuration.SetProperty("jetty/jetty.configfiles", sb.toString());

        configFiles = Configuration.GetProperty("jetty/jetty.configfiles", "");
        Log.debug("New config files property: " + configFiles);
    }
}
