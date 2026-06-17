--[[
	Чит-меню (Roblox) – скрытие по правому Shift + Auto F (нажатие F раз в секунду).
	Функции: Anti‑AFK, Fly, NoClip, ESP, Auto F.
	Поместите в StarterGui как LocalScript.
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer

if not player then
	player = Players.PlayerAdded:Wait()
end

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CheatMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Увеличим высоту, чтобы вместить 5 тогглов
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 250)   -- было 210
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local shadow = Instance.new("UIStroke")
shadow.Thickness = 1.5
shadow.Color = Color3.fromRGB(10, 10, 10)
shadow.Transparency = 0.5
shadow.Parent = mainFrame

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local dragHandle = Instance.new("TextLabel")
dragHandle.Size = UDim2.new(0, 24, 1, 0)
dragHandle.Position = UDim2.new(0, 5, 0, 0)
dragHandle.BackgroundTransparency = 1
dragHandle.Text = "⋮⋮"
dragHandle.TextColor3 = Color3.fromRGB(150, 150, 150)
dragHandle.Font = Enum.Font.GothamBold
dragHandle.TextSize = 18
dragHandle.TextXAlignment = Enum.TextXAlignment.Center
dragHandle.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 34, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "GootHub"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -30, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.Text = "—"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = titleBar

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = minimizeBtn

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -55)
contentFrame.Position = UDim2.new(0, 10, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame

-- Скрытие/показ меню по правому Shift
local menuVisible = true

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		menuVisible = not menuVisible
		mainFrame.Visible = menuVisible
	end
end)

-- Сворачивание списка функций
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	minimizeBtn.Text = minimized and "+" or "—"
	mainFrame.Size = minimized and UDim2.new(0, 200, 0, 50) or UDim2.new(0, 200, 0, 250)
end)

-- ===================== Функциональность читов =====================

-- Анти‑АФК
local antiAfkEnabled = false
local function setAntiAfk(state)
	antiAfkEnabled = state
	if state and player.Idled then
		player.Idled:Connect(function() end)
	end
end

-- Fly (полёт без тряски)
local flyEnabled = false
local flyBodyGyro, flyBodyVelocity, flyBodyForce
local flySpeed = 50
local flyConnection

local function onFlyStepped()
	if not flyEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
		return
	end
	local root = player.Character.HumanoidRootPart
	local hum = player.Character:FindFirstChild("Humanoid")
	if not hum then return end

	local camera = workspace.CurrentCamera
	if not camera then return end

	local moveDir = Vector3.zero
	if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += camera.CFrame.LookVector end
	if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= camera.CFrame.LookVector end
	if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= camera.CFrame.RightVector end
	if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += camera.CFrame.RightVector end
	if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
	if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir += Vector3.new(0, -1, 0) end

	if moveDir.Magnitude > 0 then
		moveDir = moveDir.Unit
	end

	flyBodyVelocity.Velocity = moveDir * flySpeed
	flyBodyGyro.CFrame = camera.CFrame

	local mass = root:GetMass()
	if mass > 0 then
		flyBodyForce.Force = Vector3.new(0, workspace.Gravity * mass, 0)
	end
end

local function enableFly()
	if flyEnabled then return end
	flyEnabled = true
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	local hum = char:WaitForChild("Humanoid")
	hum.PlatformStand = true

	flyBodyGyro = Instance.new("BodyGyro")
	flyBodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
	flyBodyGyro.P = 5000
	flyBodyGyro.D = 500
	flyBodyGyro.Parent = root

	flyBodyVelocity = Instance.new("BodyVelocity")
	flyBodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
	flyBodyVelocity.Velocity = Vector3.zero
	flyBodyVelocity.Parent = root

	flyBodyForce = Instance.new("BodyForce")
	flyBodyForce.Force = Vector3.new(0, workspace.Gravity * root:GetMass(), 0)
	flyBodyForce.Parent = root

	flyConnection = RunService.Stepped:Connect(onFlyStepped)
end

local function disableFly()
	flyEnabled = false
	if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
	if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
	if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
	if flyBodyForce then flyBodyForce:Destroy(); flyBodyForce = nil end
	if player.Character then
		local hum = player.Character:FindFirstChild("Humanoid")
		if hum then hum.PlatformStand = false end
	end
end

player.CharacterAdded:Connect(function(char)
	if flyEnabled then
		disableFly()
		enableFly()
	end
end)

-- NoClip (сквозь стены)
local noclipEnabled = false
local noclipCache = {}
local noclipConnection

local function clearNoclipCache()
	for part, orig in pairs(noclipCache) do
		if part and part.Parent then
			part.CanCollide = orig
		end
	end
	table.clear(noclipCache)
end

local function enableNoclip()
	if noclipEnabled then return end
	noclipEnabled = true

	noclipConnection = RunService.Heartbeat:Connect(function()
		if not noclipEnabled then return end
		local char = player.Character
		if not char then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				if not noclipCache[part] then
					noclipCache[part] = part.CanCollide
				end
				part.CanCollide = false
			end
		end
	end)

	if player.Character then
		for _, part in ipairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if not noclipCache[part] then
					noclipCache[part] = part.CanCollide
				end
				part.CanCollide = false
			end
		end
	end
end

local function disableNoclip()
	noclipEnabled = false
	if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
	clearNoclipCache()
end

player.CharacterAdded:Connect(function(char)
	if noclipEnabled then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				if not noclipCache[part] then
					noclipCache[part] = part.CanCollide
				end
				part.CanCollide = false
			end
		end
	end
end)

player.CharacterRemoving:Connect(function()
	if noclipEnabled then
		clearNoclipCache()
	end
end)

-- ESP
local espEnabled = false
local espGuis = {}
local espUpdateConnection

local function createEspForPlayer(plr)
	local function setup()
		local char = plr.Character
		if not char then return end
		local head = char:WaitForChild("Head")
		local gui = Instance.new("BillboardGui")
		gui.Size = UDim2.new(0, 200, 0, 50)
		gui.StudsOffset = Vector3.new(0, 2.5, 0)
		gui.AlwaysOnTop = true
		gui.MaxDistance = 1000
		gui.Parent = head

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		frame.BackgroundTransparency = 0.5
		frame.BorderSizePixel = 0
		frame.Parent = gui

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -6, 1, -6)
		label.Position = UDim2.new(0, 3, 0, 3)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 12
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Name = "TextLabel"
		label.Parent = frame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 4)
		corner.Parent = frame

		gui.Name = "ESP"
		espGuis[plr] = gui
	end

	if plr.Character then
		setup()
	end
	plr.CharacterAdded:Connect(function()
		if espGuis[plr] then
			espGuis[plr]:Destroy()
			espGuis[plr] = nil
		end
		setup()
	end)
end

local function removeEspForPlayer(plr)
	if espGuis[plr] then
		espGuis[plr]:Destroy()
		espGuis[plr] = nil
	end
end

local function updateEsp()
	if not espEnabled then return end
	local camera = workspace.CurrentCamera
	if not camera then return end
	for plr, gui in pairs(espGuis) do
		if plr.Parent ~= Players then
			removeEspForPlayer(plr)
			continue
		end
		local char = plr.Character
		if not char or not gui or not gui.Parent then continue end
		local head = char:FindFirstChild("Head")
		if not head or gui.Parent ~= head then
			removeEspForPlayer(plr)
			continue
		end
		local hum = char:FindFirstChild("Humanoid")
		local dist = (camera.CFrame.Position - head.Position).Magnitude
		local health = hum and hum.Health or 0
		local label = gui:FindFirstChild("Frame") and gui.Frame:FindFirstChild("TextLabel")
		if label then
			label.Text = string.format("%s | %d HP | %.0f st", plr.Name, health, dist)
		end
	end
end

local function enableEsp()
	if espEnabled then return end
	espEnabled = true
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player then
			createEspForPlayer(plr)
		end
	end
	Players.PlayerAdded:Connect(function(plr)
		if espEnabled and plr ~= player then
			createEspForPlayer(plr)
		end
	end)
	Players.PlayerRemoving:Connect(function(plr)
		removeEspForPlayer(plr)
	end)
	if not espUpdateConnection then
		espUpdateConnection = RunService.Heartbeat:Connect(updateEsp)
	end
end

local function disableEsp()
	espEnabled = false
	for plr, gui in pairs(espGuis) do
		gui:Destroy()
	end
	table.clear(espGuis)
end

-- ===================== НОВАЯ ФУНКЦИЯ: Auto F =====================
local autoFEnabled = false
local autoFThread = nil

local function startAutoF()
	if autoFThread then return end
	autoFThread = task.spawn(function()
		while autoFEnabled do
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				-- Имитируем нажатие клавиши F
				VIM:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
				task.wait(0.05)   -- короткая задержка между нажатием и отпусканием
				VIM:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
			end
			task.wait(1)   -- интервал 1 секунда
		end
		autoFThread = nil
	end)
end

local function enableAutoF()
	if autoFEnabled then return end
	autoFEnabled = true
	startAutoF()
end

local function disableAutoF()
	autoFEnabled = false
	-- цикл сам завершится, когда autoFEnabled станет false
end

-- ========================= UI: создание переключателей =========================
local function createToggle(name, callback)
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(1, 0, 0, 36)
	toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Parent = contentFrame

	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 6)
	toggleCorner.Parent = toggleFrame

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 1, -6)
	button.Position = UDim2.new(0, 5, 0, 3)
	button.BackgroundTransparency = 1
	button.Text = name
	button.TextColor3 = Color3.fromRGB(200, 200, 200)
	button.Font = Enum.Font.GothamMedium
	button.TextSize = 14
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.Parent = toggleFrame

	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0, 16, 0, 16)
	indicator.Position = UDim2.new(1, -25, 0.5, -8)
	indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	indicator.BorderSizePixel = 0
	indicator.Parent = toggleFrame

	local indicatorCorner = Instance.new("UICorner")
	indicatorCorner.CornerRadius = UDim.new(1, 0)
	indicatorCorner.Parent = indicator

	local indicatorStroke = Instance.new("UIStroke")
	indicatorStroke.Thickness = 1
	indicatorStroke.Color = Color3.fromRGB(255, 255, 255)
	indicatorStroke.Transparency = 0.7
	indicatorStroke.Parent = indicator

	local state = false

	local function updateVisual()
		indicator.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
		button.TextColor3 = state and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(200, 200, 200)
	end

	button.MouseButton1Click:Connect(function()
		state = not state
		updateVisual()
		callback(state)
	end)

	button.MouseEnter:Connect(function()
		toggleFrame.BackgroundColor3 = state and Color3.fromRGB(50, 80, 70) or Color3.fromRGB(55, 55, 55)
	end)
	button.MouseLeave:Connect(function()
		toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end)

	return {
		setState = function(s)
			if state ~= s then
				state = s
				updateVisual()
			end
		end
	}
end

local antiAfkToggle = createToggle("Anti AFK", setAntiAfk)
local flyToggle = createToggle("Fly", function(s) if s then enableFly() else disableFly() end end)
local noclipToggle = createToggle("Noclip", function(s) if s then enableNoclip() else disableNoclip() end end)
local espToggle = createToggle("ESP", function(s) if s then enableEsp() else disableEsp() end end)
local autoFToggle = createToggle("Auto F", function(s) if s then enableAutoF() else disableAutoF() end end)

player.CharacterAdded:Connect(function()
	if flyEnabled then flyToggle.setState(true) end
	if noclipEnabled then noclipToggle.setState(true) end
	-- Auto F не зависит от персонажа, он просто будет проверять его наличие при нажатии
end)

-- Анти‑АФК включён по умолчанию
antiAfkToggle.setState(true)
setAntiAfk(true)
