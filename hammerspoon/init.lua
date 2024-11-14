hs.hotkey.bind({"alt", "shift"}, "t", function()
    local alacritty = hs.application.find('alacritty')
    if alacritty then
        if alacritty:isFrontmost() then
            alacritty:hide()
        else
            alacritty:activate()
        end
    else
        hs.application.launchOrFocus('/Applications/Alacritty.app')
    end
end)
