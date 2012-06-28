package sagex.webserver.command;

public class ResolveConflictCommand extends AbstractCommand
{
//    private static final String IGNORE_THIS_CONFLICT = ;
//always ignore conflicts
//cancel manual recording of other
//override favorite recording
//force recording
//cancel favorite recording
//always override this favorite
//cancel manual recording of this

    @Override
    public void doCommand() throws Exception
    {
        //Object result = SageApi.Api(getName(), getSageObject());
/*
        // 1. xIGNORE - "IGNORE this conflict"
        if (??)
            for each in conflictingmanuals
                ConfirmManualRecordOverFavoritePriority
        return to conflicts
        // 2. xIGNOREFAVE - "ALWAYS IGNORE conflicts between these favorites"
        if (??)
            for each in conflictingfavorites
                CreateFavoritePriority
        return to conflicts
        // 3. "CANCEL Manual Recording of<br/>${conflictingManualFmt}"
        if (??)
            CancelRecord
        // 4. xOVERRIDEFAVE - 
        //         <%-- Only one conflicting fave, override and acknowledge --%>
        //            <b>OVERRIDE</b> Favorite recording of<br/>${conflictingSingleFavoriteFmt}
        GetElement
        Record
        ConfirmManualRecordOverFavoritePriority
        CancelRecord
        Ask to transfer padding
        //         <%-- Many conflicting faves, list Force option --%>
        //            <b>FORCE</b> recording of this show<br/>(this will cause other conflicts)
        Record
        Ask to transfer padding
        // 4.5. "CANCEL Favorite Recording of<br/>${conflictingSingleFavoriteFmt}"
        if (??)
            Record
            ConfirmManualRecordOverFavoritePriority
            CancelRecord
            Ask to transfer padding
        // 5. xFAVEPRIO - 
        //   <c:if test="${conflictingFavoritesSize == 1}">
        //         <b>ALWAYS OVERRIDE</b> and record this favorite instead of<br/>Favorite: ${favoriteDescription}
        CreateFavoritePriority
        Return to favorites
        //   <c:if test="${conflictingFavoritesSize != 1}">
        //         Adjust Favorite Priorities
        Show favorites, maybe filter by affected favorites
        // 6. xCANCELMR - "CANCEL Manual Recording of<br/>${airingFmt}"
        CancelRecord
        return to conflicts
*/
    }
}
