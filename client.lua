local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)
        Citizen.Wait(10)
    end
end)

local fireDuration = 30
local isBurning = nil

RegisterNetEvent("selander_ignite:startFire")
AddEventHandler("selander_ignite:startFire", function()
    if isBurning == nil then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if not IsPedInAnyVehicle(playerPed, false) then
            RequestAnimDict("random@domestic")
            while not HasAnimDictLoaded("random@domestic") do
              Wait(1)
            end
            TaskPlayAnim(playerPed,"random@domestic","pickup_low", 8.0, 0.0, 1300, 41, 0, 0, 0, 0)
            Citizen.Wait(1300)
            StopAnimTask(playerPed,"random@domestic","pickup_low", 8.0, 0.0, 1300, 41, 0, 0, 0, 0)

            theFire = StartScriptFire(playerCoords.x, playerCoords.y, playerCoords.z - 1, 10, false)
            isBurning = true
            fireDuration = 30
            Citizen.CreateThread(function()
                while isBurning do
                    Citizen.Wait(1000)

                    fireDuration = fireDuration - 1
                
                    if fireDuration == 0 then
                        isBurning = nil
                        RemoveScriptFire(theFire)
                    end
                
                end
            end)
        else
            exports['mythic_notify']:DoLongHudText('inform', 'You can´t do that in a vehicle')
        end
    else
        exports['mythic_notify']:DoLongHudText('inform', 'Your thumb still hurts from starting the last fire')
    end
end)