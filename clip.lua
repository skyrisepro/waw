_G.Noclip = not _G.Noclip

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

if _G.NoclipConnection then
    _G.NoclipConnection:Disconnect()
    _G.NoclipConnection = nil
else
    _G.NoclipConnection = runService.Stepped:Connect(function()
        if _G.Noclip then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end
