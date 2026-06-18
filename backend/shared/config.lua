CONFIG = {}

CONFIG.SETTINGS = {
    ["LOADDELAY"] = 2500,

    ["LAYOUT"] = {
        ["accept"] = "Accept",
        ["decline"] = "Decline",
        ["description"] = "Do you want to join the faction?",
    },

    ["COMMAND"] = "factioninvite",

    ["BOSS_RANK"] = {
        ["police"] = 4,
        ["ambulance"] = 4,
    },

    ["CHECK_CURRENT_JOB"] = true, -- check if the target player already has a job before sending the invite

    ["START_GRADE"] = 0,    -- the grade the player will start with when accepting the invite
}

function Notify(src, type, title, message)
    TriggerClientEvent("echo_hud:notify", src, type, title, message, 5000)
end