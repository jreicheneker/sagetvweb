package sagex.webserver.command;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mortbay.log.Log;

import sage.SageTV;

public abstract class AbstractCommand
{
    private String name = CommandEnum.getEnumFromClass(this.getClass()).getCommandName();
    private String context;
    private List<Object> sageObjectList;
    private Object sageObject;
    private Map<String, String[]> params;
    private String redirect;

    // possible url parameter keys
    protected static final String AIRINGID_KEY       = "AiringId";
    protected static final String MEDIAFILEID_KEY    = "MediaFileId";
    protected static final String FAVORITEID_KEY     = "FavoriteId";
    protected static final String JOBID_KEY          = "JobId";
    protected static final String QUALITY_KEY        = "Quality";
    protected static final String FILENAME_KEY       = "FileName";
    protected static final String SYSTEM_MESSAGE_KEY = "SystemMessage";

    public final void run() throws Exception
    {
        createObjects();

        doBeforeCommand();

        if (getSageObjectList().size() == 0)
        {
            doCommand();
        }
        else
        {
            for (Object sageObject : getSageObjectList())
            {
                setSageObject(sageObject);
                doCommand();
            }
        }

        doAfterCommand();
    }

    public void doBeforeCommand() throws Exception {}

    public void doCommand() throws Exception
    {
        sage.SageTV.api(getName(), new Object[] {getSageObject()});
    }

    public void doAfterCommand() throws Exception {}

    public String getName()
    {
        return name;
    }

    public final String getContext()
    {
        return context;
    }

    private final void setContext(String context)
    {
        this.context = context;
    }

    public Object getSageObject()
    {
        return sageObject;
    }

    private void setSageObject(Object sageObject)
    {
        this.sageObject = sageObject;
    }

    public Map<String, String[]> getParameters()
    {
        return params;
    }

    public void setParameters(Map<String, String[]> params)
    {
        this.params = params;

        String[] contextValues = params.get("context");
        if ((contextValues != null) && (contextValues.length > 0))
        {
            setContext(contextValues[0]);
        }
    }

    public String getParameter(String param)
    {
        String[] parameterValues = params.get(param);

        if ((parameterValues != null) && (parameterValues.length > 0))
        {
            return parameterValues[0];
        }

        return null;
    }

    public String[] getParameterValues(String param)
    {
        return params.get(param);
    }

    /*public SageObjectTypeEnum getObjectTypes()
    {
        return null;
    }*/

    public String getRedirect()
    {
        return redirect;
    }

    protected void setRedirect(String redirect)
    {
        this.redirect = redirect;
    }

    public List<Object> getSageObjectList()
    {
        return sageObjectList;
    }

    private void createObjects() throws Exception
    {
        //List<Object> airingList = new ArrayList<Object>();
        sageObjectList = new ArrayList<Object>();
        String currType = "";
    
        currType = AIRINGID_KEY;
        String[] airingIds = getParameterValues(currType);
        if (airingIds != null)
        {
            for (String airingId : airingIds)
            {   
                Object sageAiring = SageTV.api("GetAiringForID", new Object[] {airingId});
                sageObjectList.add(sageAiring);
            }
        }
    
        currType = MEDIAFILEID_KEY;
        String [] mediaFileIds = getParameterValues(currType);
        if (mediaFileIds != null)
        {
            for (String mediaFileId : mediaFileIds)
            {
                // groups could have multiple ids in the form field value
                String[] splitIds = mediaFileId.split(",");
                for (String splitId : splitIds)
                {
                    if ((splitId != null) && (splitId.trim().length() > 0))
                    {
                        Object sageMediaFile = SageTV.api("GetMediaFileForID", new Object[] {splitId});
                        sageObjectList.add(sageMediaFile);
                    }
                }
            }
        }
    
        currType = FAVORITEID_KEY;
        String[] favoriteIds = getParameterValues(currType);
        if (favoriteIds != null)
        {
            for (String favoriteId : favoriteIds)
            {
                if (favoriteId.trim().length() > 0)
                {
                    Object sageFavorite = SageTV.api("GetFavoriteForID", new Object[] {favoriteId});
                    sageObjectList.add(sageFavorite);
                }
            }
        }

        currType = JOBID_KEY;
        String [] jobIds = getParameterValues(currType);
        if (jobIds != null)
        {
            for (String jobId : jobIds)
            {
                Object jobIdInteger = new Integer(jobId);
                sageObjectList.add(jobIdInteger);
            }
        }
    
        currType = QUALITY_KEY;
        // TODO
    
        currType = FILENAME_KEY;
        String[] filenames = getParameterValues(currType);
        if (filenames != null)
        {
            for (String filename : filenames)
            {
                Object sageMediaFile = SageTV.api("GetMediaFileForFilePath", new Object[] {new File(filename)});
                sageObjectList.add(sageMediaFile);
            }
        }

        currType = SYSTEM_MESSAGE_KEY;
        String[] systemMessageStrings = getParameterValues(currType);
        if (systemMessageStrings != null)
        {
            // messages don't have ids, use level, code, and time that seems to be unique
            Map<String, Object> systemMessageMap = new HashMap<String, Object>();
            Object[] systemMessages = (Object[]) SageTV.api("GetSystemMessages", null);
            
            for (Object systemMessage : systemMessages)
            {
                Integer messageLevel = (Integer) SageTV.api("GetSystemMessageLevel", new Object[] {systemMessage});
                Long messageTime = (Long) SageTV.api("GetSystemMessageTime", new Object[] {systemMessage});
                Integer messageTypeCode = (Integer) SageTV.api("GetSystemMessageTypeCode", new Object[] {systemMessage});
             
                systemMessageMap.put(messageLevel.intValue() + "-" + messageTypeCode.intValue() + "-" + messageTime.longValue(), systemMessage);
            }
            
            for (String systemMessageString : systemMessageStrings)
            {
                sageObjectList.add(systemMessageMap.get(systemMessageString));
            }
        }

        sageObjectList = Collections.unmodifiableList(sageObjectList);
    }

    protected String[] getUIContextNames() throws Exception
    {
        String[] allContexts = null;
        String[] uiContexts = new String[] {};
        String[] clients = new String[] {};

        try
        {
            uiContexts = (String[]) SageTV.api("GetUIContextNames", null);
            clients = (String[]) SageTV.api("GetConnectedClients", null);
            if ((uiContexts.length > 0) || (clients.length > 0))
            {
                allContexts = new String[uiContexts.length + clients.length];
            }
            if (uiContexts.length > 0)
            {
                System.arraycopy(uiContexts, 0, allContexts, 0, uiContexts.length);
            }
            if (clients.length > 0)
            {
                System.arraycopy(clients, 0, allContexts, uiContexts.length, clients.length);
            }
        }
        catch (InvocationTargetException e)
        {
            String msg = e.getTargetException().getMessage();
            if (msg == null)
            {
                msg = e.getMessage();
            }
            Log.info(msg);
            Log.ignore(e);
            throw new Exception(msg);
        }

        return allContexts;
    }
}
