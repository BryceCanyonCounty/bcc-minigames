MiniGame = {}

MiniGame.start = function(minigame, config, callback)
    MiniGame.callback = callback
    MiniGame.config = config
    MiniGame.game = minigame

    SendNUIMessage({
        action = 'start',
        game = minigame,
        config = config
    })

    if config.focus ~= nil or config.cursor ~= nil then
        local cursor = false
        local focus = true

        if config.cursor then
            cursor = true
        end

        if config.focus == false then
            focus = false
        end
        SetNuiFocus(focus, cursor)
    end
end

MiniGame.stop = function()
    SendNUIMessage({
        action = 'stop'
    })
end


RegisterNUICallback('result', function(data, cb)
    cb('ok')

    if MiniGame.config.focus ~= nil or MiniGame.config.cursor ~= nil then
        SetNuiFocus(false, false)
    end

    if MiniGame.callback then
        MiniGame.callback(data)
    end
end)


-- RegisterCommand('playgame', function(args, rawCommand)
--     local cfg = {
--         focus = true, -- Should minigame take nui focus (required)
--         cursor = true, -- Should minigame have cursor  (required)
--         nails = 15, -- How many nails to be hammered
--         type = 'dark-wood' -- What color wood to display (light-wood, medium-wood, dark-wood)
--     }

--     exports['progressBars']:startUI(10000, 'TESTING THE PROGBAR CHANGES')

--     MiniGame.start('hammertime', cfg, function(result)
--         print("Done!", result.result) -- true/false
--     end)
-- end)