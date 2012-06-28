package sagex.jetty.properties.persistence;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.Closeable;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mortbay.jetty.security.Password;
import org.mortbay.log.Log;

import sagex.jetty.starter.JettyPlugin;
import sagex.plugin.IPropertyPersistence;

public class UserRealmPersistence implements IPropertyPersistence
{
    private static final Pattern CREDENTIAL_REGEX = Pattern.compile("(.*?):\\s*([\\S&&[^,]]*)(.*)");
    private static final int USER_REGEX_GROUP     = 1;
    private static final int PASSWORD_REGEX_GROUP = 2;
    private static final int ROLES_REGEX_GROUP    = 3;
    
    private File realmFile = new File("jetty/etc/realm.properties");

    public static void main(String[] args)
    {
        String s = "sage: frey,user admin";
        
        Matcher m = CREDENTIAL_REGEX.matcher(s);
        System.out.println(m.matches());
        if (m.matches())
        {
            for (int i = 0; i <= m.groupCount(); i++)
            {
                System.out.println("Group " + i + ": " + m.group(i));
            }
        }
    }
    
    /**
     * Get the first user/password in realms.properties
     */
    public String get(String property, String defaultValue)
    {
        String value = defaultValue;

        BufferedReader reader = null;
        try
        {
            reader = new BufferedReader(new FileReader(realmFile));
            String line = null;
            while ((line = reader.readLine()) != null)
            {
                if (line.trim().startsWith("#"))
                {
                    // commented line
                    continue;
                }
                Matcher m = CREDENTIAL_REGEX.matcher(line);
                if (m.matches())
                {
                    String user = m.group(USER_REGEX_GROUP);
                    String password = m.group(PASSWORD_REGEX_GROUP);

                    if (JettyPlugin.PROP_NAME_USER.equals(property))
                    {
                        value = user;
                    }
                    else if (JettyPlugin.PROP_NAME_PASSWORD.equals(property))
                    {
                        if (password.startsWith(Password.__OBFUSCATE))
                        {
                            value = Password.deobfuscate(password);
                        }
                        else
                        {
                            value = password;
                        }
                    }
                    break;
                }
            }
        }
        catch (IOException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
        finally
        {
            close(reader);
        }
        
        return value;
    }

    /**
     * Replace the first user/password in realms.properties with the values input by the user
     */
    public void set(String property, String value)
    {
        String user = "";
        String password = "";
        String roles = "";

        BufferedReader reader = null;
        BufferedWriter writer = null;
        boolean updated = false;
        try
        {
            reader = new BufferedReader(new FileReader(realmFile));
            List<String> propertyList = new ArrayList<String>();
            String line = null;
            while ((line = reader.readLine()) != null)
            {
                propertyList.add(line);
            }
            
            for (int i = 0; i < propertyList.size(); i++)
            {
                if (propertyList.get(i).trim().startsWith("#"))
                {
                    // commented line
                    continue;
                }
                Matcher m = CREDENTIAL_REGEX.matcher(propertyList.get(i).trim());
                if (m.matches())
                {
                    if (JettyPlugin.PROP_NAME_USER.equals(property))
                    {
                        user = value;
                        password = m.group(PASSWORD_REGEX_GROUP);
                    }
                    else if (JettyPlugin.PROP_NAME_PASSWORD.equals(property))
                    {
                        user = m.group(USER_REGEX_GROUP);
                        // can't be encrypted because Sage's CONFIG_PASSWORD checks for the old
                        // passwords before allowing the user to change it
                        password = Password.obfuscate(value);
                    }
                    roles = m.group(ROLES_REGEX_GROUP);
                    
                    // make sure there's at least the 'user' role
                    if ((roles == null) || (roles.trim().equals(",")) || (roles.trim().length() == 0))
                    {
                        roles = ",user";
                    }

                    propertyList.set(i, user + ": " + password + roles);
                    updated = true;
                    break;
                }
            }
            
            // if the property was not already specified or on a commented line, add it to the end of the file
            if (!updated)
            {
                propertyList.add("");
                propertyList.add(user + ": " + password + roles);
                updated = true;
            }
            
            writer = new BufferedWriter(new FileWriter(realmFile));
            
            for (String propertyItem : propertyList)
            {
                writer.write(propertyItem);
                writer.newLine();
            }
            writer.flush();
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
        finally
        {
            close(reader);
            close(writer);
        }
    }
    
    private void close(Closeable closeable)
    {
        if (closeable != null)
        {
            try
            {
                closeable.close();
            }
            catch (IOException e)
            {
                Log.info(e.getMessage());
                Log.ignore(e);
            }
        }
    }
}
