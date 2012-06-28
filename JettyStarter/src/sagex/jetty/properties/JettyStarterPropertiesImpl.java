package sagex.jetty.properties;

import java.util.Properties;

import sagex.jetty.starter.JettyStarterProperties;

/**
 * Retrieves Jetty properties in SAGE_HOME/JettyStarter.properties for SageTV V6 and earlier.
 */
public class JettyStarterPropertiesImpl extends JettyProperties
{
    // delegate to the existing properties class
    private JettyStarterProperties jettyProperties = null;

    public Properties getProperties()
    {
        if (jettyProperties == null)
        {
            jettyProperties = new JettyStarterProperties();
        }

        return jettyProperties.getProperties();
    }

    public String getProperty(String propertyName)
    {
        return (String) getProperties().get(propertyName);
    }
}
