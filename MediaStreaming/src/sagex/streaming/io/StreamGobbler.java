package sagex.streaming.io;

import java.io.BufferedInputStream;
import java.io.Closeable;
import java.io.Flushable;
import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.util.concurrent.Callable;

import org.mortbay.jetty.EofException;
import org.mortbay.log.Log;

// TODO redirect to Log?
// http://www.javaspecialists.eu/archive/Issue056.html
public class StreamGobbler /*extends Thread//*/implements Callable<Object>, Closeable, Flushable
{
    private String name;
    private InputStream is;
    private OutputStream os;
    private boolean autoClose = true;
    private volatile Thread currentThread = null;

    public StreamGobbler(String name, InputStream is)
    {
        this(name, is, null);
    }
    
    public StreamGobbler(String name, InputStream is, OutputStream redirect)
    {
        this(name, is, redirect, true);
    }
    
    public StreamGobbler(String name, InputStream is, OutputStream redirect, boolean autoClose)
    {
        this.name = name;
        this.is = new BufferedInputStream(is);
        this.os = redirect;
        this.autoClose = autoClose;
    }

    public synchronized void interrupt()
    {
        if (currentThread != null)
        {
            currentThread.interrupt();
        }
    }
    
    public synchronized void flush()
    {
        if (os != null)
        {
            try
            {
                os.flush();
            }
            catch (IOException e)
            {
                // ignore
            }
        }
    }
    
    public synchronized void close()
    {
        close(is);
        close(os);
    }
    
    private synchronized void close(Closeable c)
    {
        if (c != null)
        {
            try
            {
                c.close();
            }
            catch (Exception e) {} // quietly close

            c = null;
        }
    }

    public Object call() throws Exception
    {
        currentThread = Thread.currentThread();
        String oldName = currentThread.getName();

        long totalBytes = 0;

        try
        {
            if (name != null)
            {
                currentThread.setName(name + " (" + oldName + ")");
            }

            byte[] buf = new byte[4096];
            int bytesRead = 0;
            while ((bytesRead = is.read(buf, 0, buf.length)) > 0)
            {
                totalBytes += bytesRead;
                if (os != null)
                {
//                    Log.debug("Bytes read in StreamGobbler [" + Thread.currentThread().getName() + "] " + totalBytes);
                    os.write(buf, 0, bytesRead);
                }
                else
                {
                    String s = new String(buf, 0, bytesRead);
                    Log.debug(s);
                }
            }
            Log.debug("StreamGobbler bytesRead = " + bytesRead);

            flush();
        }
        catch (EofException e)
        {
            // an error occurred writing to the output stream.  if auto close
            // is not set, then the stream is the output stream to the client
            close(os);
            if (autoClose)
            {
                // unexpected EOF, log the exception
                Log.info(e.getMessage());
                Log.ignore(e);
            }
            else
            {
                // EOF can be expected since the client may disconnect and that's
                // not an error that should be reported
                Log.debug("Client disconnected");
            }

            throw e;
        }
        catch (InterruptedIOException e)
        {
            // close input and output streams when interrupted
            close();
            currentThread.interrupt();
            Log.debug("Interrupted via InterruptedIOException");
        }
        catch (IOException e)
        {
            if (!currentThread.isInterrupted())
            {
                Log.debug("StreamGobbler encountered exception " + e.getMessage() + " and is exiting.");
                Log.info(e.getMessage());
                Log.ignore(e);
                throw e;
            }
            else
            {
                // close input and output streams when interrupted
                close();
                currentThread.interrupt();
                Log.debug("Interrupted");
            }
        }
        finally
        {
            flush();
            if (autoClose)
            {
                close(os);
            }
            Log.debug("Total bytes read in StreamGobbler [" + currentThread.getName() + "] " + totalBytes);
            Log.debug("StreamGobbler [" + currentThread.getName() + "] exiting");
            currentThread.setName(oldName);
            currentThread = null;
        }
        
        return null;
    }
}
