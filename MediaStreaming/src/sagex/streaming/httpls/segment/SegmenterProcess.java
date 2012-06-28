package sagex.streaming.httpls.segment;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.lang.Thread.UncaughtExceptionHandler;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.mortbay.log.Log;

import sagex.api.MediaFileAPI;
import sagex.streaming.httpls.playlist.SegmentPlaylist;
import sagex.streaming.io.SegmentInputStream;
import sagex.streaming.io.StreamGobbler;

public class SegmenterProcess implements UncaughtExceptionHandler
{
    /**
     * The ffmepg executable used for transcoding audio and video.
     */
    private static File transcoderFile;
    /**
     * The executable used for segmenting audio and video.
     */
    private static File segmenterFile;
    private static final String SEGMENTER_PARAM = "segmenter";
    /**
     * The command that tells the transcoder when the input file has stopped recording
     */
    private String RECORDING_STOPPED = "inactivefile\r\n";    
    /**
     * A thread pool that allows the stream gobblers to reuse threads if available
     */
    private static ExecutorService threadPool = Executors.newCachedThreadPool();

    /**
     * The process that converts the video and audio into the requested formats for the client
     */
    private Process transcoderProcess = null;
    /**
     * The process that produces HTTP Live Streaming segments
     */
    private Process segmenterProcess = null;
    /**
     * Custom input stream that reads the segmenter's specially formatted output and makes it available
     * to calling code as a normal input stream.
     */
    private SegmentInputStream segmentInputStream = null;
    /**
     * 
     */
    private File inputFile = null;
    private boolean isCurrentlyRecording = false;
    /**
     * Input and output streams for transcoder and segmenter processes
     */
    private OutputStream  stdinTranscoder         = null;
    private StreamGobbler stdoutTranscoderGobbler = null;
    private StreamGobbler stderrTranscoderGobbler = null;
    private StreamGobbler stdoutSegmenterGobbler  = null;
    private StreamGobbler stderrSegmenterGobbler  = null;

    /**
     * Set the location of the ffmpeg executable when the web app starts
     */
    public static void setTranscoderProcessLocation(File f)
    {
        if (!f.exists())
        {
            throw new IllegalArgumentException("File does not exist.");
        }

        Log.info("SegmenterProcess transcoder for HTTPLS web streaming is " + f.getAbsolutePath());
        transcoderFile = f;
    }

    /**
     * Set the location of the ffmpeg executable when the web app starts
     */
    public static void setSegmenterProcessLocation(File f)
    {
        if (!f.exists())
        {
            throw new IllegalArgumentException("File does not exist.");
        }

        Log.info("SegmenterProcess segmenter for HTTPLS web streaming is " + f.getAbsolutePath());
        segmenterFile = f;
    }

    /**
     * Start transcoder and segmenter streams along with their gobblers.  After this method
     * exits, the transcoded stream is ready to be copied to the client when it's requested.
     */
    public void startProcess(File inputFile, String userAgent, String quality, int sequence) throws IOException
    {
        try
        {
            this.inputFile = inputFile;
            
            double startTime = sequenceToStartTime(sequence);
    
            // get builders for the transcoding and segmenting processes
            ProcessBuilder transcoderProcessBuilder = getTranscodeProcessBuilder(inputFile, userAgent, quality, startTime);
            ProcessBuilder segmenterProcessBuilder = getSegmenterProcessBuilder(sequence);
    
            // start the transcoding and segmenting processes
            transcoderProcess = transcoderProcessBuilder.start();
            segmenterProcess = segmenterProcessBuilder.start();
    
            // tell the transcoder if and when recording has stopped
            stdinTranscoder = transcoderProcess.getOutputStream();

            // copy the transcoder's a/v output to the segmenter
            // if this gobbler exits, streaming cannot continue so the streams should be closed
            stdoutTranscoderGobbler = new StreamGobbler("transcoder stdout", transcoderProcess.getInputStream(), segmenterProcess.getOutputStream(), true);
            // Log the stderr output of the transcoder and segmenter processes
            stderrTranscoderGobbler = new StreamGobbler("transcoder stderr", transcoderProcess.getErrorStream());
            stderrSegmenterGobbler = new StreamGobbler("segmenter stderr", segmenterProcess.getErrorStream());
    
            // start process gobblers, reusing existing threads if available
            threadPool.submit(stdoutTranscoderGobbler);
            threadPool.submit(stderrTranscoderGobbler);
            threadPool.submit(stderrSegmenterGobbler);
    
            segmentInputStream = new SegmentInputStream(segmenterProcess.getInputStream());
        }
        catch (IOException e)
        {
            stopProcess();
            throw e;
        }
    }
    
    public void stopProcess()
    {
        interrupt(stdoutSegmenterGobbler);
        interrupt(stderrSegmenterGobbler);
        interrupt(stdoutTranscoderGobbler);
        interrupt(stderrTranscoderGobbler);

        if (transcoderProcess != null)
        {
            try
            {
                int val = transcoderProcess.exitValue();
                Log.debug("SegmenterProcess: process finished with exit value " + val);
            }
            catch (IllegalThreadStateException e)
            {
                // process has not terminated
                Log.debug("SegmenterProcess: stop transcoder process");
                OutputStream os = transcoderProcess.getOutputStream();
                OutputStreamWriter osw = new OutputStreamWriter(os);
                
                try
                {
                    // try to safely kill the process
                    osw.append('q');
                    osw.flush();
                    osw.close();
                    try
                    {
                        Thread.interrupted();
                        Thread.sleep(500);
                    }
                    catch (InterruptedException e1)
                    {
                        Log.info(e1.getMessage());
                        Log.ignore(e1);
                    }
                    int val = transcoderProcess.exitValue();
                    Log.debug("SegmenterProcess: process stopped with 'q' command.  Exit value " + val);
                }
                catch (IllegalThreadStateException e2)
                {
                    destroyProcess(transcoderProcess);
                    Log.debug("SegmenterProcess: process forcibly terminated due to IllegalThreadStateException");
                }
                catch (IOException e3)
                {
                    destroyProcess(transcoderProcess);
                    Log.debug("SegmenterProcess: process forcibly terminated due to IOException");
                }
//                    catch (InterruptedException e4)
//                    {
//                        proc.destroy();
//                        System.out.println("SegmenterProcess: process forcibly terminated due to InterruptedException");
//                    }
                catch (Throwable t)
                {
                    destroyProcess(transcoderProcess);
                    Log.info("SegmenterProcess: process forcibly terminated due to unexpected exception: " + t.getMessage());
                    Log.ignore(t);
                }
            }
        }

        Log.debug("SegmenterProcess: stop segmenter process");
        if (segmenterProcess != null)
        {
            destroyProcess(segmenterProcess);
        }
        
        if (segmentInputStream != null)
        {
            try
            {
                Log.debug("SegmenterProcess: close segmenter input stream");
                segmentInputStream.close();
            }
            catch (IOException e)
            {
                // ignore
            }
        }

        // reset variables
        transcoderProcess  = null;
        segmenterProcess   = null;
        segmentInputStream = null;

        stdinTranscoder         = null;
        stdoutTranscoderGobbler = null;
        stderrTranscoderGobbler = null;
        stdoutSegmenterGobbler  = null;
        stderrSegmenterGobbler  = null;
    }

    /**
     * Utility function to catch any unexpected exception and prevent calling code from exiting prematurely
     */
    private void interrupt(StreamGobbler gobbler)
    {
        if (gobbler != null)
        {
            try
            {
                gobbler.interrupt();
            }
            catch (Throwable t)
            {
                Log.info(t.getMessage());
                Log.ignore(t);
            }
        }
    }

    /**
     * Utility function to catch any unexpected exception and prevent calling code from exiting prematurely
     */
    private void destroyProcess(Process p)
    {
        if (p != null)
        {
            try
            {
                p.destroy();
            }
            catch (Throwable t)
            {
                Log.info(t.getMessage());
                Log.ignore(t);
            }
        }
    }
    
    public long getNextSegmentLength()
    {
        segmentInputStream.fillNextSegment();
        return segmentInputStream.getSegmentLength();
    }
    
    // TODO throw custom exception
    public void streamNextSegment(OutputStream os) throws Exception
    {
        if (isCurrentlyRecording)
        {
            // TODO move to getNextSegmentLength
            Object mediaFile = MediaFileAPI.GetMediaFileForFilePath(inputFile);
            isCurrentlyRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);

            if (isCurrentlyRecording)
            {
                Log.debug("inputFile " + inputFile.getName() + " is still recording");
            }
            else
            {
                Log.debug("inputFile " + inputFile.getName() + " has finished recording.  Sending message to transcoder");
                stdinTranscoder.write(RECORDING_STOPPED.getBytes("US-ASCII"));
                stdinTranscoder.flush();
            }
        }


        try
        {
            stdoutSegmenterGobbler = new StreamGobbler("segmenter stdout", segmentInputStream, os, false);
//            stdoutSegmenterGobbler.setUncaughtExceptionHandler(this);
            Future<?> stdoutFuture = threadPool.submit(stdoutSegmenterGobbler);
            stdoutFuture.get(); // wait for the gobbler to exit
        }
        catch (InterruptedException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
            stopProcess();
            throw new Exception(e);
        }
        catch (CancellationException e)
        {
            Log.info(e.getMessage());
            Log.ignore(e);
            stopProcess();
            throw new Exception(e);
        }
        catch (ExecutionException e)
        {
            // StreamGobbler threw an exception in its call() method
            // logging is handled in StreamGobbler
            stopProcess();
            throw new Exception(e);
        }
        finally
        {
            try
            {
                if (segmenterProcess == null)
                {
                    Log.debug("segmenterProcess has been closed and set to null by a call to stopProcess");
                }
                else
                {
                    int exitValue = segmenterProcess.exitValue();
                    segmenterProcess = null;
                    Log.debug("streamNextSegment segmenterProcess exited with value " + exitValue);
                    Log.debug("Killing transcoder process");
                    stopProcess();
                    // TODO not necessarily
                    throw new Exception("SegmenterProcess: segmenter unexpectedly exited");
                }
            }
            catch (IllegalThreadStateException e)
            {
                Log.debug("streamNextSegment segmenterProcess is still running");
            }
        }
    }
    
    /**
     * Destroys the ffmpeg processes if the output gobbler encounters an exception
     */
    public void uncaughtException(Thread arg0, Throwable arg1)
    {
        stopProcess();
    }

    private ProcessBuilder getTranscodeProcessBuilder(File inputFile, String userAgent, String quality, double startTime)
    {
//        Object mediaFile = MediaFileAPI.GetMediaFileForFilePath(inputFile);
//        String aspect = MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Video.Aspect");
//        String framerate = MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Video.FPS");
//        Integer numAudioStreams = Integer.parseInt(MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Audio.NumStreams"));
//
//        Log.debug("numAudioStreams " + numAudioStreams);
//
//        for (int i = 0; i < numAudioStreams; i++)
//        {
//            Integer streamIndex = Integer.parseInt(MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Audio." + i + ".Index"));
//            Log.debug("Audio Stream " + i + ", Index = " + streamIndex);
//        }
        
        Map<String, String[]> qualityMap = new HashMap<String, String[]>();

        Log.debug("SegmenterProcess: userAgent " + userAgent);
        
        // TODO improve useragent detection, quality settings, and don't hard-code settings
        // TODO TN2224 for qualities, different for iPad vs iPhone/iPod touch
        if (userAgent.contains("iPad") ||
                 userAgent.matches("Apple Mac OS X .* CoreMedia .*") || // Mac desktop Safari video element
                 userAgent.matches("QuickTime.*") || // Windows desktop Safari video element
                 userAgent.matches(".*AppleWebKit.* Version.* Safari.*")) // Desktop Safari browser
        {
            // 16:9
            String[] s1 = {"960x720", "1792k", "1940k", "29.97", "48k", "44100", "90"};
            String[] s2 = {"960x720", "1192k", "1340k", "29.97", "48k", "44100", "90"};
            String[] s3 = {"480x320", "792k",  "940k", "29.97", "48k", "44100", "90"};
            String[] s4 = {"480x320", "592k",  "740k", "29.97", "48k", "44100", "90"};
            String[] s5 = {"480x320", "392k",  "540k", "29.97", "48k", "44100", "60"};
            String[] s6 = {"480x320", "192k",  "340k", "15.0", "48k", "44100", "45"};
            String[] s7 = {"480x320", "102k",  "250k", "10.0", "48k", "44100", "30"};
            //String[] s8 = {"480x320", "",  "", "", "40k", "44100", ""}; // Audio only stream...

            qualityMap = new HashMap<String, String[]>();
            qualityMap.put("1840", s1);
            qualityMap.put("1240", s2);
            qualityMap.put("840", s3);
            qualityMap.put("640", s4);
            qualityMap.put("440", s5);
            qualityMap.put("240", s6);
            qualityMap.put("150", s7);
            //qualityMap.put("0", s8);
        }
        else { // No longer denies the others
                // 16:9
                String[] s1 = {"640x360", "1792k", "1940k", "29.97", "48k", "44100", "90"};
                String[] s2 = {"640x360", "1192k", "1340k", "29.97", "48k", "44100", "90"};
                String[] s3 = {"480x272", "792k", "940k", "29.97", "48k", "44100", "90"};
                String[] s4 = {"480x272", "592k", "740k", "29.97", "48k", "44100", "90"};
                String[] s5 = {"480x272", "392k", "540k", "29.97", "48k", "44100", "60"};
                String[] s6 = {"480x272", "192k", "340k", "15.0", "48k", "44100", "45"};
                String[] s7 = {"480x272", "102k", "250k", "10.0", "48k", "44100", "30"};
                //String[] s8 = {"480x320", "",  "", "", "40k", "44100", ""};  // Audio only stream...

                qualityMap = new HashMap<String, String[]>();
                qualityMap.put("1840", s1);
                qualityMap.put("1240", s2);
                qualityMap.put("840", s3);
                qualityMap.put("640", s4);
                qualityMap.put("440", s5);
                qualityMap.put("240", s6);
                qualityMap.put("150", s7);
                //qualityMap.put("0", s8);
            }
        String[] currentQuality = qualityMap.get(quality);
        
        if (currentQuality == null)
        {
            throw new IllegalArgumentException("Invalid quality argument: " + quality);
        }
        
        ProcessBuilder pb = new ProcessBuilder();
        pb.command(getTranscoderParams(inputFile, startTime, currentQuality));
        return pb;
    }

    private ProcessBuilder getSegmenterProcessBuilder(long sequence)
    {
        ProcessBuilder pb = new ProcessBuilder();
        pb.command(segmenterFile.getPath(),
                   SEGMENTER_PARAM,
                   Integer.toString(SegmentPlaylist.TARGET_DURATION),
                   Long.toString(sequence));
        return pb;
    }
    
    private List<String> getTranscoderParams(File inputFile, double startTime, String[] currentQuality)
    {
        List<String> params = new ArrayList<String>();
        
        Object mediaFile = MediaFileAPI.GetMediaFileForFilePath(inputFile);
        String aspect = MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Video.Aspect");
        if ((aspect == null) || (aspect.trim().length() == 0))
        {
            aspect = null;
            String videoWidth = MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Video.Width");
            String videoHeight = MediaFileAPI.GetMediaFileMetadata(mediaFile, "Format.Video.Height");

            if ((videoWidth != null) && (videoWidth.trim().length() != 0) &&
                (videoHeight != null) && (videoHeight.trim().length() != 0))
            {
                try
                {
                    Double widthDouble = Double.valueOf(videoWidth);
                    Double heightDouble = Double.valueOf(videoHeight);
                    aspect = Double.toString(widthDouble / heightDouble);
                }
                catch (NumberFormatException e)
                {
                    Log.info(e.getMessage());
                    Log.ignore(e);
                }
            }

        }
        isCurrentlyRecording = MediaFileAPI.IsFileCurrentlyRecording(mediaFile);
        
        String cmd = transcoderFile.getAbsolutePath();
        
        params.add(cmd);
        if (isCurrentlyRecording)
        {
            params.add("-activefile");
            params.add("-stdinctrl");
        }
        params.add("-threads"); params.add(Integer.toString(Runtime.getRuntime().availableProcessors()));//"4",
        params.add("-flags2"); params.add("+fast");
        params.add("-flags"); params.add("+loop");
        params.add("-g"); params.add(currentQuality[6]);
        params.add("-keyint_min"); params.add("1");
        params.add("-bf"); params.add("0");
        params.add("-b_strategy"); params.add("0");
        params.add("-flags2");
        params.add("-wpred-dct8x8");
        params.add("-cmp"); params.add("+chroma");
        params.add("-deblockalpha"); params.add("0");
        params.add("-deblockbeta"); params.add("0");
        params.add("-refs"); params.add("1");
        params.add("-coder"); params.add("0");
        params.add("-me_range"); params.add("16");
        params.add("-subq"); params.add("5");
        params.add("-partitions"); params.add("+parti4x4+parti8x8+partp8x8");
        params.add("-trellis"); params.add("0");
        params.add("-sc_threshold"); params.add("40");
        params.add("-i_qfactor"); params.add("0.71");
        params.add("-qcomp"); params.add("0.6");
//            "-map", "0.0:0.0",
//            "-map", "0.1:0.1",
//            "-map", "0.1:0.0",
//            "-map", "0.0:0.1",
        params.add("-ss"); params.add(Double.toString(startTime));
        params.add("-i"); params.add(inputFile.getAbsolutePath());
//            "-cropleft", "0",
//            "-cropright", "0",
//            "-croptop", "0",
//            "-cropbottom", "0",
        params.add("-s"); params.add(currentQuality[0]);
        if (aspect != null)
        {
            params.add("-aspect"); params.add(aspect);
        }
        params.add("-y");
        params.add("-f"); params.add("mpegts");
        params.add("-async"); params.add("1");
        params.add("-vcodec"); params.add("libx264");
        params.add("-level"); params.add("30");
        params.add("-bufsize"); params.add("4M"); //params.add("512k");
        params.add("-b"); params.add(currentQuality[1]);
        params.add("-bt"); params.add(currentQuality[2]);
        params.add("-qmax"); params.add("48");
        params.add("-qmin"); params.add("2");
        params.add("-r"); params.add(currentQuality[3]); // Could further adapt to 24/25/50 Hz
        //params.add("29.97"); // 25
//        "-acodec", "libmp3lame",
        params.add("-vol"); params.add("1024");
        params.add("-acodec"); params.add("libfaac");
        params.add("-ab"); params.add(currentQuality[4]);
        params.add("-ar"); params.add(currentQuality[5]);
        params.add("-ac"); params.add("2");
        params.add("-");
        
        return params;
    }
    
    private double sequenceToStartTime(long sequence)
    {
        return sequence * SegmentPlaylist.TARGET_DURATION;
    }
    
    public static void main(String[] args) throws IOException
    {
        setTranscoderProcessLocation(new File("bin/linux32/ffmpeg"));
        //File f = new File("/home/jreichen/Seinfeld-TheSoupNazi-9012674-0.mp4");
        File fin = new File("/home/jreichen/Seinfeld-TheSoupNazi-9012674-0.mpegts");
        File fout = new File("/home/jreichen/segmenter.mpegts");
        System.out.println(transcoderFile.getAbsolutePath());

        //SegmenterProcess sp = new SegmenterProcess();
        //ProcessBuilder pb = sp.getTranscodeProcessBuilder(f, "iPhone", "512", 0.0);

        FileInputStream fis = null;
        FileOutputStream fos = null;
        fout.delete();
        try
        {
            fis = new FileInputStream(fin);
            fos = new FileOutputStream(fout);
//            sp.startProcess(transcodeProcess.getInputStream(), ffos, null);

//            sp.startProcess(fis, fos, null);
        }
        finally
        {
            fis.close();
            fos.close();
        }
    }
}
