local ESX = nil

Citizen.SetTimeout(CONFIG.SETTINGS["LOADDELAY"], function()
    while not NetworkIsSessionStarted() do
        Citizen.Wait(100)
    end

    while not NetworkIsSessionActive() do
        Citizen.Wait(100)
    end

    while not ESX do 
        ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(500)
    end

    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('fs_factioninvite:openUI', function(data)
    SetNuiFocus(true, true)
    SendToNUI('ToggleUI',
        data
    )
end)

function SendToNUI(action, data)
    SendNUIMessage({
        action = action,
        data = data, 
    })
end