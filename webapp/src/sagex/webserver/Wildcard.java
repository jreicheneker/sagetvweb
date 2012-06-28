package sagex.webserver;

/**
 * This file was copied from nielm's webserver to remove the dependency on that jar.
 */
public class Wildcard
{

    /**
     * Converts a windows wildcard pattern to a regex pattern
     *
     * @param wildcard - Wildcard pattern containing * and ?
     *
     * @return - a regex pattern that is equivalent to the windows wildcard pattern
     */
    public static String toRegex(String wildcard)
    {
        if (wildcard == null)
        {
            return null;
        }

        StringBuffer buffer = new StringBuffer();

        char [] chars = wildcard.toCharArray();

        for (int i = 0; i < chars.length; ++i)
        {
            if (chars[i] == '*')
            {
                buffer.append(".*");
            }
            else if (chars[i] == '?')
            {
                buffer.append(".");
            }
            else if ("+()^$.{}[]|\\".indexOf(chars[i]) != -1)
            {
                buffer.append('\\').append(chars[i]); // prefix all metacharacters with backslash
            }
            else
            {
                buffer.append(chars[i]);
            }
        }

        return buffer.toString();
    }
}
