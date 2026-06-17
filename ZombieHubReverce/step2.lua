local Env = getfenv();
local StarterGui = game:GetService("StarterGui");
for i = 1, 3 do
    StarterGui:SetCore("SendNotification", {
        ["Title"] = "CREDITS",
        ["Text"] = "Script by: @ZombieHubReverce",
        ["Icon"] = "rbxassetid://75448464738180",
        ["Duration"] = 4
    });
    task.wait(1); 
end;
return;
