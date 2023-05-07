local function getUtils ()
    local UtilAPI = {}

    UtilAPI.Start = StartMinigame
    
    return UtilAPI
end

exports('initiate',function()
    return getUtils()
end)