local AntiCheatName = Config.Anticheatname -- DONT TOUCH

RegisterCommand(Config.RecordCommand, function(source, args)
    local playerSource, recordTime

    source = source

    if source ~= 0 then
        if IsPlayerAceAllowed(source, Config.RecordCommandAce) then
            playerSource = tonumber(args[1])
            recordTime = tonumber(args[2]) * 1000
        else
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

    source = source

    if source ~= 0 then
        if IsPlayerAceAllowed(source, Config.ScreenCommandAce) then
            playerSource = tonumber(args[1])
        else
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

