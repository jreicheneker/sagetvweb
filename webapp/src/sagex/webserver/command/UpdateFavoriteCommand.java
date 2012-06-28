package sagex.webserver.command;

import java.lang.reflect.InvocationTargetException;

import sage.SageTV;

public class UpdateFavoriteCommand extends FavoriteCommand
{
    @Override
    protected Object doFavoriteCommand(Object sageFavorite, String title,
            boolean firstRunsOnly, boolean reRunsOnly, String category, String subCategory,
            String person, String roleForPerson, String rated, String year,
            String parentalRating, String network, String callsign, String day, String time,
            String keyword) throws InvocationTargetException
    {
        SageTV.api(getName(), new Object[] {sageFavorite, title,
                firstRunsOnly, reRunsOnly, category, subCategory, person, roleForPerson, rated,
                year, parentalRating, network, callsign, getTimeslot(day, time), keyword});
        return sageFavorite;
    }
}
