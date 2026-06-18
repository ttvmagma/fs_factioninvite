local ESX = exports["es_extended"]:getSharedObject()
local pendingInvites = {}

RegisterCommand(CONFIG.SETTINGS.COMMAND, function(source, args, rawCommand)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if not xPlayer then
        return Notify(src, "error", "Spieler nicht gefunden!")
    end

    local xPlayerJob = xPlayer.getJob()
    local xPlayerGrade = xPlayerJob.grade
    
    if xPlayerGrade ~= CONFIG.SETTINGS.BOSS_RANK[xPlayerJob.name] then
        return Notify(src, "error", "Du hast keine Berechtigung, Fraktionseinladungen zu senden! (Benötigt Rank: " .. CONFIG.SETTINGS.BOSS_RANK[xPlayerJob.name] .. ")")
    end

    if #args < 1 then
        return Notify(src, "error", "Benötigt wird: /" .. CONFIG.SETTINGS.COMMAND .. " [Spieler ID]")
    end

    local targetId = tonumber(args[1])

    if not targetId or targetId < 1 or targetId > 9999 then
        return Notify(src, "error", "Ungültige Spieler ID")
    end

    local tPlayer = ESX.GetPlayerFromId(targetId)
    
    if not tPlayer then
        return Notify(src, "error", "Spieler mit ID " .. targetId .. " nicht gefunden!")
    end

    if CONFIG.SETTINGS.CHECK_CURRENT_JOB then
        local targetPlayerJob = tPlayer.getJob()
        
        if targetPlayerJob.name ~= "unemployed" then
            return Notify(src, "error", "Der Spieler hat bereits einen Job: " .. targetPlayerJob.name)
        end
    end

    pendingInvites[targetId] = {
        fromId = src,
        job = xPlayerJob.name,
        label = xPlayerJob.label,
    }

    TriggerClientEvent('fs_factioninvite:openUI', targetId, pendingInvites[targetId])

    Notify(src, "info", "Du hast dem Spieler " .. tPlayer.getName() .. " eine Einladung zur Fraktion " .. xPlayerJob.label .. " gesendet!")
end, false)

RegisterNetEvent('fs_factioninvite:handleInvite', function(data)
    local src = source
    local invite = pendingInvites[src]
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return Notify(src, "error", "Spieler nicht gefunden!")
    end

    if not invite then
        return
    end

    if data.type == "accept" then
        if xPlayer then
            xPlayer.setJob(invite.job, CONFIG.SETTINGS.START_GRADE)
            
            Notify(src, "success", "Du hast die Einladung zur Fraktion " .. invite.label .. " angenommen!")
            Notify(invite.fromId, "info", "Der Spieler " .. xPlayer.getName() .. " hat deine Einladung zur Fraktion " .. invite.label .. " angenommen!")
        end
    elseif data.type == "decline" then
        Notify(src, "error", "Du hast die Einladung zur Fraktion " .. invite.label .. " abgelehnt!")
        Notify(invite.fromId, "info", "Der Spieler " .. xPlayer.getName() .. " hat deine Einladung zur Fraktion " .. invite.label .. " abgelehnt!")
    end

    pendingInvites[src] = nil
end)

AddEventHandler('playerDropped', function()
    local src = source
    if not pendingInvites[src] then
        return
    end

    pendingInvites[src] = nil
end)

AddEventHandler('esx:onPlayerDeath', function()
    local src = source
    if not pendingInvites[src] then
        return
    end

    pendingInvites[src] = nil
end)