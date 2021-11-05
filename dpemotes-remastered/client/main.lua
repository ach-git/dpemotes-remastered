local emotesmenuopened = false
emotesmenu = RageUI.CreateMenu("Animation", " ", 10, 80)
emotesmenu.Closed = function()
    emotesmenuopened = false
    RageUI.CloseAll()
end

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
                    
                    --

                end, function() 
                end)
                Wait(0)
            end
		end)
	end
end

Keys.Register("G", "-openEmotesMenu", "Ouvrir le menu des emotes!", function()
    OpenEmotesMenu()
end)