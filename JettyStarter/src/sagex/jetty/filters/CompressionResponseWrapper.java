package sagex.jetty.filters;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

class CompressionResponseWrapper extends HttpServletResponseWrapper
{
    private GZIPServletOutputStream servletGzipOS = null;
    private PrintWriter printWriter = null;
    private Object streamUsed = null;
    private int status = HttpServletResponse.SC_OK;

    public CompressionResponseWrapper(HttpServletResponse resp)
    {
        super(resp);
    }

    /**
     * Ignore this method, the output will be compressed and use chunked transfers.
     */
    @Override
    public void setContentLength(int len) { }

    public int getStatus()
    {
        return status;
    }

    @Override
    public void setStatus(int sc)
    {
        status = sc;
        super.setStatus(sc);
    }

    @Override
    public void setStatus(int sc, String sm)
    {
        status = sc;
        super.setStatus(sc, sm);
    }

    /**
     * Flushes all buffered data to the client.
     */
    @Override
    public void flushBuffer() throws IOException
    {
        // in random cases the header values are not preserved, so set them again here
        if (printWriter != null)
        {
            // wraps both servletGzipOS and getResponse().getOutputStream()
            setCompressionHeaders();
            printWriter.flush();
        }
        else if (servletGzipOS != null)
        {
            // wraps getResponse().getOutputStream()
            setCompressionHeaders();
            servletGzipOS.flush();
        }
        else
        {
            getResponse().flushBuffer();
        }
    }

    public void finish() throws IOException
    {
        flushBuffer();

        // will be null if resource is '304 Not Modified'
        if (servletGzipOS != null)
        {
            servletGzipOS.finish();
        }
    }

    @Override
    public ServletOutputStream getOutputStream() throws IOException
    {
        // Allow the servlet to access a servlet output stream, only if
        // the servlet has not already accessed the print writer.
        if ((streamUsed != null) && (streamUsed != servletGzipOS))
        {
            throw new IllegalStateException("Cannot request output stream if writer has already been requested");
        }

        if (servletGzipOS == null)
        {
            setCompressionHeaders();
            servletGzipOS = new GZIPServletOutputStream(getResponse().getOutputStream());
            streamUsed = servletGzipOS;
        }

        return servletGzipOS;
    }

    @Override
    public PrintWriter getWriter() throws IOException
    {
        // Allow the servlet to access a print writer, only if the servlet has
        // not already accessed the servlet output stream.
        if ((streamUsed != null) && (streamUsed != printWriter))
        {
            throw new IllegalStateException("Cannot request writer if output stream has already been requested");
        }

        if (printWriter == null)
        {
            // To make a print writer, we have to first wrap the servlet output stream
            // and then wrap the compression servlet output stream in two additional output
            // stream decorators: OutputStreamWriter which converts characters into bytes,
            // and the a PrintWriter on top of the OutputStreamWriter object.
            setCompressionHeaders();
            servletGzipOS = new GZIPServletOutputStream(getResponse().getOutputStream());

            OutputStreamWriter osw = new OutputStreamWriter(servletGzipOS,
                    getResponse().getCharacterEncoding());

            printWriter = new PrintWriter(osw);
            streamUsed = printWriter;
        }

        return printWriter;
    }

    private void setCompressionHeaders()
    {
        setHeader("Content-Encoding", "gzip");
        setHeader("Vary", "Accept-Encoding");
        setHeader("Transfer-Encoding", "chunked");
    }
}
