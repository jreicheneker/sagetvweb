package sagex.webserver.command;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import sage.SageTV;

public class RecordAndConfirmCommand extends AbstractRecordCommand
{
    private Object sageObject = null;
    private List<Object> sageObjectList = null;
    private Object sageFavoriteObject = null;

    @Override
    public void doCommand() throws Exception
    {
        String[] uiContexts = getUIContextNames();

        if ((uiContexts == null) || (uiContexts.length == 0))
        {
            SageTV.api("Record", new Object[] {getSageObject()});
        }
        else  
        {
            SageTV.apiUI(uiContexts[0], "Record", new Object[] {getSageObject()});
        }

        SageTV.api("ConfirmManualRecordOverFavoritePriority", new Object[] {getSageObject(), getSageFavoriteObject()});

        Thread.sleep(100);
    }

    @Override
    public void doAfterCommand() throws Exception
    {
        sageObject = null;
        sageObjectList = null;
        sageFavoriteObject = null;
    }

    @Override
    public void doBeforeCommand() throws Exception
    {
        sageObjectList = new ArrayList<Object>();

        String airingId = getParameter("AiringId");
        if (airingId == null)
        {
            throw new IllegalArgumentException("Airing Id is required");
        }

        sageObject = SageTV.api("GetAiringForID", new Object[] {new Integer(airingId)});
        sageObjectList.add(sageObject);

        String favoriteId = getParameter("FavoriteId");
        if (favoriteId == null)
        {
            throw new IllegalArgumentException("Favorite Id is required");
        }

        sageFavoriteObject = SageTV.api("GetFavoriteForID", new Object[] {new Integer(favoriteId)});

        sageObjectList = Collections.unmodifiableList(sageObjectList);
    }

    /**
     * AiringId and FavoriteId are valid parameters, but only the 
     * airing object should be considered the "Sage Object" for
     * this class.
     */
    @Override
    public Object getSageObject()
    {
        return sageObject;
    }

    @Override
    public List<Object> getSageObjectList()
    {
        return sageObjectList;
    }

    public Object getSageFavoriteObject()
    {
        return sageFavoriteObject;
    }
}
