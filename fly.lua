local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Flying = false

RunService.RenderStepped:Connect(function()
    if Flying then
        local character = Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState(4)
            character.Humanoid.WalkSpeed = 100
        end
    end
end)

Flying = not Flying

if not Flying then
    local character = Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 16
    end
end
