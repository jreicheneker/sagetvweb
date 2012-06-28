package sagex.streaming.io;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.mortbay.log.Log;

/**
 * Returns an HTTP Live Streaming segment, blocking until the entire segment is ready.
 * The entire segment length is available after the segment has been buffered therefore
 * the HTTP Content-Length response header can be included in the response.
 */
public class SegmentInputStream extends InputStream
{
    private volatile DataInputStream dis = null;
    private volatile ByteArrayInputStream bais = null;
    private volatile long segmentSize = 0; // can grow until isSegmentFinished == true
    private volatile boolean isSegmentFinished = false;

    public SegmentInputStream(InputStream is)
    {
        this.dis = new DataInputStream(is);
    }

    @Override
    public int available() throws IOException
    {
        return (bais == null) ? 0 : bais.available();
    }

    @Override
    public void close() throws IOException
    {
        dis.close();
        bais = null;
    }

    @Override
    public synchronized void mark(int arg0)
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        bais.mark(arg0);
    }

    @Override
    public boolean markSupported()
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        return bais.markSupported();
    }

    @Override
    public int read() throws IOException
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        return bais.read();
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        return bais.read(b, off, len);
    }

    @Override
    public int read(byte[] b) throws IOException
    {
        return read(b, 0, b.length);
    }

    @Override
    public synchronized void reset() throws IOException
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        bais.reset();
    }

    @Override
    public long skip(long arg0) throws IOException
    {
        if (bais == null)
        {
            throw new IllegalStateException("Buffer is null");
        }
        return bais.skip(arg0);
    }
    
    public void fillNextSegment()
    {
        isSegmentFinished = false;
        segmentSize = 0;

        try
        {
            ByteArrayOutputStream baos = new ByteArrayOutputStream(500000);
            Log.debug("Initial ByteArrayOutputStream size: " + baos.size());

            do
            {
                // Get the next subsegment
                readSegmentFinished();
                int subsegmentSize = (int) readSubsegmentSize(); // TODO throw exception

                if (subsegmentSize > 0)
                {
                    segmentSize += subsegmentSize;
                    byte[] b = new byte[subsegmentSize];
                    dis.readFully(b);
                    baos.write(b);
                }
                
            } while (!isSegmentFinished);
            
            Log.debug("Final ByteArrayOutputStream size: " + baos.size());
            bais = new ByteArrayInputStream(baos.toByteArray());
            baos = null;
        }
        catch (IOException e)
        {
            Log.warn(e.getMessage(), e);
        }
    }
    
    public long getSegmentLength()
    {
        return segmentSize;
    }

    // Read an unsigned 32-bit integer.  If it's '1' then all the
    // segment is available.  If it's '0' then some of the segment
    // still has yet to be written to the stream on the other end.
    private void readSegmentFinished() throws IOException
    {
        byte[] finished = new byte[4];
        try
        {
            dis.readFully(finished);

            isSegmentFinished = (finished[3] == 1);
//            System.err.println("Finished: " + finished[0] + " " + finished[1] + " " + finished[2] + " " + finished[3]);
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
    
    // Read an unsigned 32-bit integer.  This is the size of the segment
    // that needs to be made available by this stream.
    private long readSubsegmentSize() throws IOException
    {
        byte[] subsegmentSizeBytes = new byte[4];
        dis.readFully(subsegmentSizeBytes);

        long subsegmentSize = 0;
        try
        {
            
            subsegmentSize = 
                (((long)(subsegmentSizeBytes[0] & 0xff) << 24) |
                 ((long)(subsegmentSizeBytes[1] & 0xff) << 16) |
                 ((long)(subsegmentSizeBytes[2] & 0xff) <<  8) |
                 ((long)(subsegmentSizeBytes[3] & 0xff)));
        
//            System.err.println("Size: " + subsegmentSize + "/" + segmentSize);
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }

        return subsegmentSize;
    }
}
