if _G.ClickTeleport == nil then
	_G.ClickTeleport = true
	
	local player = game:GetService("Players").LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	local mouse = player:GetMouse()

	repeat wait() until mouse
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if _G.ClickTeleport and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)) 
			end
		end
	end)
else
	_G.ClickTeleport = not _G.ClickTeleport
end
