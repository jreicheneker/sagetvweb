package sagex.streaming.io;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.channels.WritableByteChannel;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

import org.mortbay.log.Log;

public class ChannelGobbler extends Thread
{
    private String name;
    private ReadableByteChannel input;
    private WritableByteChannel output;
    private OutputStream outputStream;
    
    public ChannelGobbler(String name, ReadableByteChannel input)
    {
        this(name, input, System.out);
    }
    
    public ChannelGobbler(String name, ReadableByteChannel input, OutputStream redirect)
    {
        this(name, input, Channels.newChannel(redirect));
        this.outputStream = redirect;
    }

    public ChannelGobbler(String name, ReadableByteChannel input, WritableByteChannel redirect)
    {
        this.name = name;
        this.input = input;
        this.output = redirect;
    }
    
    public void run()
    {
        long totalBytes = 0;
        try
        {
            if (name != null)
            {
                Thread.currentThread().setName(name);
            }

            ByteBuffer buffer = ByteBuffer.allocateDirect(1024);
            int bytesRead = 0;
            while (((bytesRead = input.read(buffer)) > -1) || (buffer.position() > 0))
            {
                if (isInterrupted())
                {
                    break;
                }
                Log.debug("Bytes read in ChannelGobbler [" + name + "] " + bytesRead);
                totalBytes += bytesRead;

                buffer.flip();
                Log.debug("Total bytes written " + totalBytes);
                if (output != null)
                {
                    output.write(buffer);
                    if (outputStream != null)
                    {
//                        outputStream.flush();
                    }
                }
                else
                {
                    Charset charset = Charset.forName("UTF-16");
                    CharsetDecoder charDecoder = charset.newDecoder();
                    String s = charDecoder.decode(buffer).toString();
                    Log.debug(s);
                }
//                output.flush();
                Log.debug("Bytes written in ChannelGobbler [" + name + "] " + bytesRead);
                buffer.compact();

//                if (os != null)
//                {
//                    totalBytes += bytesRead;
//                    os.write(buf, 0, bytesRead);
//                    os.flush();
//                }
//                else
//                {
//                    String s = new String(buf, 0, bytesRead);
//                    Log.debug(s);
//                }
            }
//            if (os != null)
//            {
//                os.flush();
//            }
        }
        catch (IOException ioe)
        {
            Log.debug("ChannelGobbler [" + name + "] encountered exception " + ioe.getMessage() + " and is exiting.");
            Log.info(ioe.getMessage());
            Log.ignore(ioe);
        }
        finally
        {
//            if (os != null)
//            {
//                try
//                {
//                    os.flush();
//                    os.close();
//                }
//                catch (IOException e)
//                {
//                }
//            }
            Log.debug("Total bytes read in ChannelGobbler [" + name + "] " + totalBytes);
            Log.debug("ChannelGobbler [" + name + "] exiting");
        }
    }
}
