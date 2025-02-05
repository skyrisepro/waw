_G.NightMode = not _G.NightMode

if not _G.NightMode then
    game.Lighting.Brightness = 2
    game.Lighting.TimeOfDay = "14:00:00"
    game.Lighting.Ambient = Color3.fromRGB(150, 150, 150)
else
    game.Lighting.Brightness = 0
    game.Lighting.TimeOfDay = "00:00:00"
    game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
end
