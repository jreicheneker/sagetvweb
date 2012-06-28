package sagex.webserver.command;

import sage.SageTV;

/**
 * Move one favorite's priority above another's.
 */
public class CreateFavoritePriorityCommand extends AbstractCommand
{
    @Override
    public void doCommand() throws Exception
    {
        String higherFavoriteId = getParameter("higherFavoriteId");
        String lowerFavoriteId = getParameter("lowerFavoriteId");

        if (higherFavoriteId == null)
        {
            throw new IllegalArgumentException("HigherFavorite is null");
        }

        if (lowerFavoriteId == null)
        {
            throw new IllegalArgumentException("LowerFavorite is null");
        }

        Object higherSageFavorite = SageTV.api("GetFavoriteForID", new Object[] {new Integer(higherFavoriteId)});
        Object lowerSageFavorite = SageTV.api("GetFavoriteForID", new Object[] {new Integer(lowerFavoriteId)});

        SageTV.api(getName(), new Object[] {higherSageFavorite, lowerSageFavorite});
    }
}
