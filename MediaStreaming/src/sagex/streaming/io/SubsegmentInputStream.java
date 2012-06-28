package sagex.streaming.io;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.mortbay.log.Log;

/**
 * Returns an HTTP Live Streaming segment as each sub segment is produced by the segmenter.
 * The entire segment length is not available therefore the HTTP Content-Length response
 * header cannot be included in the response.
 */
public class SubsegmentInputStream extends InputStream
{
    private volatile DataInputStream dis = null;
    private volatile long segmentSize = 0; // can grow until isSegmentFinished == true
    private volatile boolean isSegmentFinished = false;
    private volatile long bytesAvailable = 0; // can grow until isSegmentFinished == true

    public SubsegmentInputStream(InputStream is)
    {
        this.dis = new DataInputStream(is);
    }

    @Override
    public int available() throws IOException
    {
        // Get the next subsegment
//        if ((bytesAvailable == 0) && (!isSegmentFinished))
//        {
//            readSegmentFinished();
//            readSubsegmentSize();
//        }

//        throw new UnsupportedOperationException("available");
        if (bytesAvailable > Integer.MAX_VALUE)
        {
            throw new IllegalStateException("integer overflow");
        }
        return (int) bytesAvailable;
    }

    @Override
    public void close() throws IOException
    {
        dis.close();
    }

    @Override
    public synchronized void mark(int arg0)
    {
        throw new UnsupportedOperationException("mark");
    }

    @Override
    public boolean markSupported()
    {
        return false;
    }

    @Override
    public int read() throws IOException
    {
        if (bytesAvailable > 0)
        {
            int value = dis.read();
            if (value == -1)
            {
                throw new IllegalStateException("Segment still has bytes available but no byte was returned.");
            }
            bytesAvailable -= value;
            return value;
        }

        //
        // At this point we know there are zero bytes available
        //

        // return -1 to indicate the segment is finished, then reset so the
        // next read will start returning the next segment
        if (isSegmentFinished)
        {
            Log.debug("Segment size " + segmentSize);
            isSegmentFinished = false;
            segmentSize = 0;
            return -1;
        }
        else
        {
            // Get the next subsegment
            readSegmentFinished();
            readSubsegmentSize();

            // TODO try to refactor so infinite recursion isn't possible
            return this.read();
//            bytesAvailable -= 1;
//            return dis.read();
        }
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException
    {
        // The current subsegment has enough bytes to fulfill the request
        if (bytesAvailable >= len)
        {
            int bytesRead = dis.read(b, off, len);
            if (bytesRead == -1)
            {
                throw new IllegalStateException("Subsegment still has more than the requested number of bytes available but no bytes were returned.");
            }
            bytesAvailable -= bytesRead;
            return bytesRead;
        }

        // The current subsegment has somewhere between 1 and
        // the number of bytes requested.  Return the remaining
        // bytes of this subsegment.
        if (bytesAvailable > 0)
        {
            int bytesRead = dis.read(b, off, (int) Math.min(Integer.MAX_VALUE, bytesAvailable));
            if (bytesRead == -1)
            {
                throw new IllegalStateException("Subsegment still has bytes available but no bytes were returned.");
            }
            bytesAvailable -= bytesRead;
            return bytesRead;
        }

        //
        // At this point we know there are zero bytes available
        //

        // return -1 to indicate the segment is finished, then reset so the
        // next read will start returning the next segment
        if (isSegmentFinished)
        {
            Log.debug("Segment size " + segmentSize);
            isSegmentFinished = false;
            segmentSize = 0;
            return -1;
        }
        else
        {
            // Get the next subsegment
            readSegmentFinished();
            readSubsegmentSize();

            // TODO try to refactor so infinite recursion isn't possible
            return this.read(b, off, len);
//            bytesAvailable -= 1;
//            return dis.read();
        }
    }

    @Override
    public int read(byte[] b) throws IOException
    {
        return read(b, 0, b.length);
    }

    @Override
    public synchronized void reset() throws IOException
    {
        throw new UnsupportedOperationException("reset");
    }

    @Override
    public long skip(long arg0) throws IOException
    {
        throw new UnsupportedOperationException("skip");
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
    private void readSubsegmentSize() throws IOException
    {
        byte[] subsegmentSizeBytes = new byte[4];
        dis.readFully(subsegmentSizeBytes);

        try
        {
            long subsegmentSize = 0;
            
            subsegmentSize = 
                (((long)(subsegmentSizeBytes[0] & 0xff) << 24) |
                 ((long)(subsegmentSizeBytes[1] & 0xff) << 16) |
                 ((long)(subsegmentSizeBytes[2] & 0xff) <<  8) |
                 ((long)(subsegmentSizeBytes[3] & 0xff)));
        
            segmentSize += subsegmentSize;
            bytesAvailable += subsegmentSize;

//            System.err.println("Size: " + subsegmentSize + "/" + segmentSize);
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
}
