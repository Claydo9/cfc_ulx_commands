local commandArgumentIndexes = {
    ["ulx timegag"] = {
        targets = 2,
        duration = 3,
        reason = 4,
        dontWarnOnEmptyReason = true
    },
    ["ulx timemute"] = {
        targets = 2,
        duration = 3,
        reason = 4
    },
    ["ulx pvpban"] = {
        targets = 2,
        duration = 3,
        reason = 4
    },
    ["ulx ban"] = {
        target = 2,
        duration = 3,
        reason = 4
    },
    ["ulx banid"] = {
        targetId = 2,
        duration = 3,
        reason = 4
    }
}

hook.Add( "ULibPostTranslatedCommand", "CFC_AutoWarn_WarnOnCommands", function( caller, commandName, args )
    local indexes = commandArgumentIndexes[commandName]
    if not indexes then return end

    local duration = args[indexes.duration]
    local reason = args[indexes.reason]
    local minDuration = indexes.minDuration
    
    if indexes.dontWarnOnEmptyReason then 
        if not reason or reason == "" then return end
    end

    local targets
    if indexes.targets then
        targets = args[indexes.targets]
    elseif indexes.target then
        targets = { args[indexes.target] }
    elseif indexes.targetId then
        local targetId = args[indexes.targetId] 

        local command = string.format( 'awarn_warn "%s" "%s (%s %s)"', targetId, reason, commandName, ULib.secondsToStringTime( duration * 60 ) )
        caller:ConCommand( command )

        return
    end

    for _, target in pairs( targets ) do
        local command = string.format( 'awarn_warn "%s" "%s (%s %s)"', target:SteamID(), reason, commandName, ULib.secondsToStringTime( duration * 60 ) )
        caller:ConCommand( command )
    end
end )
