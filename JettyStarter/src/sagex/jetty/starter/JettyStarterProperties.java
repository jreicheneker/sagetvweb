package sagex.jetty.starter;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mortbay.log.Log;

import sagex.jetty.properties.JettyProperties;

// TODO resolve properties and detect circular references
public class JettyStarterProperties
{
    // in JettyStarter.properties, system properties are enclosed in $()
    private static final Pattern SYSTEM_PROPERTY_PATTERN = Pattern.compile("\\$\\(.*?\\)");

    private File jettyPropertiesFile = null;
    private Properties starterProperties = null;

    public JettyStarterProperties()
    {
    }

    private static File getSageHomeDir()
    {
        // get sage home dir
        return new File(System.getProperty("user.dir"));
    }
    
    public static File getPropertiesFile()
    {
        return new File(getSageHomeDir(), "JettyStarter.properties");
    }

    /**
     * Ensure a path is an absolute path
     * @param relativeTo if path is relative, it's appended to this parameter to create an absolute path
     * @param path path specified by the user or a default from a properties file
     * @return The path parameter if it is an absolute path, otherwise path appended to relativeTo
     */
    private File resolvePath(File relativeTo, String path)
    {
        File file = new File(path);
        if (!file.isAbsolute())
        {
            // if the property was not an absolute path, make it relative to the relativeTo parameter
            file = new File(relativeTo, path);
        }
        return file;
    }

    public Properties getProperties()
    {
        if (starterProperties == null)
        {
            loadProperties();
        }
        return starterProperties;
    }
    
    public String getProperty(String key)
    {
        return (String) getProperties().get(key);
    }

    private void loadProperties()
    {
        starterProperties = new Properties();

        // load Jetty starter properties from a file
        jettyPropertiesFile = getPropertiesFile();
        loadPropertiesFromFile();

        // make sure to do jetty.home first because other properties may depend on it
        // and properties are not in the order they appear in the file
        String jettyHomeProperty = starterProperties.getProperty(JettyProperties.JETTY_HOME_PROPERTY, "jetty");
        jettyHomeProperty = evaluateProperties(jettyHomeProperty);

        // get jetty home dir
        String jettyHomePath = jettyHomeProperty;
        File jettyHome = resolvePath(getSageHomeDir(), jettyHomePath);
        starterProperties.setProperty(JettyProperties.JETTY_HOME_PROPERTY, jettyHome.getAbsolutePath());

        // replace properties after jetty.home has been set
        replaceProperties(starterProperties);

        // get jetty log dir
        String jettyLogsPath = starterProperties.getProperty(JettyProperties.JETTY_LOGS_PROPERTY, "logs");
        File jettyLogs = resolvePath(jettyHome, jettyLogsPath);
        starterProperties.setProperty(JettyProperties.JETTY_LOGS_PROPERTY, jettyLogs.getAbsolutePath());

        // get jetty keystore file
        String jettyKeystorePath = starterProperties.getProperty(JettyProperties.JETTY_SSL_KEYSTORE_PROPERTY, null);
        if (jettyKeystorePath != null)
        {
            File jettyKeystore = resolvePath(jettyHome, jettyKeystorePath);
            starterProperties.setProperty(JettyProperties.JETTY_SSL_KEYSTORE_PROPERTY, jettyKeystore.getAbsolutePath());
        }

        // get jetty truststore file
        String jettyTruststorePath = starterProperties.getProperty(JettyProperties.JETTY_SSL_TRUSTSTORE_PROPERTY, null);
        if (jettyTruststorePath != null)
        {
            File jettyTruststore = resolvePath(jettyHome, jettyTruststorePath);
            starterProperties.setProperty(JettyProperties.JETTY_SSL_TRUSTSTORE_PROPERTY, jettyTruststore.getAbsolutePath());
        }
    }
    
    /**
     * Logging will not be configured by now if the logger is trying to get the log level property
     */
    private void loadPropertiesFromFile()
    {
        if (jettyPropertiesFile.exists())
        {
            FileInputStream fis = null;
            try
            {
                fis = new FileInputStream(jettyPropertiesFile);
                starterProperties.load(fis);
                Log.info("Loaded JettyStarter properties from " + jettyPropertiesFile.getAbsolutePath());
            }
            catch (IOException e)
            {
                Log.info("Unable to load JettyStarter properties from " + jettyPropertiesFile.getAbsolutePath());
                Log.info(e.getMessage());
                Log.ignore(e);
            }
            finally
            {
                if (fis != null)
                {
                    try
                    {
                        fis.close();
                    }
                    catch (IOException e)
                    {
                        Log.info(e.getMessage());
                        Log.ignore(e);
                    }
                }
            }
        }
    }

    /**
     * Replaces Java system properties in the values of the properties object with their actual values.
     * @param properties
     */
    @SuppressWarnings("unchecked") // Enumeration
    private void replaceProperties(Properties properties)
    {
        // do other properties
        Enumeration names = properties.propertyNames();

        while (names.hasMoreElements())
        {
            String name = (String) names.nextElement();
            String value = properties.getProperty(name);

            if (value == null)
            {
                continue;
            }

            value = evaluateProperties(value);
            properties.setProperty(name, value);
        }
    }

    /**
     * Replaces Java system properties in the values of the properties object with their actual values.
     * @param properties
     */
    private String evaluateProperties(String value)
    {
        StringBuffer sb = new StringBuffer();
        int lastEnd = 0; // copy characters between matches
        Matcher m = SYSTEM_PROPERTY_PATTERN.matcher(value);

        while (m.find())
        {
            if (lastEnd < m.start())
            {
                // copy characters between matches
                sb.append(value.substring(lastEnd, m.start()));
            }
            
            // get the property name
            String propertyName = value.substring(m.start() + 2, m.end() - 1);

            // get the property value, attempting to get it from JettyStarter.properties first
            // if not found, get it from Java system properties
            String propertyValue = getProperty(propertyName);
            if (propertyValue == null)
            {
                propertyValue = System.getProperty(propertyName);
            }
            sb.append(propertyValue);

            // record the end of the match
            lastEnd = m.end();
        }
        
        // write the characters after the last match
        sb.append(value.substring(lastEnd));

        return sb.toString();
    }

    public static void main(String[] args)
    {
        JettyStarterProperties props = new JettyStarterProperties();
//        JettyStarterProperties.writeProperty(JETTY_PORT_PROPERTY, "82");
//        JettyStarterProperties.writeProperty("jason", "friesen");
//        StringBuffer sb = new StringBuffer();
//        int lastEnd = 0;
//        //String property = "$(jetty.home)/etc/jetty.xml $(jetty.home)/etc/jetty-sage.xml";
//        //String property = "$(user.dir)/etc/jetty.xml $(user.dir)/etc/jetty-sage.xml";
//        //String property = "abc $(user.dir)/etc/jetty.xml $(user.dir)/etc/jetty-sage.xml";
//        //String property = "abc $(user.dir)$(user.dir)/etc/jetty.xml $(user.dir)/etc/jetty-sage.xml";
//        //String property = "$(user.dir)";
//        String property = "a$(user.dir)";
//        Matcher m = SYSTEM_PROPERTY_PATTERN.matcher(property);
//        while (m.find())
//        {
//            System.out.println(m.start());
//            System.out.println(m.end());
//            if (lastEnd < m.start())
//            {
//                // copy characters between matches
//                sb.append(property.substring(lastEnd, m.start()));
//            }
//            String systemProperty = System.getProperty(property.substring(m.start() + 2, m.end() - 1));
//            sb.append(systemProperty);
//            lastEnd = m.end();
//        }
//        sb.append(property.substring(lastEnd));
//        System.out.println(property);
//        System.out.println(sb.toString());
    }
}
