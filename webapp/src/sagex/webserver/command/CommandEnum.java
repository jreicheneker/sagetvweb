package sagex.webserver.command;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import sage.SageTV;

// TODO translate description
public enum CommandEnum
{
    SET_DONT_LIKE                   (false, "SetDontLike",               "Set Don't Like Flag", SetDontLikeCommand.class),
    SET_WATCHED                     (false, "SetWatched",                "Set Watched Flag", SetWatchedCommand.class),
    CLEAR_DONT_LIKE                 (false, "ClearDontLike",             "Clear Don't Like Flag", ClearDontLikeCommand.class),
    CLEAR_WATCHED                   (false, "ClearWatched",              "Clear Watched Flag", ClearWatchedCommand.class),
    DELETE_FILE                     (true,  "DeleteFile",                "Delete File", DeleteFileCommand.class),
    RECORDING_ERROR                 (true,  "RecordingError",            "Delete File - Wrong Recording", RecordingErrorCommand.class),
    WATCH_NOW                       (false, "WatchNow",                  "Watch Now", WatchNowCommand.class),
    ARCHIVE                         (false, "Archive",                   "Set Archived Flag", SetArchivedCommand.class),
    UNARCHIVE                       (false, "Unarchive",                 "ClearArchived Flag", ClearArchivedCommand.class),
    SET_MANUAL_RECORDING_STATUS     (false, "SetManRecStatus",           "Set Manual Record Status", SetManualCommand.class),
    REMOVE_MANUAL_RECORDING_STATUS  (false, "RemoveManRecStatus",        "Clear Manual Record Status", ClearManualCommand.class),
    CONVERT                         (false, "Convert",                   "Convert Media File", ConvertCommand.class),
    RECORD                          (false, "Record",                    "Record", RecordCommand.class),
    RECORD_AND_CONFIRM              (false, "RecordAndConfirm",          "Confirm Manual Record over Favorite", RecordAndConfirmCommand.class),
    CANCEL_RECORD                   (false, "CancelRecord",              "Cancel Recording", CancelRecordCommand.class),
    SET_RECORDING_PADDING           (false, "SetRecPad",                 "Set Recording Padding", SetRecordingPaddingCommand.class),
    SET_RECORDING_QUALITY           (false, "SetRecQual",                "Set Recording Quality", SetRecordingQualityCommand.class),
    CLEAR_ALL_COMPLETED_CONVERSIONS (false, "ClearCompletedConversions", "Clear Completed Conversions", ClearCompletedConversionsCommand.class),
    CANCEL_CONVERSION               (false, "CancelConversion",          "Cancel Conversion", CancelConversionCommand.class),
    ADD_FAVORITE                    (false, "AddFavorite",               "Add Favorite", AddFavoriteCommand.class),
    REMOVE_FAVORITE                 (true,  "RemoveFavorite",            "Remove Favorite", RemoveFavoriteCommand.class),
    UPDATE_FAVORITE                 (false, "UpdateFavorite",            "Update Favorite", UpdateFavoriteCommand.class),
    CREATE_FAVORITE_PRIORITY        (false, "CreateFavoritePriority",    "Creaate Favorite Priority", CreateFavoritePriorityCommand.class),
    CREATE_TIMED_RECORDING          (false, "CreateTimedRecording",      "Create Timed Recording", CreateTimedRecordingCommand.class),
    FORCE_EPG_UPDATE                (false, "ForceEpgUpdate",            "Force Epg Update", ForceEpgUpdateCommand.class),
    DELETE_SYSTEM_MESSAGE           (false, "DeleteSystemMessage",       "Delete System Message", DeleteSystemMessageCommand.class),
    DELETE_ALL_SYSTEM_MESSAGES      (false, "DeleteAllSystemMessages",   "Delete All System Messages", DeleteAllSystemMessagesCommand.class),
    RESET_ALERT_LEVEL               (false, "ResetSystemAlertLevel",     "Reset Alert Level", ResetAlertLevelCommand.class),
    SET_LATEST_WATCHED_TIME         (false, "SetLatestWatchedTime",      "Set Latest Watched Time", SetLatestWatchedTimeCommand.class),
    //RESOLVE_CONFLICT                ("ResolveConflict",           "Resolve Conflict", ResolveConflictCommand.class),
    RENAME_UI_CONTEXT               (false, "RenameUiContext",           "Rename UI Context", RenameUiContextCommand.class),
    SAGE_COMMAND                    (false, null,                        null, SageCommand.class);
    //ENCODE

    /**
     * 
     */
    private static List<String>              sageCommands; 

    /**
     * 
     */
    private boolean                          confirmationRequired;

    /**
     * 
     */
    private String                           commandName;

    /**
     * 
     */
    private String                           commandDesc;

    /**
     * 
     */
    private Class<? extends AbstractCommand> commandClass;

    static
    {
        try
        {
            sageCommands = (List<String>) SageTV.api("GetSageCommandNames", null);
        }
        catch (InvocationTargetException e)
        {
            e.printStackTrace();
        }
    }

    private CommandEnum(boolean confirmationRequired,
                        String commandName,
                        String commandDesc,
                        Class<? extends AbstractCommand> commandClass)
    {
        this.confirmationRequired = confirmationRequired;
        this.commandName          = commandName;
        this.commandDesc          = commandDesc;
        this.commandClass         = commandClass;
    }

    public static CommandEnum getEnumFromCommandName(String commandName)
    {
        for (CommandEnum commandEnum : CommandEnum.values())
        {
            if (commandEnum == SAGE_COMMAND)
            {
                if (sageCommands.contains(commandName))
                {
                    return SAGE_COMMAND;
                }
                else
                {
                    return null;
                }
            }

            if (commandEnum.getCommandName().equals(commandName))
            {
                return commandEnum;
            }
        }

        return null;
    }

    public static CommandEnum getEnumFromClass(Class<? extends AbstractCommand> commandClass)
    {
        for (CommandEnum commandEnum : CommandEnum.values())
        {
            if (commandEnum.commandClass == commandClass)
            {
                return commandEnum;
            }
        }
        return null;
    }

    public AbstractCommand newCommand()
    {
        AbstractCommand command = null;
        try
        {
            command = commandClass.newInstance();
        }
        catch (Exception e)
        {
            // should never happen because this class controls which
            // classes can be instantiated
            e.printStackTrace();
        }

        return command;
    }

    public boolean isConfirmationRequired()
    {
        return confirmationRequired;
    }

    public String getCommandName()
    {
        return commandName;
    }

    public String getCommandDesc()
    {
        return commandDesc;
    }
}
