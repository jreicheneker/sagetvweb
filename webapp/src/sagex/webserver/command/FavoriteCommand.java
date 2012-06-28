package sagex.webserver.command;

import java.io.File;
import java.lang.reflect.InvocationTargetException;

import sage.SageTV;

public abstract class FavoriteCommand extends AbstractCommand
{
    private static final String ID_PARAM = "FavoriteId";
    private static final String CATEGORY_PARAM = "Category";
    private static final String TITLE_PARAM = "Title";
    private static final String KEYWORD_PARAM = "Keyword";
    private static final String PERSON_PARAM = "Person";
    private static final String RUN_PARAM = "Run";
    private static final String CHANNELID_PARAM = "ChannelId";
    private static final String AUTODELETE_PARAM = "AutoDelete";
    private static final String KEEPATMOST_PARAM = "KeepAtMost";
    private static final String STARTPADDING_PARAM = "StartPadding";
    private static final String STARTPADDINGOFFSETTYPE_PARAM = "StartPaddingOffsetType";
    private static final String STOPPADDING_PARAM = "StopPadding";
    private static final String STOPPADDINGOFFSETTYPE_PARAM = "StopPaddingOffsetType";
    private static final String QUALITY_PARAM = "Quality";
    private static final String AUTOCONVERT_PARAM = "AutoConvert";
    private static final String FORMAT_PARAM = "Format";
    private static final String DELETEORIGINAL_PARAM = "DeleteOriginal";
    private static final String FOLDER_PARAM = "Folder";
    private static final String DESTFOLDER_PARAM = "DestinationFolder";
    private static final String PARENTALRATING_PARAM = "ParentalRating";
    private static final String MOVIERATING_PARAM = "MovieRating";
    private static final String DAY_PARAM = "Day";
    private static final String TIME_PARAM = "Time";
    private static final String FAVORITEPRIORITYRELATION_PARAM = "FavoritePriorityRelation";
    private static final String RELATIVEFAVORITEID_PARAM = "RelativeFavoriteId";

    @Override
    public final void doCommand() throws Exception
    {
        String stringId = getParameter(ID_PARAM);
        String category = getParameter(CATEGORY_PARAM); // only editable on new favorite in v4 stv
        String subCategory = getParameter("subcategory"); // not in v4 stv
        String keyword = getParameter(KEYWORD_PARAM);
        String person = getParameter(PERSON_PARAM); // only editable on new favorite in v4 stv
        String roleForPerson = getParameter("roleforperson"); // not in v4 stv
        String title = getParameter(TITLE_PARAM); // only editable on new favorite in v4 stv
        String run = getParameter(RUN_PARAM);
        String[] channelIDs = getParameterValues(CHANNELID_PARAM);
        String network = getParameter("network"); // not in v4 stv
        String autoDelete = getParameter(AUTODELETE_PARAM);
        String keepAtMost = getParameter(KEEPATMOST_PARAM);
        String startPad = getParameter(STARTPADDING_PARAM);
        String startPadOffsetType = getParameter(STARTPADDINGOFFSETTYPE_PARAM);
        String endPad = getParameter(STOPPADDING_PARAM);
        String endPadOffsetType = getParameter(STOPPADDINGOFFSETTYPE_PARAM);
        String quality = getParameter(QUALITY_PARAM);
        String autoConvert = getParameter(AUTOCONVERT_PARAM);
        boolean isDeleteAfterFavoriteAutomaticConversion = "yes".equals(getParameter(DELETEORIGINAL_PARAM));
        String favoriteAutomaticConversionFormat = getParameter(FORMAT_PARAM);
        boolean isFavoriteAutomaticConversionDestinationOriginalDir = "Original".equals(getParameter(FOLDER_PARAM));
        String favoriteAutomaticConversionDestination = getParameter(DESTFOLDER_PARAM);
        String parentalRating = getParameter(PARENTALRATING_PARAM);
        String rated = getParameter(MOVIERATING_PARAM);
        String year = getParameter("year"); // not in v4 stv
        String day = getParameter(DAY_PARAM);
        String time = getParameter(TIME_PARAM);
        String favoritePriorityRelation = getParameter(FAVORITEPRIORITYRELATION_PARAM);
        String relativeFavoriteId = getParameter(RELATIVEFAVORITEID_PARAM);

        Boolean firstRunsOnly = new Boolean("First Runs".equals(run));
        Boolean reRunsOnly = new Boolean("ReRuns".equals(run));

        StringBuilder callsigns = new StringBuilder();
        if (channelIDs != null)// && (channelID.trim().length() != 0))
        {
            for (int i = 0; i < channelIDs.length; i++)
            {
                String channelID = channelIDs[i];
                if ((channelID != null) && (channelID.trim().length() > 0))
                {
                    try
                    {
                        Integer channelInt = new Integer(channelID);
                        Object channel = SageTV.api("GetChannelForStationID", new Object[] {channelInt});
                        if (channel == null)
                        {
                            throw new IllegalArgumentException("Unknown channel for parameter: channelID='" + channelID + "'.");
                        }
                        String callsign = (String) SageTV.api("GetChannelName", new Object[] {channel});
                        if (i > 0)
                        {
                            callsigns.append(";");
                        }
                        callsigns.append(callsign);
                    }
                    catch (NumberFormatException e)
                    {
                        throw new IllegalArgumentException("Invalid command parameter: channelID='" + channelID + "'.");
                    }
                }
            }
        }
        
        if ((title    == null || title.length()    == 0) &&
            (category == null || category.length() == 0) &&
            (person   == null || person.length()   == 0) &&
            (keyword  == null || keyword.length()  == 0))
        {
            throw new IllegalArgumentException("Must specify one of title, category, person or keyword");
        }

        Object sageFavorite = null;
        if /*(id != -1)*/ ((stringId != null) && (stringId.trim().length() > 0))
        {
            sageFavorite = SageTV.api("GetFavoriteForID", new Object[] {new Integer(stringId)});
        }

        boolean isAutomaticConversionSupported = true;
        try
        {
            SageTV.api("GetFavoriteAutomaticConversionFormat", new Object[] {sageFavorite});
        }
        catch (InvocationTargetException e)
        {
            isAutomaticConversionSupported = false;
        }

        if (isAutomaticConversionSupported &&
            !isFavoriteAutomaticConversionDestinationOriginalDir &&
            favoriteAutomaticConversionDestination == null)
        {
            throw new IllegalArgumentException("Must specify conversion destination folder");
        }

        sageFavorite = doFavoriteCommand(sageFavorite, title,
                firstRunsOnly, reRunsOnly, category, subCategory, person, roleForPerson, rated,
                year, parentalRating, network, callsigns.toString(), day, time, keyword);

        int id = (Integer) SageTV.api("GetFavoriteID", new Object[] {sageFavorite});

        //Favorite favorite = new Favorite(sageFavorite);
        if (favoritePriorityRelation != null && 
            !favoritePriorityRelation.equals("default") &&
            relativeFavoriteId != null &&
            relativeFavoriteId.length() > 0)
        {
            // set favorite priority
            if (favoritePriorityRelation.equals("Above"))
            {
                // set above
                createFavoritePriority(id, Integer.parseInt(relativeFavoriteId), true);
            }
            else if (favoritePriorityRelation.equals("Below"))
            {
                // set below
                createFavoritePriority(Integer.parseInt(relativeFavoriteId), id, false);
            }
        }
        //
        // The following are not parameters to the above API's
        //

        // set start padding
        long startPadLong = Long.parseLong(startPad) * 60000;
        if (startPadOffsetType.equals("Later"))
        {
            startPadLong = -startPadLong;
        }
        SageTV.api("SetStartPadding", new Object[] {sageFavorite, new Long(startPadLong)});

        // set end padding
        long endPadLong = Long.parseLong(endPad) * 60000;
        if (endPadOffsetType.equals("Earlier"))
        {
            endPadLong = -endPadLong;
        }
        SageTV.api("SetStopPadding", new Object[] {sageFavorite, new Long(endPadLong)});

        // set autodelete
        boolean autoDeleteBoolean = new Boolean(autoDelete).booleanValue();
        SageTV.api("SetDontAutodelete", new Object[] {sageFavorite, new Boolean(!autoDeleteBoolean)});

        // set keepatmost
        int keepAtMostInteger = new Integer(keepAtMost).intValue();
        SageTV.api("SetKeepAtMost", new Object[] {sageFavorite, new Integer(keepAtMostInteger)});

         // set quality
        SageTV.api("SetFavoriteQuality", new Object[] {sageFavorite, quality});
        
        // save auto conversion settings
        if (isAutomaticConversionSupported)
        {
            boolean isAutoConvert = new Boolean(autoConvert).booleanValue();
            if (isAutoConvert && (favoriteAutomaticConversionFormat != null) && (favoriteAutomaticConversionFormat.trim().length() > 0))
            {
                // automatically convert
                SageTV.api("SetFavoriteAutomaticConversionFormat", new Object[] {sageFavorite, favoriteAutomaticConversionFormat});
                SageTV.api("SetDeleteAfterAutomaticConversion", new Object[] {sageFavorite, isDeleteAfterFavoriteAutomaticConversion});
                if (isFavoriteAutomaticConversionDestinationOriginalDir)
                {
                    SageTV.api("SetFavoriteAutomaticConversionDestination", new Object[] {sageFavorite, null});
                }
                else
                {
                    SageTV.api("SetFavoriteAutomaticConversionDestination", new Object[] {sageFavorite, favoriteAutomaticConversionDestination});
                }
                
                // Set 'transcoder/last' properties
                SageTV.api("SetProperty", new Object[] {"transcoder/last_replace_choice", (isDeleteAfterFavoriteAutomaticConversion?"xKeepOnlyConversion":"xKeepBoth")});
                String[] formatArr=favoriteAutomaticConversionFormat.split("-", 2);
                SageTV.api("SetProperty", new Object[] {"transcoder/last_format_name", formatArr[0]});
                SageTV.api("SetProperty", new Object[] {"transcoder/last_format_quality/" + formatArr[0], favoriteAutomaticConversionFormat});
                if (isFavoriteAutomaticConversionDestinationOriginalDir)
                {
                    SageTV.api("SetProperty", new Object[] {"transcoder/last_dest_dir", null});
                }
                else
                {
                    File destDir = new File(favoriteAutomaticConversionDestination);
                    SageTV.api("SetProperty", new Object[] {"transcoder/last_dest_dir", destDir.getAbsolutePath()});
                }
            }
            else
            {
                // don't automatically convert
                SageTV.api("SetFavoriteAutomaticConversionFormat", new Object[] {sageFavorite, ""});
                SageTV.api("SetDeleteAfterAutomaticConversion", new Object[] {sageFavorite, Boolean.FALSE});
            }
        }
    }

    protected abstract Object doFavoriteCommand(Object sageFavorite, String title,
            boolean firstRunsOnly, boolean reRunsOnly, String category, String subCategory,
            String person, String roleForPerson, String rated, String year,
            String parentalRating, String network, String callsign, String day, String time,
            String keyword) throws InvocationTargetException;

    protected String getTimeslot(String day, String time)
    {
        String timeslot = "";
        day = (day == null) ? "" : day.trim();
        time = (time == null) ? "" : time.trim();

        /*if ((!day.equals("")) && (!Arrays.asList(DAYS).contains(day))) {
            throw new IllegalArgumentException("Invalid value for day parameter: '" + day + "'.");
        }

        if ((!time.equals("")) && 
            (!Arrays.asList(TIMES_AM_PM).contains(time)) &&
            (!Arrays.asList(TIMES_24).contains(time))) {
            throw new IllegalArgumentException("Invalid value for time parameter: '" + time + "'.");
        }*/

        if ((day.length() > 0) && (time.length() > 0))
        {
            timeslot = day + " " + time;
        }
        else if (day.length() > 0)
        {
            timeslot = day;
        }
        else if (time.length() > 0)
        {
            timeslot = time;
        }

        return timeslot;
    }

    /** Swap the priority of consecutive favorites */
    public static void createFavoritePriority(Object higherPriorityFavorite, Object lowerPriorityFavorite) throws Exception
    {
        SageTV.api("CreateFavoritePriority", new Object[] {higherPriorityFavorite, lowerPriorityFavorite});
    }

    /** Move a favorite above or below another favorite.  They do not have to be consecutive favorites. */
    private void createFavoritePriority(int higherPriorityFavoriteID, int lowerPriorityFavoriteID, boolean moveHigherPriorityFavorite) throws Exception
    {
        if (higherPriorityFavoriteID == lowerPriorityFavoriteID)
        {
            throw new IllegalArgumentException("Higher priority favorite is equal to lower priority favorite.");
        }

        int higherPriorityFavoriteIndex = 0;
        int lowerPriorityFavoriteIndex  = 0;

        Object favoritesList = SageTV.api("GetFavorites", null);
        favoritesList = SageTV.api("Sort", new Object[] {favoritesList, Boolean.FALSE, "FavoritePriority"}); // sort ascending

        // find the index of both favorites
        int size = (Integer) SageTV.api("Size", new Object[] {favoritesList});
        for (int i = 0; i < size; i++)
        {
            int currentFavoriteID = (Integer) SageTV.api("GetFavoriteID", new Object[] {SageTV.api("GetElement", new Object[] {favoritesList, i})});
            if (higherPriorityFavoriteID == currentFavoriteID)
            {
                higherPriorityFavoriteIndex = i;
            }
            if (lowerPriorityFavoriteID == currentFavoriteID)
            {
                lowerPriorityFavoriteIndex = i;
            }
        }

        // return if the favorites are already in the desired position
        if ((higherPriorityFavoriteIndex - lowerPriorityFavoriteIndex) == -1)  // higher priority has lower index
        {
            return;
        }

        /*
         * Case 1                    Case 2                  Case 3                    Case 4
         * Not inverted              Inverted                Not inverted              Inverted
         * 0                         0                       0                         0
         * 1 HP - move this down 2   1 LP                    1 LP - move this down 3   1 HP
         * 2                         2                       2                         2
         * 3                         3                       3                         3
         * 4 LP                      4 HP - move this up 3   4 HP                      4 LP - move this up 2
         * 5                         5                       5                         5
         */
        if (moveHigherPriorityFavorite)
        {
            Object higherPriorityFavorite = SageTV.api("GetFavoriteForID", new Object[] {higherPriorityFavoriteID});

            if (higherPriorityFavoriteIndex < lowerPriorityFavoriteIndex) // not inverted
            {
                // Case 1
                for (int i = higherPriorityFavoriteIndex + 1; i < lowerPriorityFavoriteIndex; i++)
                {
                    Object currentFavorite = SageTV.api("GetElement", new Object[] {favoritesList, i});
    
                    // move one position lower
                    createFavoritePriority(currentFavorite, higherPriorityFavorite);
                }
            }
            else // inverted (must decrement loop counter)
            {
                // Case 2
                for (int i = higherPriorityFavoriteIndex - 1; i >= lowerPriorityFavoriteIndex; i--)
                {
                    Object currentFavorite = SageTV.api("GetElement", new Object[] {favoritesList, i});
    
                    // move one position higher
                    createFavoritePriority(higherPriorityFavorite, currentFavorite);
                }
            }
        }
        else // move lower priority favorite
        {
            Object lowerPriorityFavorite = SageTV.api("GetFavoriteForID", new Object[] {lowerPriorityFavoriteID});

            if (higherPriorityFavoriteIndex > lowerPriorityFavoriteIndex) // not inverted
            {
                // Case 3
                for (int i = lowerPriorityFavoriteIndex + 1; i <= higherPriorityFavoriteIndex; i++)
                {
                    Object currentFavorite = SageTV.api("GetElement", new Object[] {favoritesList, i});
    
                    // move one position lower
                    createFavoritePriority(currentFavorite, lowerPriorityFavorite);
                }
            }
            else // inverted (must decrement loop counter)
            {
                // Case 4
                for (int i = lowerPriorityFavoriteIndex - 1; i > higherPriorityFavoriteIndex; i--)
                {
                    Object currentFavorite = SageTV.api("GetElement", new Object[] {favoritesList, i});
    
                    // move one position higher
                    createFavoritePriority(lowerPriorityFavorite, currentFavorite);
                }
            }
        }
    }
}
