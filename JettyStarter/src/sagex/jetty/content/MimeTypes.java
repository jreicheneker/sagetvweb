package sagex.jetty.content;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mortbay.io.Buffer;
import org.mortbay.log.Log;

public class MimeTypes extends org.mortbay.jetty.MimeTypes
{
    private static String MIME_FILE_LINE_DELIMITERS = "[\\t ]+"; // tab or space

    private long fileLastReadTime;
    private String location;
    private List<File> mimeTypesFiles;

    public MimeTypes()
    {
    }
    
    private void setupMimeTypes()
    {
        if (mimeTypesFiles == null)
        {
            // mime types have not been setup or setLocation was called
            findFiles();
        }

        if (mimeTypesFiles.size() == 0)
        {
            // no files were found
            return;
        }

        // check if called within 1 second (to prevent too much FS access)
        if (fileLastReadTime + 1000 > System.currentTimeMillis())
        {
            return;
        }

        try
        {
            // if any file has changed they must all be reloaded because
            // one overrides another and types may be removed
            boolean filesChanged = false;
            for (File file : mimeTypesFiles)
            {
                if (fileLastReadTime <= file.lastModified())
                {
                    filesChanged = true;
                    break;
                }
            }

            if (filesChanged)
            {
                Map<String, String> mimeMap = new HashMap<String, String>();

                for (int i = mimeTypesFiles.size() - 1; i >= 0; i--)
                {
                    File mimeTypesFile = mimeTypesFiles.get(i);

                    System.out.println("Loading mime types from file " + mimeTypesFile.getAbsolutePath());

                    BufferedReader reader = new BufferedReader(new FileReader(mimeTypesFile));
                    String line = null;

                    while ((line = reader.readLine()) != null)
                    {
                        if (line.startsWith("#"))
                        {
                            // comment
                            continue;
                        }
                        String[] mimeTypeLineParts = line.split(MIME_FILE_LINE_DELIMITERS);
                        String mimeType = null;
                        if (mimeTypeLineParts.length > 1)
                        {
                            mimeType = mimeTypeLineParts[0];
                            for (int j = 1; j < mimeTypeLineParts.length; j++)
                            {
                                mimeMap.put(mimeTypeLineParts[j], mimeType);
                            }   
                        }
                    }
                }

                this.setMimeMap(mimeMap);
            }

            fileLastReadTime = System.currentTimeMillis();
        }
        catch (Throwable t)
        {
            t.printStackTrace();
        }
    }

    @Override
    public Buffer getMimeByExtension(String arg0)
    {
        // lazy loading of mime types file(s)
        setupMimeTypes();
        return super.getMimeByExtension(arg0);
    }

    @Override
    public synchronized Map getMimeMap()
    {
        // lazy loading of mime types file(s)
        setupMimeTypes();
        return super.getMimeMap();
    }

    /**
     * Overridden to synchronize the method
     */
    @Override
    public synchronized void setMimeMap(Map mimeMap)
    {
        super.setMimeMap(mimeMap);
    }

    private void findFiles()
    {
        mimeTypesFiles = new ArrayList<File>();

        // use the sage home for relative paths
        File sageHome = new File(System.getProperty("user.dir"));

        // the user override location
        File userMimeTypesFile = new File(sageHome, "jetty/user/mime.types");
        File defaultMimeTypesFile = new File(sageHome, "jetty/etc/mime.types");

        if (userMimeTypesFile.exists())
        {
            mimeTypesFiles.add(userMimeTypesFile);
        }

        // override by the web application
        File overrideMimeTypesFile = null;

        if (getLocation() != null)
        {
            // the context xml file or calling code specified a location
            overrideMimeTypesFile = new File(location);
            if (!overrideMimeTypesFile.isAbsolute())
            {
                // the location is not absolute so make it relative to the sagetv home
                overrideMimeTypesFile = new File(sageHome, location);
                
                if (overrideMimeTypesFile.exists())
                {
                    mimeTypesFiles.add(overrideMimeTypesFile);
                }
                else
                {
                    Log.info("mime.types file not found in override location " +
                            overrideMimeTypesFile.getAbsolutePath() + ".  Checking default locations.");
                }
            }
        }

        // the plugin's defaults location, overrides Jetty's defaults
        if (defaultMimeTypesFile.exists())
        {
            mimeTypesFiles.add(defaultMimeTypesFile);
        }

        if (mimeTypesFiles.size() == 0)
        {
            if (getLocation() == null)
            {
                Log.info("mime.types file for Jetty plugin not found in " +
                    "user location " + userMimeTypesFile.getAbsolutePath() + " or " +
                    "default plugin location " + defaultMimeTypesFile.getAbsolutePath() + ". " +
                    "Jetty's default mime types will be the only types available.");
            }
            else
            {
                Log.info("mime.types file for Jetty plugin not found in " +
                    "user location " + userMimeTypesFile.getAbsolutePath() + ", " +
                    "default plugin location " + defaultMimeTypesFile.getAbsolutePath() + ", or " +
                    "web application override location + " + overrideMimeTypesFile.getAbsolutePath() + ", " +
                    "Jetty's default mime types will be the only types available.");
            }
        }
    }

    public String getLocation()
    {
        return this.location;
    }

    public void setLocation(String location)
    {
        this.location = location;
        // reset the file list so findFiles searches for files again
        mimeTypesFiles = null;
        findFiles();
    }
    
    public static void main(String[] args)
    {
        // nielm format
        String[] a = "video/mp4    \t      mp4".split("[\\t ]+"); 
        String[] b = "video/mp2t              TS".split("[\\t ]+"); 
        String[] c = "video/mp4v-es".split("[\\t ]+"); 
        String[] d = "video/mp4 \t \t \t        mp4".split("[\\t ]+"); 
        String[] e = "video/mpeg          mpeg mpg mpe m2v m4v".split("[\\t ]+"); 

        System.out.println("a: " + a.length);
        System.out.println("b: " + b.length);
        System.out.println("c: " + c.length);
        System.out.println("d: " + d.length);
        System.out.println("e: " + e.length);
    }
}
