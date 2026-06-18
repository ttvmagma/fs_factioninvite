RegisterNUICallback("faction/ready", function(data, cb)
    cb({
        layout = CONFIG.SETTINGS["LAYOUT"],
    })
end)

RegisterNUICallback("faction/invite", function(data, cb)
    TriggerServerEvent('fs_factioninvite:handleInvite', data)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback("faction/closeUI", function(_, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)