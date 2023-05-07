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
--         focus = true,
--         cursor = true,
--         maxattempts = 3,
--         threshold = 10,
--         hintdelay = 500, --milliseconds
--         stages = {
--             {
--                 deg = 25 -- 0-360
--             },
--             {
--                 deg = 0
--             },
--             {
--                 deg = 300
--             }
--         }
        
--     }


--     MiniGame.start('lockpick', cfg, function(result)
--         print("Unlocked?", result.unlocked)
--     end)
-- end)

-- RegisterCommand('playgame', function(args, rawCommand)
--     local cfg = {
--         focus = true,
--         maxattempts = 3,
--         type = 'bar',
--         userandomkey = true,
--         keytopress = 'B',
--         keycode = 66,
--         speed = 20,
--         strict = false
--     }


--     MiniGame.start('skillcheck', cfg, function(result)
--         print("Passed?", result.passed)
--     end)
-- end)

-- RegisterCommand('playgame', function(args, rawCommand)
--     local cfg = {
--         focus = true,
--         cursor = true,
--         allowretry = false
--     }


--     MiniGame.start('rps', cfg, function(result)
--         print("Result?", result.result)
--     end)
-- end)