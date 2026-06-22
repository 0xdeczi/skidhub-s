--[[ 
    XEON V6 - STABLE BUILD [UPDATED]
    🛡️ Status: WORKING / UNDETECTED
]]

local CORRECT_KEY = "XEON_TOP_2026"
local SITE_URL = "https://sites.google.com/view/xeon-v6-access" -- deleted
 
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
 
-- Очистка старых меню
if game:GetService("CoreGui"):FindFirstChild("XeonProject") then
    game:GetService("CoreGui").XeonProject:Destroy()
end
 
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XeonProject"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
 
local Settings = {
    ESP = false,
    Aim = false,
    AimFOV = 150, 
    GameFOV = 70
}
 
-- Визуал FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 64
FOVCircle.Radius = Settings.AimFOV
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
 
local function ClearESP()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "XeonHighlight" then v:Destroy() end
    end
end
 
local function GetClosestPlayerToCenter()
    local closestDist = Settings.AimFOV
    local target = nil
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
 
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
            local hum = v.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        target = v.Character.Head
                    end
                end
            end
        end
    end
    return target
end
 
RunService.RenderStepped:Connect(function()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Position = center
    FOVCircle.Radius = Settings.AimFOV
    FOVCircle.Visible = Settings.Aim
 
    if Settings.Aim then
        local target = GetClosestPlayerToCenter()
        if target then 
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
 
    if Settings.ESP then
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model.Name ~= Player.Name then
                local root = model:FindFirstChild("HumanoidRootPart")
                if root and not root:FindFirstChild("XeonHighlight") then
                    local adorn = Instance.new("BoxHandleAdornment")
                    adorn.Name = "XeonHighlight"
                    adorn.Size = Vector3.new(4, 6, 0.5)
                    adorn.Adornee = root
                    adorn.AlwaysOnTop = true
                    adorn.ZIndex = 5
                    adorn.Transparency = 0.5
                    adorn.Color3 = Color3.fromRGB(255, 0, 0)
                    adorn.Parent = root
                end
            end
        end
    end
end)
 
------------------------------------------------------------------
-- ГЛАВНОЕ МЕНЮ (ПОСЛЕ ПАРОЛЯ)
------------------------------------------------------------------
local function CreateMainGui()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 260)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)
 
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Text = "XEON V6 CONTROL"
    Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame
 
    local ESPBtn = Instance.new("TextButton")
    ESPBtn.Size = UDim2.new(0.9, 0, 0, 40)
    ESPBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
    ESPBtn.Text = "ESP: OFF"
    ESPBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ESPBtn.TextColor3 = Color3.new(1,1,1)
    ESPBtn.Parent = MainFrame
    Instance.new("UICorner", ESPBtn)
 
    local AimBtn = Instance.new("TextButton")
    AimBtn.Size = UDim2.new(0.9, 0, 0, 40)
    AimBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
    AimBtn.Text = "AUTO-AIM: OFF"
    AimBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AimBtn.TextColor3 = Color3.new(1,1,1)
    AimBtn.Parent = MainFrame
    Instance.new("UICorner", AimBtn)
 
    local AimFOVInput = Instance.new("TextBox")
    AimFOVInput.Size = UDim2.new(0.4, 0, 0, 30)
    AimFOVInput.Position = UDim2.new(0.55, 0, 0.58, 0)
    AimFOVInput.Text = tostring(Settings.AimFOV)
    AimFOVInput.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    AimFOVInput.TextColor3 = Color3.new(1, 1, 1)
    AimFOVInput.Parent = MainFrame
 
    local L1 = Instance.new("TextLabel")
    L1.Text = "Aim Radius:"; L1.TextColor3 = Color3.new(1,1,1); L1.Size = UDim2.new(0.5,0,0,30); L1.Position = UDim2.new(0.05,0,0.58,0); L1.BackgroundTransparency = 1; L1.Parent = MainFrame
 
    ESPBtn.MouseButton1Click:Connect(function()
        Settings.ESP = not Settings.ESP
        ESPBtn.Text = Settings.ESP and "ESP: ON" or "ESP: OFF"
        ESPBtn.BackgroundColor3 = Settings.ESP and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 30)
        if not Settings.ESP then ClearESP() end
    end)
 
    AimBtn.MouseButton1Click:Connect(function()
        Settings.Aim = not Settings.Aim
        AimBtn.Text = Settings.Aim and "AUTO-AIM: ON" or "AUTO-AIM: OFF"
        AimBtn.BackgroundColor3 = Settings.Aim and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 30, 30)
    end)
 
    AimFOVInput.FocusLost:Connect(function() Settings.AimFOV = tonumber(AimFOVInput.Text) or 150 end)
end
 
------------------------------------------------------------------
-- ОКНО АВТОРИЗАЦИИ (ВХОД)
------------------------------------------------------------------
local Auth = Instance.new("Frame")
Auth.Size = UDim2.new(0, 240, 0, 200)
Auth.Position = UDim2.new(0.5, -120, 0.5, -100)
Auth.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Auth.Parent = ScreenGui
Auth.Active = true
Auth.Draggable = true
Instance.new("UICorner", Auth)

local AuthTitle = Instance.new("TextLabel")
AuthTitle.Size = UDim2.new(1, 0, 0, 40)
AuthTitle.Text = "XEON ACCESS"
AuthTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
AuthTitle.BackgroundTransparency = 1
AuthTitle.Font = Enum.Font.GothamBold
AuthTitle.Parent = Auth
 
local KInput = Instance.new("TextBox")
KInput.Size = UDim2.new(0.8, 0, 0, 35)
KInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KInput.PlaceholderText = "Enter Key..." -- УБРАЛИ ПОДСКАЗКУ ПАРОЛЯ
KInput.Text = ""
KInput.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KInput.TextColor3 = Color3.new(1, 1, 1)
KInput.Parent = Auth
Instance.new("UICorner", KInput)
 
local Login = Instance.new("TextButton")
Login.Size = UDim2.new(0.8, 0, 0, 35)
Login.Position = UDim2.new(0.1, 0, 0.6, 0)
Login.Text = "LOGIN"
Login.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Login.TextColor3 = Color3.new(1,1,1)
Login.Parent = Auth
Instance.new("UICorner", Login)
 
local GetK = Instance.new("TextButton")
GetK.Size = UDim2.new(0.8, 0, 0, 30)
GetK.Position = UDim2.new(0.1, 0, 0.82, 0)
GetK.Text = "GET KEY"
GetK.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
GetK.TextColor3 = Color3.new(1,1,1)
GetK.Parent = Auth
Instance.new("UICorner", GetK)
 
GetK.MouseButton1Click:Connect(function() 
    setclipboard(SITE_URL)
    GetK.Text = "URL COPIED!"
    wait(1)
    GetK.Text = "GET KEY"
end)
 
Login.MouseButton1Click:Connect(function()
    if KInput.Text == CORRECT_KEY then
        Auth:Destroy()
        CreateMainGui()
    else
        KInput.Text = ""
        KInput.PlaceholderText = "WRONG KEY!"
        KInput.PlaceholderColor3 = Color3.new(1, 0, 0)
    end
end)
