-- https://www.roblox.com/games/3261957210/Infinity-Gauntlet-Thanos-Simulator
-- // CONFIGURATION
_G.MainWebhook = "https://discord.com/api/webhooks/1480551838196695243/4MvEKy4Mk53oicuEWtwMEOZt7qnpfwAei9wZKNzbPviZnF9ddohtxKHahkn_odUTDCpH"

-- // GLOBAL STATES
_G.AutoFarm = false
_G.FarmMode = "Sky" 
_G.SelectedTargets = {}
_G.Abilities = {["Q"] = false, ["E"] = false, ["Z"] = false, ["X"] = false}
_G.Running = true

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local ACCENT = Color3.fromRGB(0, 255, 150) 
local BG_MAIN = Color3.fromRGB(10, 10, 12)
local PANEL_BG = Color3.fromRGB(20, 20, 25)

-- // CORE ENGINE
task.spawn(function()
    local angle = 0
    while _G.Running do
        task.wait(0.01)
        if _G.AutoFarm and _G.Running then
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local tool = char and char:FindFirstChildOfClass("Tool")
            
            if root then
                local target = nil
                local dist = 10000
                for _, v in pairs(workspace:GetDescendants()) do
                    if _G.SelectedTargets[v.Name] and v:IsA("Model") then
                        local h = v:FindFirstChildOfClass("Humanoid")
                        local tP = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso")
                        if h and h.Health > 0 and tP then
                            local mag = (root.Position - tP.Position).Magnitude
                            if mag < dist then dist = mag target = tP end
                        end
                    end
                end

                if target and _G.Running then
                    angle = angle + math.rad(15)
                    local tPos = (_G.FarmMode == "Sky") and (target.Position + Vector3.new(math.cos(angle)*7, 18, math.sin(angle)*7)) or (target.Position + Vector3.new(0, 0, 4.5))
                    root.CFrame = CFrame.new(tPos, target.Position)
                    root.Velocity = Vector3.new(0,0,0)
                    
                    -- Only activates if YOU have a tool equipped manually
                    if tool then tool:Activate() end
                    
                    for k, v in pairs(_G.Abilities) do
                        if v then 
                            VirtualInputManager:SendKeyEvent(true, k, false, game) 
                            task.wait() 
                            VirtualInputManager:SendKeyEvent(false, k, false, game) 
                        end
                    end
                else 
                    if root then root.Velocity = Vector3.new(0,0,0) end
                end
            end
        end
    end
end)

-- // UI BUILD
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Eclipse"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false 

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 520) 
Main.Position = UDim2.new(0.5, -180, 0.5, -260)
Main.BackgroundColor3 = BG_MAIN
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Glow = Instance.new("Frame", Main)
Glow.Size = UDim2.new(1, 6, 1, 6)
Glow.Position = UDim2.new(0, -3, 0, -3)
Glow.BackgroundColor3 = ACCENT
Glow.ZIndex = 0
Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "ECLIPSE // VIPER [MADE BY ARGPIPG]"
Title.TextColor3 = ACCENT
Title.BackgroundColor3 = PANEL_BG
Title.Font = Enum.Font.Code
Title.TextSize = 20
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- // DRAGGING LOGIC
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = Main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
Main.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- // UI ELEMENTS
local function CreateViperToggle(key, x, y)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.44, 0, 0, 40)
    b.Position = UDim2.new(x, (x == 0 and 15 or 5), 0, y)
    b.BackgroundColor3 = PANEL_BG
    b.Text = "USE " .. key
    b.TextColor3 = Color3.new(0.6,0.6,0.6)
    b.Font = Enum.Font.Code b.TextSize = 17
    Instance.new("UICorner", b)
    local Line = Instance.new("Frame", b)
    Line.Size = UDim2.new(1, 0, 0, 3)
    Line.Position = UDim2.new(0, 0, 1, -3)
    Line.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    b.MouseButton1Click:Connect(function()
        _G.Abilities[key] = not _G.Abilities[key]
        local active = _G.Abilities[key]
        TweenService:Create(b, TweenInfo.new(0.3), {TextColor3 = active and ACCENT or Color3.new(0.6,0.6,0.6)}):Play()
        TweenService:Create(Line, TweenInfo.new(0.3), {BackgroundColor3 = active and ACCENT or Color3.new(0.2, 0.2, 0.2)}):Play()
    end)
end
CreateViperToggle("Q", 0, 65) CreateViperToggle("E", 0.5, 65)
CreateViperToggle("Z", 0, 115) CreateViperToggle("X", 0.5, 115)

local ListFrame = Instance.new("ScrollingFrame", Main)
ListFrame.Size = UDim2.new(1, -30, 0, 150)
ListFrame.Position = UDim2.new(0, 15, 0, 170)
ListFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
ListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListFrame.ScrollBarThickness = 4
Instance.new("UIListLayout", ListFrame).Padding = UDim.new(0, 5)
Instance.new("UICorner", ListFrame)

task.spawn(function()
    while _G.Running do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Humanoid") and not Players:GetPlayerFromCharacter(v.Parent) then
                local n = v.Parent.Name
                if not ListFrame:FindFirstChild(n) then
                    local b = Instance.new("TextButton", ListFrame)
                    b.Name = n b.Size = UDim2.new(1, -10, 0, 35) b.Text = "  > "..n
                    b.BackgroundColor3 = PANEL_BG b.TextColor3 = Color3.new(0.7,0.7,0.7)
                    b.Font = Enum.Font.Code b.TextSize = 16 b.TextXAlignment = Enum.TextXAlignment.Left
                    Instance.new("UICorner", b)
                    b.MouseButton1Click:Connect(function()
                        _G.SelectedTargets[n] = not _G.SelectedTargets[n]
                        b.TextColor3 = _G.SelectedTargets[n] and ACCENT or Color3.new(0.7,0.7,0.7)
                    end)
                end
            end
        end
        task.wait(5)
    end
end)

local function CreateFarmBtn(mode, x, y)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.44, 0, 0, 55)
    b.Position = UDim2.new(x, (x == 0 and 15 or 5), 1, y)
    b.Text = mode:upper() .. " ENGAGE"
    b.BackgroundColor3 = PANEL_BG b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Code b.TextSize = 17
    Instance.new("UICorner", b)
    task.spawn(function()
        while _G.Running do
            local active = (_G.AutoFarm and _G.FarmMode == mode)
            b.BackgroundColor3 = active and ACCENT or PANEL_BG
            b.TextColor3 = active and Color3.new(0,0,0) or Color3.new(1,1,1)
            task.wait(0.2)
        end
    end)
    b.MouseButton1Click:Connect(function()
        if _G.AutoFarm and _G.FarmMode == mode then _G.AutoFarm = false else _G.AutoFarm = true _G.FarmMode = mode end
    end)
end
CreateFarmBtn("Sky", 0, -135) CreateFarmBtn("Ground", 0.5, -135)

local Unload = Instance.new("TextButton", Main)
Unload.Size = UDim2.new(1, -30, 0, 50)
Unload.Position = UDim2.new(0, 15, 1, -65)
Unload.Text = "TERMINATE SESSION"
Unload.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
Unload.TextColor3 = Color3.new(1,0.2,0.2)
Unload.Font = Enum.Font.Code Unload.TextSize = 17
Instance.new("UICorner", Unload)
Unload.MouseButton1Click:Connect(function() _G.Running = false _G.AutoFarm = false task.wait(0.1) ScreenGui:Destroy() end)

UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible Glow.Visible = Main.Visible end end)
