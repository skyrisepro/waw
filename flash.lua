--[[
	https://scriptblox.com/script/Universal-Script-Rewind-Flashback-GUI-x-Better-UI-28049
  https://scriptblox.com/script/Universal-Script-Rewind-GUI-Script-27800
]]
local flashbacklength = 10000
local flashbackspeed = 0.75

local name = game:GetService("RbxAnalyticsService"):GetSessionId()
local frames, LP, RS, UIS = {}, game:GetService("Players").LocalPlayer, game:GetService("RunService"), game:GetService("UserInputService")

pcall(RS.UnbindFromRenderStep, RS, name)

local function getchar()
   return LP.Character or LP.CharacterAdded:Wait()
end

local function gethrp(c)
   return c:FindFirstChild("HumanoidRootPart") or c.RootPart or c.PrimaryPart or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChildWhichIsA("BasePart")
end

local flashback = {lastinput=false, canrevert=true}

function flashback:Advance(char, hrp, hum, allowinput)
   if #frames > flashbacklength * 60 then
       table.remove(frames, 1)
   end
   if allowinput and not self.canrevert then
       self.canrevert = true
   end
   if self.lastinput then
       hum.PlatformStand = false
       self.lastinput = false
   end
   table.insert(frames, {
       hrp.CFrame,
       hrp.Velocity,
       hum:GetState(),
       hum.PlatformStand,
       char:FindFirstChildOfClass("Tool")
   })
end

function flashback:Revert(char, hrp, hum)
   local num = #frames
   if num == 0 or not self.canrevert then
       self.canrevert = false
       self:Advance(char, hrp, hum)
       return
   end
   for i = 1, flashbackspeed do
       table.remove(frames, num)
       num = num - 1
   end
   self.lastinput = true
   local lastframe = frames[num]
   table.remove(frames, num)
   hrp.CFrame = lastframe[1]
   hrp.Velocity = -lastframe[2]
   hum:ChangeState(lastframe[3])
   hum.PlatformStand = lastframe[4]
   local currenttool = char:FindFirstChildOfClass("Tool")
   if lastframe[5] then
       if not currenttool then
           hum:EquipTool(lastframe[5])
       end
   else
       hum:UnequipTools()
   end
end

local function step()
   local char = getchar()
   local hrp = gethrp(char)
   local hum = char:FindFirstChildWhichIsA("Humanoid")
   if flashback.active then
       flashback:Revert(char, hrp, hum)
   else
       flashback:Advance(char, hrp, hum, true)
   end
end

-- UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LP:FindFirstChildOfClass("PlayerGui")
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 100)
frame.Position = UDim2.new(0.5, -125, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 3
uiStroke.Color = Color3.fromRGB(0, 255, 255)
uiStroke.Parent = frame

local function createButton(text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.AutoButtonColor = false
    button.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 255, 255)
    stroke.Parent = button

    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 100)}):Play()
    end)

    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)

    button.MouseButton1Click:Connect(callback)
    return button
end

local flashbackButton = createButton("Flashback", UDim2.new(0, 10, 0, 50), function()
    flashback.active = not flashback.active
    flashbackButton.Text = flashback.active and "Stop Flashback" or "Flashback"
end)

local resetButton = createButton("Reset", UDim2.new(0, 140, 0, 50), function()
    frames = {}
    flashback.active = false
    flashbackButton.Text = "Flashback"
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Flashback System"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.Parent = frame

local function animateOutline()
    local colors = {Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 255, 0)}
    local index = 1
    while true do
        index = index % #colors + 1
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(1), {Color = colors[index]}):Play()
        wait(1)
    end
end

spawn(animateOutline)

RS:BindToRenderStep(name, 1, step)
