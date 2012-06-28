package sagex.jetty.properties;

import java.util.Properties;

import sagex.api.Configuration;

/**
 * Retrieves Jetty properties from SAGE_HOME/Sage.properties for SageTV V7 and later.
 */
public class SagePropertiesImpl extends JettyProperties
{
    private final static String JETTY_PROPERTY_PREFIX = "jetty";
    
    public Properties getProperties()
    {
        Properties jettyProperties = new Properties();

        String[] jettyPropertyArray = Configuration.GetSubpropertiesThatAreLeaves(JETTY_PROPERTY_PREFIX);
        
        if (jettyPropertyArray != null)
        {
            for (String propertyName : jettyPropertyArray)
            {
                String propertyValue = getProperty(propertyName);
                if (propertyValue != null)
                {
                    jettyProperties.put(propertyName, propertyValue);
                }
            }
        }
        return jettyProperties;
    }
    
    public String getProperty(String propertyName)
    {
        return Configuration.GetProperty(JETTY_PROPERTY_PREFIX + "/" + propertyName, null);
    }
}
