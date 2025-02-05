local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function removeLegs()
    for _, limb in pairs(character:GetChildren()) do
        if limb:IsA("BasePart") and (limb.Name == "Left Leg" or limb.Name == "Right Leg" or limb.Name == "LeftLowerLeg" or limb.Name == "RightLowerLeg") then
            limb:Destroy()
        end
    end
end

removeLegs()
