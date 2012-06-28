package sagex.streaming.servlet;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.log.Log;

import sagex.api.AlbumAPI;
import sagex.api.Database;
import sagex.api.MediaFileAPI;
import sagex.api.Utility;


/**
 * Copied from nielm's web server to eliminate dependency.
 */
public class MediaFileThumbnailServlet extends SageServlet
{
    private static final long serialVersionUID = 5914576130809217889L;
    
    protected void doServletGet(HttpServletRequest req, HttpServletResponse resp)
        throws Exception
    {
        try
        {
            Object thumb = null;
            String albumName = req.getParameter("albumname");
            if (albumName == null)
            {
                Object mediaFile = super.getMediaFile(req);
                if (mediaFile != null)
                {
                    thumb = MediaFileAPI.GetThumbnail(mediaFile);
                    if (thumb == null)
                    {
                        throw new Exception("GetThumbnail returned null");
                    }
                }
            }
            else
            {
                // album thumb
                String artist = req.getParameter("artist");
                if (artist == null) artist = "";
                String year = req.getParameter("year");
                if (year == null) year = "";
                String genre = req.getParameter("genre");
                if (genre == null) genre = "";
                Object albums = AlbumAPI.GetAlbums();
                albums = Database.FilterByMethod(albums,"GetAlbumName",albumName,Boolean.TRUE);
                albums = Database.FilterByMethod(albums,"GetAlbumArtist",artist,Boolean.TRUE);
                albums = Database.FilterByMethod(albums,"GetAlbumYear",year,Boolean.TRUE);
                albums = Database.FilterByMethod(albums,"GetAlbumGenre",genre,Boolean.TRUE);
                Object album = Utility.GetElement(albums,0);
                if (album == null)
                {
                    throw new Exception("Cound not find album for: " + albumName + "/" + artist + "/" + year + "/" + genre);
                }
                if ((Boolean) AlbumAPI.HasAlbumArt(album))
                {
                    thumb = AlbumAPI.GetAlbumArt(album);
                }
                if (thumb == null)
                {
                    throw new Exception("GetAlbumArt on album: " + album + " returned null");
                }
            }
            BufferedImage image = (BufferedImage) Utility.GetImageAsBufferedImage(thumb);
            if (image == null) 
            {
                throw new Exception("GetImageAsBufferedImage returned null");
            }
            // got a BufferedImage, write it out as JPEG
            // cache for at least 10 mins 
            boolean headOnly = false;
            long lastMod = System.currentTimeMillis() - (10*60*1000);
            try
            {
                if (!super.CheckIfModifiedSince(req,lastMod))
                {
                    resp.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
                    headOnly = true;
                }
            }
            catch (IllegalArgumentException e)
            {
                e.printStackTrace();
            }
            
            resp.setContentType("image/png");
            resp.setDateHeader("Last-modified", lastMod);
            resp.setBufferSize(8192);
            // set expiry date to now+1 week
            long expiry = System.currentTimeMillis() + (1000*60*60*24*7);
            resp.setDateHeader("Expires", expiry);
            if (!headOnly)
            {
                if (req.getParameter("small") != null
                     && (image.getWidth() > 100 || image.getHeight() > 100))
                {
                    Image scaledimage = image.getScaledInstance(50, -1, Image.SCALE_SMOOTH);
                    image = new BufferedImage(scaledimage.getWidth(null), scaledimage.getHeight(null), BufferedImage.TYPE_INT_RGB);
                    Graphics2D g2d = image.createGraphics();
                    g2d.drawImage(scaledimage, 0, 0, null);
                    g2d.dispose();
                }
                OutputStream os = resp.getOutputStream();
                javax.imageio.ImageIO.write(image, "png", os);
                os.close();
            }
        }
        catch (Exception e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
        }
    }
}

