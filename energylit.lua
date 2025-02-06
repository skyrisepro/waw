local tycoon = workspace["Tycoon 7"]
local dropsFolder = tycoon.Drops
local cashCFrame = CFrame.new(139.681763, 0.513072968, 378.258972)

game:GetService("RunService").Heartbeat:Connect(function()
    for _, obj in pairs(dropsFolder:GetChildren()) do
        if obj:IsA("BasePart") then
            obj.CFrame = cashCFrame
        end
    end
end)
