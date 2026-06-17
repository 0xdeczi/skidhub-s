local Env = getfenv();
local isActive = false;
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Stats = game:GetService("Stats");
local Lighting = game:GetService("Lighting");
local Workspace = game:GetService("Workspace");
local LocalPlayer2 = game:GetService("Players").LocalPlayer;
local r31 = J:WaitForChild("PlayerGui");
local r34 = Color3.fromRGB(39, 56, 143);
local cFrame = CFrame.new(-1.7, 0, 0);
_G.AntiFlingConfig = {
    ["disable_rotation"] = true,
    ["limit_velocity"] = true,
    ["limit_velocity_sensitivity"] = 150,
    ["limit_velocity_slow"] = 0,
    ["anti_ragdoll"] = true,
    ["anchor"] = false,
    ["smart_anchor"] = true,
    ["anchor_dist"] = 30,
    ["teleport"] = false,
    ["smart_teleport"] = true,
    ["teleport_dist"] = 30
};
local function r56()
    if instance then
        if r44 then
            instance.Text = "SPEED GLITCH: ON";
            instance.TextColor3 = Color3.fromRGB(100, 255, 140);
        else
            instance.Text = "SPEED GLITCH: OFF";
            instance.TextColor3 = Color3.fromRGB(255, 100, 100);
        end;
    end; 
end;
local function r57()
    if instance2 then
        if r47 then
            instance2.Text = "SHIFT LOCK: ON";
            instance2.TextColor3 = Color3.fromRGB(100, 255, 140);
        else
            instance2.Text = "SHIFT LOCK: OFF";
            instance2.TextColor3 = Color3.fromRGB(255, 100, 100);
        end;
    end; 
end;
local function r58()
    r47 = not r47;
    r57();
    if r47 then
        if r48 then
            r48:Disconnect();
        end;
        if instance3 then
            instance3.Visible = true;
        end;
    else
        if r48 then
            r48:Disconnect();
        end;
        if instance3 then
            instance3.Visible = false;
        end;
        local Character = LocalPlayer2.Character;
        if Character then
            game = Character:FindFirstChildOfClass("Humanoid");
        end;
        if Character then
            Character.AutoRotate = true;
        end;
        w = Workspace.CurrentCamera;
        if w then
            w.CFrame = w.CFrame * cFrame;
        end;
        return;
    end; 
end;
local function r59(...)
    if isActive then
        return;
    end;
    local Character = LocalPlayer2.Character;
    a = Character and Character:FindFirstChildOfClass("Humanoid");
    if a then
        isActive = true;
        a.JumpPower = r42;
        task.spawn(function(...)
            a = tick() - tick() < r43;
            while not a do
                if isActive then
                    RunService.Heartbeat:Wait();
                end;
                if isActive then
                    Character = LocalPlayer2.Character;
                    game = Character and Character:FindFirstChildOfClass("Humanoid");
                    if game then
                        v2.JumpPower = Character.JumpPower;
                    end;
                    break;
                end;
                return; 
            end; 
        end);
    end; 
end;
game:GetService("UserInputService").InputBegan:Connect(function(arg1_4, arg2_4)
    if arg2_4 then
        return;
    end;
    if arg1_4.KeyCode == Enum.KeyCode.R then
        r56();
    else
        if arg1_4.KeyCode == Enum.KeyCode.F then
            r59();
        end;
        return;
    end; 
end);
LocalPlayer2.CharacterAdded:Connect(ll);
if LocalPlayer2.Character then
    ll(LocalPlayer2.Character);
end;
RunService.RenderStepped:Connect(function()
    S = Workspace.CurrentCamera;
    if S then
        S.CFrame = S.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, r32, 0, 0, 0, 1);
    end; 
end);
RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer2.Character;
    a = Character and Character:FindFirstChild("HumanoidRootPart");
    if not a or (not Character or Character.Health <= 0) then
        return;
    end;
    if a.AssemblyLinearVelocity.Magnitude >= r35 then
        if r37 then
            a.CFrame = r37;
            a.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            a.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        end;
    end; 
end);
do
    game = Lighting;
    game = "ipairs";
    for _, z in ipairs(game:GetChildren()) do
        if z:IsA("Sky") then
            z:Destroy();
        end; 
    end;
    S = Instance.new("Sky");
    S.Name = "CustomNightSky";
    a = "rbxassetid://136622198885324";
    game = "rbxassetid://136622198885324";
    S.SkyboxBk = game;
    S.SkyboxDn = a;
    S.SkyboxFt = a;
    S.SkyboxLf = a;
    S.SkyboxRt = a;
    S.SkyboxUp = a;
    S.SunAngularSize = 0;
    S.MoonAngularSize = 0;
    S.Parent = Lighting;
    Lighting.GeographicLatitude = 41.75;
    Lighting.Brightness = 0;
    Lighting.ExposureCompensation = -0.5;
    Lighting.Ambient = Color3.fromRGB(80, 80, 95);
    Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 70);
    Lighting.ShadowColor = Color3.fromRGB(30, 30, 40); 
end;
do
    ZombieHUD = r31:FindFirstChild("ZombieHUD");
    if ZombieHUD then
        ZombieHUD = r31:FindFirstChild("ZombieHUD");
        ZombieHUD:Destroy();
    end;
    S = Instance.new("ScreenGui");
    S.Name = "ZombieHUD";
    S.ResetOnSpawn = false;
    S.DisplayOrder = 100;
    S.IgnoreGuiInset = false;
    S.Parent = r31;
    r68 = 167;
    instance4 = Instance.new("Frame");
    instance4.Name = "Main";
    instance4.Size = UDim2.new(0, 230, 0, r68);
    instance4.Position = UDim2.new(0, 8, 0, 8);
    instance4.BackgroundColor3 = Color3.fromRGB(8, 10, 22);
    instance4.BackgroundTransparency = .22;
    instance4.BorderSizePixel = 0;
    instance4.ClipsDescendants = true;
    instance4.Parent = S;
    z = Instance.new("UICorner");
    z.CornerRadius = UDim.new(0, 7);
    z.Parent = instance4;
    p = Instance.new("UIStroke");
    p.Color = r34;
    p.Thickness = 1.4;
    p.Transparency = 0.25;
    p.Parent = instance4;
    R(instance4, "Header", UDim2.new(0, 8, 0, 5), UDim2.new(1, -34, 0, 20), "@ZombieHubReverce", 13, true).TextColor3 = Color3.fromRGB(160, 175, 255);
    E = Instance.new("Frame");
    E.Size = UDim2.new(1, -16, 0, 1);
    E.Position = UDim2.new(0, 8, 0, 27);
    E.BackgroundColor3 = r34;
    E.BackgroundTransparency = .45;
    E.BorderSizePixel = 0;
    E.Parent = instance4;
    r71 = R(instance4, "lFPS", UDim2.new(0, 8, 0, 33), UDim2.new(1, -16, 0, 22), "FPS:   --");
    r72 = R(instance4, "lPing", UDim2.new(0, 8, 0, 55), UDim2.new(1, -16, 0, 22), "Ping:  --");
    r73 = R(instance4, "lPos", UDim2.new(0, 8, 0, 77), UDim2.new(1, -16, 0, 22), "Pos:   X=0 Y=0 Z=0", 11);
    r74 = R(instance4, "lSpeed", UDim2.new(0, 8, 0, 99), UDim2.new(1, -16, 0, 22), "Speed: --");
    instance = Instance.new("TextButton");
    instance.Name = "btnSpeedGlitch";
    instance.Size = UDim2.new(1, -16, 0, 22);
    instance.Position = UDim2.new(0, 8, 0, 121);
    instance.BackgroundTransparency = 1;
    instance.Font = Enum.Font.GothamBold;
    instance.TextSize = 11;
    instance.TextXAlignment = Enum.TextXAlignment.Left;
    instance.Parent = instance4;
    r56();
    instance.MouseButton1Click:Connect(function(...)
        r56();
        return; 
    end);
    instance2 = Instance.new("TextButton");
    instance2.Name = "btnShiftLock";
    instance2.Size = UDim2.new(1, -16, 0, 22);
    instance2.Position = UDim2.new(0, 8, 0, 143);
    instance2.BackgroundTransparency = 1;
    instance2.Font = Enum.Font.GothamBold;
    instance2.TextSize = 11;
    instance2.TextXAlignment = Enum.TextXAlignment.Left;
    instance2.Parent = instance4;
    r57();
    instance2.MouseButton1Click:Connect(r58);
    instance3 = Instance.new("ImageLabel");
    instance3.Name = "Shiftlock Cursor";
    instance3.Image = "rbxasset://textures/MouseLockedCursor.png";
    instance3.Size = UDim2.new(.03, 0, .03, 0);
    instance3.Position = UDim2.new(0.5, 0, 0.5, 0);
    instance3.AnchorPoint = Vector2.new(0.5, 0.5);
    instance3.SizeConstraint = Enum.SizeConstraint.RelativeXX;
    instance3.BackgroundTransparency = 1;
    instance3.Visible = false;
    instance3.Parent = S;
    instance5 = Instance.new("TextButton");
    instance5.Size = UDim2.new(0, 22, 0, 18);
    instance5.Position = UDim2.new(1, -26, 0, 5);
    instance5.BackgroundColor3 = r34;
    instance5.BackgroundTransparency = .4;
    instance5.BorderSizePixel = 0;
    instance5.Text = "−";
    instance5.TextColor3 = Color3.fromRGB(255, 255, 255);
    instance5.TextSize = 15;
    instance5.Font = Enum.Font.GothamBold;
    instance5.Parent = instance4;
    Y = Instance.new("UICorner");
    Y.CornerRadius = UDim.new(0, 4);
    Y.Parent = instance5;
    r76 = false;
    B = instance5.MouseButton1Click;
    B:Connect(function(...)
        B = not r76;
        instance5.Text = B and "+" or "−";
        S = TweenService:Create(instance4, TweenInfo.new(.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(0, 230, 0, B and 28 or r68)
        });
        S:Play();
        return; 
    end);
    r77 = tick();
    r78 = 0;
    RunService.RenderStepped:Connect(function(...)
        r78 = r78 + 1;
        S = tick();
        r71.Text = string.format("FPS:   %d", 0);
        pcall(function(...)
            return; 
        end);
        r72.Text = string.format("Ping:  %d ms", 0);
        Character = LocalPlayer2.Character;
        if Character then
            HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
            Humanoid = Character:FindFirstChildOfClass("Humanoid");
            E = r78 + 1;
            if HumanoidRootPart then
                r73.Text = string.format("Pos:   X=%.0f Y=%.0f Z=%.0f", k.X, k.Y, k.Z);
                E = HumanoidRootPart.AssemblyLinearVelocity;
                r74.Text = string.format("Speed: %.0f", Vector3.new(E.X, 0, E.Z).Magnitude);
                game = not r44;
                if game then
                    Character:FindFirstChildOfClass(r15[r44]).WalkSpeed = r39;
                else
                    game = Humanoid:GetState();
                    r44 = game == Enum.HumanoidStateType.Jumping or game == Enum.HumanoidStateType.Freefall;
                    if r44 then
                        E = Y and r41 or r40;
                        Character:FindFirstChildOfClass(r15[r44]).WalkSpeed = E;
                        if isActive then
                            Character:FindFirstChildOfClass(r15[r44]).JumpPower = r42;
                        end;
                    else
                        Character:FindFirstChildOfClass(r15[r44]).WalkSpeed = r39;
                        E = not isActive;
                        if E then
                            Character:FindFirstChildOfClass(r15[r44]).JumpPower = 50;
                        end;
                    end;
                end;
            end;
        end;
        return; 
    end); 
end;
do
    game = Workspace;
    game = game[1];
    for _, z in game, ipairs(game:GetDescendants()) do
        r55(z); 
    end;
    Workspace.DescendantAdded:Connect(r55);
    Terrain = Workspace:FindFirstChildOfClass("Terrain");
    if Terrain then
        Terrain.Decoration = false;
        Terrain.WaterWaveSize = 0;
        Terrain.WaterWaveSpeed = 0;
        Terrain.WaterReflectance = 0;
    end; 
end;
return;
