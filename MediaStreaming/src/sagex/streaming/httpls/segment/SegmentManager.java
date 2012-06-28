package sagex.streaming.httpls.segment;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import org.mortbay.log.Log;

/**
 * Keeps track of the current state for a conversion id.
 * Calling code should always do so within a block that synchronizes
 * on this object.  If it also calls SegmentProducer and needs to hold locks on
 * both objects, it should acquire the lock on this first to avoid deadlock.
 */
public class SegmentManager
{
    private Map<String, SegmentProducer> segmentProducerMap = new LinkedHashMap<String, SegmentProducer>();
    private List<String> oldSegmentProducerList = new ArrayList<String>();
    // TODO determine when the last segment has been sent
    private Timer timer = null;

    public void addSegmentProducer(String conversionId, SegmentProducer segmentProducer)
    {
        if (oldSegmentProducerList.contains(conversionId))
        {
            Log.warn("SegmentManager.addSegmentProducer() Conversion Id is being reused.");
        }
        
        if (segmentProducerMap.containsKey(conversionId))
        {
            throw new IllegalArgumentException("Conversion id " + conversionId + " already exists");
        }

        segmentProducerMap.put(conversionId, segmentProducer);
        
        if (timer == null)
        {
            timer = new Timer("ffmpeg cleanup timer");
            timer.schedule(new CleanupTask(), 5 * 60 * 1000, 1 * 60 * 1000);
        }
    }
    
    public SegmentProducer getSegmentProducer(String conversionId)
    {
        if (oldSegmentProducerList.contains(conversionId))
        {
            Log.warn("SegmentManager.getSegmentProducer() Conversion Id is being reused.");
        }

        SegmentProducer segmentProducer = segmentProducerMap.get(conversionId);

        return segmentProducer;
    }

    public List<SegmentProducer> getSegmentProducers()
    {
        List<SegmentProducer> segmentProducers = new ArrayList<SegmentProducer>();
        segmentProducers.addAll(segmentProducerMap.values());
        return segmentProducers;
    }

    public SegmentProducer removeSegmentProducer(String conversionId)
    {
        SegmentProducer segmentProducer = getSegmentProducer(conversionId);
        
        if (segmentProducer != null)
        {
            oldSegmentProducerList.add(conversionId);
            segmentProducerMap.remove(conversionId);
            
            if ((timer != null) && (segmentProducerMap.size() == 0))
            {
                timer.cancel();
                timer = null;
            }
        }
        
        return segmentProducer;
    }

    public List<SegmentProducer> removeSegmentProducers()
    {
        if (timer != null)
        {
            timer.cancel();
            timer = null;
        }

        List<SegmentProducer> segmentProducers = getSegmentProducers();
        oldSegmentProducerList.addAll(segmentProducerMap.keySet());
        segmentProducerMap.clear();
        return segmentProducers;
    }

    /**
     * Clean up any ffmpeg processes that have been inactive for a certain amount of time
     */
    private class CleanupTask extends TimerTask
    {
        @Override
        public void run()
        {
            synchronized (SegmentManager.this)
            {
                long now = System.currentTimeMillis();
                
                Iterator<Map.Entry<String, SegmentProducer>> mapIterator = segmentProducerMap.entrySet().iterator();

                while (mapIterator.hasNext())
                {
                    Map.Entry<String, SegmentProducer> currentEntry = mapIterator.next();
                    SegmentProducer currentSegmentProducer = currentEntry.getValue();

                    synchronized (currentSegmentProducer)
                    {
                        if (now - currentSegmentProducer.getLastActivity() > 5 * 60 * 1000) // 5 minutes
                        {
                            Log.debug("Segment Producer has been inactive for " + (now - currentSegmentProducer.getLastActivity()) / 1000 + " seconds.  Removing producer.");
                            try
                            {
                                currentSegmentProducer.stop();
                            }
                            catch (Throwable t)
                            {
                                Log.info(t.getMessage());
                                Log.ignore(t);
                            }
                            Log.debug("Map size before remove: " + segmentProducerMap.size());
                            oldSegmentProducerList.add(currentEntry.getKey());
                            mapIterator.remove();
                            Log.debug("Map size after remove: " + segmentProducerMap.size());
                        }
                        else
                        {
                            Log.debug("Segment Producer has been inactive for " + (now - currentSegmentProducer.getLastActivity()) / 1000 + " seconds");
                        }
                    }
                }
                
                if ((timer != null) && (segmentProducerMap.size() == 0))
                {
                    timer.cancel();
                    timer = null;
                }
            }
        }
    }
}
