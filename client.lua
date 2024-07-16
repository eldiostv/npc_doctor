QBCore = exports['qb-core']:GetCoreObject()

local doctorPeds = {
    {model = 's_m_m_doctor_01', coords = vector3(300.0, -580.0, 42.2), heading = 90.0},
    -- Add more doctor NPCs here if needed
}

-- Spawn doctor NPCs
CreateThread(function()
    for i, pedInfo in ipairs(doctorPeds) do
        RequestModel(GetHashKey(pedInfo.model))
        while not HasModelLoaded(GetHashKey(pedInfo.model)) do
            Wait(1)
        end
        local ped = CreatePed(4, GetHashKey(pedInfo.model), pedInfo.coords.x, pedInfo.coords.y, pedInfo.coords.z, pedInfo.heading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'revive',
                icon = 'fas fa-user-md',
                label = 'Get Revived',
                onSelect = function()
                    TriggerServerEvent('qb-npcdoctor:server:RequestRevive')
                end
            }
        })
    end
end)

-- Client-side event to handle the revival process
RegisterNetEvent('qb-npcdoctor:client:Revive')
AddEventHandler('qb-npcdoctor:client:Revive', function()
    TriggerEvent("ars_ambulancejob:healPlayer", {revive = true})
    QBCore.Functions.Notify('You have been revived by the doctor.')
end)





