_G.DayMode = not _G.DayMode

if _G.DayMode then
    game.Lighting.Brightness = 5
    game.Lighting.TimeOfDay = "12:00:00"
    game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
else
    game.Lighting.Brightness = 2
    game.Lighting.TimeOfDay = "14:00:00"
    game.Lighting.Ambient = Color3.fromRGB(150, 150, 150)
end
