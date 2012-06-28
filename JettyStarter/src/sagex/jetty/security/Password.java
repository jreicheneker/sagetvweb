package sagex.jetty.security;

import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * Utility class for creating encrypted or obfuscated passwords.
 * <p>
 * The org.mortbay.jetty.security.Password class requires the
 * password to be entered on the command line, despite being
 * documented that entering a question mark for the password
 * will tell the program to prompt the user for the password.
 * <p>
 * This class wraps Jetty's class to provide the prompting
 * functionality.
 *
 */
public class Password
{
    public static void main(String[] args)
    {
        try
        {
            if ((args.length == 1) || (args.length == 2))
            {
                int pwIndex = (args.length == 1) ? 0 : 1;
                String pwString = args[pwIndex];
                if ("?".equals(pwString))
                {
                    System.out.print("Password: ");
                    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
                    String pwInput = reader.readLine();
                    args[pwIndex] = pwInput;
                }
            }
            org.mortbay.jetty.security.Password.main(args);
        }
        catch (Exception e)
        {
            System.err.println(e.getMessage());
        }
    }
}
