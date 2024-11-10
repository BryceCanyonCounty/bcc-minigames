exports('initiate', function()
    local MinigameAPI = {}

    MinigameAPI.Start = MiniGame.start
    MinigameAPI.Stop = MiniGame.stop
    MinigameAPI.Trigger = MiniGame.trigger
    
    return MinigameAPI
end)