--// Open Source Script Hub (GameID -> Loadstring)
--// Clean + Notifier Included

-- SARHUB Full Screen Popup

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Remove old if exists
if CoreGui:FindFirstChild("SARHUB_Fullscreen") then
    CoreGui.SARHUB_Fullscreen:Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SARHUB_Fullscreen"
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BackgroundTransparency = 1
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, -40, 1, -40)
TextLabel.Position = UDim2.new(0, 20, 0, 20)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Thank you for using SARHUB by SARpastes\n\nSupports OVER 30+ GAMES!\n\nLoading Script..."
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Parent = Frame

-- Fade IN
local fadeIn = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.2
})
fadeIn:Play()

-- Wait while showing
task.wait(2.5)

-- Fade OUT
local fadeOut = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
    BackgroundTransparency = 1
})
fadeOut:Play()

fadeOut.Completed:Connect(function()
    ScreenGui:Destroy()
end)

setclipboard("https://discord.gg/vDKSEfCMPV")

--// Discord Popup GUI by SAR (With Background Overlay)

local ScreenGui = Instance.new("ScreenGui")

--// Background Overlay (THIS WAS MISSING)
local Background = Instance.new("Frame")

local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")

local TitleText = Instance.new("TextLabel")
local InfoText = Instance.new("TextLabel")
local ExtraText = Instance.new("TextLabel")

local JoinButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

local JoinCorner = Instance.new("UICorner")
local CloseCorner = Instance.new("UICorner")

--// Parent
ScreenGui.Parent = game.CoreGui

--// Background Overlay
Background.Parent = ScreenGui
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.4 -- adjust darkness here
Background.BorderSizePixel = 0

--// Main Frame
Frame.Parent = Background
Frame.Size = UDim2.new(0, 420, 0, 280)
Frame.Position = UDim2.new(0.5, -210, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 12)

--// Title
TitleText.Parent = Frame
TitleText.Size = UDim2.new(1, -20, 0, 80)
TitleText.Position = UDim2.new(0, 10, 0, 10)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Hello, Do you want to join SARHUB Official Discord server? where you can communicate the creator or even post, share or even sell the script to other players? join now"
TitleText.TextColor3 = Color3.fromRGB(255,255,255)
TitleText.TextWrapped = true
TitleText.Font = Enum.Font.GothamBold
TitleText.TextScaled = true

--// Info Text
InfoText.Parent = Frame
InfoText.Size = UDim2.new(1, -20, 0, 30)
InfoText.Position = UDim2.new(0, 10, 0, 90)
InfoText.BackgroundTransparency = 1
InfoText.Text = "CLICK JOIN TO COPY DISCORD LINK"
InfoText.TextColor3 = Color3.fromRGB(185, 187, 190)
InfoText.Font = Enum.Font.Gotham
InfoText.TextScaled = true

--// Extra Text (hidden first)
ExtraText.Parent = Frame
ExtraText.Size = UDim2.new(1, -20, 0, 30)
ExtraText.Position = UDim2.new(0, 10, 0, 115)
ExtraText.BackgroundTransparency = 1
ExtraText.Text = "Copy link Go to your browser and open the link"
ExtraText.TextColor3 = Color3.fromRGB(160, 163, 168)
ExtraText.Font = Enum.Font.Gotham
ExtraText.TextScaled = true
ExtraText.Visible = false

--// Join Button
JoinButton.Parent = Frame
JoinButton.Size = UDim2.new(0.8, 0, 0, 45)
JoinButton.Position = UDim2.new(0.1, 0, 0, 155)
JoinButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
JoinButton.Text = "JOIN DISCORD"
JoinButton.TextColor3 = Color3.fromRGB(255,255,255)
JoinButton.Font = Enum.Font.GothamBold
JoinButton.TextScaled = true
JoinButton.BorderSizePixel = 0

JoinCorner.Parent = JoinButton
JoinCorner.CornerRadius = UDim.new(0, 10)

--// Close Button
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0.8, 0, 0, 40)
CloseButton.Position = UDim2.new(0.1, 0, 0, 210)
CloseButton.BackgroundColor3 = Color3.fromRGB(237, 66, 69)
CloseButton.Text = "CLOSE"
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextScaled = true
CloseButton.BorderSizePixel = 0

CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(0, 10)

--// Clipboard
local invite = "https://discord.gg/vDKSEfCMPV"

JoinButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(invite)
    end
    
    ExtraText.Visible = true
    InfoText.Text = "LINK COPIED!"
end)

--// Close
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ScriptHub = {}

--// =========================
--// CONFIG: GAME LIST
--// =========================
ScriptHub.Games = {
    [84514721527976] = "https://pastebin.com/raw/in0B0D3E", -- dig deeper for branrots
    [72845937010155] = "https://pastebin.com/raw/apRhidGL", -- gear slap tower
    [136801880565837] = "https://pastebin.com/raw/eACmt48f", --Flick
    [126509999114328] = "https://pastebin.com/raw/LyRY3Jdh", -- 99 nights 
    [15002061926] = "https://pastebin.com/raw/Hn3L3h4Q", -- death ball
    [9872472334] = "https://pastebin.com/raw/A2Ha3VQ5",  -- evade
    [97365843755210] = "https://pastebin.com/raw/7dZwHtvj", --cut grass for brainrot
    [120700541929930] = "https://pastebin.com/raw/GA3Q8vQU", -- Knife VS Gun DUELS
    [124473577469410] = "https://pastebin.com/raw/4HqNRakY", --Be a lucky block
    [2768379856] = "https://pastebin.com/raw/TBRpz9XV", --3008 [2.74]
    [70876832253163] = "https://pastebin.com/raw/4XvgXZxe", --auto farm bonds script for dead rails
    [79602128065352] = "https://pastebin.com/raw/3NYESdyh", --No Cooldown Doomspire Brickbattle
    [119048529960596] = "https://pastebin.com/raw/0pX5wZLB", --Restaurant Tycoon 3
    [155615604] = "https://pastebin.com/raw/4tVjiyFr", --Prison Life
    [537413528] = "https://pastebin.com/raw/wWzEmV41", --Build A Boat For Treasure autofarm
    [122902171482835] = "https://pastebin.com/raw/8dDPhUWC", --+1 Health Per Click
    [135856908115931] = "https://pastebin.com/raw/APNLBNWs", --Murderers VS Sheriffs
    [137826330724902] = "https://pastebin.com/raw/hQTNE2m1", -- Scary Shawarma Kiosk: the ANOMALY [horror]
    [83403180598996] = "https://pastebin.com/raw/jYbeACd0", --🚀Climb to Infinity!
    [10449761463] = "https://pastebin.com/raw/V0uEDSGE", --The Strongest Battlegrounds
    [120564326011184] = "https://pastebin.com/raw/4pybLPME", --Be a YouTuber! 🔴🎥
    [107095834793267] = "https://pastebin.com/raw/zZjCDrgr", --Oil Empire🛢️
    [95082159892680] = "https://pastebin.com/raw/VjkgdYZJ", --+1 Speed Keyboard Escape | Candy & Chocolate
    [106683702021527] = "https://pastebin.com/raw/LtbbqKaN", --Guess the Slapper
    [92683694220101] = "https://pastebin.com/raw/HhdFt5dC", --Fight Your Zombie
    [129866685202296] = "https://pastebin.com/raw/8wrECu99", --Last Letter 💬
    [12355337193] = "https://pastebin.com/raw/x6gRjBp6", --Murderers VS Sheriffs DUELS
    [110449467745196] = "https://pastebin.com/raw/kLQK903M", --Infinite Drill Simulator 🔥
    [1240123653] = "https://pastebin.com/raw/iHNam9dk", --Zombie Attack
    [13772394625] = "https://pastebin.com/raw/aeBvX8m7", --blade ball
    [77393318863643] = "https://pastebin.com/raw/2q6trHU0", -- Aura Ascension
    [90148635862803] = "https://raw.githubusercontent.com/Sariscute/scripts/refs/heads/main/survive%20the%20apocalypse", -- Survive the apocalypse
    [116139828947259] = "https://raw.githubusercontent.com/Sariscute/scripts/refs/heads/main/survive%20the%20apocalypse", -- Survive the apocalypse
    [000] = "https://pastebin.com", 
}

--// =========================
--// NOTIFIER
--// =========================
function ScriptHub:Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "SARHUB by SARpastes",
            Text = text or "",
            Duration = duration or 5
        })
    end)
end

--// =========================
--// LOADER
--// =========================
function ScriptHub:Load()
    local gameId = game.PlaceId
    local scriptUrl = self.Games[gameId]

    if scriptUrl then
        self:Notify("SARHUB", "Game Detected: "..gameId, 5)

        local success, err = pcall(function()
            loadstring(game:HttpGet(scriptUrl))()
        end)

        if success then
            self:Notify("Success", "Script Loaded Successfully", 5)
        else
            warn(err)
            self:Notify("Error", "Failed to load script", 5)
        end
    else
        self:Notify("DONT EXECUTE IT ON THE LOBBY!", "Thank You! - SARHUB ", 5)
        warn("No script for this Game ID:", gameId)
    end
end

--// =========================
--// EXECUTE
--// =========================
ScriptHub:Load()
