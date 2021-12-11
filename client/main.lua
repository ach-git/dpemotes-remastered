local emotesmenuopened = false

emotesmenu = RageUI.CreateMenu("Animation", " ", 10, 80)
emotesmenu.Closed = function()
    emotesmenuopened = false
    RageUI.CloseAll()
end
emotessubmenu = RageUI.CreateSubMenu(emotesmenu,"Animation", " ", 10, 80)
demarchesubmenu = RageUI.CreateSubMenu(emotesmenu,"Démarche", " ", 10, 80)
expressionssubmenu = RageUI.CreateSubMenu(emotesmenu,"Expressions", " ", 10, 80)

dancesubmenu = RageUI.CreateSubMenu(emotessubmenu,"Dance", " ", 10, 80)
objetsubmenu = RageUI.CreateSubMenu(emotessubmenu,"Objet", " ", 10, 80)
partageessubmenu = RageUI.CreateSubMenu(emotessubmenu,"Partagées", " ", 10, 80)
posesubmenu = RageUI.CreateSubMenu(emotessubmenu,"Pose", " ", 10, 80)
gestessubmenu = RageUI.CreateSubMenu(emotessubmenu,"Gestes", " ", 10, 80)
autressubmenu = RageUI.CreateSubMenu(emotessubmenu,"Autres", " ", 10, 80)
santesubmenu = RageUI.CreateSubMenu(emotessubmenu,"Santé", " ", 10, 80)
sportsubmenu = RageUI.CreateSubMenu(emotessubmenu,"Sports", " ", 10, 80)

local OpenEmotesMenu = function()
	if emotesmenuopened then
        emotesmenuopened = false 
        RageUI.CloseAll()
        RageUI.Visible(emotesmenu, false)
        return
    else
		emotesmenuopened = true

		RageUI.Visible(emotesmenu, true)

        Citizen.CreateThread(function()
            while emotesmenuopened do
                RageUI.IsVisible(emotesmenu, function()

                    RageUI.Button("🕺 Animations", nil, {}, true, {}, emotessubmenu)

                    RageUI.Button("🚶‍♂️ Démarche", nil, {}, true, {}, demarchesubmenu)

                    RageUI.Button("😀 Expressions", nil, {}, true, {}, expressionssubmenu)

                end, function() 
                end)
                RageUI.IsVisible(emotessubmenu, function()

                    RageUI.Button("🕺 Dance", nil, {}, true, {}, dancesubmenu)

                    RageUI.Button("📦 Animations avec objet", nil, {}, true, {}, objetsubmenu)

                    RageUI.Button("👫 Animations partagées", nil, {}, true, {}, partageessubmenu)

                    RageUI.Button("🧍‍♂️ Pose", nil, {}, true, {}, posesubmenu)

                    RageUI.Button("🖐 Gestes", nil, {}, true, {}, gestessubmenu)

                    RageUI.Button("⚽ Sports", nil, {}, true, {}, sportsubmenu)
                    
                    RageUI.Button("🏥 Santé", nil, {}, true, {}, santesubmenu)

                    RageUI.Button("❓ Autres", nil, {}, true, {}, autressubmenu)

                end, function() 
                end)
                RageUI.IsVisible(demarchesubmenu, function()
                    for k,v in pairs(hEmote.Walks) do
                        RageUI.Button(k, nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                WalkMenuStart(hEmote.Walks[k][1])
                            end
                        })
                    end
                end, function() 
                end)
                RageUI.IsVisible(expressionssubmenu, function()
                    for k,v in pairs(hEmote.Expressions) do
                        RageUI.Button(k, nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                OnEmotePlay(hEmote.Expressions[k])
                            end
                        })
                    end
                end, function() 
                end)
                RageUI.IsVisible(dancesubmenu, function()
                    for k,v in pairs(hEmote.Dances) do
                        RageUI.Button(hEmote.Dances[k][3], "Faire l'animation "..hEmote.Dances[k][3], {RightLabel = "→→"}, true, {
                            onSelected = function()
                                OnEmotePlay(hEmote.Dances[k])
                            end
                        })
                    end
                end, function() 
                end)
                RageUI.IsVisible(objetsubmenu, function()
                    for k,v in pairs(hEmote.PropEmotes) do
                        RageUI.Button(hEmote.PropEmotes[k][3], "Faire l'animation "..hEmote.PropEmotes[k][3], {RightLabel = "→→"}, true, {
                            onSelected = function()
                                OnEmotePlay(hEmote.PropEmotes[k])
                            end
                        })
                    end
                end, function()
                end)
                RageUI.IsVisible(partageessubmenu, function()
                    for k,v in pairs(hEmote.Shared) do
                        RageUI.Button(hEmote.Shared[k][3], "Faire l'animation "..hEmote.Shared[k][3], {RightLabel = "→→"}, true, {
                            onSelected = function()
                                target, distance = GetClosestPlayer()
                                if(distance ~= -1 and distance < 3) then
                                    TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), k, 'Dances')
                                    SimpleNotify("<C>Animations</C>\nDemande envoyée à ~g~"..GetPlayerName(target)) 
                                else
                                    SimpleNotify("<C>Animations</C>\nPersonne assez proche.")
                                end
                            end
                        })
                    end
                end, function() 
                end)
                RageUI.IsVisible(posesubmenu, function()
                    for k,v in pairs(hEmote.Emotes) do
                        if hEmote.Emotes[k].Menu == "position" then
                            RageUI.Button(hEmote.Emotes[k][3], "Faire l'animation "..hEmote.Emotes[k][3], {RightLabel = "→→"}, true, {
                                onSelected = function()
                                    OnEmotePlay(hEmote.Emotes[k])
                                end
                            })
                        end
                    end
                end, function() 
                end)
                RageUI.IsVisible(gestessubmenu, function()
                    for k,v in pairs(hEmote.Emotes) do
                        if hEmote.Emotes[k].Menu == "gesture" then
                            RageUI.Button(hEmote.Emotes[k][3], "Faire l'animation "..hEmote.Emotes[k][3], {RightLabel = "→→"}, true, {
                                onSelected = function()
                                    OnEmotePlay(hEmote.Emotes[k])
                                end
                            })
                        end
                    end
                end, function() 
                end)
                RageUI.IsVisible(sportsubmenu, function()
                    for k,v in pairs(hEmote.Emotes) do
                        if hEmote.Emotes[k].Menu == "sport" then
                            RageUI.Button(hEmote.Emotes[k][3], "Faire l'animation "..hEmote.Emotes[k][3], {RightLabel = "→→"}, true, {
                                onSelected = function()
                                    OnEmotePlay(hEmote.Emotes[k])
                                end
                            })
                        end
                    end
                end, function() 
                end)
                RageUI.IsVisible(santesubmenu, function()
                    for k,v in pairs(hEmote.Emotes) do
                        if hEmote.Emotes[k].Menu == "health" then
                            RageUI.Button(hEmote.Emotes[k][3], "Faire l'animation "..hEmote.Emotes[k][3], {RightLabel = "→→"}, true, {
                                onSelected = function()
                                    OnEmotePlay(hEmote.Emotes[k])
                                end
                            })
                        end
                    end
                end, function() 
                end)
                RageUI.IsVisible(autressubmenu, function()
                    for k,v in pairs(hEmote.Emotes) do
                        if hEmote.Emotes[k].Menu == "other" then
                            RageUI.Button(hEmote.Emotes[k][3], "Faire l'animation "..hEmote.Emotes[k][3], {RightLabel = "→→"}, true, {
                                onSelected = function()
                                    OnEmotePlay(hEmote.Emotes[k])
                                end
                            })
                        end
                    end
                end, function() 
                end)
                Wait(0)
            end
		end)
	end
end

Keys.Register("F3", "-openEmotesMenu", "KeyDescription", function()
    OpenEmotesMenu()
end)

Keys.Register("X", "-cancelEmotes", "KeyDescription", function()
    EmoteCancel()
    DestroyAllProps()
end)

if Config.ActiveRagdoll then
    local isInRagdoll = false

    local RagdollFunc = function()
        if isInRagdoll then
            isInRagdoll = false
        else
            isInRagdoll = true
            Wait(500)
            while isInRagdoll do
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                Wait(0)
            end
        end
    end

    Keys.Register("H", "-ragdoll", "KeyDescription", function()
        RagdollFunc()
    end)
end