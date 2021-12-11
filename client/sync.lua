local isRequestAnim = false
local requestedemote = ''

Citizen.CreateThread(function()
    TriggerEvent("esx:getSharedObject", function(obj)   ESX = obj   end)
end)

RegisterNetEvent("SyncPlayEmote")
AddEventHandler("SyncPlayEmote", function(emote, player)
    EmoteCancel()
    Wait(300)
    -- wait a little to make sure animation shows up right on both clients after canceling any previous emote
    if hEmote.Shared[emote] ~= nil then
      if OnEmotePlay(hEmote.Shared[emote]) then end return
    elseif hEmote.Dances[emote] ~= nil then
      if OnEmotePlay(hEmote.Dances[emote]) then end return
    end
end)

RegisterNetEvent("SyncPlayEmoteSource")
AddEventHandler("SyncPlayEmoteSource", function(emote, player)
    -- Thx to Poggu for this part!
    local pedInFront = GetPlayerPed(GetClosestPlayer())
    local heading = GetEntityHeading(pedInFront)
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, 1.0, 0.0)
    if (hEmote.Shared[emote]) and (hEmote.Shared[emote].AnimationOptions) then
      local SyncOffsetFront = hEmote.Shared[emote].AnimationOptions.SyncOffsetFront
      if SyncOffsetFront then
          coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, SyncOffsetFront, 0.0)
      end
    end
    SetEntityHeading(PlayerPedId(), heading - 180.1)
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
    EmoteCancel()
    Wait(300)
    if hEmote.Shared[emote] ~= nil then
      if OnEmotePlay(hEmote.Shared[emote]) then end return
    elseif hEmote.Dances[emote] ~= nil then
      if OnEmotePlay(hEmote.Dances[emote]) then end return
    end
end)

RegisterNetEvent("ClientEmoteRequestReceive")
AddEventHandler("ClientEmoteRequestReceive", function(emotename, etype)
    isRequestAnim = true

    RequestAnim(emotename)
    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    SimpleNotify("<C>Animations</C>\n~y~Y~w~ pour accepter, ~r~L~w~ pour refuser (~g~"..hEmote.Shared[emotename][3].."~w~)")
end)


RequestAnim = function(requestedemote)
    isRequestAnim = true
    Citizen.SetTimeout(15000, function()
        isRequestAnim = false
    end)
    while isRequestAnim do
        if IsControlJustPressed(1, 246) then
            target, distance = ESX.Game.GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                if hEmote.Shared[requestedemote] ~= nil then
                    _,_,_,otheremote = table.unpack(hEmote.Shared[requestedemote])
                elseif hEmote.Dances[requestedemote] ~= nil then
                    _,_,_,otheremote = table.unpack(hEmote.Dances[requestedemote])
                end
                if otheremote == nil then otheremote = requestedemote end
                TriggerServerEvent("ServerValidEmote", GetPlayerServerId(target), requestedemote, otheremote)
                isRequestAnim = false
            else
                SimpleNotify("<C>Animations</C>\nPersonne assez proche.")
            end
        elseif IsControlJustPressed(1, 182) then
            SimpleNotify("<C>Animations</C>\nAnimation refusée.")
            isRequestAnim = false
        end
        Wait(0)
    end
end

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

GetPlayerFromPed = function(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

GetPedInFront = function()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12, plyPed, 7)
    local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
    return ped2
end

SimpleNotify = function(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

GetPlayers = function()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end