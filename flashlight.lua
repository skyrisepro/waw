local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local light = Instance.new("PointLight")
light.Brightness = 2 
light.Range = 15 
light.Color = Color3.new(1, 1, 1) 
light.Parent = character:FindFirstChild("Head") or character:FindFirstChildOfClass("Part")
