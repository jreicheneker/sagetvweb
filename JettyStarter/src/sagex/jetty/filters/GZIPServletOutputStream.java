package sagex.jetty.filters;

import java.io.IOException;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletOutputStream;

class GZIPServletOutputStream extends ServletOutputStream
{
    // Keep a reference to the raw GZIP stream.  This instance variable
    // is package-private to allow the compression response wrapper access
    // to the variable;
    private GZIPOutputStream internalGzipOS;

    GZIPServletOutputStream(ServletOutputStream sos) throws IOException
    {
        this.internalGzipOS = new GZIPOutputStream(sos);
    }

    @Override
    public void write(int param) throws IOException
    {
        internalGzipOS.write(param);
    }

    @Override
    public void write(byte[] b, int off, int len) throws IOException
    {
        internalGzipOS.write(b, off, len);
    }

    @Override
    public void write(byte[] b) throws IOException
    {
        internalGzipOS.write(b);
    }

    @Override
    public void flush() throws IOException
    {
        super.flush();
        internalGzipOS.flush();
    }

    public void finish() throws IOException
    {
        flush();
        internalGzipOS.finish();
    }
}
