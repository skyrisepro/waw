_G.InfiniteJump = not _G.InfiniteJump

if _G.InfiniteJumpStarted == nil then
	_G.InfiniteJumpStarted = true
	
	local player = game:GetService("Players").LocalPlayer
	local mouse = player:GetMouse()

	mouse.KeyDown:Connect(function(key)
		if _G.InfiniteJump and key:byte() == 32 then
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState("Jumping")
				wait()
				humanoid:ChangeState("Seated")
			end
		end
	end)
end
