-- Simple gun jamming script for, everytime you shoot there is a slight chance your gun will game, requiring you to press R to unjam it

local jamChance = Config.JamChance or 0.01
local unjamKey = Config.UnjamKey or 184
local UnjamKeyLetter = Config.UnjamKeyLetter or "E"

local isJammed = false

local ped = PlayerPedId()

local isHoldingGun = IsPedArmed(ped, 4)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsPedArmed(ped, 4) then 
            -- Nothing
        else
            -- print("Ped is not armed, pausing for 500 ms then will check again.")
            Wait(500)
        end

        if IsPedShooting(ped) and not isJammed then
            if math.random() < jamChance then
                isJammed = true
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    args = {'GunJam','Your gun has jammed! Press ' .. UnjamKeyLetter .. ' to unjam.' }
                })
            end
        end

        if isJammed then
            DisablePlayerFiring(ped, true)
            if IsControlJustReleased(0, unjamKey) then
                isJammed = false
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    args = {'GunJam','You have unjammed your gun.' }
                })
            end
        end
    end
end)