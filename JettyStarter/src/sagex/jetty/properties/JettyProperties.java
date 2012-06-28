package sagex.jetty.properties;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import sagex.jetty.starter.JettyInstance;

/**
 * An abstraction of the properties for configuring the {@link JettyInstance}.
 * The properties can either come from JettyStarter.properties (SageTV 6 or earlier)
 * or from Sage.properties (SageTV 7 or later).
 * @author jreichen
 *
 */
public abstract class JettyProperties
{
    public static final String JETTY_HOME_PROPERTY = "jetty.home";
    public static final String JETTY_CONFIG_FILES_PROPERTY = "jetty.configfiles";
    public static final String JETTY_LOGS_PROPERTY = "jetty.logs";
    public static final String JETTY_LOG_LEVEL = "jetty.log.level";
    public static final String JETTY_HOST_PROPERTY = "jetty.host";
    public static final String JETTY_PORT_PROPERTY = "jetty.port";
    public static final String JETTY_SSL_PORT_PROPERTY = "jetty.ssl.port";
    public static final String JETTY_SSL_KEYSTORE_PROPERTY = "jetty.ssl.keystore";
    public static final String JETTY_SSL_PASSWORD_PROPERTY = "jetty.ssl.password";
    public static final String JETTY_SSL_KEYPASSWORD_PROPERTY = "jetty.ssl.keypassword";
    public static final String JETTY_SSL_TRUSTSTORE_PROPERTY = "jetty.ssl.truststore";
    public static final String JETTY_SSL_TRUSTPASSWORD_PROPERTY = "jetty.ssl.trustpassword";

    public JettyProperties()
    {
        Properties jettyProperties = getProperties();

        setSystemProperties(jettyProperties);
    }
    
    public abstract Properties getProperties();
    
    public abstract String getProperty(String propertyName);

    private void setSystemProperties(Properties starterProperties)
    {
        // two properties that must be set as Java system properties so they're
        // available to the default jetty xml config files
        String jettyHome = starterProperties.getProperty(JettyProperties.JETTY_HOME_PROPERTY);
        String jettyLogs = starterProperties.getProperty(JettyProperties.JETTY_LOGS_PROPERTY);

        if (jettyHome == null)
        {
            throw new IllegalStateException(JettyProperties.JETTY_HOME_PROPERTY + " property is not configured");
        }

        if (jettyLogs == null)
        {
            throw new IllegalStateException(JettyProperties.JETTY_LOGS_PROPERTY + " property is not configured");
        }

        System.setProperty(JettyProperties.JETTY_HOME_PROPERTY, jettyHome);
        System.setProperty(JettyProperties.JETTY_LOGS_PROPERTY, jettyLogs);
    }

    /**
     * 
     */
    public static String[] parseConfigFilesSetting(String configFiles)
    {
        String UQ = "(?<!\\\\)\\\""; // unescaped quotes
        Pattern p = Pattern.compile(UQ + ".*?" + UQ);
        Matcher m = p.matcher(configFiles);
        List<String> configFileList = new ArrayList<String>();
        int previousEnd = 0;
        while (m.find())
        {
            if (m.start() > previousEnd)
            {
                // there is some text between the previous match and this match
                // (or before this match if it's the first match)
                // split it on spaces
                String textBetweenMatches = configFiles.substring(previousEnd, m.start()).trim();
                String[] textArray = textBetweenMatches.split(" ");
                for (String text : textArray)
                {
                    if (text.trim().length() > 0)
                    {
                        configFileList.add(text);
                    }
                }
            }
            String matchingText = configFiles.substring(m.start() + 1, m.end() - 1).trim();
            configFileList.add(matchingText);

            previousEnd = m.end();
        }

        if (configFiles.length() > previousEnd)
        {
            // text after the last match, split it on spaces
            String tailText = configFiles.substring(previousEnd, configFiles.length()).trim();
            String[] textArray = tailText.split(" ");
            for (String text : textArray)
            {
                if (text.trim().length() > 0)
                {
                    configFileList.add(text);
                }
            }
        }

        String[] configFileArray = new String[configFileList.size()];
        configFileArray = configFileList.toArray(configFileArray);
        return configFileArray;
    }
}
