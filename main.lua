local AntiCheatName = Config.Anticheatname -- DONT TOUCH

ESX = exports['es_extended']:getSharedObject()

RegisterCommand(Config.RecordCommand, function(source, args)
    local playerSource, recordTime
    local xPlayer = ESX.GetPlayerFromId(source)

    source = source

    local allowedGroups = Config.AllowedGroups

    if source ~= 0 then
        local playerGroup = xPlayer.getGroup()
        local hasPermission = false

        for _, group in pairs(allowedGroups) do
            if playerGroup == group then
                hasPermission = true
                break
            end
        end

        if hasPermission then
            playerSource = tonumber(args[1])
            recordTime = tonumber(args[2]) * 1000
        else
            console("Du hast keine Berechtigung dafür")
            return
        end
    elseif source == 0 then
        if args[2] == nil or args[1] and args[2] == nil then
            console("No player or wrong command:^3 " .. Config.RecordCommand .. " ^0[ID] [Time in Sec]")
            return
        else
            playerSource = tonumber(args[1])
            recordTime = tonumber(args[2]) * 1000
        end
    end

    local function screenRecordHandler(url)
        if url then
            console("Screen recording successful!", url)
        else
            console("Script Error!")
        end
    end

    if playerSource and recordTime then
        AntiCheatName:recordPlayerScreen(playerSource, recordTime, screenRecordHandler)
    end
end)

RegisterCommand(Config.ScreenCommand, function(source, args)
    local playerSource
    local xPlayer = ESX.GetPlayerFromId(source)
    
    source = source

    local allowedGroups = Config.AllowedGroups

    if source ~= 0 then
        local playerGroup = xPlayer.getGroup()
        local hasPermission = false

        for _, group in pairs(allowedGroups) do
            if playerGroup == group then
                hasPermission = true
                break
            end
        end

        if hasPermission then
            playerSource = tonumber(args[1])
        else
            console("Du hast keine Berechtigung dafür")
            return
        end
    elseif source == 0 then
        if args[1] == nil then
            console("No player or wrong command:^3 " .. Config.ScreenCommand .. " ^0[ID]")
            return
        else
            playerSource = tonumber(args[1])
        end
    end

    local function screenshotHandler(url)
        if url then
            console("Screenshot successfully created!", url)
        else
            console("Script Error!")
        end
    end

    if playerSource then
        AntiCheatName:screenshotPlayer(playerSource, screenshotHandler)
    end
end)

function console(msg, url)
    if url == nil then
        print("^5[FG_ADDON]^1 " .. msg .. "^0")
    elseif msg == nil and url == nil then
        print("^5[FG_ADDON]^1 ERROR^0")
    else
        print("^5[FG_ADDON]^0 " .. msg .. "^3[" .. url .. "]^0")
    end
end

