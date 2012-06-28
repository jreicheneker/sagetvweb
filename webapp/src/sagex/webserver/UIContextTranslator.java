package sagex.webserver;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import sage.SageTV;

/**
 * This file was copied from nielm's webserver to remove the dependency on that jar.
 */
public class UIContextTranslator
{
    private static UIContextTranslator instance = null;
    private static Pattern CLIENT_CONTEXT_PATTERN = Pattern.compile("(/\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}):(\\d{1,5})");
    private static Pattern CLIENT_CONTEXT_WILDCARD_PATTERN = Pattern.compile("(/\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}):(\\*)");

    private long fileLastReadTime=0;
    private HashMap<String, String> contextNames=new HashMap<String, String>(0);

    private UIContextTranslator()
    {
    }
    
    public static synchronized UIContextTranslator getInstance()
    {
        if (instance == null)
        {
            instance = new UIContextTranslator();
        }
        return instance;
    }
    
    public static String doTranslate(String uiContext)
    {
        return getInstance().translate(uiContext);
    }

    public synchronized String translate(String uiContext)
    {
        readProperties();
        String contextName=(String)contextNames.get(uiContext);
        if (contextName != null)
        {
            return contextName;
        }
        else
        {
            // wildcard port number for client contexts
            Matcher uiContextMatcher = CLIENT_CONTEXT_PATTERN.matcher(uiContext);
            if ( uiContextMatcher.matches()) {
                // the supplied context is that of a SageTV Client (/IP:Port)
                Set<Entry<String, String>> contextNameEntrySet = contextNames.entrySet();
                Iterator<Entry<String, String>> iter = contextNameEntrySet.iterator();
                while (iter.hasNext())
                {
                    Entry<String, String> currentEntry = iter.next();
                    String currentContextName = currentEntry.getKey();
                    Matcher currentContextMatcher = CLIENT_CONTEXT_WILDCARD_PATTERN.matcher(currentContextName);
                    if (currentContextMatcher.matches())
                    {
                        String uiContextIP = uiContextMatcher.group(1);
                        String currentContextIP = currentContextMatcher.group(1);
                        String currentContextPort = currentContextMatcher.group(2);
                        
                        if (uiContextIP.equals(currentContextIP) && currentContextPort.equals("*"))
                        {
                            // wildcard match found
                            return currentEntry.getValue();
                        }
                    }
                }
            }
            // no context name override, return the context name
            return uiContext;
        }
    }
    
    /**
     * Reads or re-reads the properties file if modified
     */
    private synchronized void readProperties()
    {
        
        String workPath = "webserver";
        try
        {
            workPath = (String) SageTV.api("GetProperty", new Object[]{"nielm/webserver/root","webserver"});
        }
        catch (InvocationTargetException e)
        {
            System.out.println(e);
        }
        
        // check if called within 30 secs (to prevent to much FS access)
        if (fileLastReadTime + 30000 > System.currentTimeMillis())
        {
            return;
        }

        // check if file has recently been loaded
        File propsFile=new File(workPath,"extenders.properties");
        if (fileLastReadTime >= propsFile.lastModified())
        {
            return;
        }

        if (propsFile.canRead())
        {
            BufferedReader in = null;
            contextNames.clear();
            try
            {
                in = new BufferedReader(new FileReader(propsFile));
                String line;
                Pattern p = Pattern.compile("([^=]+[^=]*)=(.*)");
                while (null != (line = in.readLine()))
                {
                    line = line.trim();
                    if ((line.length() > 0) && (line.charAt(0) != '#'))
                    {
                        Matcher m =p.matcher(line.trim());
                        if (m.matches())
                        {
                            contextNames.put(m.group(1).trim(), m.group(2).trim());
                        }
                        else
                        {
                            System.out.println("Invalid line in "+propsFile+"\""+line+"\"");
                        }
                    }
                }
                fileLastReadTime=System.currentTimeMillis();

            }
            catch (IOException e)
            {
                System.out.println("Exception occurred trying to load properties file: "+propsFile+"-" + e);
            }
            finally
            {
                if (in != null)
                {
                    try
                    {
                        in.close();
                    }
                    catch (IOException e) {}
                }
            }
        } 
    }
}
