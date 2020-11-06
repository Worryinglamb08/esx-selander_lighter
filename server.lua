ESX = nil  
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("lighter",function(source)
    local _source = source
    TriggerClientEvent("selander_ignite:startFire", source)
end)