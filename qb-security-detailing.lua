-- qb-security-detailing.lua
-- Security Detailing Job for QBCore Framework

local QBCore = exports['qb-core']:GetCoreObject()

-- Config for the Security Job
Config = {
    JobName = 'security',  -- Name of the Job
    NPCs = {  -- NPCs that can give the player the security job
        { x = 247.2, y = -880.5, z = 30.5, name = "Officer Tom" },  -- Example NPC coordinates
        { x = -1215.5, y = -330.8, z = 37.8, name = "Mrs. Kline" },  -- Another NPC for job offers
    },
    PatrolPoints = {  -- Points where security can patrol
        vector3(350.0, -1050.0, 30.0),
        vector3(500.0, -2000.0, 25.0),
        vector3(-1500.0, 1200.0, 60.0)
    },
    SecurityVehicles = { "police", "securityvan" },  -- The security vehicle model (can be customized)
    AlarmLocations = {  -- Locations where alarms may go off
        vector3(200.0, -500.0, 40.0),
        vector3(-1000.0, -1500.0, 30.0)
    }
}

-- Job Check (Making sure player has the correct job)
QBCore.Functions.CreateCallback('qb-security-detailing:checkJob', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player and Player.Job.name == Config.JobName then
        cb(true)
    else
        cb(false)
    end
end)

-- Create NPCs that give security job
Citizen.CreateThread(function()
    for _, npc in ipairs(Config.NPCs) do
        RequestModel("s_m_m_security_01")
        while not HasModelLoaded("s_m_m_security_01") do
            Wait(500)
        end

        local npcPed = CreatePed(4, "s_m_m_security_01", npc.x, npc.y, npc.z, 0.0, false, true)
        SetEntityInvincible(npcPed, true)
        FreezeEntityPosition(npcPed, true)

        -- Display Job Interaction
        exports['qb-target']:AddTargetEntity(npcPed, {
            options = {
                {
                    event = "qb-security-detailing:startJob",
                    icon = "fas fa-shield-alt",
                    label = "Start Security Detail Job",
                    job = "security",
                }
            },
            distance = 2.0
        })
    end
end)

-- Start Security Detail Job
RegisterNetEvent('qb-security-detailing:startJob', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local ped = GetPlayerPed(source)

    -- Check if player already has a job
    if Player and Player.Job.name ~= Config.JobName then
        TriggerClientEvent('QBCore:Notify', source, "You must be in the security job to accept this task.", 'error')
        return
    end

    -- Choose a patrol route for the player
    local randomPatrol = Config.PatrolPoints[math.random(1, #Config.PatrolPoints)]
    TriggerClientEvent('qb-security-detailing:startPatrol', source, randomPatrol)

    TriggerClientEvent('QBCore:Notify', source, "You have been assigned a security detail. Head to the designated area.", 'success')
end)

-- Security patrol and incident response
RegisterCommand('patrol', function(source, args, rawCommand)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player and Player.Job.name == Config.JobName then
        -- Trigger patrol mission
        local patrolPoint = Config.PatrolPoints[math.random(1, #Config.PatrolPoints)]
        TriggerClientEvent('qb-security-detailing:patrolArea', source, patrolPoint)
    else
        TriggerClientEvent('QBCore:Notify', source, "You must be in the security job to patrol.", 'error')
    end
end)

-- Responding to security alarm
RegisterCommand('respondalarm', function(source, args, rawCommand)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player and Player.Job.name == Config.JobName then
        -- Trigger random alarm at a location
        local alarmLocation = Config.AlarmLocations[math.random(1, #Config.AlarmLocations)]
        TriggerClientEvent('qb-security-detailing:triggerAlarm', source, alarmLocation)
    else
        TriggerClientEvent('QBCore:Notify', source, "You must be in the security job to respond to alarms.", 'error')
    end
end)

-- Handling Security Incident and Alarms
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)  -- Check for any incidents every 5 seconds
        
        -- Randomly trigger an alarm
        if math.random(1, 100) <= 10 then  -- 10% chance of an alarm
            local alarmLocation = Config.AlarmLocations[math.random(1, #Config.AlarmLocations)]
            TriggerClientEvent('qb-security-detailing:triggerAlarm', -1, alarmLocation)
        end
    end
end)
