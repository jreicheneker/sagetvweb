package sagex.webserver;

import java.lang.reflect.InvocationTargetException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mortbay.log.Log;

import sage.SageTV;

/**
 * Stores and retrieves descriptive names - or other properties - for Sage's UI
 * contexts in Sage.properties. Names used to be stored in webserver/extenders.properties
 * but are being moved so the file can be obsoleted and other plugins can easily use the
 * same properties.
 * The contexts ids are either MAC addresses for placeshifters and extenders, or
 * IP addresses for client.
 * 
 */
public class UiContextProperties
{
    private static Pattern CLIENT_CONTEXT_PATTERN = Pattern.compile("/(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}):(\\d{1,5})");

    private UiContextProperties()
    {
    }

    public static String getProperty(String contextName, String contextPropertyName)
    {
        return getProperty(contextName, contextPropertyName, contextName);
    }

    public static String getProperty(String contextName, String contextPropertyName, String defaultValue)
    {
        String returnValue = null;

        try
        {
            String propertyName = createPropertyName(contextName, contextPropertyName);
            returnValue = (String) SageTV.api("GetServerProperty",
                                              new Object[] {propertyName, null});

            // value not in Sage.properties, fallback to extenders.properties
            if (returnValue == null)
            {
                // copy context name from extenders.properties
                returnValue = UIContextTranslator.doTranslate(contextName);

                if ((returnValue != null) && (!returnValue.equals(contextName)))
                {
                    // copy property to Sage.properties if it exists and is not the same as the context
                    setProperty(contextName, contextPropertyName, returnValue);
                }
                else
                {
                    // set a blank value so next time this won't read from extenders.properties
                    setProperty(contextName, contextPropertyName, "");
                }
            }
        }
        catch (InvocationTargetException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }

        if ((returnValue == null) || (returnValue.trim().length() == 0))
        {
            returnValue = defaultValue;
        }

        return returnValue;
    }

    public static void setProperty(String contextName, String contextPropertyName, String value)
    {
        String propertyName = createPropertyName(contextName, contextPropertyName);

        try
        {
            SageTV.api("SetServerProperty", new Object[] {propertyName, value});
        }
        catch (InvocationTargetException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
    
    private static String createPropertyName(String contextName, String contextPropertyName)
    {
        Matcher contextMatcher = CLIENT_CONTEXT_PATTERN.matcher(contextName);
        if (contextMatcher.matches())
        {
            // if the ui context is for a SageTV Client, strip off the leading forward
            // slash and the trailing colon and port number
            contextName = contextMatcher.group(1);
        }

        String propertyName = "sagex/uicontexts/" +
                              contextName + "/" +
                              contextPropertyName;
        
        return propertyName;
    }
}
