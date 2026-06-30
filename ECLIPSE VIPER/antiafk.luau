-- [[ ECLIPSE // VIPER: HACKER OVERLAY FINAL ]] --

if not game:IsLoaded() then game.Loaded:Wait() end

local TweenService = game:GetService("TweenService")
local ACCENT = Color3.fromRGB(0, 255, 150)
local BG_DARK = Color3.fromRGB(5, 5, 5)

-- // 1. LOADING SCREEN
local function BootSequence(isClosing)
    local BootGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Main = Instance.new("Frame", BootGui)
    Main.Size = UDim2.new(0, 220, 0, 70)
    Main.Position = UDim2.new(0.5, -110, 0.45, -35)
    Main.BackgroundColor3 = BG_DARK
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main)
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = ACCENT
    Stroke.Thickness = 1.5
    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.Text = isClosing and "> SHUTTING_DOWN" or "> BYPASSING_AFK"
    Title.TextColor3 = ACCENT
    Title.Font = Enum.Font.Code
    Title.TextSize = 14
    Title.BackgroundTransparency = 1
    local BarBg = Instance.new("Frame", Main)
    BarBg.Size = UDim2.new(0.7, 0, 0, 2)
    BarBg.Position = UDim2.new(0.15, 0, 0.7, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    BarBg.BorderSizePixel = 0
    local Fill = Instance.new("Frame", BarBg)
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = ACCENT
    Fill.BorderSizePixel = 0
    local fillTween = TweenService:Create(Fill, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 1, 0)})
    fillTween:Play()
    fillTween.Completed:Wait()
    task.wait(0.2)
    BootGui:Destroy()
end

-- // 2. HACKER DASHBOARD
local function CreateEliteDash()
    local DashGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    DashGui.Name = "Eclipse_Dashboard_Hacker"

    local Main = Instance.new("Frame", DashGui)
    Main.Size = UDim2.new(0, 280, 0, 175)
    Main.Position = UDim2.new(0.5, -140, 0.5, -87)
    Main.BackgroundColor3 = BG_DARK
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 4)
    
    -- Hacker Grid Background Effect
    local Grid = Instance.new("ImageLabel", Main)
    Grid.Size = UDim2.new(1, 0, 1, 0)
    Grid.BackgroundTransparency = 1
    Grid.Image = "rbxassetid://6073763717" -- Subtle grid texture
    Grid.ImageColor3 = ACCENT
    Grid.ImageTransparency = 0.92
    Grid.ZIndex = 0

    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = ACCENT
    Stroke.Thickness = 1
    Stroke.Transparency = 0.6

    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 28)
    Header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Header.BorderSizePixel = 0
    Instance.new("UICorner", Header)
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = "SYS_RECON // ECLIPSE"
    Title.TextColor3 = ACCENT
    Title.Font = Enum.Font.Code
    Title.TextSize = 13
    Title.TextXAlignment = 0
    Title.BackgroundTransparency = 1

    local CloseBtn = Instance.new("TextButton", Header)
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.Text = "[X]"
    CloseBtn.TextColor3 = ACCENT
    CloseBtn.Font = Enum.Font.Code
    CloseBtn.TextSize = 14
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.MouseButton1Click:Connect(function() 
        DashGui:Destroy() 
        task.spawn(function() BootSequence(true) end)
    end)

    local function CreateRow(name, y)
        local Container = Instance.new("Frame", Main)
        Container.Size = UDim2.new(1, -30, 0, 25)
        Container.Position = UDim2.new(0, 15, 0, y)
        Container.BackgroundTransparency = 1

        local L = Instance.new("TextLabel", Container)
        L.Size = UDim2.new(0.4, 0, 1, 0)
        L.Text = "> " .. name
        L.TextColor3 = ACCENT
        L.Font = Enum.Font.Code
        L.TextSize = 13
        L.TextXAlignment = 0
        L.BackgroundTransparency = 1

        local V = Instance.new("TextLabel", Container)
        V.Size = UDim2.new(0.6, 0, 1, 0)
        V.Position = UDim2.new(0.4, 0, 0, 0)
        V.Text = "000"
        V.TextColor3 = Color3.fromRGB(255, 255, 255)
        V.Font = Enum.Font.Code
        V.TextSize = 14
        V.TextXAlignment = 1
        V.BackgroundTransparency = 1
        return V
    end

    local UptimeV = CreateRow("UPTIME", 40)
    local FPSV = CreateRow("FPS_CUR", 65)
    local PingV = CreateRow("NET_LAT", 90)

    local StatusFrame = Instance.new("Frame", Main)
    StatusFrame.Size = UDim2.new(1, -24, 0, 30)
    StatusFrame.Position = UDim2.new(0, 12, 1, -42)
    StatusFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Instance.new("UICorner", StatusFrame)
    Instance.new("UIStroke", StatusFrame).Color = Color3.fromRGB(30,30,30)

    local Dot = Instance.new("Frame", StatusFrame)
    Dot.Size = UDim2.new(0, 6, 0, 6)
    Dot.Position = UDim2.new(0, 10, 0.5, -3)
    Dot.BackgroundColor3 = ACCENT
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    -- Pulsing Dot Effect
    task.spawn(function()
        while DashGui.Parent do
            TweenService:Create(Dot, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.5}):Play()
            task.wait(1.6)
        end
    end)

    local StatusText = Instance.new("TextLabel", StatusFrame)
    StatusText.Size = UDim2.new(1, -30, 1, 0)
    StatusText.Position = UDim2.new(0, 25, 0, 0)
    StatusText.Text = "ENCRYPTED_SESSION: ACTIVE"
    StatusText.TextColor3 = ACCENT
    StatusText.Font = Enum.Font.Code
    StatusText.TextSize = 11
    StatusText.TextXAlignment = 0
    StatusText.BackgroundTransparency = 1

    -- Drag Logic
    local d,s,p; Main.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true;s=i.Position;p=Main.Position;i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then d=false end end) end end)
    game:GetService("UserInputService").InputChanged:Connect(function(i) if d and i.UserInputType==Enum.UserInputType.MouseMovement then local delta=i.Position-s; Main.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y) end end)

    task.spawn(function()
        local start = os.time()
        while DashGui and DashGui.Parent do
            local sec = os.difftime(os.time(), start)
            UptimeV.Text = string.format("%02i:%02i:%02i", sec/3600, (sec/60)%60, sec%60)
            FPSV.Text = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            PingV.Text = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms"
            task.wait(1)
        end
    end)
end

task.spawn(function() BootSequence(false) CreateEliteDash() end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
