QBCore = exports['qb-core']:GetCoreObject()

-- Server-side event to handle the revival request
RegisterServerEvent('qb-npcdoctor:server:RequestRevive')
AddEventHandler('qb-npcdoctor:server:RequestRevive', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    -- Check if the player can afford the service
    local cost = 10 -- Define the cost of the revive
    if xPlayer.Functions.RemoveMoney('cash', cost) then
        TriggerClientEvent('qb-npcdoctor:client:Revive', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money to pay for the service.', 'error')
    end
end)




